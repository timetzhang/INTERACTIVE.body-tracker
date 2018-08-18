import KinectPV2.*;
import processing.sound.*;

KinectPV2 kinect;
SoundFile soundKick;
SoundFile soundSnare;

boolean foundUsers = false;

class Circle {
  PVector pos;
  PVector startPos;
  color strokeColor;
  color fillColor;
  int lifeSpan;
  float radius;

  Circle(float x, float y) {
    pos = new PVector(x, y);
    startPos  = new PVector(x, y);
    strokeColor = color(120, 30);
    fillColor = color(120, 10);
    lifeSpan = 255;
    radius = 10;
    noFill();
  }

  void update() {
    pos.x += random(-0.3, 0.3);
    pos.y += random(-0.3, 0.3);
    strokeColor = color(random(255), random(255), random(255));
    fillColor = color(random(255), random(255), random(255));
    lifeSpan = 255;
  }

  void reset() {
    pos.x += random(-6, 6);
    pos.y += random(-6, 6);
    lifeSpan-=3;
    strokeColor = color(strokeColor,lifeSpan);
    fillColor = color(fillColor,lifeSpan);
    
    pos = startPos;
  }

  void display() {
    fill(fillColor);
    stroke(strokeColor);
    rect(pos.x, pos.y, radius, radius);
  }
}

Circle[][] circles = new Circle[100][200];

void setup() {
  fullScreen(P3D);
  background(0);

  //init kinect
  kinect = new KinectPV2(this);
  kinect.enableBodyTrackImg(true);
  kinect.enableDepthMaskImg(true);
  kinect.init();

  //Init sound files
  soundKick = new SoundFile(this, "./kick.wav");
  soundSnare = new SoundFile(this, "./snare.wav");

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
