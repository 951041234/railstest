class EventsController < ApplicationController

    before_action :set_event, :only => [ :show, :edit, :update, :destory]

    def index
        @events = Event.order(:id).page(params[:page]).per(5)
      end

    def new
        @event = Event.new
    end

    def create
        flash[:notice] = "event was successfully created"
        @event = Event.new(event_params)
        if @event.save
            redirect_to :action => :index
        else
            render :action => :new
        end
    end

    def show 
        @page_title = @event.name
    end

    def edit
    end

    def update
        flash[:notice] = "#{@event.name} was successfully updated"
        @event.update(event_params)
        redirect_to :action => :show, :id =>@event 
    end

    def destory
        flash[:alert] = "#{@event.name} was successfully deleted" 
        @event.destroy

        redirect_to :action => :index
    end

    private

    def event_params
        params.require(:event).permit(:name, :description, :capacity)
    end

    def set_event
        @event = Event.find(params[:id])        
    end

end
