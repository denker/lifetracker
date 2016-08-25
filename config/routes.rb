Rails.application.routes.draw do

  devise_for :users
  root 'records#index'

  resources :records
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  telegram_webhooks TelegramController if Rails.env.development?

  if Rails.env.production?
    telegram_webhooks TelegramController, bot, {token: ENV['TELEGRAM_BOT_TOKEN'], username: 'day_life_tracker_bot'}
  end

end
