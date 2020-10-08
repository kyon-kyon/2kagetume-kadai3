class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    #render 'show_follow'
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
    
  end


  def update
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "ログインユーザーのものではありません"
      redirect_to user_path(current_user.id)
    end
    if @user.update(user_params)
      flash[:notice] ="successfully"
     redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "ログインユーザーのものではありません"
      redirect_to user_path(current_user.id)
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
