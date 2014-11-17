Rails.application.routes.draw do
  resources :diff, path: 'diff', only: [:index] 
end
