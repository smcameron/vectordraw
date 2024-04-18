vectordraw
==========

Really stupidly simple vector graphics editor that outputs C code in a format only I would be interested in.

It wants an image called "myimage.jpg" in your home directory.  This image will get scaled to 512x512,
darkened, and displayed in a 512x512 window with an axis superimposed on it.

You can then draw with the mouse, tracing over the image.

![Image of vectordraw in action](https://raw.githubusercontent.com/smcameron/vectordraw/master/vectordraw.jpg)

* Mouse button 1 (left mouse button) draws a line from the last position clicked to the current mouse position.
* Mouse button 2 (middle mouse button) backspace (erases the last clicked point from existence.)
* Mouse button 3 (right mouse button) lifts the pen.
* Backspace key does the same thing as mouse button 2.
* The 'o' key moves the origin to the current mouse position.
* The spacebar causes the program to "dump out" the data to stdout.

The coordinates recorded are scaled down into the range -128 to +127 before being output
(so that they fit into a signed char).  "Pen lifts" are recorded as { -128, -128 },

An example of the output:

```
originx = 128, originy =  128
{
	{ -104, -101 },
	{ -96, 94 },
	{ -128, -128 },
	{ 91, 92 },
	{ 90, -96 },
}
```


Apart from the first line, this can be cut and pasted into a C program, e.g.:

```
	static const struct point {
		signed char x, y;
	} mypoints[] = {
		{ -104, -101 },
		{ -96, 94 },
		{ -128, -128 },
		{ 91, 92 },
		{ 90, -96 },
	};
```

Then it is a trivial matter to traverse this array drawing from point to point,
skipping pairs that begin with coordinates (-128, -128) to "lift the pen".  In this
way, you can trace small drawings and reproduce them digitally.  Potentially useful
for making stupid little games. 

