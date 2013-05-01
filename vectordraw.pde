
int maxpoints = 1000;
int[] x;
int[] y;
int npoints = 0;
int lastmouse = -1;
int lastkey = -1;
PImage img, shade;

void setup() {

  img = loadImage("/home/scameron/myimage.jpg");

  shade = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.pixels.length; i++) {
    shade.pixels[i] = color(100, 100, 100); 
  }

  size(img.width, img.height);
  background(0);
  x = new int[maxpoints];
  y = new int[maxpoints];
}

void draw()
{
	int i;
	int x1, y1;

	if (keyPressed)
		lastkey = key;

	stroke(255);
	background(0);
	image(img, 0, 0);
	blend(shade, 0, 0, img.width, img.height, 0, 0, img.width, img.height, MULTIPLY);

	for (i = 0; i < npoints - 1; i++) {
		if (x[i + 1] == -9999) {
			i++;
			continue;
		} else {
			line(x[i], y[i], x[i + 1], y[i + 1]);
		}
	}

	if (npoints <= 0)
		return;

	x1 = x[npoints - 1];
	y1 = y[npoints - 1];
	line(x1 - 5, y1, x1 + 5, y1);
	line(x1, y1 - 5, x1, y1 + 5);
}

void mouseReleased() {
	if (lastmouse == 1) {
		x[npoints] = mouseX;
		y[npoints] = mouseY;
	}
	if (lastmouse == 2) {
		if (npoints > 0)
			npoints--;
	}
	if (lastmouse == 3) {
		x[npoints] = -9999;
		y[npoints] = -9999;
	}
	npoints++;
}

void mousePressed()
{
	if (mouseButton == LEFT) {
		lastmouse = 1;
	}
/*
	if (mouseButton == MIDDLE) {
		lastmouse = 2;
	}
*/
	if (mouseButton == RIGHT) {
		lastmouse = 3;
	}
}

void dump_data()
{
	int i;
	int maxy, maxyi;

	maxy = y[0];
	maxyi = 0;

	for (i = 0; i < npoints; i++) {
		if (y[i] > maxy) {
			maxy = y[i];
			maxyi = i;
		}
	}

	println("{");
	for (i = 0; i < npoints; i++) {
		println("	{ " + x[i] + ", " + (y[i] - maxy) + " },");
	}
	println("}");
}

void keyReleased()
{
	if (lastkey == ' ')
		dump_data();
	if (lastkey == BACKSPACE) {
		if (npoints > 0) {
			npoints--;
		}
	}
}

