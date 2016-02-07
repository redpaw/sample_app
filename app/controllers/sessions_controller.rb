class SessionsController < ApplicationController
  def new
  end

  def create 
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
       if user.activated? 
         log_in user
         params[:session][:remember_me] == '1' ? remember(user) : forget(user) 
         redirect_back_or user
      else 
        message = "Account not activated"
        message += "Check your email for activation link"
        flash[:warning] = message 
        redirect_to root_url 
    end 
  		#Login the user and redirect to his page 
  	else 
  		render 'new'
  		flash.now[:danger] = 'Invalid email/password combination'
     end 
  end 

  def destroy 
    log_out if logged_in?
    redirect_to root_url 
  end 

end
