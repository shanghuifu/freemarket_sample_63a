Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  
  resources :items, only: [:index, :new, :create, :show] do
    resources :purchases, only: [:new, :create]
  end

  resources :users, only: [:show, :edit, :update] do
    member do
      get :logout
    end
    resources :cards
  end

  get 'cards/new'
  
  get '/signup', to: 'signup#index'
  resources :signup do
    collection do
      get 'step1'
      post 'step2'
      post 'step3' #入力が全て完了
      get 'complete_signup' #登録完了後
    end
  end
end
