require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    OmniAuth.config.add_mock(:twitch, OmniAuth::AuthHash.new({
      info: {"name" => "twitchuser"}
    }))
    get session_create_url(provider: :twitch)
    assert_equal "twitchuser", session[:username]
    assert_response :redirect
  end

  test "should post update" do
    OmniAuth.config.add_mock(:developer, OmniAuth::AuthHash.new({
      info: {"username" => "devuser"}
    }))
    post session_update_url(provider: :developer)
    assert_equal "devuser", session[:username]
    assert_response :redirect
  end

  test "should delete destroy" do
    OmniAuth.config.add_mock(:developer, OmniAuth::AuthHash.new({
      info: {"username" => "sign_me_out"}
    }))
    post session_update_url(provider: :developer)
    assert_equal "sign_me_out", session[:username]

    delete sign_out_url
    assert_nil session[:username]
    assert_response :redirect
  end
end
