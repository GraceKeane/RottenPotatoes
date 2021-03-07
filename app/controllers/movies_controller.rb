# CONTROLLER
class MoviesController < ApplicationController
# @ratings_to_show.include?(rating)
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Passing from view to controller
    @all_ratings = Movie.all_ratings
    sort_ratings = Movie.all_ratings
    sort_par = params[:sort] || session[:sort]
    
    # Sessions - "remembering the last state"
    session[:sort] = params[:sort] unless params[:sort].nil?
    session[:ratings] = params[:ratings] unless params[:ratings].nil?
    
     if !@ratings_to_show
         @ratings_to_show = Hash.new
         @all_ratings.each do |rating|
         @ratings_to_show[rating] = 1
     end
       
    # Working with sessions (remembering the last state)
 
    # If sort OR ratings are nill and have no cookies
    if (params[:sort].nil? && !session[:sort].nil?) || (params[:ratings].nil? && !session[:ratings].nil?)
      
      redirect_to movies_path("ratings" => session[:ratings], "sort" => session[:sort])
      
    # If ratings and sort are not null
    elsif !params[:ratings].nil? || !params[:sort].nil?
      if !params[:ratings].nil?
        movie_list = params[:ratings].keys
        # Return the list of movies selected
        return @movies = Movie.where(rating: movie_list).order(session[:sort])
      else 
        # Return all movies 
        return @movies = Movie.all(session[:sort])
    end
      
    elsif !session[:ratings].nil? || session[:sort].nil?
      # Return session (last state)
      redirect_to movies_path("ratings" => session[:ratings], "sort" => session[:sort])
      else
        # Return all movies in the DB
        return @movies = Movie.all
    end
       
   end
  end
  
  def new
    # default: render 'new' template
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

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
