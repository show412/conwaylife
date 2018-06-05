class Grid
  attr_reader(:cell_array, :x, :y)
  def initialize(x, y)
    @y = y
    @x = x
    @cell_array = []
    (x * y).times do
      new_cell = Cell.new(' ')
      @cell_array << new_cell
    end
    neighbor(x, y)
  end

  def neighbor(grid_x, grid_y)
    @cell_array.each_with_index do |cell, ind|
      if ind == 0
        is_top_left(cell, ind, grid_x)
      elsif ind == (grid_x - 1)
        is_top_right(cell, ind, grid_x)
      elsif ind == (grid_x * grid_y - grid_x)
        is_bottom_left(cell, ind, grid_x)
      elsif ind == (grid_x * grid_y - 1)
        is_bottom_right(cell, ind, grid_x)
      elsif ind < grid_x 
        is_top(cell, ind, grid_x)
      elsif ind % grid_x == 0
        is_left(cell, ind, grid_x)
      elsif ind % grid_x == grid_x - 1
        is_right(cell, ind, grid_x)
      elsif ind > (grid_x * grid_y - grid_x)
        is_bottom(cell, ind, grid_x)
      else
        is_middle(cell, ind, grid_x)
      end
    end
  end

  def is_top_left(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind + 1]
    cell.neighbors << @cell_array[ind + grid_x]
    cell.neighbors << @cell_array[ind + grid_x + 1]
  end

  def is_top_right(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind - 1]
    cell.neighbors << @cell_array[ind + grid_x]
    cell.neighbors << @cell_array[ind + grid_x - 1]
  end

  def is_bottom_left(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind - grid_x]
    cell.neighbors << @cell_array[ind - grid_x + 1]
    cell.neighbors << @cell_array[ind + 1]
  end

  def is_bottom_right(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind - grid_x]
    cell.neighbors << @cell_array[ind - grid_x - 1]
    cell.neighbors << @cell_array[ind - 1]
  end

  def is_top(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind + 1]
    cell.neighbors << @cell_array[ind - 1]
    cell.neighbors << @cell_array[ind + grid_x - 1]
    cell.neighbors << @cell_array[ind + grid_x]
    cell.neighbors << @cell_array[ind + grid_x + 1]
  end

  def is_left(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind + grid_x]
    cell.neighbors << @cell_array[ind - grid_x]
    cell.neighbors << @cell_array[ind + 1]
    cell.neighbors << @cell_array[ind + grid_x + 1]
    cell.neighbors << @cell_array[ind - grid_x + 1]
  end

  def is_right(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind + grid_x]
    cell.neighbors << @cell_array[ind - grid_x]
    cell.neighbors << @cell_array[ind - 1]
    cell.neighbors << @cell_array[ind + grid_x - 1]
    cell.neighbors << @cell_array[ind - grid_x - 1]
  end

  def is_bottom(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind + 1]
    cell.neighbors << @cell_array[ind - 1]
    cell.neighbors << @cell_array[ind - grid_x]
    cell.neighbors << @cell_array[ind - grid_x + 1]
    cell.neighbors << @cell_array[ind - grid_x - 1]
  end

  def is_middle(cell, ind, grid_x)
    cell.neighbors << @cell_array[ind + 1]
    cell.neighbors << @cell_array[ind - 1]
    cell.neighbors << @cell_array[ind - grid_x]
    cell.neighbors << @cell_array[ind + grid_x]
    cell.neighbors << @cell_array[ind + grid_x + 1]
    cell.neighbors << @cell_array[ind + grid_x - 1]
    cell.neighbors << @cell_array[ind - grid_x - 1]
    cell.neighbors << @cell_array[ind - grid_x + 1]
  end

  def live_count(cell)
    live_count = 0
    cell.neighbors.each do |cell|
      if cell.state == '.'
        live_count += 1
      end
    end
    live_count
  end

  def play_god
    @cell_array.each do |val|
      lives = live_count(val)
      if val.state == "."
        if lives < 2 || lives > 3
          val.murder
        else
          val.res
        end
      elsif val.state == " "
        if lives == 3
          val.res
        else
          val.murder
        end
      end
    end
  end

  def next_gen
    @cell_array.each do | cell |
      cell.state = cell.pending
    end
  end

  def output(grid_x)
    system "clear" or system "cls"
    @cell_array.each_with_index do |val, ind|
      if ind % grid_x == 0 && ind != 0
        print "\n"
      end
      print val.state + ' '
    end
  end
end
