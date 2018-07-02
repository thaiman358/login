class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # パスワードが合っているか判定
    if user && user.authenticate(params[:session][:password])
      # ログイン成功した場合
      session[:user_id] = user.id
      redirect_to blogs_path
    else
      # ログイン失敗した場合
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end
  
   def destroy
    # ログアウトの処理
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
   end
end
