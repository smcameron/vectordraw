
int maxpoints = 1000;
int[] x;
int[] y;
int npoints = 0;
int lastmouse = -1;
int lastkey = -1;
int originx = 0;
int originy = 0;
PImage img, shade;
int lift_pen = -10000;
int output_lift_pen = -128;
int outputx = 256;
int outputy = 256;

void setup() {

  img = loadImage("/home/scameron/myimage.jpg");

  shade = createImage(img.width, img.height, RGB);
  for (int i = 0; i < img.pixels.length; i++) {
    shade.pixels[i] = color(100, 100, 100); 
  }

  img.resize(512, 512);

  size(512, 512);
  background(0);
  originx = img.width / 2;
  originy = img.height / 2;
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

	line(originx, 0, originx, img.height);
	line(0, originy, img.width, originy);

	for (i = 0; i < npoints - 1; i++) {
		if (x[i + 1] == lift_pen) {
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
		x[npoints] = lift_pen;
		y[npoints] = lift_pen;
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
        println("originx = " + originx / 2 + ", originy = ", originy / 2);

	println("{");
	for (i = 0; i < npoints; i++) {
		if (x[i] != lift_pen) {
			println("	{ " + (x[i] - originx) / 2 + ", " +
				((y[i] - maxy) - (originy - maxy)) / 2 + " },");
		} else {
			println("	{ " + output_lift_pen + ", " + output_lift_pen + " },");
		}
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
	if (lastkey == 'o') {
		originx = mouseX;
		originy = mouseY;
	}
}

