# CustomImageEqualizer

CustomImageEqualizer is an add-on for Godot Engine providing a graphical equalizer Control using a custom image as the graphical elements of the equalizer.

[CustomImageEqualizer Demo](https://youtu.be/Mmz0w2cbLp4)

The add-on can be found under addons/custom-image-equalizer. An example Godot project has been included under the example folder.

CustomImageEqualizer has been tested on version 3.5.2-stable and uses GDScript.

The included image and music are original works by BumbleMeow, LLC and are free to use under the MIT license.

To use the add-on:

1. Copy addons/custom-image-equalizer to your addons folder (creating an addons folder if you don't already have one).
2. Instance custom-image-equalizer.tscn into your scene. You may need to add a CanvasLayer as a parent depending on where you are trying to include the scene.
3. Add an image to the Image Texture script variable.
4. If you are using an Audio bus with a name other than "Master", update the Bus Name script variable with that name.
5. Add the Spectrum Analyzer effect to your Audio Bus noting the position of the effect (the first effect is index 0, the second index 1 etc.)
6. If the Spectrum Analyzer Effect is not the first effect in your Audio bus (index 0), update the Spectrum Effect Index script variable with the correct index number.
7. Add an AudioStreamPlayer to your scene and play music on the Bus you have configured in steps 4-6

 Optional Script Variables:

 * Image Tint - Default is white, select a color to tint your image as you would like.
 * Num Columns - The number of columns in your equalizer
 * Num Rows - The number of rows per column
 * FPS - The Frames per Second that the equalizer will update. Default is 10 which looks pretty good.
 * Frequency Max - The maximum frequency to include in the equalizer
 * Min DB - The minimum decibel level used for normalizing the results of the FFT
 * Max FPS - The maximum FPS to consider. Usually this is 60 FPS but your game may run at a higher rate

As CustomImageEqualizer is derived from Control, you can size and position it like any other Control. The equalizer will be scaled to fit the desired number of rows and columns of your selected image.

This add-on was used (in a modified form) in our mobile game [BebeBoop](https://apps.apple.com/app/id6448795283) in
the "Posters" ["DJ Meow Meow"](https://www.bumblemeow.com/bebeboop#djmm-description) and 
["Raining Teddies"](https://www.bumblemeow.com/bebeboop#rainingteddies-description) as well as the Karaoke version
of "Raining Teddies" on [YouTube](https://youtu.be/BIPHg9bDsnA).
