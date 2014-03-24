class MoviesController < ApplicationController
  attr_accessor :attr,:rating
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # url=Rails.application.routes.recognize_path(request.referrer)
    # controller_name=url[:controller]
    # action_name=url[:action]
    controller_name=session[:controller_name]
    action_name =session[:action_name]
   
    if(session[:controller_name]=="movies"&&session[:action_name]=="index")
      redirect_to :controller=>"movies",:action=>"index"
    else
      if(params[:attr])
        session[:attr]=params[:attr]
      end
      if(params[:ratings])
        session[:ratings]=params[:ratings]
      end
      @ratings=session[:ratings]
      if(session[:attr])
        @attr=session[:attr]
        if(session[:ratings])
          @ratings=session[:ratings]
          @movies = Movie.order(@attr).where(:rating => @ratings.keys)
        else
          @ratings = {"all"=>1}
          @movies = Movie.order(@attr)
        end
      else
        if(session[:ratings])
          @ratings=session[:ratings]
          @movies = Movie.where(:rating => @ratings.keys)
        else
          @ratings = {"all"=>1}
          @movies = Movie.all
        end
      end
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
