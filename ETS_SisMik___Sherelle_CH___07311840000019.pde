import controlP5.*; //import ControlP5 library
import processing.serial.*;

String outtp = "";
String serv = "";
String adc = "";
char c1; 
int xPos = 1;         // horizontal position of the graph 
float charte = 0;

//Variables to draw a continuous line.
int lastxPos=1;
int lastheight=height;

Serial port;

ControlP5 cp5; //create ControlP5 object

void setup(){ //Same as setup in arduino
  
  size(300, 300);                //Window size, (width, height)
  port = new Serial(this, "COM3", 9600);   
  port.bufferUntil('\n');
  background(0,0,0); //Background colour of window 
  
  cp5 = new ControlP5(this);
  
  cp5.addButton("Switch")  //The button
    .setPosition(180, 20)  //x and y coordinates
    .setSize(100, 40)      //(width, height)
  ;     
}

void draw(){  //Same as loop in arduino

  fill(255);
  rect(0,0,300,150); 
  
  fill(0);
  textSize(14);
  text("Switch Servo Control",20,45);
  
  fill(0);
  textSize(14);
  text("ADC Reading: " + adc, 20,100);  
  
  fill(0);
  textSize(14);
  text("Servo Position: " +serv+ " Degrees", 20,130);
  
    stroke(255);     //stroke color
    strokeWeight(2);        //stroke wider
    line(lastxPos, lastheight, xPos, height - charte); 
    lastxPos= xPos;
    lastheight= int(height-charte);

    // at the edge of the window, go back to the beginning:
    if (xPos >= width) {
      lastxPos= 0;
      xPos = 0;
      background(0);  //Clear the screen.
    } 
    else {
      xPos++;  // increment the horizontal position
  }
}

void Switch(){
  port.write("1");
}

void serialEvent(Serial port)
{ outtp = port.readStringUntil('\n');
 c1 = outtp.charAt(0);
 
  if (c1 == 'a') {
    adc = outtp.replace("a",""); //clear code and newline
    adc = adc.replace("\n","");
    charte = float(adc);
    charte=map(charte, 0, 1023, 0, 150);
  } else if (c1 == 's') {
    serv = outtp.replace("s",""); //clear code and newline
    serv = serv.replace("\n","");
  }
}
