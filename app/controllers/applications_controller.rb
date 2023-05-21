class ApplicationsController < ApplicationController
  def index

  end

  def show
    if params[:search].present?
      @pets = Pet.search(params[:search])
      @application = Application.find(params[:id])
      @app_petapps = PetApplication.find_applications(@application.id)
    else
      @pets = Pet.all
      @application = Application.find(params[:id])
      @app_petapps = PetApplication.find_applications(@application.id)
    end
  end

  def new

  end

  def create
    new_app = Application.new(application_params)
    if new_app.save
      new_app.update(status: "In Progress")
      redirect_to "/applications/#{new_app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(new_app.errors)}"
    end
  end

  # def update
  #   # find pet id
  #   require 'pry'; binding.pry
  #   if params[:search].present?
  #     @pet = Pet.search(params[:search])
  #     @application = Application.find(params[:id])
  #     # @app_petapps = PetApplication.find_applications(@application.id)
  #     PetApplication.create!(application_id: @application.id, pet_id: @pet.id)
  #   end

  #   # @pet = Pet.find(params[:id])
  #   # @application = Application.find(params{:id})
  #   # find application id
  #   # update petapplication with pet id and application id
  # end

  private

  def application_params
    params.permit(
      :name,
      :street_address,
      :city,
      :state,
      :zip_code,
      :description,
      :status
    )
  end
end