Rails.application.routes.draw do
  devise_for :users
  root "homes#index"
  get "home/about" => "homes#about"

  resources :books do
  resource :favorites, only: [:create, :destroy]
  resources :post_comments, only: [:create, :destroy]
  
  
end

 resources :users do
    member do
      get :following, :followers
    end
  end

 resources :relationships, only: [:create, :destroy]

  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
