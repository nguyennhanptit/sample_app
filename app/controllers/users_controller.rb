class UsersController < ApplicationController

  def show
    find_by
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t :welcome_flash
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_by
    @user = User.find_by id: params[:id]
    return if @user
     flash[:success] = t :not_flash
      redirect_to @user
  end
end
