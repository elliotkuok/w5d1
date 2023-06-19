class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    res = 0
    self.each_with_index { |ele, i| res += ele.hash * i }
    res
  end
end

class String
  def hash
    res = 0
    self.each_char.with_index { |ele, i| res += ele.ord.hash * i }
    res
  end
end

class Hash
  def hash
    res = 0
    self.each { |k, v| res += k.to_s.ord.hash + v.to_s.ord.hash }
    res
  end
end