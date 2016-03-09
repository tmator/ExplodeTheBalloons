class Balloon {
  
  float     xpos;
  float     ypos;

  
  Balloon() {
    xpos      = random (40, width-40);
    ypos   = random(40, height-40);
  }
  
  void display() {

    fill(0,0,200);
    ellipse(xpos, ypos, 50, 50);
    
  }

  void reset() {
    xpos      = random (40, width-40);
    ypos   = random(40, height-40);
  }  
  

  
}
