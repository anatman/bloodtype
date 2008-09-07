# bloodtype.rb
# version alpha 0.0.1

# this is a shoes program. it requires shoes to run. run with the command 'shoes bloodtype.rb'

# this simulates genetic drift under no selective pressure in the human a-b-o blood type system.
# an individual with homozygous a alleles, or a heterozygous individual with a and o alleles will
# be blood type a (represented as a red dot). a homozygous b indivdual or a heterozygous one with
# b and o alleles, will be blood type b ( a blue dot). a homozygous o person is blood type o (yellow dot).
# a heterozygous person with a and b alleles will be type ab (shown by a purple dot).

# the 'individuals' are randomly mated and replaced with two offspring who cross their alleles in the
# proper manner. the matrix of colored dots represents the phenotypes, a, b, ab, or o of the population.
# the running totals at the bottom keep track of the number of each allele present in the population.
# there are, of course, twice as many alleles as individuals.

# disclaimer: i am not a geneticist or a biologist or anything remotely qualified in any of the relevant
# fields. any hope of actual information from this project may well founder on the rock of my ignorance.
# i am essentially doing this for fun, curiosity, and shoes practice. as noted below, the simulation is far
# from even pretending to be realistic at the moment, though i hope to improve this.

# this is not anywhere close to complete. i went for quick and ugly tricks, rather than good code, and the
# 'mating' system in particular is far from realistic, so no actual conclusions can be drawn from the
# experiment as yet. this is intentional. i am considering starting a tutorial blog and improving this as
# an example.

# you make the simulation advance a generation by clicking the simulation window anywhere except on
# the quit button, which you click to end the simulation and close the program. the background gradient
# reverses itself each generation to provide an easy visual cue that that generation is completed.

# s is the size parameter. there will be s squared individuals in the population. for rendering and speed
# reasons, i recommend that s be an integer between 16 and 32. my original setting is 32, giving 1024
# individuals to follow.

s = 32

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

  selcol = {
    [:a, :a] => red,
    [:a, :b] => purple,
    [:a, :o] => red,
    [:b, :a] => purple,
    [:b, :b] => blue,
    [:b, :o] => blue,
    [:o, :a] => red,
    [:o, :b] => blue,
    [:o, :o] => yellow
  }
  
  (0 .. (s * s - 1)).each { |i| people[i] = genes(alleles) }
  
  def gen(arr, s)
    arr.each_index do |i|
      n = arr[rand(s * s)]
      arr[i] = [arr[i][rand(2)], n[rand(2)]]
      arr
    end
    arr
  end
  
  every(1) do
    clear
    k = 0
    a, b = b, a
    people = gen(people, s)
    background(gradient(a, b))
    (20 .. 20 * s).step 20 do |i|
      (20 .. 20 * s).step 20 do |j|
        zot(i, j, selcol[people[k]])
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