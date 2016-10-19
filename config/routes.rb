Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :campaigns, only: [:new, :create, :show] ## restrict the resources to only the path
  #that I am using
end
