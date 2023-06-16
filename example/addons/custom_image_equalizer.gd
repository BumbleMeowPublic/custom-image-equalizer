class_name CustomImageEqualizer
extends Control

# A graphical equalizer where each block of the equalizer is an image you
# provide. To configure you must do the following:
# 1. Make sure to set the Image Texture script variable
# 2. If the Audio bus your music is playing on is named something other than
#    "Master" then change the "Bus Name" script variable to match the name of
#    your Audio bus
# 3. Add the "SpectrumAnalyzer" effect to the Audio bus your music will play on
# 4. Make sure the "Spectrum Effect Index" script variable is set to match the
#    index of the effect set in #3 (indices are 0 based, so the first effect
#    added to a bus is 0, the second is 1 etc.)


# "Required" variables
export (Texture) var image_texture
export (String) var bus_name := "Master"
export (int) var spectrum_effect_index := 0

# "Optional" variables with suitable defaults
export (Color) var image_tint := Color.white
export (int) var num_columns := 16
export (int) var num_rows := 10
export (int) var fps := 10
export (float) var frequency_max := 11050.0
export (int) var min_db := 60
export (int) var max_fps := 60


var image_width
var image_height
var width
var height
var col_width: float
var row_height: float
var src_rect: Rect2
var spectrum: AudioEffectInstance
var music_bus_index: int
var prev_hz: float
var hz: float
var magnitude: float
var energy: float
var frame_counter: int = 0
var column_heights := []


func _ready():
	if image_texture:
		image_width = image_texture.get_width()
		image_height = image_texture.get_height()
		width = rect_size.x
		height = rect_size.y
		col_width = float(width) / num_columns
		row_height = float(height) / num_rows
		src_rect = Rect2(0, 0, image_width, image_height)
		for _i in range(num_columns):
			column_heights.append(1.0)
		
		music_bus_index = AudioServer.get_bus_index(bus_name)
		if music_bus_index == -1:
			push_error("CustomImageEqualizer: Can't find the Audio bus named: " + bus_name)

		AudioServer.set_bus_effect_enabled(music_bus_index, spectrum_effect_index, true)
		spectrum = AudioServer.get_bus_effect_instance(music_bus_index, spectrum_effect_index)
		if !spectrum:
			push_error("CustomImageEqualizer: Can't find SpectrumAnalyzer effect at index: " + 
				str(spectrum_effect_index) + " on bus: " + bus_name)
	else:
		push_error("CustomImageEqualizer: You forgot to assign a value to image_texture")


func _process(_delta):
	if image_texture:
		frame_counter += 1
		
		#warning-ignore:integer_division
		if frame_counter == (max_fps / fps):
			frame_counter = 0
		else:
			return

		prev_hz = 0
		for i in range(0, num_columns):
			hz = i * frequency_max / num_columns
			magnitude = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
			#warning-ignore:narrowing_conversion
			energy = clamp(((min_db + linear2db(magnitude)) / min_db), 0.0, 1.0)
			column_heights[i] = max(1.0, ceil(energy * num_rows))
			prev_hz = hz
		update()


func _draw():
	if image_texture:
		for i in range(num_columns):
			for j in range(num_rows):
				var row = num_rows - 1 - j
				if j < column_heights[i]:
					var dest_rect = Rect2(i * col_width, row * row_height, col_width, row_height)
					draw_texture_rect_region(image_texture, dest_rect, src_rect, image_tint)
