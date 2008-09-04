Shoes.app(:height => 680, :width => 680) do
  a = cornflowerblue
  b = pink
  alleles = [:a, :b, :o]
  people = []
  
  background(gradient(a, b))
  
  def zot(x, y, col)
    nostroke
    fill col
    oval x, y, 10
  end
  
  def genes(n)
    [n[rand(3)], n[rand(3)]]
  end
  
  def selcol(gn)
    if gn[0] == :a
      gn[1] != :b ? red : purple
    else if gn[0] == :b
      gn[1] != :a ? blue : purple
      else gn[1] == :o ? yellow : (gn[1] == :a ? red : blue)
      end
    end
  end
  
  (0 .. 1023).each { |i| people[i] = genes(alleles) }
  
  def gen(arr)
    arr.each_index do |i|
      n = arr[rand(1024)]
      arr[i] = [arr[i][rand(2)], n[rand(2)]]
      arr
    end
    arr
  end
  
  click do
    clear
    k = 0
    a, b = b, a
    people = gen(people)
    background(gradient(a, b))
    (20 .. 640).step 20 do |i|
      (20 .. 640).step 20 do |j|
        zot(i, j, selcol(people[k]))
        k += 1
      end
    end
  end
end