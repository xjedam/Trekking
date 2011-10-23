class TrailsController < ApplicationController
  # GET /trails
  # GET /trails.json
  def index
    @trails = Trail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trails }
    end
  end

  # GET /trails/1
  # GET /trails/1.json
  def show
    @trail = Trail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trail }
    end
  end

  # GET /trails/new
  # GET /trails/new.json
  def new
    @trail = Trail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trail }
    end
  end

  # GET /trails/1/edit
  def edit
    @trail = Trail.find(params[:id])
  end

  # POST /trails
  # POST /trails.json
  def create
    @trail = Trail.new(params[:trail])
    tGenerator = TrailGenerator.new(@trail.latitude_start, @trail.longitude_start, @trail.latitude_end, @trail.longitude_end)
    @trail.map_url = tGenerator.getChartUrl()
    respond_to do |format|
      if @trail.save
        format.html { redirect_to @trail, notice: 'Trail was successfully created.' }
        format.json { render json: @trail, status: :created, location: @trail }
      else
        format.html { render action: "new" }
        format.json { render json: @trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trails/1
  # PUT /trails/1.json
  def update
    @trail = Trail.find(params[:id])

    respond_to do |format|
      if @trail.update_attributes(params[:trail])
        format.html { redirect_to @trail, notice: 'Trail was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
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
