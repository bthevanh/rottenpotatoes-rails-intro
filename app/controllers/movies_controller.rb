class MoviesController < ApplicationController

  @order = 0
  
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    
    if @order ==1
      @movies = Movie.order(:title)
    elsif @order ==2
      @movies = Movie.order(:release_date)
    else
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end
  
  def nameIndex
    @order = 1
    redirect_to movies_path
  end
  
  def dateIndex
    @order = 2
    redirect_to movies_path
  end
  
  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
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
    redirect_to movies_path
  end

end
