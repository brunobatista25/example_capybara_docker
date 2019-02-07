When('I create a user') do
  user_page.load
  @person = OpenStruct.new
  @person.name = Faker::Name.first_name
  @person.last_name = Faker::Name.last_name
  @person.address = Faker::Address.street_name
  @person.email = Faker::Internet.free_email
  @person.university = Faker::University.name
  @person.age = Faker::Number.between(18, 50)
  @person.job = Faker::Job.title
  @person.gender = Faker::Gender.binary_type
  
  user_page.create_user(@person)
end

Then('I will check if the user was successfully created') do
  @notice = find('#notice')
  expect(@notice.text).to eq 'Usuário Criado com sucesso'
end
