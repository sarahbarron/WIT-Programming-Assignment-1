/*
Name : Sarah Barron
Student Number: 20013679

My programming assignment 1 is the game of hangman.

Hangman is a popular word guessing game. The user is given 8 lives for each wrong guess you lose a life and another 
part of the hangman diagram is drawn when you have lost all your lives the man is hanged. If you guess the right word 
the man’s life is spared and he is set free. Once the game is either lost or won the user gets the option to play again.

I felt this game fitted the specification of a dynamic animation with user interaction. 
Initially the user interacts with the game when they are asked to input their username into a JOption input
dialog box. This username is used during the game in text areas such as in the speech bubble. 
The user also interacts with the game by selecting or guessing letters with a mouse click. 
The user will also have to interact with a confirm JOption pane, if they click somewhere on the screen that
is not a letter or if they try to click on a letter they have already clicked on previously.
Finally the user is asked to confirm if they would like to play again via a JOption confirm dialog box. The
user interacts with the dialog box by clicking yes or no.

At the start a dynamic alphabet is drawn at the top surrounded by a rectangle each rectangle is coloured white to begin with 
implying the letter is free to click. If a user guesses a right letter the background of the letter turns green. 
If the user guesses a wrong letter the background will turn red. 

Also at the beginning of the game, underscore characters '_' are drawn for each letter in the hangman word at the bottom
of the screen. As the user guesses right letters the display is updated removing the '_' and replacing it with the correct
letter in the correct position. 

Each time a user guesses a wrong letter they lose a life the display or the speech bubble are updated with the number
of guesses left. For each wrong guess a new part of the hangman diagram is added (stand, head, body, left arm, right arm, 
left leg, right leg, and noose). Once the head is added a speech bubble appears and the animation becomes really dynamic with
a swinging rope & swinging hangman who waves his arms. 

If the user has 8 wrong guesses they lose the game. The man is hanged and begins to fall to the ground, his facial 
expression changes to a sad red face and closed eyes, the text bubble message changes twice as the man falls. 
When the hangman disappears from the screen an RIP cross appears. A large eclipse bubble with the correct hangman 
word is displayed and moves across the screen, bounces of the edge of the screen and returns back to the pendulum.
Finally a dynamic wall covers the screen leaving only the correct hangman word in view.

When a player guesses the correct word they win the game. The man floats to the ground. The speech bubble changes its 
message twice. His face changes to a happy face. The text winner is displayed across the top of the screen and random 
coloured bubbles are displayed in celebration.

The player is then asked if they want to play again. If the player chooses not to play again the 
screen changes to black and a green hangman crosses the screen waving goodbye. The text "Game Over" becomes 
dynamic before the processor is exited. 

If the player chooses to play again the necessary variables are reset to their initail values and the game starts again.

The specification also asked for draw() and setup(), selection(if), iteration(loops), String methods, Processing methods 
and bespoke methods. This project needed all of these in order to work. I show this in more detail in the reflection


Known bugs/problems: There are no known bugs

Sources referred to during the project:

I referenced the processing reference (https://processing.org/reference/) to find processing methods that we 
had not covered in class such as delay() and exit()

I referenced oracle 
  - to confirm how to convert a character to a string Character.toString() 
    (https://docs.oracle.com/javase/7/docs/api/java/lang/Character.html#toString())
  - to check String methods such as contains() and trim() 
    (https://docs.oracle.com/javase/7/docs/api/java/lang/Character.html#toString())
*/
