class MovingObject {
  PVector pos;
  PVector vel;
  PVector acc;
  float vol;
  float mass;
  int col;

  MovingObject(int x, int y, float v, float m, int c) {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);

    vol = v;
    mass = m;
    col = c;
  }

  void display() {
    stroke(0);
    fill(col);
    ellipse(pos.x, pos.y, vol, vol);
  }

  void applyForce(PVector f) {
    PVector force;

    force = new PVector();
    force = f.copy();
    force.mult(1/mass);

    acc.add(force);
  }

  void move() {
    float halfVol;

    halfVol = vol/2;

    vel.add(acc);
    pos.add(vel);

    if(pos.x < halfVol) pos.x = halfVol;
    if(pos.x > width - halfVol) pos.x = width - halfVol;

    if(pos.y < halfVol) pos.y = halfVol;
    if(pos.y > height - halfVol) pos.y = height - halfVol;

    acc.mult(0);
  }

  void getBounce() {
    float halfVol;

    halfVol = vol/2;

    if (pos.x == halfVol || pos.x == width - halfVol) {
      vel.x *= -0.5;
    }

    if (pos.y == halfVol || pos.y == height - halfVol) {
      vel.y *= -0.5;
    }
  }
}