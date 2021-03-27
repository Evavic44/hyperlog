Rails.application.routes.draw do
  get  'home/index'
  get  'profiles/oauth/github',
       to: 'profiles/oauth_github#oauth_initiate'
  get  'profiles/oauth/github/callback',
       to: 'profiles/oauth_github#oauth_callback'

  post 'internal/api/initial_analysis',
       to: 'analysis_endpoints/receive_analysis#receive_initial_analysis'
  post 'internal/api/tech_analysis',
       to: 'analysis_endpoints/receive_analysis#add_tech_analysis_by_repo'
  post 'internal/api/tech_analysis/status',
       to: 'analysis_endpoints/receive_analysis#tech_analysis_status'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    invitations: 'users/invitations',
    registrations: 'users/registrations'
  }, skip: [:registrations]

  as :user do
    put 'users' => 'users/registrations#update', :as => 'user_registration'
    delete 'users' => 'users/registrations#destroy', :as => 'user_delete'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  scope '/internal/api' do
    post 'initial_analysis',
         to: 'analysis_endpoints/receive_analysis#receive_initial_analysis'
    post 'tech_analysis',
         to: 'analysis_endpoints/receive_analysis#add_tech_analysis_by_repo'
    post 'repo_analysis',
         to: 'analysis_endpoints/receive_analysis#repo_analysis'
  end

  scope '/data_api' do
    get '/user_info', to: 'data_api#user_info'
    get '/user_socials', to: 'data_api#user_socials'
    get '/projects', to: 'data_api#projects'
    get '/projects/:id', to: 'data_api#project_info'
    get '/projects/:project_id/repos/:repo_id', to: 'data_api#project_repo'
  end

  scope '/settings' do
    get '/profile', to: 'settings#profile'
    put '/profile', to: 'settings#profile_edit'
    put '/profile_social', to: 'settings#social_edit'
    put '/profile_contact_info', to: 'settings#contact_info_edit'
    get '/themes', to: 'settings#themes'
    put '/themes', to: 'settings#themes_edit'
    get '/account', to: 'settings#account'
    get '/password', to: 'settings#password'
  end

  scope '/projects' do
    get '/', to: 'projects#index', as: 'projects_home'
    get '/new', to: 'projects#new', as: 'project_new'
    put '/new', to: 'projects#create', as: 'project_create'
    get '/:id', to: 'projects#show', as: 'project'
    put '/:id', to: 'projects#update', as: 'update_project'
    get '/:id/edit', to: 'projects#edit', as: 'edit_project'
    delete '/:id', to: 'projects#delete', as: 'delete_project'
  end
end
