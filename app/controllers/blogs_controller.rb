class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy] # destroyアクションを追加
  
  def index
    if logged_in?
      @blogs = Blog.all # 全部表示する
    else
      redirect_to new_session_path
    end
  end
  
  # /newのリクエストを受け取った時の処理
  def new
    if logged_in?
      if params[:back]
        @blog = Blog.new(blog_params)
      else
        @blog = Blog.new
        @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。->これが無いとアソシエーション動かない
      end
    else
      redirect_to new_session_path
    end
  end
  
  # 作成
  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。->これが無いとアソシエーション動かない
    if @blog.save
      redirect_to blogs_path
    else
      render 'new'
    end
  end
  
  # 確認画面
  def confirm
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidをblogのuser_idカラムに挿入する。->これが無いとアソシエーション動かない
    render :new if @blog.invalid?
  end
  
  # 詳細画面
  def show
    if logged_in?
      @blog = Blog.find(params[:id])
      @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    else
      redirect_to new_session_path
    end
  end
  
  # 編集画面
  def edit
    if logged_in?
      @blog = Blog.find(params[:id])
    else
      redirect_to new_session_path
    end
  end
  
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to blogs_path, notice: "ブログを編集しました！"
    else
      render 'edit'
    end
  end
  
  # ブログの削除機能
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice:"ブログを削除しました！"
  end
  
  private
  def blog_params
    params.require(:blog).permit(:title, :content, :user_id)
  end
  
  def set_blog
  @blog = Blog.find(params[:id])
  end
end