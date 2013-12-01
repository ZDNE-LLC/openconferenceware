def login_as(login)
  if login.blank?
    logout
  else
    @user = User.find(ActiveRecord::Fixtures.identify(login))
    post browser_session_path, :login_as => @user.login
  end
end

def logout
  @user = nil
  delete sign_out_path
  session[:user].should == nil
end

Given /^I am logged in as "([^\"]*)"$/ do |login|
  login_as(login)
end

Given /^I am not logged in$/ do
  logout
end
