module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  # selectedrating from index - session
  def selectedrating?(rating)
    
    selectedrating = session[:ratings]
    return true if selectedrating.nil?
    selectedrating.include? rating
    
  end
  
  # Color title only when clicked
  def hilite(form_column)
    
    if(session[:sort].to_s == form_column)
      return 'hilite'
    else
      return nil
      
    end
  end
end
