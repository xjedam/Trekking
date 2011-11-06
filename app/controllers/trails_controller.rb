class TrailsController < ApplicationController
  # GET /trails
  # GET /trails.json
  def index
    @trails = Trail.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trails }
    end
  end

  # GET /trails/1
  # GET /trails/1.json
  def show
    @trail2 = Trail.find(params[:id])
    @trails = Trail.page(params[:page])
    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @trail }
    end
  end

  # GET /trails/new
  # GET /trails/new.json
  def new
    @trail = Trail.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trail }
    end
  end

  # GET /trails/1/edit
  def edit
    @trail2 = Trail.find(params[:id])
    @trails = Trail.page(params[:page])
    respond_to do |format|
      format.html { render action: "index" }
      format.json { render json: @trail2 }
    end
  end

  # POST /trails
  # POST /trails.json
  def create

    @trail = Trail.new(params[:trail])
    respond_to do |format|
      if @trail.save
        @trails = Trail.page(params[:page])
        format.html { render action: "index" }
        format.json { render json: @trail, status: :created, location: @trail }
      else
        format.html { render action: "index" }
        format.json { render json: @trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trails/1
  # PUT /trails/1.json
  def update
    @trail2 = Trail.find(params[:id])

    respond_to do |format|
      if @trail2.update_attributes(params[:trail])

        @trails = Trail.page(params[:page])
        format.html { render action: "index" }
        format.json { head :ok }
      else
        format.html { render action: "index" }
        format.json { render json: @trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trails/1
  # DELETE /trails/1.json
  def destroy
    @trail = Trail.find(params[:id])
    @trail.destroy

    respond_to do |format|
      format.html { redirect_to trails_url }
      format.json { head :ok }
    end
  end
end
