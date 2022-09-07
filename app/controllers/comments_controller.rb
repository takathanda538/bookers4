class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_back(fallback_location: root_path) 
    else
      redirect_back(fallback_location: root_path) 
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path) 
  end
  
  private
  def comment_params
    params.require(:comment).permit(:comment, :book_id)  #formにてpost_idパラメータを送信して、コメントへpost_idを格納するようにする必要がある。
  end
  
end
