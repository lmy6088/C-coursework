//This program is basicly 2 live meters displaying the current light level
//and temperature of the surrounding.Also there is a contrast meter that 
//changes colour on different light intensities.
import processing.serial.*;

Serial engduino;

String inString;

// Sensor data from engduino
float temperature;
int lightLevel;
int xPos = 100;
int yPos = 100;
int xPos1 = 200;
int yPos1 = 280;

void setup()
{
  engduino = new Serial(this, Serial.list()[5], 9600);
  engduino.readStringUntil('\n');
  engduino.bufferUntil('\n');
  size(600, 400);
}

void draw(){
  background(24);
  drawLightMeter();
  drawLightPointer();
  drawLightLabel();
  drawTempMeter();
  drawTempLabel();
  drawTempPointer();
  writeText();
  ContrastMeter();
  
}

void serialEvent(Serial engduino)
{
  inString = engduino.readStringUntil('\n');
  inString = trim(inString);
  println(inString);
  String[] splitStr = inString.split(",");
  if (splitStr.length == 2) {
    try {
      temperature = Float.parseFloat(splitStr[0]);
      lightLevel = Integer.parseInt(splitStr[1]);
    } catch (Exception e) {
      println("An error occurred with input: " + inString);
    }
  }
}

void drawLightMeter(){
  
  //Horiontal scale of the Temp meter
  for(int i = xPos ; i <= width/6*5 ; i+=40){
   fill(255,0,0);
   stroke(255, 0, 0);
   strokeWeight(2);
   line(i, yPos-10, i, yPos+13);
  }
  strokeWeight(4);
  line(xPos, yPos, xPos+410, yPos);
  fill(255, 0, 0);
  triangle(xPos+413, yPos-5, xPos+413, yPos+5, xPos+423, yPos);
}

void drawLightPointer(){
 int triangleXPos = lightLevel*400/1000;
 int triangleYPos = 115;
 fill(0, 255, 0);
 triangle(triangleXPos+97, triangleYPos+20, triangleXPos+100, triangleYPos+10, triangleXPos+103, triangleYPos+20);
 text(lightLevel, triangleXPos+94, triangleYPos+35);
}

void drawLightLabel(){
  //scale of 100
 text("0", xPos-4, yPos-25);
 text("500", xPos+190, yPos-25);
 text("1000", xPos+384, yPos-25);
}

void writeText(){
  fill(0, 255, 0);
  text("Light Level: " + lightLevel, xPos+180, yPos+80); 
  text("Contrast Meter", 463, 192);
  fill(0, 106, 252);
  text("Temperature: "+temperature, xPos1+59, yPos1+77);
}

void drawTempMeter(){
  for(int i = xPos1 ; i <= width/3*2 ; i+=40){
   strokeWeight(2); 
   line(i, yPos1-10, i, yPos1+10);   
  }
  strokeWeight(4);
  line(xPos1, yPos1, xPos1+220, yPos1);
  fill(255, 0, 0);
  triangle(xPos1+220, yPos1-5, xPos1+220, yPos1+5, xPos1+230, yPos1);
}

void drawTempLabel(){
  //scale of 10
  fill(0, 106, 252);
  text("0", xPos1-4, yPos1-25);
  text("10", xPos1+36, yPos1-25);
  text("20", xPos1+76, yPos1-25);
  text("30", xPos1+116, yPos1-25);
  text("40", xPos1+156, yPos1-25);
  text("50", xPos1+196, yPos1-25);

}

void drawTempPointer(){
 float PtrXpos = temperature*200/50; 
 int PtrYpos = 293;
 fill(0, 106, 252);
 triangle(PtrXpos+197, PtrYpos+20, PtrXpos+200, PtrYpos+10, PtrXpos+203, PtrYpos+20);
 text(temperature, PtrXpos+176, PtrYpos+36);
}

void ContrastMeter(){
  int blue = lightLevel*252/1000; //Controls the contrast of blue and green.
  int green = lightLevel*112/1000;
  noStroke();
  fill(0,green,blue); 
  rect(394,163,54,54);
}