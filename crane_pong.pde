import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

import processing.video.*;
Movie movie;

BallClass ball;

PVector player1, player2;
int playerW = 15; // width of paddle
int playerH = 60; // hieght of paddle
int control1 = 2;
int control2 = 4;
int read1;
int read2;

float px;
float py;

float speed = 10;

int blueFrames = 16;
int bFrame = 0;
PImage[] blue = new PImage[blueFrames];
long btimer;
float bFramespeed = 150;

int redFrames = 16;
int rFrame = 0;
PImage[] red = new PImage[redFrames];
long rtimer;
float rFramespeed = 150;


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

  movie = new Movie(this, "clouds.mov");
  movie.loop();

  // blue images
  blue[0]  = loadImage("1b.png");
  blue[1]  = loadImage("2b.png");
  blue[2]  = loadImage("3b.png");
  blue[3]  = loadImage("4b.png");
  blue[4]  = loadImage("5b.png");
  blue[5]  = loadImage("6b.png");
  blue[6]  = loadImage("7b.png");
  blue[7]  = loadImage("8b.png");
  blue[8]  = loadImage("9b.png");
  blue[9]  = loadImage("10b.png");
  blue[10] = loadImage("11b.png");
  blue[11] = loadImage("12b.png");
  blue[12] = loadImage("13b.png");
  blue[13] = loadImage("14b.png");
  blue[14] = loadImage("15b.png");
  blue[15] = loadImage("16b.png");

  // red images
  red[0]  = loadImage("1r.png");
  red[1]  = loadImage("2r.png");
  red[2]  = loadImage("3r.png");
  red[3]  = loadImage("4r.png");
  red[4]  = loadImage("5r.png");
  red[5]  = loadImage("6r.png");
  red[6]  = loadImage("7r.png");
  red[7]  = loadImage("8r.png");
  red[8]  = loadImage("9r.png");
  red[9]  = loadImage("10r.png");
  red[10] = loadImage("11r.png");
  red[11] = loadImage("12r.png");
  red[12] = loadImage("13r.png");
  red[13] = loadImage("14r.png");
  red[14] = loadImage("15r.png");
  red[15] = loadImage("16r.png");

  btimer = millis();
  rtimer = millis();
  imageMode(CENTER);
}


void draw () {
  //background (50);// background color
  if (movie.available() == true) {
    movie.read();
  }


  image(movie, 500, 400, width, height);
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
  //rect(player1.x, player1.y, playerW, playerH);
  image(blue[bFrame], player1.x, player1.y);
  if (read1 == 1) { // check the state of our boolean
    player1.y -= speed;
    if (millis() - btimer > bFramespeed) {
      btimer = millis();
      bFrame++;
    } if (bFrame == blueFrames) {
      bFrame = 0;
    }
  } else { // if the boolean is false
    player1.y += speed;
    bFrame = 0;
  }

  if (player1.y < 0) {
    player1.y = 0;
  } else if (player1.y > height) {
    player1.y = height;
  }
}

void redCrane() {
   //player1.y = map(pot1, 0, 1, 0, height);
  //rect(player2.x, player2.y, playerW, playerH);
  image(red[rFrame], player2.x, player2.y);
  if (read2 == 1) { // check the state of our boolean
    player2.y -= speed;
    if (millis() - rtimer > rFramespeed) {
      rtimer = millis();
      rFrame++;
    } if (rFrame == redFrames) {
      rFrame = 0;
    }
  } else { // if the boolean is false
    player2.y += speed;
    rFrame = 0;
  }

  if (player2.y < 0) {
    player2.y = 0;
  } else if (player2.y > height) {
    player2.y = height;
  }
}