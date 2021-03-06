# frozen_string_literal: true

if Rails.env.production?
  Sentry.init do |config|
    # DSN is loaded from environment variable
    # config.dsn = 'https://examplePublicKey@o0.ingest.sentry.io/0'
    config.breadcrumbs_logger = [:active_support_logger]

    # To activate performance monitoring, set one of these options.
    # We recommend adjusting the value in production:
    config.traces_sample_rate = 0.5
    # or
    # config.traces_sampler = lambda do |context|
    #   true
    # end
  end
end