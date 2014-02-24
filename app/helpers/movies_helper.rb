module MoviesHelper
  # Checks if a number is odd:
=begin
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
=end
	
  	def movies_path(attr="title")
  		Movie.all(:order=>attr)
  	end
end
