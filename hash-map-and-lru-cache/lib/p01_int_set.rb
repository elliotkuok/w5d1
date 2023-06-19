class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    is_valid?(num) ? @store[num] = true : ( raise "Out of bounds" )
  end

  def remove(num)
    is_valid?(num) ? @store[num] = false : ( raise "Num does not exist" )
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    (0...max).include?(num)
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    bucket = self[num]

    if bucket.include?(num)
      raise "Number already exists"
    else
      bucket << num
    end
  end

  def remove(num)
    bucket = self[num]

    if bucket.include?(num)
      bucket.delete(num)
    else
      raise "Number does not exist"
    end
  end

  def include?(num)
    bucket = self[num]
    bucket.each { |ele| return true if ele == num }
    false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
      bucket = self[num]

      unless bucket.include?(num)
        bucket << num
        @count += 1
        resize! if count > num_buckets
      end
  end

  def remove(num)
      bucket = self[num]

      if bucket.include?(num)
        bucket.delete(num)
        @count -= 1
      end
  end

  def include?(num)
    bucket = self[num]
    bucket.each { |ele| return true if ele == num }
    false
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    @new_store = Array.new(new_num_buckets) { Array.new }
    @store.flatten.each { |ele| @new_store[ele % new_num_buckets] << ele }
    @store = @new_store
  end

  def [](num)
    @store[num % num_buckets]
  end
end