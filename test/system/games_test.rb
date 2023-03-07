require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Fill the form with a random word, click play, message not in grid" do
    visit new_url

    fill_in 'answer', with: 'zzzz'
    click_on 'submit'

    assert_selector 'h3', text: /Sorry but the zzzz cannot be built from \w{10}/
  end

  test 'fill the form with one letter consonant, click submit and word is not valid english word' do
    visit new_url

    fill_in 'answer', with: 'h'
    click_on 'submit'

    assert_selector 'h3', text: /Sorry but \w does not seem to be an English word/

  end

  test 'fill the form with valid english word, and return right message' do
    visit new_url

    fill_in 'answer', with: 'hello'
    click_on 'submit'

    assert_selector 'h3', text: /Congratulations, you got a score of \d letters!/
  end

end

# Going to the /new game page displays a random grid.
# You can fill the form with a random word, click the play button, and get a message that the word is not in the grid.
# You can fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word.
# You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a “Congratulations” message.

