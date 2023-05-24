class ApplicationsController < ApplicationController
  def index

  end

  def show
    if params[:search].present?
      @pets = Pet.search(params[:search])
      @application = Application.find(params[:id])
    else
      @pets = Pet.all
      @application = Application.find(params[:id])
    end
  end

  def new

  end

  def update
    application = Application.find(params[:id])
    application.update(description: params[:description], status: "Pending")
    applications_to_update = application.pet_applications
    applications_to_update.update(pet_applications_status: "Pending")
    redirect_to "/applications/#{application.id}"
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