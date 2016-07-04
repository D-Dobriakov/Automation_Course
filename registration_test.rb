require 'test/unit'
require 'selenium-webdriver'
require_relative 'module'

class RegistrationTest < Test::Unit::TestCase
  include OurModule

  def setup
    @browser = Selenium::WebDriver.for :firefox
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def test_positive
    registration
    success_text = 'Your account has been activated. You can now log in.'
    actual_text = @browser.find_element(:id, 'flash_notice').text
    assert_equal(success_text, actual_text)
  end

  def test_change_password
    registration
    @browser.find_element(:css, '.icon.icon-passwd').click
    @browser.find_element(:id, 'password').send_keys @password
    new_pass='qwerty'
    @browser.find_element(:id, 'new_password').send_keys new_pass
    @browser.find_element(:id, 'new_password_confirmation').send_keys new_pass
    @browser.find_element(:name, 'commit').click

    success_text = 'Password was successfully updated.'
    actual_text = @browser.find_element(:id, 'flash_notice').text
    assert_equal(success_text, actual_text)
  end

  def test_create_project
    registration
    create_project
    success_text = 'Successful creation.'
    actual_text = @browser.find_element(:id, 'flash_notice').text
    assert_equal(success_text, actual_text)
  end

  def test_create_project_versions
    registration
    create_project
    @browser.find_element(:id, 'tab-versions').click
    @browser.find_element(:css, '#tab-content-versions .icon.icon-add').click
    @browser.find_element(:id, 'version_name').send_keys 'mp'
    @browser.find_element(:name, 'commit').click
    success_text = 'Successful creation.'
    actual_text = @browser.find_element(:id, 'flash_notice').text
    assert_equal(success_text, actual_text)
  end

  def test_create_bug
    registration
    create_project
    create_issue('bug')
    assert(@browser.find_element(:css, 'h2').text.include?('Bug'))
  end

  def test_create_feature
    registration
    create_project
    create_issue('feature')
    assert(@browser.find_element(:css, 'h2').text.include?('Feature'))
  end

  def test_create_support
    registration
    create_project
    create_issue('support')
    assert(@browser.find_element(:css, 'h2').text.include?('Support'))
  end

  def test_logout
    registration
    @browser.find_element(:class, 'logout').click

    @wait.until { @browser.find_element(:class, 'login').displayed? }

    login_button = @browser.find_element(:class, 'login')
    assert(login_button.displayed?)
  end

  def teardown
    @browser.quit
  end

end

