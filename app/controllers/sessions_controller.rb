class SessionsController < ApplicationController

 def create
   omniauth_info = request.env["omniauth.auth"]
   user = User.from_omniauth(omniauth_info)

   if user && user.new_record?
    render :template => "oauth/new", locals: {oauth_info: request.env["omniauth.auth"], user: User.new, name: User.name_from_oauth(request.env["omniauth.auth"])}
  else
    session[:user_id] = user.id
    redirect_to root_path
  end
 end
end
