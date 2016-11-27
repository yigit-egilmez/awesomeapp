require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup 
    @micropost = microposts(:orange)
  end 

  test "should redirect edit when not logged in" do
    assert_no_difference "Micropost.count", 0 do
      post microposts_path, params: { micropost: {content: "Lorem ipsum"}} 
    end
    assert_redirected_to login_url
  end

  test "should redirect create when not logged in" do
    assert_no_difference "Micropost.count", 0 do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong post" do
    log_in_as(users(:michael))
    micropost = microposts(:ants)
    assert_no_difference "Micropost.count", -1 do
        delete micropost_path(micropost)
    end
    assert_redirected_to root_url
  end
end
