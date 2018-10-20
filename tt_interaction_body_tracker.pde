import KinectPV2.*;
import processing.video.*;

KinectPV2 kinect;
Movie movie;

boolean foundUsers = false;

Circle[][] circles = new Circle[300][300];

void setup() {
  fullScreen(P2D);
  background(0);
  
  movie = new Movie(this, "45.mp4");
  movie.loop();

  //init kinect
  kinect = new KinectPV2(this);
  kinect.enableBodyTrackImg(true);
  kinect.enableDepthMaskImg(true);
  kinect.init();


  noFill();

  for (int i=0; i<424; i+=5) {
    for (int j=0; j<512; j+=5) {
      int p = i * 512 + j;
      circles[i/5][j/5] = new Circle(j*3.8, i*2.75);
    }
  }
}

void draw() {
  background(0);
  image(movie, 0, 0, width, height);
  PImage myImage = kinect.getBodyTrackImage();
  myImage.loadPixels();

  for (int i=0; i<424; i+=5) {
    for (int j=0; j<512; j+=5) {
      int p = i * 512 + j;
      if (myImage.pixels[p] == -1) {
        circles[i/5][j/5].reset();
      } else {
        circles[i/5][j/5].update();
      }
      circles[i/5][j/5].display();
    }
  }
}

void mousePressed() {
  println(frameRate);
}

void movieEvent(Movie m) {
  m.read();
}
