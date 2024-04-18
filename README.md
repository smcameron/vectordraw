vectordraw
==========

Really stupidly simple vector graphics editor written in
[processing](https://processing.org/) that outputs C code
in a format suitable for use in C programs. 

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

The Processing language is kind of a pain in the ass in that it wants the vectordraw.pde
source code to reside in your home directory in ~/sketchbook/vectordraw/vectordraw.pde.
The best way I've found to satisfy it is to use a symlink:

```
	mkdir -p ~/sketchbook/vectordraw
	ln -s vectordraw-git-repo/vectordraw.pde ~/sketchbook/vectordraw/vectordraw.pde
```

That way, you can edit the source either via the built in Processing editor
or use whatever editor you prefer on the source in its normal git repo location,
and things will work without copying things back and forth.  I think there is some
preference in Processing you can set so that it will auto load the source any time
changes are made in an external editor, but I can't remember what it's called.
It might be "editor.watcher=true" in ~/.config/processing/preferences.txt but I can't
find any documentation for that option now, so don't hold me to that.

You can also run it from the command line, though processing makes this a pain
in the ass too.  E.g:

```
	~/processing-4.1.1/processing-java \
		--sketch=/home/username/sketchbook/vectordraw --run --output=/tmp/junk
```

Note in particular that it will not expand the tilde character into the name of
your home directory.

