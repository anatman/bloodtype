Shoes.app do
  a = cornflowerblue
  b = pink
  
  background(gradient(a, b))
  
  def zot(x, y, col)
    nostroke
    fill col
    oval x, y, 10
  end
  
  click do
    clear
    a, b = b, a
    background(gradient(a, b))
    (20 .. 400).step 20 do |i|
      (20 .. 400).step 20 do |j|
        zot(i, j, [red, blue, yellow, purple][rand(4)])
      end
    end
  end
end