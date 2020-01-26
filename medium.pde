class Medium {
  String name;
  float dens;
  int col;
  int infLimit;
  int supLimit;
  PVector externalForce;

  Medium(String n, float d, int c, int i, int s) {
    name = n;
    dens = d;
    col = c;
    infLimit = i;
    supLimit = s;
    externalForce = new PVector(0, 0);
  }

  void display() {
    noStroke();
    fill(col);
    rect(0, infLimit, width, supLimit);
  }

  void addExternalForce(PVector f) {
    externalForce.add(f);
  }

  void applyFriction(MovingObject o) {
    PVector friction;

    friction = new PVector();
    friction = o.vel.copy();
    friction.normalize();
    friction.mult(dens * o.vel.mag() * o.vel.mag() * -0.01);

    o.applyForce(friction);
  }

  void applyExternalForce(MovingObject o) {
    o.applyForce(externalForce);
  }
}