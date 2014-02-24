module MoviesHelper
  # Checks if a number is odd:

  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end

=begin	
  	def movies_path(attr)
  		Movie.order(attr).all
  	end
=end  	
end
