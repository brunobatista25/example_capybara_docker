# Classe para mapear os elementos da pagina home
class UserPage < SitePrism::Page
  set_url '/users/new'
  element :name, '#user_name'
  element :last_name, '#user_lastname'
  element :address, '#user_address'
  element :email, '#user_email'
  element :university, '#user_university'
  element :job, '#user_profile'
  element :gender, '#user_gender'
  element :age, '#user_age'
  element :create_button, 'input[value="Criar"]'
  element :cancel_button, 'a[href="/treinamento/home"]'

  def create_user(person)
    name.set person.name
    last_name.set person.last_name
    email.set person.email
    address.set person.address
    university.set person.university
    job.set person.job
    gender.set person.gender
    age.set person.age
    create_button.click
  end
end