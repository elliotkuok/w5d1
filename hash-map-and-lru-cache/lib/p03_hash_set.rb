class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    bucket = self[key] 

    unless bucket.include?(key)
      bucket << key
      @count += 1
      resize! if count > num_buckets
    end
  end

  def include?(key)
    bucket = self[key]
    bucket.each { |ele| return true if ele == key }
    false
  end

  def remove(key)
    bucket = self[key]

    if bucket.include?(key)
      bucket.delete(key)
      @count -= 1
    end
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    @new_store = Array.new(new_num_buckets) { Array.new }
    @store.flatten.each { |ele| @new_store[ele.hash % new_num_buckets] << ele }
    @store = @new_store
  end

  def [](key)
    @store[key.hash % num_buckets]
  end
end