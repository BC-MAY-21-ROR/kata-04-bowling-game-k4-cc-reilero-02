# frozen_string_literal: true

require_relative './frame'

class Game
  attr_accessor :game

  def initialize
    @game = Array.new(10) { Frame.new }
  end

  def start
    @game.each_with_index do |frame, i|
      if i <= 0
        frame.next_frame = @game[i + 1]
      elsif i >= 9
        frame.previous_frame = @game[i - 1]
      else
        frame.next_frame = @game[i + 1]
        frame.previous_frame = @game[i - 1]
      end
      random_try(frame, i)
    end

    calculate_totals
  end

  def random_try(frame, i)
    r1 = rand(11)
    frame.first_try = r1

    if r1 != 10
      r2 = rand(11 - r1)
      frame.second_try = r2
    end

    if i == 9 && r1 == 10
      r2 = rand(11)
      frame.second_try = r2

      r3 = rand(11)
      frame.third_try = r3
    elsif i == 9 && frame.is_spare?
      r3 = rand(11)
      frame.third_try = r3
    end
  end

  def calculate_totals
    @game.each do |frame|
      puts '- - - - - - - - -'
      if !@game[9]
        puts "#{frame.first_try} #{frame.second_try}"
      else
        puts "#{frame.first_try} #{frame.second_try} #{frame.third_try}"
      end
      puts frame.calculate_total
    end
  end
end

ngame = Game.new
ngame.start
