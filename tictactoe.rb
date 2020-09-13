class Game
  def initialize
    #make new board
    @new_board = Board.new

    #gets name for player 1
    puts "Who is Player 1?"
    input = gets.chomp.downcase
    @player_1 = Players.new("#{input}")

    #gets name for player 2
    puts "Who is Player 2?"
    input = gets.chomp.downcase
    @player_2 = Players.new("#{input}")

    #sets the current player as player 1 and current token as X
    @current_player = @player_1.name
    @token = "X"

    #starts the game
    player_turn
  end

  def player_turn
    #player input decides what space the token occupies
    puts "Choose a number, #{@current_player.capitalize}!"
    player_choice = gets.chomp.to_i

    #checks to see if the input is a number on the board
    if ((1..9).include? player_choice)
      #checks to see if the input has already been used
      if (@new_board.check_choice(player_choice))
        #puts the current token on the board
        @new_board.add_token(player_choice, @token)
        #if the move did not win the game, next player's turn
        @new_board.win_con(@current_player) ? return : change_players
      else
        #player input was already used
        puts "\nThat space is already taken!"
        player_turn
      end
    else
      #player input is not on the board
      puts "That's not a valid choice!"
      player_turn
    end
  end

  def change_players
    #changes current player and token
    if (@current_player == @player_1.name)
      @current_player = @player_2.name
      @token = "O"
    elsif (@current_player == @player_2.name)
      @current_player = @player_1.name
      @token = "X"
    end
    player_turn
  end
end

class Board
  def initialize
    puts "Board Template:"
    puts "\n[1][2][3]\n[4][5][6]\n[7][8][9]\n\n"

    #create a three by three array of spaces for tokens to go into
    @board = Array.new(3) {Array.new(3, " ")}

    #create a hash with keys representing spaces on the board and values as tokens
    @spaces = {
      1 => @board[0][0],
      2 => @board[0][1],
      3 => @board[0][2],
      4 => @board[1][0],
      5 => @board[1][1],
      6 => @board[1][2],
      7 => @board[2][0],
      8 => @board[2][1],
      9 => @board[2][2],
    }
  end

  #displays the current board
  def print_board
    puts "\n[#{@spaces[1]}][#{@spaces[2]}][#{@spaces[3]}]\n[#{@spaces[4]}][#{@spaces[5]}][#{@spaces[6]}]\n[#{@spaces[7]}][#{@spaces[8]}][#{@spaces[9]}]\n\n"
  end

  #checks to see if the input has been used yet
  def check_choice(choice)
    @spaces[choice] == " " ? true : false  
  end

  #uses the input as the key to change the value to the current player's token
  def add_token(choice, token)
    @spaces[choice] = token
    print_board
  end

  #checks to see if the move won the game
  def win_con(name)
    #horizontal win conditions
    if ((@spaces[1] != " " && @spaces[1] == @spaces[2] && @spaces[2] == @spaces[3]) || (@spaces[4] != " " && @spaces[4] == @spaces[5] && @spaces[5] == @spaces[6]) || (@spaces[7] != " " && @spaces[7] == @spaces[8] && @spaces[8] == @spaces[9]))
      puts "Congratulations, #{name.capitalize}! You win!"
      return true
    #vertical win conditions
    elsif ((@spaces[1] != " " && @spaces[1] == @spaces[4] && @spaces[4] == @spaces[7]) || (@spaces[2] != " " && @spaces[2] == @spaces[5] && @spaces[5] == @spaces[8]) || (@spaces[3] != " " && @spaces[3] == @spaces[6] && @spaces[6] == @spaces[9]))
      puts "Congratulations, #{name.capitalize}! You win!"
      return true
    #diagonal win conditions
    elsif ((@spaces[1] != " " && @spaces[1] == @spaces[5] && @spaces[5] == @spaces[9]) || (@spaces[3] != " " && @spaces[3] == @spaces[5] && @spaces[5] == @spaces[7]))
      puts "Congratulations, #{name.capitalize}! You win!"
      return true
    elsif (!@spaces.has_value? (" "))
      puts "It's a tie!"
      return true
    else
      #move did not win the game
      return false
    end
  end
end

class Players
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

new_game = Game.new 