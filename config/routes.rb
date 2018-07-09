Rails.application.routes.draw do
  root 'static_pages#home'
  get 'password_resets/new'
  get 'password_resets/edit'
  get  '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/show', to: 'microposts#show'
  get '/new', to: 'microposts#new'
  resources :users
  resources :microposts,          only: [:create, :destroy]
  resources :password_resets,     only: [:new, :create, :edit, :update]\
end
