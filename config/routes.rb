require 'sidekiq/web'

Rails.application.routes.draw do
  
  namespace :admin do
    resources :users
    resources :notifications
    resources :announcements


    root to: "users#index"
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

  devise_scope :user do
    get 'signup', to: 'devise/registrations#new'
  end
  
  devise_for :users, skip: :all

  root to: "homes#index"
end
