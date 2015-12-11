module Enumerable
  def my_each
    i = 0
    while i < self.size
      yield(self[i])
      i += 1
    end 
    self
  end

  def my_each_with_index
    i = 0
    while i < self.size
      yield(self[i], i)
      i += 1
    end
    self
  end

  def my_select
    i = 0
    array = []
    while i < self.size
      array.push(self[i]) if yield(self[i])
      i += 1
    end
    array
  end

  def my_all?
    i = 0
    while i < self.size
      return false unless yield(self[i])
      i += 1
    end
    return true
  end

  def my_any?
    i = 0
    while i < self.size
      return true if yield(self[i])
      i += 1
    end
    return false
  end

  def my_none?
    i = 0
    while i < self.size
      return false if yield(self[i])
      i += 1
    end
    return true
  end

  def my_count(arg = nil)
    count = 0
    if !arg.nil?
      i = 0
      while i < self.size
        count += 1 if self[i] == arg
        i += 1
      end
    elsif block_given?
      i = 0
      while i < self.size
        count += 1 if yield(self[i])
        i += 1
      end
    else
      count = self.size
    end
    count
  end

=begin
  def my_map
    array = []
    i = 0
    while i < self.size
      array.push(yield(self[i]))
      i += 1
    end
    array
  end
=end

  def my_map(block)
    array = []
    i = 0
    while i < self.size
      tmp = block.call(self[i])
      tmp = yield(tmp) if block_given?
      array << tmp
      i += 1
    end
    array
  end

  def my_inject(*args)
    initial, sym = nil

    # Giant chunk that validates the arguments and stores them
    # in 'initial' and 'sym'
    case args.size
    when 0
      fail "Wrong usage" if !block_given?
    when 1
      if args[0].is_a?(Numeric) && block_given?
        initial = args[0]
      elsif args[0].is_a?(Symbol) && !block_given?
        sym = args[0]
      else
        fail "Wrong usage"
      end
    when 2
      if (!block_given? && 
          args.my_select { |arg| arg.is_a?(Symbol) || arg.is_a?(Numeric) }
              .size == args.size && 
          args[0].class != args[1].class)
        initial = args.my_select { |arg| arg.is_a?(Numeric) }[0]
        sym = args.my_select { |arg| arg.is_a?(Symbol)}[0]
      else
        fail "Wrong usage"
      end
    else
      fail "Too many arguments"
    end

    # Accumulation loop
    i = 0
    accumulator = initial || (i = 1 and self[0])
    if sym
      while i < self.size      
        accumulator = accumulator.send(sym, self[i])
        i += 1
      end
    end
    if block_given?
      while i < self.size
        accumulator = yield(accumulator, self[i])
        i += 1
      end
    end
    accumulator
  end
end

