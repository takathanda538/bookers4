class BooksController < ApplicationController
  
  before_action :authenticate_user!
  
  
  def show
    @booknew = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def create
    @book = Book.new(params_book)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
    else
      @user = current_user
      @books = Book.all
      @book = Book.new
      render :index
    end
  end

  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(params_book)
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      redirect_to books_path
    else
      render :index
    end
  end

  private

  def params_book
    params.require(:book).permit(:title, :body)
  end
end
