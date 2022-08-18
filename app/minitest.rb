require "minitest/reporters" 
Minitest::Reporters.use!
require "minitest/autorun"
require "./game.rb"
require "./frame.rb"
class TestFrame < Minitest::Test

  def setup
    @frame = Frame.new
  end

  def test_frame_next_frame_init
    assert_nil(@frame.next_frame)
  end

  def test_frame_previous_frame_init
    assert_nil(@frame.previous_frame)
  end

end

class TestGame < Minitest::Test

  def setup
    @game_test = Game.new
    @game_test.start
  end

  def test_first_frame_previous_is_nil
    assert_nil(@game_test.game[0].previous_frame)
  end

  def test_last_frame_next_is_nil
    assert_nil(@game_test.game[9].next_frame)
  end

  def test_when_strike_second_try_is_nil
    @game_test.game.each do |frame|
      if frame.is_strike?
        assert_equal(frame.second_try, 0)
      end
    end
  end

  def test_when_spare_tries_equals_ten
    @game_test.game.each do |frame|
      if frame.is_spare?
        assert_equal(frame.first_try + frame.second_try, 10)
      end
    end
  end

  def test_is_total_sum
    frame = @game_test.game[9]
    total = frame.previous_frame.total
    if frame.is_strike? || frame.is_spare?
      total += frame.first_try + frame.second_try + frame.third_try
    else 
      total += frame.first_try + frame.second_try
    end
    assert_equal(total, frame.total)
  end

end
