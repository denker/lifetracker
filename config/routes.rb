Rails.application.routes.draw do

  devise_for :users
  root 'records#index'

  resources :records
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  telegram_webhooks TelegramController#, {token: Rails.configuration.bot_token, username: 'day_life_tracker_bot'}

end
