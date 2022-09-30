class SessionsController < ApplicationController
  def new
    #debugger
  end

  def create
    user = User.find_by(username: params[:session][:username])
    # if user && user.authenticate(params[:session][:password])
    #   # good scenario
    #   session[:user_id] = user.id
    #   flash[:success] = "You have successfully logged in"
    #   redirect_to root_path
    # else
    #   flash.now[:error]= "There was something wrong with your login information"
    #   render 'new', status: :see_other
    # end


    respond_to do |format|
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        flash[:success] = "Logged in successfully"
        format.html { redirect_to root_path }
      else
        flash.now[:error] = "There was something wrong with your login!"
        format.html { render :new, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    #debugger
    session[:user_id] = nil
    flash[:success] = "You have successfully logged out"
    redirect_to login_path, status: :see_other
  end

end
