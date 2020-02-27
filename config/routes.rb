Rails.application.routes.draw do

  get 'purchase/index'
  get 'purchase/done'
  resources :prefectures

  root to: 'top#index'

  resources :items, only: [:new, :create, :show] do
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end


  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }
  resources :orders, only: [:new]
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
  resources :mypage, only: [:index]

  resources :card, only: [:new, :show, :destroy] do
    collection do
      post 'create', to: 'card#create'
      post 'pay', to: 'card#pay'
    end
  end

  resources :purchase, only: [:index] do
    collection do
      post 'index', to: 'purchase#index'
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  
end
