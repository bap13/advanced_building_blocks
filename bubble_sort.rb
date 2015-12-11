def bubble_sort(array)
  n = array.length
  loop do
    swapped = false
    for i in (1...n)
      if array[i - 1] > array [i]
        array[i - 1], array[i] = array[i], array[i - 1]
        swapped = true
      end
    end
    break unless swapped
  end
  array
end

def bubble_sort_by(array)
  n = array.length
  loop do
    swapped = false
    for i in (1...n)
      if yield(array[i - 1], array[i]) > 0
        array[i - 1], array[i] = array[i], array[i - 1]
        swapped = true
      end
    end
    break unless swapped
  end
  array
end
