class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
  end

  def update
    if params[:updated_status] == "Approved"
      pet_application = PetApplication.find(params[:pet_application_id])
      pet_application.update(pet_applications_status: params[:updated_status])
      redirect_to "/admin/applications/#{pet_application.application_id}"
    elsif params[:updated_status] == "Rejected"
      pet_application = PetApplication.find(params[:pet_application_id])
      pet_application.update(pet_applications_status: params[:updated_status])
      redirect_to "/admin/applications/#{pet_application.application_id}"
    end
  end
end