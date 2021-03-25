Rails.application.routes.draw do
  # トップページ
  root :to => 'homes#top'

  # ルーティング設定
  resources :books, only: [:index ,:show ,:edit ,:create ,:update ,:destroy]

end
