class Barre {
  
  int attention;
  int signal;

  
  Barre() {
   attention = 0;
   signal=200;
  }
  
  void display() {

    if (signal != 0)
    {
      fill(200,0,0);
    }
    else
    {
      fill(0,200,0);
    }
    rect(0, height, 30, -attention);
    
  }

  void reset() {
   attention = 0;
   signal=200;
  }  
  

  
}
