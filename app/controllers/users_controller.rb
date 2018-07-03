class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      # 保存の成功した場合の処理
      session[:user_id] = @user.id # セッション情報に現在のidをぶち込む->sign up後にログイン状態にするため
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end
  
  def show
      @user = User.find(params[:id])
      @favorites_blogs = @user.favorite_blogs
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end