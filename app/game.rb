# frozen_string_literal: true
require "./frame.rb"

class Game

  def initialize
    @game = Array.new(10) {Frame.new}
  end

  def start
    @game.each_with_index do |frame, i|
      if(i <= 0)
        frame.next_frame = @game[i + 1]
      elsif(i >= 9)
        frame.previous_frame = @game[i - 1]
      else
        frame.next_frame = @game[i + 1]
        frame.previous_frame = @game[i - 1]
      end
      random_try(frame)
    end
    calculate_totals()
  end

  def random_try(frame)
    r1 = rand(11)
    frame.first_try = r1

    if(r1 != 10)
      r2 = rand(11-r1)
      frame.second_try = r2
    end
  end

  def calculate_totals
    @game.each do |frame|
      puts "- - - - - - - - -"
      puts "#{frame.first_try} #{frame.second_try}"
      puts frame.calculate_total
    end
  end


end

ngame = Game.new
ngame.start
