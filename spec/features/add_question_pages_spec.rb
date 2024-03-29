require 'rails_helper'




describe 'Adding a question' do
  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    user_login
  end

  it 'visits the question creation page' do
    click_link "q?      (҂⌣̀_⌣́)ᕤ"
    expect(page).to have_content 'Add a question'
  end

  it 'adds a question' do
    click_link "q?      (҂⌣̀_⌣́)ᕤ"
    fill_in 'question_text', :with => "Blah Blah"
    click_button "submit"
    expect(page).to have_content 'Blah Blah'
  end

  it 'displays an error if text box is blank on submission' do
    click_link "q?      (҂⌣̀_⌣́)ᕤ"
    click_button "submit"
    expect(page).to have_content "Please fill in the text box"
  end

  it 'takes a user to the sign in page if they try to create a question and are not logged in' do
    click_link "logout"
    visit ('/')
    click_link "q?      (҂⌣̀_⌣́)ᕤ"
    expect(page).to have_content "Not authorized"
  end
end

describe 'Answering a question' do
  let(:user) { FactoryGirl.create(:user)}
  before(:each) do
    user_login
  end

  it 'visits a question page' do
    test_question = Question.create({:user_id => user.id, :text => "test text" })
    visit '/'
    click_link "#{test_question.id}"
    expect(page).to have_content "Answer"

  end

  it 'displays a text field when the answer button is clicked', js: true do
    test_question = Question.create({:user_id => user.id, :text => "test text" })
    visit '/'
    click_link "#{test_question.id}"
    click_link "Answer"
    expect(page).to have_css('#reply')
  end
end

