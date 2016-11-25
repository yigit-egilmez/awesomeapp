require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup 
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test "password reset" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    
    #invalid test
    post password_resets_path, params: {password_reset: {email: ""}}
    assert_not flash.empty?
    assert_template 'password_resets/new'
    
    #valid email
    post password_resets_path, params: {password_reset: {email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to root_url
    
    #password reset form
    user = assigns(:user)
    
    #wrong email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    
    #Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    
    #right email, wrong token
    get edit_password_reset_path("wrongtoken", email:user.email)
    assert_redirected_to root_url
    
    #right email, right token
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    
    #invalid password & confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "foobar",
                            password_confirmation: "barfoo" } }
                            
    assert_select 'div#error_explanation'
    
    # Empty password
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "",
                            password_confirmation: "" } }
    assert_select 'div#error_explanation'

    # Valid password & confirmation
    patch password_reset_path(user.reset_token),
          params: { email: user.email,
                    user: { password:              "foobaz",
                            password_confirmation: "foobaz" } }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end

end
