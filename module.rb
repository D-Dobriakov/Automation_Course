module OurModule
  def registration
    @browser.navigate.to 'http://demo.redmine.org'
    @browser.find_element(:class, 'register').click

    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    @wait.until { @browser.find_element(:id, 'user_login').displayed? }

    login = 'login' + (rand(99999)).to_s
    @password = 'Qwerty1'

    @browser.find_element(:id, 'user_login').send_keys login
    @browser.find_element(:id, 'user_password').send_keys @password
    @browser.find_element(:id, 'user_password_confirmation').send_keys @password
    @browser.find_element(:id, 'user_firstname').send_keys 'qwsder'
    @browser.find_element(:id, 'user_lastname').send_keys 'qwser'
    @browser.find_element(:id, 'user_mail').send_keys (login+ '@sdef.sd')
    @browser.find_element(:name, 'commit').click

  end

  def create_project
    @browser.find_element(:class, 'projects').click
    @browser.find_element(:css, '.icon.icon-add').click
    @browser.find_element(:id, 'project_name').send_keys 'My project'
    @browser.find_element(:id, 'project_identifier').click
    @browser.find_element(:id, 'project_identifier').send_keys rand(9999)
    @browser.find_element(:name, 'commit').click


    def create_issue (issue)

      if issue == 'bug'
        option_value = '1'
      elsif issue == 'feature'
        option_value = '2'
      elsif issue == 'support'
        option_value = '3'
      end

      @browser.find_element(:class, 'new-issue').click

      issue_type_dropdown = @browser.find_element(:id, 'issue_tracker_id')
      option = Selenium::WebDriver::Support::Select.new(issue_type_dropdown)
      option.select_by(:value, option_value)
      @browser.find_element(:id, 'issue_subject').send_keys 'qwerty'
      @browser.find_element(:name, 'commit').click
    end
  end
end