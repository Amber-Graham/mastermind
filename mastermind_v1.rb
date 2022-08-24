class Mastermind
  initialize a welcome that goes over the rules 
  of the game, as well as if the player would like to
  be a code breaker or code maker

  call a game_loop function to see if the player wants to 
  try again. It will take them back to the welcome where they 
  can select what they want to do (maker or breaker)

  def game_start
    recieves the input from player for their role in the game
    initialize a board.new based on the input

    if they want to be a breaker, we we will call the 
      player_breaker version of the game
      the player guess the computer code
    elsif they want to be a code maker, we will call the 
      player_coder version of the game
      the computer guesses the player code
    end
  end

  def play_again
    the input will be nil until input is "Y" or "N"
    we will ask if they want to play again, take their input
    and put it in upcase. we will run a case for the input
    when "Y", game_start
    when "N", puts "See you soon!"
    end
  end
end

class Computer
  i know i will need knuth\s algorithm for this section
end

class Player
  initialize a new player
    ask what role they want to be, and store it here. 
end

class Board
  the code will be a 4 digit color code. The options for the 
  code will be red, orange, cyan, purple, pink, green in an Array
  if the computer is picking the code,
    it will randomly pick the colors to using sample
  elsif the player is picking the code,
    they will assign a color for each digit in the Array
  
  def create_board
    once the computer or player has created their board,
    that information will go here and be stored in an instance
    variable. 
    
    i will need to look up how to display these with small
    colored circles. 
    
    the goal will be once the information has been stored in 
    the variables, then we will display a blank mastermind 
    board that the player will input their guesses into.

    this will be called in the Game class later
end

class Game
  initialize gameboard, player_role (?), code
  the empty board is has been called and is ready for the 
  player or the computer to input their guesses into it.

  the player will pick their guesses and the computer will rely
  on the data in the Computer class for its guesses.

  def hints
    this may need to be its own class, but for now we will 
    keep it here. Next to the board, there will be feedback
    section for the player or computer to see how close they 
    are to getting the code correct.
    the pins will display green if there is a color in the correct
    spot, and yellow if it is in the code, but not in the correct
    spot. If the color does not appear in the code at all, the pin
    will stay in its default, which is a small white dot.  
end

class Colors
  i believe i can add a gem that will help with the colors.
    look into this.
end