require 'ruby-processing'

class LightsOut < Processing::App
  def setup
    size 800, 600
    background 0
    
    frame_rate 24
    
    @color_map = {
      :normal => [0,113,188], #light blue
      :normal_border => [0,173,239], #lighter Blue
      :clicked => [68,199,244], #aqua
      :clicked_border => [157,220,249], #light aqua
      :selected => [255,235,149], #yellow
      :selected_border => [255,255,255] #black
    }
    
    max_width = 800
    max_height = 600
    spacing = 5
    width = (max_width/4)-(20); puts "Width: #{width}"
    height = (max_height/4)-(20); puts "Height: #{height}"
    @object_map = []
    @state_map = []
    (0...4).each do |column|
      x = (width*column)+((column+1)*spacing)+(column*spacing)
      (0...4).each do |row|
        y = (height*row)+((row+1)*spacing)+(row*spacing)
        puts "#{x}, #{y}"
        @object_map.push [x,y,width,height]
        @state_map.push :normal
      end
    end
    
    # a dirty trick
    @neighbor_map = [
      [0,  1,4],
      [1,  0,2,5],
      [2,  1,3,6],
      [3,  2,7],
      [4,  0,5,8],
      [5,  1,4,6,9],
      [6,  2,5,7,10],
      [7,  3,6,11],
      [8,  4,9,12],
      [9,  5,8,10,13],
      [10, 6,9,11,14],
      [11, 7,10,15],
      [12, 8,13],
      [13, 9,12,14],
      [14, 10,13,15],
      [15, 11,14]
    ]
    
    stroke_width 5
  end
  
  def draw
    @object_map.each_with_index do |x,i|
      state = @state_map[i]
      
      fill *@color_map[state]
      stroke *@color_map["#{state}_border".to_sym]
      rect *x
    end
  end
  
  def mouse_pressed
    puts "#{mouse_x}, #{mouse_y}"
    idx = find_box
    if idx == -1
      puts "no box found"
    else
      puts "box #{idx}"
      full_toggle idx
    end
  end
  
  def find_box
    x = mouse_x; y = mouse_y
    @object_map.each_with_index do |box,i|
      next if x < box[0] || x > box[0]+box[2]
      next if y < box[1] || y > box[1]+box[3]
      return i
    end
    return -1
  end
  
  def full_toggle(box)
    # toggles all the neighbors of idx
    @neighbor_map[box].each do |x|
      toggle x
    end
  end
  
  def toggle(box)
    state = @state_map[box]
    if state == :normal
      @state_map[box] = :clicked
    else
      @state_map[box] = :normal
    end
  end
end

LightsOut.new #( :width => 800, :height => 600 )