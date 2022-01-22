# Patch Omniauth gem into our app.
class SessionController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update]

  # Called by twitch authentication.
  def create
    session[:username] = user_info[:name]
    # TODO:  Make this go to the dashboard!
    redirect_to home_index_url
  end

  # Called by the developer authentication.
  def update
    unless Rails.env.production?
      session[:username] = user_info[:username]
      # TODO:  Make this go to the dashboard!
      redirect_to home_index_url and return
    end
    render plain: '', status: :unauthorized
  end

  # Sign out!
  def destroy
    session.delete(:username)
    redirect_to home_index_url
  end

  private

  def user_info
    request.env["omniauth.auth"][:info]
  end
end
