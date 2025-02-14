class MoviesController < ApplicationController

  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all if @movies.nil? || @movies.empty?
    @all_ratings = ['G','PG','PG-13','R']
    @sort_params = params[:sort] if !params[:sort].nil?
    @movies = @movies.order(@sort_params)
  end

  def new
    # default: render 'new' template
  end
  

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    @movies = @movies.order(@sort_params)
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    @movies = @movies.order(@sort_params)
    redirect_to movies_path
  end
  
  def ratings
    ratings = params[:ratings]
    @movies.reject{ |movie| !ratings.include? movie[:rating] }
    
    redirect_to movies_path
  end

end
