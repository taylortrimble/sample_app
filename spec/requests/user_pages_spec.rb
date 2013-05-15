require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1', text: 'Sign up') }
    it { should have_full_title('Sign up') }
  end
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
  
    it { should have_selector('h1', text: user.name) }
    it { should have_full_title(user.name) }
  end
  
  describe "signup" do
  
    before { visit signup_path }
  
    let(:submit) { "Create my account" }
  
    describe "with invalid information" do
      
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end
  
    describe "with valid information" do
      
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
  
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_full_title(user.name) }
        it { should have_success_message('Thank you') }
        it { should have_link('Sign out') }
      end
    end
  end
  
  describe "edit" do
    let(:user) { FactoryGirl.create :user }
    before { visit edit_user_path(user) }
    
    describe "page" do
      it { should have_selector('h1',     text: "Update your profile") }
      it { should have_selector('title',  text: "Edit user") }
      it { should have_link('Change',     href: 'http://gravatar.com/emails') }
    end
    
    describe "with invalid information" do
      before {click_button "Save changes" }
      
      it { should have_content('error') }
    end
  end
  
end
