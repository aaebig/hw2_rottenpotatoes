class MoviesController < ApplicationController

  before_filter :load_vars

  def load_vars
    Rating.all().each {|rating| (@all_ratings ||= []) << rating.rating}
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @highlight = params[:sort]
    if params[:ratings]
      session[:ratings] = params[:ratings]
    end
    if params[:sort]
      session[:sort] = params[:sort]
    end
    
    if params[:sort] != session[:sort] or params[:ratings] != session[:ratings]
      redirect_to movies_path(:sort=>session[:sort], :ratings=>session[:ratings])
    elsif params[:ratings]
      ratingsearch = {:rating => params[:ratings].keys}
      @ratings = params[:ratings]
      @movies = Movie.all(:conditions=>ratingsearch,:order=>params[:sort])
    else
      @ratings = {}
      @movies = Movie.all(:order=>params[:sort])
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
