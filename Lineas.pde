class Liner {

  PVector pos, prev, spd;
  float angle, speed = lineSpeed, h;

  public Liner(float gridX, float gridY, float a) {
    h = random(360);
    pos = new PVector(gridX * gridSize, gridY * gridSize);
    prev = new PVector();
    angle = a;
    spd = new PVector(cos(radians(angle)) * speed * (1f/60), round(sin(radians(angle)) * speed * (1f/60)));
  }

  void randomise() {
    pos.set(gridSize * (int)random(width/gridSize), gridSize * (int)random(height/gridSize));
    prev = new PVector(pos.x, pos.y);
    angle = 90 * round(random(4));
    spd = new PVector(cos(radians(angle)) * speed * (1f/60), round(sin(radians(angle)) * speed * (1f/60)));
  }

  void update() {
    //prev = pos.copy(); Not supported on Android
    prev = new PVector(pos.x, pos.y);
    if (pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0) {
      randomise();
    }
    pos.add(spd);
  }

  void draw() {
    colorMode(HSB, 360, 100, 100);
    stroke(h, 100, 100);
    //METHOD 1: Render point (not as pretty at high speeds, but best in performance)
    //point(pos.x, pos.y);
    
    //METHOD 2: Render line and ellipse (best performance/appearance tradeoff)
    line(prev.x, prev.y, pos.x, pos.y);
  }
}