require 'rspec'
require 'cell'
require 'grid'

describe Cell do
  it 'it is an instance of Cell' do
    test_cell = Cell.new(" ")
    test_cell.should be_an_instance_of Cell
  end
  describe('res') do
    it('should make a cell live!') do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].res
      test_grid.cell_array[0].pending.should(eq('.'))
    end
  end
  describe('murder') do
    it('should make a cell dead!') do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].murder
      test_grid.cell_array[0].pending.should(eq(' '))
    end
  end
end

describe Grid do
  it('should create an instance of Grid') do
    test_grid = Grid.new(3, 3)
    test_grid.should(be_an_instance_of(Grid))
  end
  it ("should create 9 cells") do
    test_grid = Grid.new(3, 3)
    test_grid.cell_array.length.should(eq(9))
  end
  describe('neighbor') do
    it("should return an array of all the neighboring cells") do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[4].neighbors.length.should(eq(8))
    end
    it("should return an array of all the neighboring cells") do
      test_grid = Grid.new(25, 25)
      test_grid.cell_array[30].neighbors.length.should(eq(8))
    end
  end
  describe("live_count") do
    it "should return a value of how many cells are alive around it" do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[1].state = '.'
      test_grid.cell_array[2].state = '.'
      test_grid.live_count(test_grid.cell_array[4]).should(eq(2))
    end
  end
  describe('play_god') do

    it('should leave any live cell with 2 or 3 neighbors alone') do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].state = '.'
      test_grid.cell_array[1].state = '.'
      test_grid.cell_array[2].state = '.'
      test_grid.cell_array[4].state = '.'
      test_grid.cell_array[4].pending = ' '
      test_grid.play_god
      test_grid.cell_array[4].pending.should(eq('.'))
    end
    it('should murder any live cell with fewer than 2 live neighbors') do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].state = '.'
      test_grid.play_god
      test_grid.cell_array[0].pending.should(eq(' '))
    end
    it("should murder any live cell with more than 3 live neighbors") do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].state = '.'
      test_grid.cell_array[1].state = '.'
      test_grid.cell_array[2].state = '.'
      test_grid.cell_array[3].state = '.'
      test_grid.cell_array[4].state = '.'
      test_grid.play_god
      test_grid.cell_array[4].pending.should(eq(' '))
    end
    it("any live cell with 2 or 3 live neighbors should live") do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].state = '.'
      test_grid.cell_array[1].state = '.'
      test_grid.cell_array[3].state = '.'
      test_grid.cell_array[4].state = '.'
      test_grid.play_god
      test_grid.cell_array[4].state.should(eq('.'))
    end
    it("any dead cell with exactly 3 neighbors revives") do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].state = '.'
      test_grid.cell_array[1].state = '.'
      test_grid.cell_array[3].state = '.'
      test_grid.play_god
      test_grid.cell_array[4].pending.should(eq('.'))
    end
  end
  describe('next_gen') do
    it('should switch state status to equal pending status') do
      test_grid = Grid.new(3, 3)
      test_grid.cell_array[0].state = ' '
      test_grid.cell_array[0].pending = '.'
      test_grid.next_gen
      test_grid.cell_array[0].state.should(eq('.'))
    end
  end
end
