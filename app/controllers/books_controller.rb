class BooksController < ApplicationController
before_action :authenticate_user!

  def new
    @book = Book.new
    @books = Book.all

  end

  def create
    @book = Book.new(book_image_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to  user_path(current_user.id)
    else
      @users = User.all
      @books = Book.all
      render "index"
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
     flash[:notice] = "ログインユーザーのものではありません"
     redirect_to books_path
    end

  end

  def update
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
     flash[:notice] = "ログインユーザーのものではありません"
     redirect_to books_path
    end
    if @book.update(book_image_params)
      flash[:notice] = "successfully"
     redirect_to book_path(@book)
    else
     render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def index
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @post_comment = PostComment.new
    
  end

  private
  def book_image_params
    params.require(:book).permit(:title, :body)
  end
end


