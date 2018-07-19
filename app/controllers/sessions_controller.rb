class SessionsController < ApplicationController
  def new
  end

  def create
    find_by_user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def find_by_user
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      if params[:session][:remember_me] == "1"
          remember user
      else
          forget user
      end
      redirect_to user
    else
      flash[:danger] =  t".not_confirm"
      render :new
    end
  end
end
