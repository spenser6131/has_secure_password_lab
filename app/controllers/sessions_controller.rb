class SessionsController < ApplicationController

  def new
    @user = User.new
    render :login
  end

  def create
    user = User.find_by(name: params[:user][:name])
    if user.try(:authenticate, params[:user][:password])
      session[:user_id] = user.id
      redirect_to "/home"
    else
      redirect_to "/login"
    end
  end

  private

  def user_params
    params.require[:user].permit[:name, :password, :password_confirmation]
  end

end
