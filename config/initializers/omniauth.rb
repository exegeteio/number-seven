# Use the Rails logger.  Helps in tests.
OmniAuth.config.logger = Rails.logger
# Add Twitch OmniAuth provider as middleware.
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, fields: [:username], uid_field: :username unless Rails.env.production?
  provider(
    :twitch,
    ENV.fetch("TWITCH_CLIENT_ID", "NOT PROVIDED"),
    ENV.fetch("TWITCH_CLIENT_SECRET", "NOT PROVIDED")
  )
end
