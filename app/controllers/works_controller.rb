class WorksController < ApplicationController

  def index
    @works = Work.all
  end


  def new
    @work = Work.new
  end


  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end


  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
      @work = Work.find_by(id: params[:id])

      @work.destroy
      redirect_to works_path
  end


  private

  def work_params
    return params.require(:work).permit(
      :title,
      :published_year,
      :category,
      :creator,
      :description
    )
  end

end
