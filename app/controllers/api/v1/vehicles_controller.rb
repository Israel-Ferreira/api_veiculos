# frozen_string_literal: true

class Api::V1::VehiclesController < Api::V1::ApiController
  before_action :set_vehicle, only: %i[show update destroy]

  def index
    model_name = params[:vehicle_model].present? ? params[:vehicle_model] : nil
    @vehicles = model_name.nil? ? Vehicle.all : Vehicle.by_name(model_name)

    render json: @vehicles
  end

  def show
    if @vehicle.nil?
      render json: {message: 'Veiculo não encontrado'}, status: :not_found
    else
      render json: @vehicle
    end
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)

    if @vehicle.save
      render json: { message: 'Veiculo Adicionado com sucesso', data: @vehicle }, status: :created
    else
      render json: @vehicle.errors.full_messages.to_sentence, status: :bad_request
    end
  end

  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: @vehicle.errors.full_messages.to_sentence, status: :bad_request
    end
  end

  def destroy
    @vehicle.destroy!
    render json: { message: 'Veiculo deletado com sucesso' }
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:vehicle_name, :description, :year, :brand, :sold)
  end

  def set_vehicle
    @vehicle = Vehicle.find(params[:id])
  end
end
