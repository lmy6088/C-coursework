#include <EngduinoThermistor.h>
#include <EngduinoLEDs.h>
#include <EngduinoLight.h>

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  EngduinoThermistor.begin();
  EngduinoLEDs.begin();
  EngduinoLight.begin();
  EngduinoLEDs.setLED(0, GREEN);

}

void loop() {
  // put your main code here, to run repeatedly:
  float temp = EngduinoThermistor.temperature();
  int lightlvl = EngduinoLight.lightLevel(); 
  
  Serial.print(temp);
  Serial.print(",");
  Serial.print(lightlvl);
  Serial.println();
  
  delay(10);
 
}
