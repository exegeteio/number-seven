Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get "/home", to: "home#index", as: "home_index"

  get "/auth/twitch/callback", to: "session#create", as: "session_create"
  unless Rails.env.production?
    post "/auth/developer/callback", to: "session#update", as: "session_update"
  end
  delete "/auth", to: "session#destroy", as: "sign_out"
end
