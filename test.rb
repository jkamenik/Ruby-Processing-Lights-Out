require 'ruby-processing'

class Test < Processing::App
  
  def setup
    background 0
    smooth
    
    ellipse_mode CENTER
    
    frame_rate 24
    
    @rand_count = 10
    @rand_last  = 10
    
    @start = 10
    @min = 10
    @max = 690
    @dir = 1
    @stop = false
  end
  
  def draw
    return if @stop
    if(@start >= @max)
      @dir = -1
    elsif(@start <= @min)
      @dir = 1
    end
    @start += @dir
    
    fill *random_color
    
    rect 10,10,@start,@start
  end
  
  def random_color
    if(@curr_rand && @start > (@rand_count+@rand_last))
      return @curr_rand
    end
    @curr_rand = [rand(255),rand(255),rand(255)]
    @rand_last = @start
  end
  
  def mouse_released
    stop = !@stop
    @stop = stop
  end
end

Test.new(:width => 800, :height => 600)