class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @comments = @blog.comments

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    #@blog=Blog.find(params[:id])
    #@blog.destroy
    #redirect_to blogs_path, notice: "ブログを削除しました!  

    @comment = Comment.find(params[:id])

    @blog = @comment.blog
    @comments = @blog.comments

    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @blog = @comment.blog
  end

  private 
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
      params.fetch(:comment, {}).permit(:blog_id, :content)
    end
end
