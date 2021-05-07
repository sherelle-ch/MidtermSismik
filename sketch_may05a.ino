#include <Servo.h>

Servo myservo;

const int potensio1 = A0;
const int potensio2 = A1;
const int btnpin = 12;
const int servpin = 4;
boolean states = false; 
char command;

void setup() {
  // put your setup code here, to run once:
  myservo.attach(servpin);
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
 while (Serial.available() > 0) {
   command = Serial.read();}
   
 int statbut = digitalRead(btnpin);
 if ((statbut == HIGH) or (command == '1')) {
  states=!states;
 }
 
 int pot1 = analogRead(potensio1);
 int pot2 = analogRead(potensio2);
 
 if (states==false) {
  int posserv = map(pot1, 0, 1023, 0, 180);
  myservo.write(posserv);
  Serial.print('s');
  Serial.println(posserv);
  Serial.print('a');
  Serial.println(pot2);
 } else {
  int posserv = map(pot2, 0, 1023, 0, 180);
  myservo.write(posserv);
  Serial.print('s');
  Serial.println(posserv);
  Serial.print('a');
  Serial.println(pot1);
 }
 delay(300);
 command = '0';
}
