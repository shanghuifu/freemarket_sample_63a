Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items, only: [:index, :show]
  resources :users, only: [:show, :edit, :update] do
    member do
      get :logout
    end
  end
end