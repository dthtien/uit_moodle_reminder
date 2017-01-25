class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def subscribe
    @user = User.find_by_username_or_initialize_by(user_params)

    if @user.persisted?
      flash.now[:alert] = "Account is existed in system"
      render "new"
    else
      if @user.authenticate! && @user.save(validate: false)
        flash[:notice] = "Success"
        UserMailer.subscribe_confirmation.deliver_now
        redirect_to thankyou_path
      else
        flash.now[:alert] = "Failed"
        render "new"
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end