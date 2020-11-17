class BarbersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_barber, only: [:show, :edit, :update, :destroy]
  
    def index
      @barbers = Barber.all
    end
  
    def show
    end
  
    def new
      @barber = Barber.new
    end
  
    def create
      @barber = Barber.new(barber_params)
      if @barber.save
        redirect_to barber_path(@barber)
      else
        render :new
      end
    end
  
    private
  
    def set_barber
      @barber = Barber.find(params[:id])
    end
  
    def barber_params
      params.require(:barber).permit(:name, :phone_number, :email, :skills)
    end
  end
  