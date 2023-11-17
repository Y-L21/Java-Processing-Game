float xPos;
float yPos;
float playerSize;
float playerRadius;
float velocity;
float xPos2;
float yPos2;
Boolean menuScreen = true;
Boolean singlePlayerInstructionScreen = false;
Boolean singlePlayerScreen = false;
Boolean twoPlayerInstructionScreen = false;
Boolean twoPlayerScreen = false;
Boolean chaserWinsScreen = false;
Boolean runnerWinsScreen = false;
Boolean quitGameScreen = false;
float ballSize;
float ballRadius;
import processing.video.*;
Movie chaserWinsVid, staringVid, runnerWinsVid;
float eX;
float eY;
float easing = 0.01;
Timer timer;
int currentTime;
int countdownTime;
int maxTime;
String s;


void setup()
{
  fullScreen();
  size(800, 800);
  xPos = width/2;
  yPos = height/2;
  playerSize = 50;
  chaserWinsVid = new Movie(this, "chaserWinsVid.mp4");
  staringVid = new Movie(this, "staringVid.mp4");
  runnerWinsVid = new Movie(this, "runnerWinsVid2.mp4");
  timer = new Timer(1000);
  s = "";
  currentTime = 0;
  maxTime = 11;
  countdownTime = maxTime;
}

void draw()
{
  background(4, 54, 74);
  playerRadius = playerSize/2;

  if (menuScreen == true)
  {
    menuScreen();
    quitGame();
  }

  if (singlePlayerInstructionScreen == true)
  {
    singlePlayerInstructions();
    quitGame();
  }

  if (singlePlayerScreen == true)
  {
    quitGame();
    fill(#1AD4D8);
    circle(xPos, yPos, playerSize);

    // SPAWNS THE BALL THAT NEEDS TO BE CHASED
    runningBall();

    // PLAYER MOVEMENT METHOD
    playerMovement();

    // IMPACT DETECTION METHOD
    impactDetection();
  }

  if (twoPlayerInstructionScreen == true)
  {
    twoPlayerInstructions();
    quitGame();
  }

  if (twoPlayerScreen == true)
  {
    quitGame();

    // DISPLAYED TIMER
    if (timer.complete() == true)
    {
      if (countdownTime > 0)
      {
        countdownTime --;
        timer.start();
      } else {
        runnerWinsScreen = true;
      }
    }
    textSize(200);
    s = "Time left: " + countdownTime + "s";
    text(s, width/2, height/2);

    fill(#1AD4D8);
    circle(xPos, yPos, playerSize);

    // RUNNER METHOD
    runner();

    // PLAYER MOVEMENT METHOD
    playerMovement();

    // IMPACT DETECTION METHOD
    impactDetectionTwo();
  }

  if (chaserWinsScreen == true)
  {
    quitGame();
    textSize(50);
    //background(random(0, 255), random(0, 255), random(0, 255));
    text("CHASER WINS!", width/2, 500);
    text("TIME TO JERSEY BOP IN VICTORY!!!", width/2, 600);
    text("CLICK SPACE FOR HELP!!!", width/2, 700);
    if (key == ' ')
    {
      background(random(0, 255), random(0, 255), random(0, 255));
      for (int row=0; row<5; row++)
      {
        for (int col=0; col<6; col++)
        {
          // MAKE THIS FILL THE ENTIRE SCREEN
          image(chaserWinsVid, 20 + col*320, 50 + row*200, 280, 180);
          chaserWinsVid.loop();
        }
      }
    }
  }

  if (runnerWinsScreen == true)
  {
    quitGame();
    textSize(50);
    background(4, 54, 74);
    //background(random(0, 255), random(0, 255), random(0, 255));
    text("RUNNER WINS!", width/2, 500);
    text("TIME TO JERSEY BOP IN VICTORY!!!", width/2, 600);
    text("CLICK SPACE FOR HELP!!!", width/2, 700);
    if (key == ' ')
    {
      background(random(0, 255), random(0, 255), random(0, 255));
      for (int row=0; row<5; row++)
      {
        for (int col=0; col<6; col++)
        {
          // MAKE THIS FILL THE ENTIRE SCREEN
          image(runnerWinsVid, 20 + col*320, 50 + row*200, 280, 180);
          runnerWinsVid.loop();
        }
      }
    }
  }

  if (quitGameScreen == true)
  {
    // MAYBE NOT LOOPING BECAUSE ITS A GIF????
    chaserWinsVid.stop();
    runnerWinsVid.stop();
    fill(218, 255, 251);
    textSize(50);
    textAlign(LEFT);
    text("What are you doing here...", width/2+170, 500);
    text("It took me several WEEKS to make this.", width/2+50, 600);
    text("Click 'f' to quit the game... loser.", width/2+100, 700);
    staringVid.loop();
    image(staringVid, 100, 350);
    if (key == 'f')
    {
      exit();
    }
  }



  // stopping the circle from leaving the screen

  if (xPos <= 0)
  {
    xPos = 0;
  } else if (xPos >= width)
  {
    xPos = width;
  }
  if (yPos >= height)
  {
    yPos = height;
  } else if (yPos <= 0)
  {
    yPos = 0;
  }
}

// player movement keys

void playerMovement()
{
  if (key == 'w')
  {
    yPos -= velocity;
  }
  if (key == 's')
  {
    yPos += velocity;
  }
  if (key == 'a')
  {
    xPos -= velocity;
  }
  if (key == 'd')
  {
    xPos += velocity;
  }
}

// changing velocity of the circle (1 = slowest, 0 = fastest)

void selectingLevel()
{
  if (key == '1')
  {
    velocity = 1;
  }
  if (key == '2')
  {
    velocity = 2;
  }
  if (key == '3')
  {
    velocity = 3;
  }
  if (key == '4')
  {
    velocity = 4;
  }
  if (key == '5')
  {
    velocity = 5;
  }
  if (key == '6')
  {
    velocity = 6;
  }
  if (key == '7')
  {
    velocity = 7;
  }
  if (key == '8')
  {
    velocity = 8;
  }
  if (key == '9')
  {
    velocity = 9;
  }
  if (key == '0')
  {
    velocity = 10;
  }
}

// CODE FOR RUNNING BALL
void runningBall()
{
  fill(218, 255, 251);
  float smoothness = 0.025;
  ballSize = 20;
  ballRadius = ballSize/2;
  xPos2 = noise(frameCount * smoothness, 0) * width;
  yPos2 = noise(frameCount * smoothness, 1) * height;
  circle(xPos2, yPos2, ballSize);
}

// TAB TO QUIT THE GAME
void quitGame()
{
  if (key == 'p')
  {
    menuScreen = false;
    singlePlayerInstructionScreen = false;
    singlePlayerScreen = false;
    twoPlayerInstructionScreen = false;
    twoPlayerScreen = false;
    chaserWinsScreen = false;
    runnerWinsScreen = false;
    quitGameScreen = true;
  }
}


// IMPACT METHOD
void impactDetectionTwo()
{
  Boolean impact = dist(xPos, yPos, eX, eY) < ballRadius + playerRadius;
  if (impact == true)
  {
    twoPlayerScreen = false;
    chaserWinsScreen = true;
    //impact = false;
  }
}

// IMPACT METHOD
void impactDetection()
{
  Boolean impact = dist(xPos, yPos, xPos2, yPos2) < ballRadius + playerRadius;
  if (impact == true)
  {
    singlePlayerScreen = false;
    chaserWinsScreen = true;
    //impact = false;
  }
}

void movieEvent(Movie videoBuffer)
{
  videoBuffer.read();
}

void runner()
{
  fill(218, 255, 251);
  ballSize = 20;
  ballRadius = ballSize/2;
  float targetX = mouseX;
  float dx = targetX - eX;
  eX += dx * easing;

  float targetY = mouseY;
  float dy = targetY - eY;
  eY += dy * easing;

  circle(eX, eY, ballSize);
}

void menuScreen()
{
  chaserWinsScreen = false;
  runnerWinsScreen = false;
  fill(218, 255, 251);
  textSize(100);
  textAlign(CENTER);
  text("WELCOME!", width/2, 250);
  textSize(25);
  text("'p' = exit", 60,40);

  //  CIRCLE "1 PLAYER"
  fill(23, 107, 135);
  noStroke();
  float onePlayerButton = dist(width/2-400, 600, mouseX, mouseY);
  if (onePlayerButton<=200)
  {
    fill(100, 204, 197);
    if (mousePressed && (mouseButton == LEFT))
    {
      singlePlayerInstructionScreen = true;
      menuScreen = false;
    }
  }

  circle(width/2-400, 600, 400);
  fill(218, 255, 251);
  textSize(80);
  text("1 PLAYER", width/2-400, 625);


  //  CIRCLE "2 PLAYERS"
  fill(23, 107, 135);
  noStroke();
  float twoPlayersButton = dist(width/2+400, 600, mouseX, mouseY);
  if (twoPlayersButton<=200)
  {
    fill(100, 204, 197);
    if (mousePressed && (mouseButton == LEFT))
    {
      twoPlayerInstructionScreen = true;
      menuScreen = false;
    }
  }
  circle(width/2+400, 600, 400);
  fill(218, 255, 251);
  textSize(80);
  text("2 PLAYERS", width/2+400, 625);
}

void singlePlayerInstructions()
{
  selectingLevel();
  fill(#1AD4D8);
  circle(xPos, yPos, playerSize);
  playerMovement();
  fill(218, 255, 251);
  textSize(50);
  textAlign(CENTER);
  text("This is the HARDEST game you will ever play... capture the ball and you win!", width/2, 350);
  text("Select your speed from 1 (slowest) - 0 (fastest)", width/2, 450);
  text("Use 'w', 'a', 's', 'd' to move your character", width/2, 550);
  text("If you want to quit the game just click 'p'.", width/2, 650);
  text("Click 'm' to start the game!", width/2, 750);
  textSize(10);
  text("If you're epileptic DON'T play.", width/2+500, 950);
  if (key == 'm')
  {
    singlePlayerInstructionScreen = false;
    singlePlayerScreen = true;
  }
}

void twoPlayerInstructions()
{
  selectingLevel();
  fill(#1AD4D8);
  circle(xPos, yPos, playerSize);
  playerMovement();
  runner();
  fill(218, 255, 251);
  textSize(50);
  textAlign(CENTER);
  text("The 'Chaser' will try to capture the 'Runner' before the 10 second countdown is up!", width/2, 250);
  text("Select the speed of the Chaser from 1 (slowest) - 0 (fastest)", width/2, 350);
  text("Use 'w', 'a', 's', 'd' to move the Chaser.", width/2, 450);
  text("Use the mouse to move the Runner.", width/2, 550);
  text("If you want to quit the game just click 'p'.", width/2, 650);
  text("Click 'm' to start the game!", width/2, 750);
  textSize(10);
  text("If you're epileptic DON'T play.", width/2+500, 950);
  if (key == 'm')
  {
    twoPlayerInstructionScreen = false;
    twoPlayerScreen = true;
  }
}

class Timer
{
  int startTime;
  int interval;

  Timer(int timeInterval)
  {
    interval = timeInterval;
  }

  void start()
  {
    startTime = millis();
  }
  Boolean complete()
  {
    int elapsedTime = millis() - startTime;
    if (elapsedTime > interval)
    {
      return true;
    } else
    {
      return false;
    }
  }
}
