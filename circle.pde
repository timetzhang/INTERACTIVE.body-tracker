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
    fillColor = color(120);
    lifeSpan = 255;
    radius = 10;
    noFill();
  }

  void update() {
    pos = startPos;
    strokeColor = color(255);
    fillColor = color(255);
    lifeSpan = 255;
  }

  void reset() {
    pos.x += random(-0.05, 0.05);
    pos.y += random(-0.05, 0.05);
    lifeSpan-=0.5;
    strokeColor = color(strokeColor, lifeSpan);
    fillColor = color(fillColor, lifeSpan);
    pos = startPos;
  }

  void display() {
    fill(fillColor);
    stroke(strokeColor);
    rect(pos.x, pos.y, radius, radius);
  }
}
