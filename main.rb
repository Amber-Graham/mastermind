require './game.rb'
require './computer.rb'
require './player.rb'
require 'colorize'
require 'colorized_string'


class Mastermind
  include Colorize
  include Human
  include Computer

  COLORS = %w[yellow blue red green purple white].freeze

  def initialize
    @player = Player.new
    @secret_combination = []
  end

  def play
    game_welcome

      loop do
        puts "Would you like to be the code MAKER or the code BREAKER?\n
            Press '1' for code BREAKER\n
            Press '2' for code MAKER\n"
        @role = gets.chomp
        break if @role == '1' || @role == '2'
        puts "\nInvalid input!"
      end

      if @role == '1'
        set_secret_combination
        turns = 12

        loop do
          puts "\nTurns left: #{turns}"
          turns -= 1
          player_guess = @player.make_guess
          print "\nYour guess:"
          print_combination(player_guess)

          if winner?(player_guess)
            puts "Congratulations! You cracked the code!"
            play_again?
          elsif turns == 0
            print "\nYou couldn't crack the code in time!"
            puts "The secret combination was: "
            print_combination(@secret_combination)
            play_again?
          else
            clues = check_for_clues(player_guess)
            print_clues(clues)
          end
        end

      else
        computer_player = Computer.new
        @all_combinations = Mastermind::COLORS.repeated_permutation(4).to_a
        @secret_combination = @player.create_secret_combination

          print "Secret combination: "
          print_combination(@secret_combination)
          turns = 12

          loop do
            sleep(1)
            puts "\nTurns left: #{turns}"
            turns -= 1
            computer_guess = computer_player.make_guess(turns, @all_combinations)
            print "Computer's guess: "
            print_combination(computer_guess)

            if winner?(computer_guess)
              sleep(0.5)
              puts "\nThe Computer cracked your code!"
              play_again?
            elsif turns == 0
              sleep(0.5)
              puts "\nCongratulations! The Computer could not break your code!"
              play_again?
            else 
              clues = check_for_clues(computer_guess.dup)
              print_clues(clues)
              find_remaining_combinations(computer_guess, clues)
            end
          end
    end
  end

  def set_secret_combination
    4.times { @secret_combination << COLORS.sample }
  end

  def print_combination(guess)
    guess.each do |color|
      case color
      when 'red'
        print red(color)
      when 'blue'
        print blue(color)
      when 'yellow'
        print yellow(color)
      when 'green'
        print green(color)
      when 'purple'
        print purple(color)
      else
        print color
      end
      print ' '
    end
    puts "\n"
  end

  def print_clues(clues)
    print 'Clues: '
    clues.each { |clue| print clue + " " }
    puts "\n"
  end

  def winner?(guess)
    guess == @secret_combination
  end

  def check_for_clues(guess)
    clues = []
    secret_combo = @secret_combination.dup
    secret_combo.each_with_index do |color, i|
      if color == guess[i]
        secret_combo[i] = 'exact match'
        guess[i] = 'X'
        clues << red("\u25CF".encode('utf-8'))
      end
    end

    secret_combo.each_with_index do |color, i|
      if guess.include?(color)
        clues << "\u25CF".encode('utf-8')
        guess[guess.index(color)] = 'X'
      end
    end
    clues
  end

    def play_again?
    loop do
      print "\nPlay again? (Y/N): "
      answer = gets.chomp.upcase
      if answer == "N"
        puts "See you later!"
        exit
      elsif answer == "Y"
        initialize
        play
      end
    end
  end

  def game_welcome
    puts "
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------"
    puts "
      _____      ____      __    __    ______       ______     __    __   __
    /  __   \\   /    \\    /  \\  /  \\  |  ____|     /  __  \\   /  \\  |  | |  |
    |  | | _|  /  /\\  \\  |    \\/    | |  |___     |  /  \\  | |    \\ |  | |  |
    |  |  ___ |  |  |  | |          | |   ___|    |  |  |  | |     \\|  | |  |
    |  | |_ | |  |__|  | |  |\\  /|  | |  |        |  |  |  | |  |\\     | |__|
    |  |__| | |   __   | |  | \\/ |  | |  |___     |  \\__/  | |  | \\    |  __
     \\______/ |__/  \\__| |__|    |__| |______|     \\______/  |__|  \\___| |__| 

     "
     puts "
     ----------------------------------------------------------------------------
     ----------------------------------------------------------------------------\n\n"
     print "Welcome to the Mastermind Game!\n 
            You can choose to be the code MAKER or the code BREAKER.\n 
            The code BREAKER will have 12 turns to decipher the code that the MAKER has created.\n
            The code consists of 4 colors, ranging from: #{red('RED')}, #{blue('BLUE')}, #{green('GREEN')}, WHITE, #{yellow('YELLOW')} and #{purple('PURPLE')}.\n
            Feedback will be given with each entry to show how close the guess was to the hidden code.\n
            When guessing a correct color that is in the correct position, your feedback will be a red dot.\n
            When guessing a correct color in the incorrect position, your feedwill will be a white dot.\n
            The feedback position does not correlate with the guess position.\n\n"
  end
end

module Colorize
  def colorize(text, color_code)
    "#{color_code}#{text}\e[0m"
  end

  def red(text)
    colorize(text, "\e[31m")
  end

  def yellow(text)
    colorize(text, "\e[33m")
  end

  def blue(text)
    colorize(text, "\e[34m")
  end

  def green(text)
    colorize(text, "\e[32m")
  end

  def purple(text)
    colorize(text, "\e[35m")
  end  
end

new_game = Mastermind.new
new_game.play