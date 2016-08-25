class TelegramController < Telegram::Bot::UpdatesController

  # https://habrahabr.ru/post/279179/

  def start(email=nil, *)
    message = if email && from
      user = User.find_by(email: email)
      if user
        user.update(telegram: from['id'].to_i)
        "Привет #{from['username']}! Телеграм и почта связаны, пишите, всё сохраним."
      else
        "Привет, #{from['username']}! Похоже, у вас ещё нет аккаунта."
      end
    else
      "Привет #{from['username']}! Введите правильный электронный адрес." if from
    end
    reply_with :message, text: message
  end

  def message(message)
    r = Record.create( user: User.find_by(telegram: from['id']), text: message['text'] )
    reply_with :message, text: r ? "Ок" : "Ошибка :("
  end

  def help(cmd = nil, *)
    message =
      if cmd
        help_for_cmd?(cmd) ? t(".cmd.#{cmd}") : t('.no_help')
      else
        t('.help')
      end
    reply_with text: message
  end

end
