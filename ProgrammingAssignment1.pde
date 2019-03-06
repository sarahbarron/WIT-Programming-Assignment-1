/*
 Name : Sarah Barron
 Student Number: 20013679
 
 HDIP Computer Science - WIT - February 2019
 Programming assignment 1.
 
 The is a project based on the game Hangman which is a popular word guessing game. 
 The user is given 8 lives for each wrong guess you lose a life and another part of
 the hangman diagram is drawn when you have lost all your lives the man is hanged. 
 If the user guesses the right word the man’s life is spared and he is set free. 
 Once the game is either lost or won the user gets the option to play again.
 */

//imported JOptionPane for dialog box
import javax.swing.JOptionPane;

/*ARRAY
 An array containing 50 Random dictionary words, each word contains more than 6 characters. 
 These words were generated from https://randomwordgenerator.com/ */
String[] miniDictionary ={"drawing", "earthflax", "interface", "rhetoric", "surface", "qualification", 
  "unlikely", "consciousness", "reflection", "committee", "complex", "friendly", 
  "chauvinist", "pavement", "decorative", "benefit", "serious", "complete", "liberal", 
  "transparent", "display", "undress", "illustrate", "execute", "aquarium", "trouble", 
  "eternal", "research", "density", "steward", "produce", "astonishing", "romantic", 
  "childish", "limited", "nervous", "battery", "challenge", "fashion", "remunerate", 
  "qualified", "leftovers", "section", "digital", "constitution", "combination", 
  "athlete", "strange", "distortion", "exposure"};

/*STRINGS
 A string to hold all letters that have been guessed or clicked on */
String allGuesses="";
// Stores the hangman word
String hangmanWord="_";
// Stores the string with right guessed letters or a '_' for unguessed letters 
String rightGuess="";
// Stores the string to be shown in the speech bubble text
String speechBubbleText;
// Stores the username
String userName="username";

/* INTS
 Y coordiante of the outer part of the arm */
int armY = 400;
// X coordinate of the outer part of the left leg
int leftLegX = 670;
// The x co-ordinate of the game over bubble containing the hangman word
int gameoverEllipseX=0;
// The y co-ordinate of the game over bubble containing the hangman word
int gameoverEllipseY=410;
// the length of the hangman word
int wordLen;
// stores the number of wrong guesses
int wrongGuess=0;
// x & y coordiantes of the head
int xCoord = 675;
int yCoord = 330;
// constant diameter value used in various ellipses through out the code
int diameter = 100;
// game over x and y coordinates
int gameOverX=100;
int gameOverY=100;
// x and y coordinates of the colored bubbles when the user wins
int drawWinnerBubblesY;
int drawWinnerBubblesX;

/* FLOATS
 Index values used in the final screen when the user wins or loses it increments
 the final screen with the bubble effect for the winner & brick effect for the loser*/
float bubbleIndex = 200;
float brickIndex = 100;

/* BOOLEANS
 The boolean flag when set to true moves the hangman word and bubble backwards */
boolean bounceBack = false;
// The boolean flags for the direction of the moving body
boolean centerToLeft=true;
boolean leftToCenter=false;
boolean centerToRight=false;
boolean rightToCenter=false;
// boolean flags to tell the legs to swing left or right
boolean swingLegsRight=true;
boolean swingLegsLeft=false;
// booleans to store if the person has won or lost
boolean loser = false;
boolean winner = false;
// when the person clicks no on the play again JOption Pane gameOver boolean is set to true
boolean gameOver = false;
// boolean flags for moving the arms up or down waving goodbye in the game over screen
boolean gameOverArmUp = false;
boolean gameOverArmDown = true;

// the method setup is used to setup the initial window
void setup() 
{
  // size of display window
  size(1000, 1000);
  // reduced the frame rate to 30 per second
  frameRate(30);
  // initial stroke color set to black
  stroke(0);
  // initial stroke weight set to 5
  strokeWeight(5);
  // initial fill color set to black
  fill(0);
  /* Input Dialog box asking the user for a username with a maximum of 9 characters
   this username is converted to uppercase and white spaces from the beginning and 
   end are deleted */
  userName = JOptionPane.showInputDialog(null, 
    "LETS PLAY \n HANGMAN \n YOU HAVE 8 LIVES \n\n ENTER YOUR USERNAME \n(maximum of 9 characters)", "username").toUpperCase().trim(); 
  /* if the username input is greater than 9 characters, 
   the username is cut to the 1st 9 characters using substring */
  if (userName.length()>9)
  {
    userName = userName.substring(0, 9);
  }
  // Stores a String returned from the getRandomWord method
  hangmanWord = getRandomWord();
  // Stores the lenght of the hangmanWord
  wordLen= hangmanWord.length();
  /* loops until it reaches the lenght of the hangman word
   adding the char '_' for each letter of the word to the 
   String called rightGuess */
  for (int i=0; i<wordLen; i++) 
  {
    rightGuess = rightGuess+'_';
  }
}


/* The draw method to continuously draw the alphabeth, the hangman diagram, the 
 right guesses and winner bubbles if the user winsand waits for mouse clicks */
void draw() 
{ 
  // if the game is not over
  if (!gameOver)
  {
    // checks if the hangman word and the rightGuess string are the same
    if (hangmanWord.equals(rightGuess))
    {
      /* if they are the same it means the user has guessed the right
       word so the gameOverWinner method is called */
      gameOverWinner();
    }
    // set the background to grey
    background(160);
    // If the user has not won call the printAlphabet method
    if (!winner)
    {
      printAlphabet();
    }
    // call the printWord method which prints '_' or correctly guessed letters
    printWord();
    // print the hangman diagram
    printHangmanDiagram();
    // if the user has won call the drawWinnerBubbles method
    if (winner)
    {
      drawWinnerBubbles();
    }
  }
  // if the user chooses not to play another game by clicking no on the JOption panel
  if (gameOver)
  {
    // call the gameOverExit method
    gameOverExit();
  }
}


// Method to return a String which is a random word from the miniDictionary array
String getRandomWord() 
{
  // Get a random number between 0 and 50 (as there are 50 words in the array)
  int index = (int)random(0, 50);  
  // Get the word that is stored in the miniDictionary array positioned at the random number
  String word = miniDictionary[index];
  // convert the word to upper case
  word = word.toUpperCase();
  //return this word
  return word;
}


void mouseClicked() {
  // letter is set to capital A so checking will start from capital A after every click 
  char letter='A';
  /* If the game is over don't do anything when the user clicks on the screen 
   otherwise do the following */
  if (!loser && !winner)
  {     
    /* Loop the letters to find the letter where the user clicked by checking the x coordinate 
     and y coordinate against where they are positioned in the drawn alphabet
     - the Y coordinate must be between 64px and 109px as this is the y coordinates of the 
     alphabet diagram.
     - the loop continues to increase the letter ASCII value until the loop reaches a point 
     where the mouse X is greater than the letters ASCII value */
    while (mouseX>((letter*36)-2300+18) && mouseY>64 && mouseY<109) 
    {
      letter++;
    }
    /* If a letter was clicked we know this if the
     - ASCII value is between 65 and 90 (values for capital letters)
     - the mouse y coordinate is greather than 64 and less than 109
     - the mouse x coordinate is greater than 22 (where the A rectangle starts) */
    if (letter<=90 && letter>=65 && mouseY>64 && mouseY<109 && mouseX>22) 
    {
      /* assign the letter that was clicked to letterSelected
       (decrement the letter by 1 value as the while loop has caused it to move to the next ASCII letter) */
      char letterSelected = letter--;
      // if the letter has been guessed previously open a jOption pane to inform the user
      if (allGuesses.contains(Character.toString(letterSelected)))
      {
        JOptionPane.showMessageDialog(null, 
          userName+" SELECT A LETTER YOU HAVE NOT GUESSED BEFORE", "HANGMAN", 
          JOptionPane.PLAIN_MESSAGE);
      }
      // if the letter has not been guessed previously
      if (!(allGuesses.contains(Character.toString(letterSelected))))
      { 
        // add the letter to the allGuesses String
        allGuesses = allGuesses+letterSelected;
        /* pass the guessed letter to the isGuessRightOrWrong method 
         to check if the letter is right or wrong */
        isGuessRightOrWrong(letterSelected);
      }
    }
    /* Otherwise the user has not clicked on any letter therefore open a JOption pane
     display with a message to the console prompting the user to select a letter*/
    else 
    {
      JOptionPane.showMessageDialog(null, 
        "PLEASE SELECT A LETTER FROM THE LIST OF ALPHABET \n LETTERS AT THE TOP OF THE SCREEN", "HANGMAN", 
        JOptionPane.PLAIN_MESSAGE);
    }
  }
}


// method to check if the letter passed to it is in the hangman word or not 
void isGuessRightOrWrong(char letter) 
{

  // if the hangman word contains the letter
  if (hangmanWord.contains(Character.toString(letter)))
  {
    // loop throught each letter to find the letters position in the word 
    for (int i=0; i<wordLen; i++) 
    {
      //if the letter is eaqual to the character at index i
      if (letter==hangmanWord.charAt(i)) 
      {
        // add the letter to the rightGuess string in its right position and remove the '_'
        rightGuess = rightGuess.substring(0, i)+letter+rightGuess.substring(i+1, wordLen);
      }
    }
  }
  // otherwise the letter is not in the hangman word so increase the number of wrong guesses BY 1
  else 
  {
    wrongGuess++;
  }
}


// Method to print the alphabet, surrounded by a rectangle
void printAlphabet()
{
  // start at the letter A
  char letter = 'A';
  // set the stroke weight to 5
  strokeWeight(5);
  // Prints a rectangle around each capital letter of the alphabet
  for (int i=0; i<26; i++) 
  {
    // set the text size to 35px
    textSize(35);
    // center align the text
    textAlign(CENTER);
    /* if the letter has been guessed already & it was a 
     right guess make the rectangle green */
    if (rightGuess.contains(Character.toString(letter)))
    {
      fill(0, 255, 0);
    } 
    /* if the letter has been guessed already & it was a 
     wrong guess make the rectangle red */
    else if (allGuesses.contains(Character.toString(letter)))
    {
      fill(255, 0, 0);
    } 
    /* otherwise the letter hasn't been clicked on before so 
     make the rectangle white */
    else
    {
      fill(255);
    }
    /* draw a rectangle around the letter
     the letter ASCII value needed to be multiplyed by the text size plus 1
     so that each rectangle would surround each letter evenly. This multiplicaton caused the 
     rectangles to move to far along the x axis and out of view so 2318 needed to
     be subtracted to position it properly on the screen */
    rect((letter*36)-2318, 64, 36, 45);
    // set the text color to black
    fill(0);
    /* draw the letter 
     Just like the rectangles The x coordinate of each letter needed to be multiplied by the 
     character size plus 1 in order for the letters to be spread evenly across the screen otherwise 
     they appear squashed together, this however caused the letters to move to far along the x axis 
     so 2300 needed to be subtracted to position the letters correctly on the screen*/
    text(letter, (letter*36)-2300, 100);
    // increment the letter (ASCII value)
    letter++;
  }
}


//prints either dashes or right guessed letters at the bottom of the screen
void printWord()
{
  // set the text color to black
  fill(0);
  // set the text size to 70px
  textSize(70);
  // draw the rightGuess String at the bottom of the screen
  text(rightGuess, 300, height-100);
}


// This is the method that draws the hangman diagram on the screen
void printHangmanDiagram() 
{
  // set the stroke weight to 10px
  strokeWeight(10);
  /* if the the user has less than 2 wrong guesses and the person 
   hasn't lost and hasn't won the game print the uername and number of 
   guesses left in large text on the screen */
  if (wrongGuess<=1 && !winner && !loser)
  {
    // text size 37px
    textSize(37);
    // color the text blue
    fill(0, 0, 255);
    // print username, the text and the number of guesses left
    text(userName+"\n YOU HAVE "+ (8-wrongGuess) +" GUESSES", 510, 500);
  }
  /* if the  number of wrong guesses is greater than 0
   and the person has not won draw the hangman STAND */
  if (wrongGuess>0 && !winner)
  {
    // color the stand black
    fill(0);
    // draw the tall rectangle 
    rect(250, 150, 50, 600);
    // draw the top rectangle 
    rect(250, 150, 500, 50);
    /* if the person hasn't lost and hasn't won draw a static rope at the top of the
     stand these cordinates will change as it will start swinging as the body swings */
    if (!loser && !winner)
    {
      line(xCoord, yCoord-150, xCoord, yCoord);
    }
    /* otherwise if the person has lost or won draw a static rope on the stand otherwise
     the rope would have began falling with the hangman when the game was won or lost*/
    else
    {
      line(675, 180, 675, 310);
    }
  }
  /* if the wrong guess is greater than 1
   or the person has won, draw the head & face  */
  if (wrongGuess>1||winner)
  {
    // reduce the stroke weight to 4px
    strokeWeight(4);
    // if person hasn't won and hasn't lost
    if (!loser && !winner)
    {
      // set the speech bubble text with the username & number of guesses left
      speechBubbleText = "HELP "+userName+" \n you have only \n" + (8-wrongGuess) +" guesses left";

      /* If the man is set to move from center to left
       reduce the x & y coordinates by 1px*/
      if (centerToLeft) 
      {
        yCoord --;
        xCoord --;
        /* when the y coordinate reaches 315px or goes below
         change the direction of the man to move from left to center*/
        if (yCoord<=315)
        {
          centerToLeft=false;
          leftToCenter = true;
        }
      } 
      /* if the man is set to move from left to center increase
       the x and y coordinates by 1px*/
      else if (leftToCenter)
      {
        yCoord++;
        xCoord++;
        /* once the y coordiante reaches the center y coordinate of 330px 
         change the direction of the man to move from center to right */
        if (yCoord==330)
        {
          leftToCenter=false;
          centerToRight=true;
        }
      } 
      /* if the man is set to move from center to right increase 
       the x coordiante and reduce the y coordiante by 1px */
      else if (centerToRight)
      {
        xCoord++;
        yCoord--;
        /* once the y coordinate is less than or equal to 315px chanage
         the direction of the man to move from right to center */
        if (yCoord<=315)
        {
          centerToRight=false;
          rightToCenter=true;
        }
      }
      /* if the man is set to move from right to center reduce the x 
       coordinate and increase the coordinate by 1px */
      else if (rightToCenter)
      {
        xCoord--;
        yCoord++;
        /* once the y coordinate reaches the center 330px change the direction
         of the man to move from center to left */
        if (yCoord==330) {
          rightToCenter=false;
          centerToLeft=true;
        }
      }
    }
    /* draw a circle head
     if the user has lost the game make the hangman red in color */
    if (loser)
    {
      fill(255, 0, 0);
    }
    // if the user has won the game make the hangman green in color
    else if (winner)
    {
      fill(0, 255, 0);
    }
    // draw the head 
    ellipse(xCoord, yCoord, diameter, diameter); 
    // if you have lost draw shut eyes with lines
    if (loser)
    {
      line(xCoord-20, yCoord-20, xCoord-10, yCoord-20);
      line(xCoord+10, yCoord-20, xCoord+20, yCoord-20);
    } 
    // otherwise if you haven't lost draw circle eyes
    else
    {
      // draw 2 white eyes
      fill(255);
      ellipse(xCoord-20, yCoord-20, diameter/4, diameter/4);
      ellipse(xCoord+20, yCoord-20, diameter/4, diameter/4);
      // draw 2 black pupils
      fill(0);
      ellipse(xCoord-20, yCoord-20, diameter/30, diameter/30);
      ellipse(xCoord+20, yCoord-20, diameter/30, diameter/30);
    }
    // if you are a winner
    if (winner)
    {
      // draw a white circle mouth
      stroke(0);
      fill(255);
      ellipse(xCoord, yCoord+20, diameter/2.5, diameter/2.5);
      // draw a green rectangle over half the mouth to make it look like a happy face
      fill(0, 255, 0);
      noStroke();
      rect(xCoord-30, yCoord-6, 60, 30);
    }
    // if you are a loser 
    else if (loser)
    { 
      // draw a sad face with his mouth as 2 lines pointing downwards
      fill(255);
      line(xCoord, yCoord+20, xCoord-20, yCoord+30);
      line(xCoord, yCoord+20, xCoord+20, yCoord+30);
    }
    // otherwise if you haven't won or lost draw a straight white mouth
    else
    {
      stroke(255);
      line(xCoord-20, yCoord+25, xCoord+20, yCoord+25);
    }
    // if you have won or lost make the nose black
    if (loser || winner)
    {
      stroke(0);
    }
    // otherwise the nose is white
    else {
      stroke(255);
    }
    // draw the nose
    line(xCoord, yCoord-5, xCoord+10, yCoord);
    line(xCoord, yCoord+5, xCoord+10, yCoord);
    // the speech bubble will have a black stroke
    stroke(0);
    // the speech bubble will be pink in color
    fill(255, 51, 153);
    // if the user loses the game set the speech bubble to red
    if (loser) 
    {
      fill(255, 0, 0);
    }
    // draw the speech bubble
    ellipse(xCoord+200, yCoord+20, diameter*2, diameter*1.5);
    // set the color of the the small triangle off the speech bubble to black
    fill(0);
    // draw the small triangle off the side of the speech bubble
    triangle(xCoord+100, yCoord+10, xCoord+100, yCoord+30, xCoord+70, yCoord+20);
    // set the size of the text inside the speech bubble to 20
    textSize(20);
    // draw the text inside the speech bubble
    text(speechBubbleText, xCoord+200, yCoord);
  }
  /* if the wrongGuess is greater than 2
   or the person has won draw the BODY */
  if (wrongGuess>2 || winner)
  {
    strokeWeight(10);
    line(xCoord, yCoord+(diameter/2), xCoord, yCoord+200);
  }
  /* if the wrongGuess is greater than 3
   or the person has won draw the LEFT ARM */
  if (wrongGuess>3 || winner)
  {
    line(xCoord, yCoord+100, xCoord-75, armY);
    /* if the wrongGuess is greater than 4
     or the person has won draw the RIGHT ARM */
    if (wrongGuess>4  || winner)
    {
      line(xCoord, yCoord+100, xCoord+75, armY);
    }
  }
  /* if the wrongGuess is grethan 5
   or the person has won draw the LEFT LEG */
  if (wrongGuess>5 || winner)
  {
    line(xCoord, yCoord+200, leftLegX, yCoord+300);
    /* if the wrongGuess is greater than 6
     or the person has won draw the RIGHT LEG */
    if (wrongGuess>6 || winner)
    { 
      line(xCoord, yCoord+200, leftLegX+50, yCoord+300);
    }
    /* if the left legs x coordinate is less than or equal to 625 px 
     change the direction of the swinging legs to swing right */
    if (leftLegX<=625)
    { 
      swingLegsRight=true;
      swingLegsLeft=false;
    }
    /* if the left legs x coordinate is greater than or equal to
     700px change the direction of the swinging legs to swing left */
    if (leftLegX >= 700)
    {
      swingLegsLeft =true;
      swingLegsRight = false;
    }
    // if the legs are set to swing right increaase the x coordinate 
    if (swingLegsRight)
    {
      leftLegX+=2;
    }
    // if the legs are set to swing left decrease the x coordinate 
    if (swingLegsLeft)
    {
      leftLegX-=2;
    }
  }


  // if the wrong guess is greater than 7 draw the noose & call gameOverLosser method
  if (wrongGuess>7)
  {
    //color of noose is red
    stroke(255, 0, 0);
    // noose line
    line(xCoord-50, yCoord+50, xCoord+50, yCoord+50);
    // set color of all other strokes back to black
    stroke(0);
    // color of text is red
    fill(255, 0, 0);
    // call the gameOverLoser method
    gameOverLoser();
  }
}


// method for when the person has guessed the correct word
void gameOverWinner() 
{
  // boolean for winner becomes true
  winner=true;
  // the speech in the speech bubble is changed to a winner message 
  speechBubbleText="THANK'S FOR \n SAVING ME \n"+userName;
  /* the legs continue to swing until they are back in the center &
   the yCoord is greater than 500 once they are back in the center 
   they stop swinging so that they stand straight on the ground and 
   don't land lobsided*/
  if (leftLegX==(xCoord-25)&&yCoord>500)
  {
    swingLegsRight = false;
    swingLegsLeft = false;
  }
  /* if statement to make body fall until it is standing on the 
   bottom by incrementing the y coordinates */
  if (yCoord<height-340)
  {
    //increments the y coordinates of the hangman body by 3px
    armY+=3;
    yCoord+=3;
    // the text in the speech bubble changes when the man is falling
    if (yCoord>height-400)
    {
      speechBubbleText="WELL DONE \n"+userName+"\n YOU WIN";
    }
  }
  /* when the man is standing on the ground 
   call the playAgain method */
  else if (yCoord>=height-340)
  {
    playAgain();
  }
}

/* if the user guesses the right word the drawWinnerBubbles method is called
 it draws random colored bubbles & the word WINNER. the bubbles and word are 
 dynamic and move down the screen as the man floats to the ground */
void drawWinnerBubbles() 
{
  // color the the rectangle grey the same color as the over all background
  fill(160);
  // the rectangle will have no stroke
  noStroke();
  /* I needed this rectangle to seperate a section of the screen. The rectangle covers the 
   width of the screen and moves further down the screen with the bubbles and WINNER text as they move, 
   it is need as a background to the bubbles and word so they are drawn on a blank canvas the same 
   color as the background of the whole screen. If I had not used this the screen would have become 
   overrun with bubbles and WINNER would have been illegible. If i had refreshed the background of 
   the whole screen the hangman word and floating hangman would have dissapeared */
  rect(0, 0, width, bubbleIndex);

  /* start drawing bubbles at x coordinate 50 and increment the x coordinate each time by 80
   until it reaches the width of the screen */
  for (drawWinnerBubblesX = 50; drawWinnerBubblesX<width; drawWinnerBubblesX+=80)
  {
    // generate a random color for each bubble
    fill(random(0, 256), random(0, 256), random(0, 256));
    //generate a random Y coordinate for each bubble between 0 and the bubbleIndex
    drawWinnerBubblesY = int(random(0, bubbleIndex));
    // draw a circle bubble 
    ellipse(drawWinnerBubblesX, drawWinnerBubblesY, 80, 100);
    // set the text size to 200px
    textSize(200);
    // set the text color to green
    fill(0, 255, 0);
    // center align the text
    textAlign(CENTER);
    /* draw the text winner and have it start above the screens Y axis and move downwards towards
     the center of the screen */
    text("WINNER", 500, bubbleIndex-200);
    // when the bubbleIndex reaches 500 stop incrementing so as not to cover the hangman or the word.
    if (bubbleIndex<=500)
    {
      // increment the bubble index by 0.3 px each time 
      bubbleIndex+=0.3;
    }
  }
}


/* The gameOverLoser method is what happens when the game
 is over and the user has not guessed the right word
 - a bubble containing the hangman word is shown and moves 
 across the screen
 - the hangman body falls and dissapears
 - A graveyard cross appears once the hangman is gone
 - dynamic rows of bricks cover the screen leaving nothing
 only the correct word*/
void gameOverLoser()
{
  // the boolean flag loser is set to true
  loser=true;
  // change the speech bubble text to a loser msg 
  speechBubbleText="YOU \n LOSE";
  /* call the loserWordEllipse method to print the 
   correct word inside an ellipse */
  loserWordEllipse();
  //body falls until it dissapears from the screen
  if (yCoord<=height+50)
  {
    armY+=3;
    yCoord+=3;
  } 
  /* when the body has neary reached the bottom 
   of the screen change the text to a bye bye message */
  if (yCoord>=height-300)
  {
    speechBubbleText=("BYE BYE \n"+userName);
  }

  /* Once the body dissapears under the ground print 
   a grave yard cross */
  if (yCoord>height+50 && brickIndex<height-300)
  {  
    rect(xCoord-25, height-300, 80, 300);
    rect(xCoord-100, height-250, 230, 50);
    fill(255);
    text("RIP", xCoord+20, height-220);
  }
}


// when the loser loses draw an ellipse bubble with the hangman word in it
void loserWordEllipse() 
{
  /* If bounceBack is false and the bubble hasn't reached the width of the screen
   less half the diameter of the ellipse draw the ellipse containing the hangman 
   word and move from left to right */
  if (gameoverEllipseX <= width-diameter*2 && !bounceBack)
  {
    // move the ellipse & text forward by 3px every time along the x axis
    gameoverEllipseX+=3;
    /* when the bubble reaches width of the screen set the bounceback to true
     so the bubble and word will bounce off the wall an begin moving backwards*/
    if (gameoverEllipseX > (width-diameter*2))
    {
      bounceBack=true;
    }
  }
  /* If bounceBack is true and the X cordinate of the ellipse is greater than 
   or equal to the middle X cooridante position of the stands rope move backwards
   once it reaches the middle of the rope it stops moving */
  else if (bounceBack && gameoverEllipseX >= 662)
  {
    // move the ellipse & hangman word & text back 3px every time along the x axis
    gameoverEllipseX-=3;
  } 
  // once the bubble with the hangman word stops moving call the loserBuildBricks method
  else
  {
    loserBuildBricks();
  }
  /* once the bricks have reached the height of the screen call the playAgain method
   asking the user do they want to play again */
  if (brickIndex>=height)
  {
    playAgain();
  }

  // set the color of the ellipse to red
  fill(255, 0, 0);
  // draw the ellipse surrounding the hangman word and text
  ellipse(gameoverEllipseX, gameoverEllipseY-5, diameter*4, diameter*2);
  // set the color of the hangman word and text to black
  fill(0);
  // set the text size to 40
  textSize(40);
  // draw text with the correct hangman word inside the ellipse
  text("The word was \n"+hangmanWord, gameoverEllipseX, gameoverEllipseY-15);
}

/* This is a method that builds bricks starting at the top of the screen and moves down
 to the bottom when the user has lost the game */
void loserBuildBricks()
{
  // loops through the x coordinates adding 70px each time
  for (int brickXCoord=0; brickXCoord<width; brickXCoord+=70)
  {
    // loops through the y coordinates adding 30px each time
    for (int brickYCoord=0; brickYCoord<brickIndex; brickYCoord +=30)
    {
      /* if the bricks X coordinate and bricks Y coordinate modulus 20 returns a remainder of 0
       or if the bricks X coordinate and bricks Y coordinate modulus 20 returns a remainder of 10
       set the color of the brick to white */
      if ((brickXCoord%20==0 && brickYCoord%20==0) ||(brickXCoord%20==10 && brickYCoord%20==10))
      {
        fill(255);
      } 
      // otherwise set the color to black
      else
      {
        fill(0);
      }
      // draw a rectangle brick at the current X and Y coordinates
      rect(brickXCoord, brickYCoord, 70, 30);
      // increment the height of the wall of bricks by 0.05px each time
      brickIndex+=0.05;
    }
  }
}

/* This method is called when the user clicks NO on the JOption dialog panel which
 asks the user do they want to play again */
void gameOverExit()
{
  /* if the gameOver Text hasn't met in the middle of the screen
   continue to move the text towards the center */
  if (gameOverX<width/2 && gameOverY<height/2)
  {
    // background set to black each time
    background(0);
    // set the color to green
    fill(0, 255, 0);
    // set the stroke to green
    stroke(0, 255, 0);
    // set the stroke weight to 10px
    strokeWeight(10);
    // draw a green hangman
    if (xCoord<width+50)
    {
      // head
      ellipse(xCoord, yCoord, diameter, diameter);
      // body
      line(xCoord, yCoord+50, xCoord, yCoord+200);
      // left arm
      line(xCoord, yCoord+100, xCoord-50, yCoord+180);
      // right arm
      line(xCoord, yCoord+100, xCoord+100, armY);
      // left leg
      line(xCoord, yCoord+200, xCoord-50, yCoord+300);
      // right leg
      line(xCoord, yCoord+200, xCoord+50, yCoord+300);
      // increment the x coordiante by 3 each time to make the hangman cross the screen
      xCoord+=3;
      /* to make the hangman wave goodbye
       if the gameOverArmDown is true move the arm down 15px */
      if (gameOverArmDown)
      {
        armY++;
        /* when the arms Y coordiante is equal to 415 change the direction
         of the arm to move up by changing the flag booleans setting
         gameOverArmUp to true and gameOverArmDown to false*/
        if (armY==415)
        {
          gameOverArmDown=false;
          gameOverArmUp=true;
        }
      }
      // if the gameOverArmUp is true move the arm up by 15px
      if (gameOverArmUp)
      {
        armY--;
        /* If the arms Y coordinate equals 385 change the direction of the
         arm to move down by changing the booleans setting gameOverArmDown
         to true and gameOverArmUp to false */
        if (armY==385)
        {
          gameOverArmUp=false;
          gameOverArmDown=true;
        }
      }
    }
    // text size 120px
    textSize(120);
    // center align text
    textAlign(CENTER);
    // draw the text GAME
    text("GAME", gameOverX, gameOverY);
    // draw the text OVER
    text("OVER", width - gameOverX, width-gameOverY+150);

    // increment the x and y coordinates for GameOverX and GameOverY
    gameOverX++;
    gameOverY++;
  }

  /* if the game over text has arrived at the center of the screen delay 
   for 1.5 seconds and exit the processer */
  else
  {
    delay(1500);
    exit();
  }
}


/* The playAgain method asks the user do they want to play again
 if the user clicks yes on the dialog box to play 
 again reset all the global variables that need to be reset if the user
 clicks no call the gameOver method*/
void playAgain()
{
  // delay for 1.5 seconds before asking player do they want to play again
  delay(1500);
  // Dialog pane asking player do they want to play again
  int yesOrNo = JOptionPane.showConfirmDialog(null, 
    "Do You Want to Play Again", "HANGMAN", JOptionPane.YES_NO_OPTION); 
  /* if the user clicks no exit re-assign the hangmans coordiantates 
   and set gameOver to true this will cause the gameOverExit method to
   start from the draw() method*/
  if (yesOrNo == JOptionPane.NO_OPTION)
  {
    gameOverX+=2;
    gameOverY+=2;
    xCoord=100;
    yCoord=350;
    armY=400;
    gameOver=true;
  } 
  /* otherwise if the user clicks on yes start the game again
   by resetting the global variables that need to be reset and
   call the initial methods to start the game */
  else if (yesOrNo == JOptionPane.YES_OPTION)
  {
    // reset global variables
    winner=false;
    loser=false;
    hangmanWord="_";
    wrongGuess=0;
    rightGuess="";
    gameoverEllipseX=0;
    gameoverEllipseY=410;
    bounceBack = false;
    allGuesses="";
    centerToLeft=true;
    leftToCenter=false;
    centerToRight=false;
    rightToCenter=false;
    xCoord = 675;
    yCoord = 330;
    diameter = 100;
    armY = 400;
    leftLegX = 670;
    swingLegsRight=true;
    swingLegsLeft=false;
    bubbleIndex = 200;
    brickIndex = 100;
    stroke(0);
    strokeWeight(5);

    // Store a String returned from the getRandomWord method
    hangmanWord = getRandomWord();
    // Stores the lenght of the hangmanWord
    wordLen= hangmanWord.length();
    /* loops until it reaches the lenght of the hangman word
     initally it adds the char '_' for each letter of the hangman
     word to the String called rightGuess */
    for (int i=0; i<wordLen; i++) 
    {
      rightGuess = rightGuess+'_';
    }
  }
}
