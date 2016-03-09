/**

Shipbrain tmator

 */
 
import processing.serial.*;

Serial serial;


int time;
int wait = 1000;
int sec=60;
   
int run=0; //0 départ, 1 jeux, 2 score, 3 attente attention
int attention=50;
int signal=200;



//le ballon
Balloon theBalloon;

//la barre d'attention
Barre theBarre;
//compteur
int total=0;

//temps
   
void setup() {
  size(1000, 600);
  noStroke();
  background(0);

  theBalloon = new Balloon();
  theBarre = new Barre();
  
  serial = new Serial(this, Serial.list()[0], 9600);    
  serial.bufferUntil(10);

  
}

void draw() { 
    background(0);

  theBarre.attention=attention*6;
  theBarre.signal=signal;

  theBarre.display();
  
  
  if (run==1)
  {
    // keep draw() here to continue looping while waiting for keys
    
    //affichage du compteur et temps
    textSize(32);
    fill(255,255,255);
    text("Résultat : "+total, 430, 30); 
    text("Restant : "+sec, 430, 550);

    //if attention = 100 le balon explose
    println("attention "+attention);
    if (attention < 70)
    {
      theBalloon.display();
    }
    else
    {
      //boom
      
      total++;
      theBalloon.reset();  
      run=3;
        //    theBalloon.display();

    }
   
    
    //check the difference between now and the previously stored time is greater than the wait interval
    if (millis() - time >= wait && sec > 0) {
    time = millis();//also update the stored time
    sec--;
    
    if (sec==0)
      run=2;
  }
  }
  else if (run==0)
  {
    textSize(20);
    fill(255,255,255);
    text("Utilisez votre mental pour explosser les ballons, vous avez une minute.", 0, 200);
    text("Appuyez sur a pour démarrer.", 0, 250); 
  }
  else if (run==2)
  {
    background(0);
    textSize(20);
    fill(255,255,255);
    text("Vous avez eu "+total+" ballons", 0, 200);
    text("Appuyez sur a pour relancer le jeux.", 0, 250); 
  }
  else if (run==3)
  {
    textSize(20);
    fill(255,255,255);
    text("Baissez votre attention pour continuer.", 100, 200);
    if (attention <50)
    {
      run=1;
    }
  }

  
}

void serialEvent(Serial p) {
  // Split incoming packet on commas
  // See https://github.com/kitschpatrol/Arduino-Brain-Library/blob/master/README for information on the CSV packet format
  
  String incomingString = p.readString().trim();
  print("Received string over serial: ");
  println(incomingString);  
  
  String[] incomingValues = split(incomingString, ',');

  // Verify that the packet looks legit
  if (incomingValues.length > 1) {
    

    // Wait till the third packet or so to start recording to avoid initialization garbage.
      //get signal
      String SstringValue = incomingValues[0].trim();
      int SnewValue = Integer.parseInt(SstringValue);
      

      // get attention      
      String stringValue = incomingValues[1].trim();

      int newValue = Integer.parseInt(stringValue);

      // Zero the EEG power values if we don't have a signal.
      // Can be useful to leave them in for development.
      if ((Integer.parseInt(incomingValues[0]) == 200)) {
        newValue = 0;
      }
     // Integer.parseInt(incomingValues[0])
      attention = newValue;
      signal = SnewValue;
      

  } 
}


void keyPressed() {
 
  //shoot
  if (key == ' ')
  {
    //test explosion
    attention=95;
  }
  else if (key == 'a')
  {
    run=1;
    sec=60;
    total=0;
  }
  else if (key == 'q')
  {
    attention = 40;
  }
    else if (key == 'w')
  {
    signal = 0;
  }
}
