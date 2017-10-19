import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

BallClass ball; 
int analogPin = 0;
int analogPin1 = 1;

PVector player1, player2; 
int playerW = 15; // width of paddle
int playerH = 60; // hieght of paddle
int read;
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

  tsuru = loadImage("tsuru.png");
  imageMode(CENTER);
}


void draw () {
  background (50);// background color
  int pot1 = arduino.analogRead(analogPin); 
  int pot2 = arduino.analogRead(analogPin1); 
  player1.y = map(pot1, 0, 1023, 0, height); 
  player2.y = map(pot2, 0, 1023, 0, height);

  rect(player1.x, player1.y, playerW, playerH); 
  rect(player2.x, player2.y, playerW, playerH); 
  ball.move(); 
  ball.display();
  
   read=arduino.digitalRead(sensor);
  println(read);
}

class BallClass {
  PVector ballLoc, velocity; 
  int ballsize = 64; // width of ball
  BallClass() {
    ballLoc = new PVector(width/2, height/2);
    velocity  = new PVector(3, 3);
  }

  void move() {
    ballLoc.add(velocity); 
    if (ballLoc.x > width || ballLoc.x < 0) {
      velocity.x *= -1;
    }
    if (ballLoc.y > height || ballLoc.y < 0) {
      velocity.y *= -1;
    }

    //if (collide(player1.x, player1.y)) {
    //  ballLoc.x = player1.x + playerW/2 + ballsize/2;
    //  velocity.x *= -1;
    //  velocity.y *= -1;
    //}

    //if (collide(player2.x, player2.y)) {
    // //ballLoc.x = player1.x + playerW/2 + ballsize/2;
    // velocity.x *= -1;
    // velocity.y *= -1;
    //}

    //    if (ballLoc.x + ballsize/2 > player1.x - playerW/2 &&
    //      ballLoc.x - ballsize/2 < player1.x + playerW/2 &&
    //      ballLoc.y + ballsize/2 < player1.y + playerH/2 &&
    //      ballLoc.y - ballsize/2 > player1.y - playerH/2) {
    //      //velocity.x *= -1;
    //      velocity.x *= -1;
    //      velocity.y *= -1;
    //    }

    //    if (ballLoc.x + ballsize/2 > player2.x - playerW/2 &&
    //      ballLoc.x - ballsize/2 < player2.x + playerW/2 &&
    //      ballLoc.y + ballsize/2 < player2.y + playerH/2 &&
    //      ballLoc.y - ballsize/2 > player2.y - playerH/2) {
    //      //velocity.x *= -1;
    //      velocity.x *= -1;
    //      velocity.y *= -1;
    //    }

    if (paddleCollide(player1.x, player1.y)) {
      velocity.x *= -1;
      velocity.y *= -1;
    }


    if (paddleCollide(player2.x, player2.y)) {
      velocity.x *= -1;
      velocity.y *= -1;
    }
  }

  boolean paddleCollide(float px, float py) {
    if (ballLoc.x + ballsize/2 > px - playerW/2 && 
      ballLoc.x - ballsize/2 < px + playerW/2 && 
      ballLoc.y + ballsize/2 > py - playerH/2 && 
      ballLoc.y - ballsize/2 < py + playerH/2 
      ) {
      return true;
    } else {
      return false;
    }
  }


  void display() {
    ellipse(ballLoc.x, ballLoc.y, ballsize, ballsize);
    //image(tsuru, ballLoc.x, ballLoc.y, ballsize, ballsize);
  }
}