require "pry"

class TicTacToe
    attr_accessor :board
    
    def initialize
        @board = [" ", " ", " ", 
                  " ", " ", " ", 
                  " ", " ", " "]
    end
    @@winner = ""

    WIN_COMBINATIONS = [[0,1,2], [0,3,6], [0,4,8], [1,4,7], [2,5,8], [6,7,8], [3,4,5], [2,4,6]]

    def display_board
        print " #{board[0]} | #{board[1]} | #{board[2]} "
        print "-----------"
        print " #{board[3]} | #{board[4]} | #{board[5]} "
        print "-----------"
        print " #{board[6]} | #{board[7]} | #{board[8]} "
    end

    def input_to_index(input)
        return input.to_i - 1
    end

    def move(index, token)
        board[index] = "#{token}"
    end

    def position_taken?(index)
        if board[index] == "" || board[index] == " "
            return false
        else
            true
        end
    end

    def valid_move?(index)
        if position_taken?(index) == true
            false
        elsif index >= 0 && index <= 8
            true
        end
    end

    def turn_count
        count = 0
        board.map do |item|
            if item == "X" || item == "O"
                count += 1
            end
        end
        return count
    end

    def current_player
        if turn_count % 2 == 0
            "X"
        else
            "O"
        end
    end

    def turn 
        puts "Please enter 1-9: "
        user_input = gets.chomp
        index = input_to_index(user_input)
        token = current_player
            if valid_move?(index) == true && position_taken?(index) == false
                move(index, token)
            else
                turn
        end
        display_board()
    end

    def won?
        x_location = []
        o_location = []
        board.map.with_index do |space, index|
            if space == "X" 
                x_location << index
            elsif space == "O"
                o_location << index
            end
        end
        WIN_COMBINATIONS.map do |item|
            if item - x_location == [] && o_location != []
                @@winner = "X"
                return item 
            elsif item - o_location == [] && x_location != []
                @@winner = "O"
                return item
            end
        end
        false
    end

    def full?
        board.all? { |square| square != " " }
        # if board.include?(" ")
        #     false
        # else
        #     x_location = []
        #     o_location = []
        #     board.map.with_index do |space, index|
        #         if space == "X" 
        #             x_location << index
        #         elsif space == "O"
        #             o_location << index
        #         end
        #     end
        #     WIN_COMBINATIONS.map do |item|
        #         if item -x_location == [] && item - o_location == []
        #             true
        #         end
        #     end
        # end
    end


    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if over? || draw?
            return @@winner
        end
    end

    def play
        turn until over?
        if won? 
            puts "Congratulations #{winner}!" 
        elsif draw? 
            puts "Cat's Game!"
        end
    end
end
