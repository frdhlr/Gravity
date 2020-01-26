Medium [] strate = new Medium[3];
MovingObject [] corpse = {};

PVector [] gravity = {};

float orb;
float halfVol;

int nbCorpse = 4;

void setup() {
  PVector wind;
  PVector flow;

  strate[0] = new Medium("Mud", 500, 10, 500, height);
  strate[1] = new Medium("Water", 300, 50, 300, 500);
  strate[2] = new Medium("Air", 0, 100, 0, 300);

  wind = new PVector(0.5, 0);
  flow = new PVector(-1, -0.7);

  strate[2].addExternalForce(wind);
  strate[1].addExternalForce(flow);

  size(1200, 600);

  for (int s = strate.length - 1; s >= 0; s--) {
    strate[s].display();
  }

  for(int c = 0; c < nbCorpse; c++) {
    corpse = (MovingObject[]) append(corpse, new MovingObject(200 + c*200, 30, 20 + c*10, 150 + c*50, 50 + c*40));
    corpse[c].display();
  }
}

void draw() {
  for (int s = strate.length - 1; s >= 0; s--) {
   strate[s].display();
  }

  for(int c = 0; c < corpse.length; c++) {
    halfVol = corpse[c].vol/2;
    orb = height - corpse[c].pos.y;

    gravity = (PVector[]) append(gravity, new PVector(0, (corpse[c].mass * 3000)/(orb * orb)));

    corpse[c].applyForce(gravity[c]);

    for(int s = 0; s < strate.length; s++) {
      if(corpse[c].pos.y + halfVol > strate[s].infLimit) {
        strate[s].applyFriction(corpse[c]);
        strate[s].applyExternalForce(corpse[c]);
        break;
      }
    }

    if(mousePressed) {
      applyComplementaryForce(new PVector(0, -1.5));
    }

    corpse[c].move();
    corpse[c].getBounce();
    corpse[c].display();
  }
}

void applyComplementaryForce(PVector f) {
  for(int c = 0; c < corpse.length; c++) {
    corpse[c].applyForce(f);
  }
}