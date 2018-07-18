class SessionsController < ApplicationController
  def new
  end

  def create
    find_by_user
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

  def find_by_user
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to user
    else
      flash[:danger] =  t".not_confirm"
      render :new
    end
  end
end
