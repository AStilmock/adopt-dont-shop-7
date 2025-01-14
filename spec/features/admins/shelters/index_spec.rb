require "rails_helper"

RSpec.describe "/admin/shelters", type: :feature do
  describe "admin_shelters#index" do
    before(:each) do
      @shelter1 = Shelter.create!(foster_program: true, name: "Bishop Animal Rescue", city: "Bishop", rank: 5)
      @pet1 = @shelter1.pets.create!(adoptable: true, age: 3, breed: "Samoyed", name: "Fluffy")
      @pet2 = @shelter1.pets.create!(adoptable: true, age: 6, breed: "Husky", name: "Hubert")
      @pet3 = @shelter1.pets.create!(adoptable: true, age: 8, breed: "Shiba Inu", name: "Shishi")

      @shelter2 = Shelter.create!(foster_program: true, name: "Chicago Animal Rescue", city: "Chicago", rank: 4)
      @pet4 = @shelter2.pets.create!(adoptable: true, age: 1, breed: "Lab", name: "Lally")
      @pet5 = @shelter2.pets.create!(adoptable: true, age: 10, breed: "Chihuahua", name: "Chewy")

      @shelter3 = Shelter.create!(foster_program: true, name: "Los Angeles Animal Rescue", city: "Los Angeles", rank: 3)
      @pet6 = @shelter3.pets.create!(adoptable: true, age: 5, breed: "Pitbull", name: "Bully")

      @app1 = Application.create!(name: "Garrett", street_address: "123 Upland", city: "Bishop", state: "CA", zip_code: "12345", description: "I'm the best -DJ Khaled", status: "In Progress")
      @petapp1 = PetApplication.create!(application_id: @app1.id, pet_id: @pet1.id)
      @petapp2 = PetApplication.create!(application_id: @app1.id, pet_id: @pet4.id)

      @app2 = Application.create!(name: "Andy", street_address: "456 Downtown", city: "Anywhere", state: "HI", zip_code: "23456", description: "Anotha One -DJ Khaled", status: "Pending")
      @petapp3 = PetApplication.create!(application_id: @app2.id, pet_id: @pet1.id)
      @petapp4 = PetApplication.create!(application_id: @app2.id, pet_id: @pet3.id)
      @petapp5 = PetApplication.create!(application_id: @app2.id, pet_id: @pet6.id)

      @app3 = Application.create!(name: "Jeff", street_address: "567 Sideways", city: "Somewhere", state: "DE", zip_code: "34567", description: "We the best -DJ Khaled", status: "Rejected")
      @petapp6 = PetApplication.create!(application_id: @app3.id, pet_id: @pet5.id)
    end

    it "displays all shelters in the Shelters DB in reverse alphabetical order by name using SQL" do
      visit "/admin/shelters"

      expect(@shelter3.name).to appear_before(@shelter2.name)
      expect(@shelter2.name).to appear_before(@shelter1.name)
    end

    it "has a section for shelters with pending applications" do
      # For this story, you should fully leverage ActiveRecord methods in your query.

      # 11. Shelters with Pending Applications

      # As a visitor
      # When I visit the admin shelter index ('/admin/shelters')
      # Then I see a section for "Shelters with Pending Applications"
      # And in this section I see the name of every shelter that has a pending application

      visit "/admin/shelters"

      within "#pending" do
        expect(page).to have_content("Shelters with Pending Applications")
        expect(page).to have_content(@shelter1.name)
        expect(page).to have_content(@shelter3.name)
        expect(page).to_not have_content(@shelter2.name)
      end
    end
  end
end