import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

BallClass ball; 
int analogPin = 0;
int analogPin1 = 1;

PVector player1, player2; 
int playerW = 15; // width of paddle
int playerH = 60; // hieght of paddle
int control1 = 8;
int control2 = 10;
int read1;
int read2;
float px;
float py;

//float r2 = .5;
//float speed = 4; 

PImage tsuru;

void setup() {
  size(1000, 800); 
  smooth();// make the graphics look purdy. 
  rectMode(CENTER); // draw rects from center
  player1 = new PVector(20, height/2); 
  player2 = new PVector(width -20, height/2); 
  ball = new BallClass();
  arduino = new Arduino(this, Arduino.list()[5], 57600);
  
  arduino.pinMode(control1, Arduino.INPUT);//setup pins to be input (A0 = 0?)
  arduino.pinMode(control2, Arduino.INPUT);//setup pins to be input (A0 = 0?)

  tsuru = loadImage("tsuru.png");
  imageMode(CENTER);
}


void draw () {
  background (50);// background color

  blueCrane();
  redCrane();
  ball.move(); 
  ball.display();

  read1=arduino.digitalRead(control1);
  println("p1: "+ read1);
  
  read2=arduino.digitalRead(control2);
  println("p2: " + read2);
}

void blueCrane() { 
  //player1.y = map(pot1, 0, 1, 0, height); 
  rect(player1.x, player1.y, playerW, playerH);

  if (read1 == 1) { // check the state of our boolean
    player1.y--;
  } else { // if the boolean is false 
    player1.y++;
  }

  if (player1.y < 0) { 
    player1.y = 0;
  } else if (player1.y > height) {
    player1.y = height;
  }
}

void redCrane() {
   //player1.y = map(pot1, 0, 1, 0, height); 
  rect(player2.x, player2.y, playerW, playerH);

  if (read2 == 1) { // check the state of our boolean
    player2.y--;
  } else { // if the boolean is false 
    player2.y++;
  }

  if (player2.y < 0) { 
    player2.y = 0;
  } else if (player2.y > height) {
    player2.y = height;
  }
}