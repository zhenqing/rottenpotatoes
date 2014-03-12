class MoviesController < ApplicationController
  attr_accessor :attr,:rating
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    attr=session[:attr]
    ratings=session[:ratings]
    if (params[:attr])
      @attr=params[:attr]
      session[:attr]=params[:attr]
      @movies = Movie.order(params[:attr])
    else if(session[:attr])
      @attr=session[:attr]
      @movies = Movie.order(session{:attr})
    else
      @movies = Movie.all
    end 

    if (params[:ratings])
      @ratings = params[:ratings]
      @movies = Movie.where(:rating => params[:ratings].keys)
    else if(session[:ratings])
      @ratings = session[:ratings]
      @ratings = MOvie.where(:rating => session[:ratings].keys)
    else
      @ratings = {"all"=>1}
    end

  end
  

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
