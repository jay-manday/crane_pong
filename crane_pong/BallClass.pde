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