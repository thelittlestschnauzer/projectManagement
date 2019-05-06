require 'sidekiq/web'

Rails.application.routes.draw do
  
  
  namespace :admin do
    resources :users
    resources :notifications
    resources :announcements


    root to: "users#index"
  end
  
  resources :announcements, only: [:index]
  resources :notifcations, only: [:index]
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end
  
  devise_for :users, skip: :all
  
  resources :lists do
    member do    
      patch :move
    end      
  end 

  resources :cards do     
    member do    
      patch :move 
    end 
  end 

  root to: "lists#index"
end
