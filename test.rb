require 'test/unit'
require 'selenium-webdriver'
require_relative 'module'

class RegistrationTest < Test::Unit::TestCase
  include OurModule

  def setup
    @browser = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end



  def test_create_project
    registration
    create_project
    success_text = 'Successful creation.'
    actual_text = @browser.find_element(:id, 'flash_notice').text
    assert_equal(success_text, actual_text)
  end






end


