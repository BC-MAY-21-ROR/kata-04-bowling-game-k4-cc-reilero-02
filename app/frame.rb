# frozen_string_literal: true

class Frame
  attr_accessor :next_frame, :previous_frame, :first_try, :second_try, :total, :third_try

  def initialize
    @total = 0
    @first_try = 0
    @second_try = 0
    @third_try = nil
    @next_frame = nil
    @previous_frame = nil
  end

  def is_strike?
    @first_try == 10
  end

  def is_spare?
    (@first_try + @second_try) == 10
  end

  def calculate_total
    subtotal = @previous_frame ? @previous_frame.total : 0
    if is_strike? && @next_frame.nil?
      subtotal += @first_try + @second_try + @third_try
    elsif is_strike?
      subtotal += 10
      subtotal += if @next_frame.is_strike?
                    @next_frame.first_try + @next_frame.next_frame.first_try
                  else
                    @next_frame.first_try + @next_frame.second_try
                  end
    elsif is_spare? && @next_frame.nil?
      subtotal += 10 + @third_try
    elsif is_spare?
      subtotal += 10 + @next_frame.first_try
    else
      subtotal += @first_try + @second_try
    end
    @total = subtotal
  end
end
