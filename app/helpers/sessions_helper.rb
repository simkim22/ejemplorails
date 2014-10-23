module SessionsHelper
  
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
   # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
  
  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  # def sign_in(user)
    # remember_token = User.new_remember_token
    # cookies.permanent[:remember_token] = remember_token
    # user.update_attribute(:remember_token, User.digest(remember_token))
    # self.current_user = user
  # end
#   
  # def signed_in?
    # !current_user.nil?
  # end
#   
  # def current_user=(user)
    # @current_user = user
  # end
# 
  # def current_user
    # remember_token = User.digest(cookies[:remember_token])
    # @current_user ||= User.find_by(remember_token: remember_token)
  # end
#   
  # def sign_out
    # current_user.update_attribute(:remember_token,
                                  # User.digest(User.new_remember_token))
    # cookies.delete(:remember_token)
    # self.current_user = nil
  # end
  
end
