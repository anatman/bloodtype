s = 16

Shoes.app(:height => s * 20 + 80, :width => s * 20 + 40) do
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
  
  (0 .. (s * s - 1)).each { |i| people[i] = genes(alleles) }
  
  def gen(arr, s)
    arr.each_index do |i|
      n = arr[rand(s * s)]
      arr[i] = [arr[i][rand(2)], n[rand(2)]]
      arr
    end
    arr
  end
  
  click do
    clear
    k = 0
    a, b = b, a
    people = gen(people, s)
    background(gradient(a, b))
    (20 .. 20 * s).step 20 do |i|
      (20 .. 20 * s).step 20 do |j|
        zot(i, j, selcol(people[k]))
        k += 1
      end
    end
    tp = people.flatten.partition { |i| i == :a }
    tp2 = tp[1].partition {|i| i == :b }
    tpa = tp[0].size
    tpb = tp2[0].size
    tpo = tp2[1].size
    para("type a: #{tpa}", :top => s * 20 + 20, :left => 20, :stroke => red)
    para("type b: #{tpb}", :top => s * 20 + 20, :left => s * 5 + 20, :stroke => blue)
    para("type o: #{tpo}", :top => s * 20 + 20, :left => s * 10 + 20, :stroke => yellow)
    button("quit", :top => s * 20 + 50, :left => s * 7 + 20) { exit }
  end
end