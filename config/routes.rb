# 最初にブラウザからの信号を受け取り、コントローラーに渡す
Rails.application.routes.draw do
  get 'sessions/new'

  resources :blogs do #blogsに対してconfirmのルーティングを新たに生成
    collection do
      post :confirm
    end
  end
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end