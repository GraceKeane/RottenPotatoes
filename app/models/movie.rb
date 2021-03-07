# MODEL
class Movie < ActiveRecord::Base
  
  def self.all_ratings
    # Ratings array
    ['G','PG','PG-13','R']
  end
  
  def self.with_ratings(ratings_list)
  # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    if rating_list
      #  movies with those ratings
      Movie.where(rating: ratings_list)
      # if ratings_list is nil, retrieve ALL movies
    else
      # Else return all movies in the db
      Movie.all
    end
  end
end
