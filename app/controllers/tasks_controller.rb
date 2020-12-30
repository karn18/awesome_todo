class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :done]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    @task = Task.new
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(:new_task, partial: 'tasks/edit', locals: { task: @task }) }
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.create!(task_params)
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @task.update!(task_params)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(:new_task, partial: 'tasks/new', locals: { task: Task.new }) }
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy!
  end

  # POST /tasks/done
  def done
    @task.update!(done: !@task.done)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def task_params
    params.require(:task).permit(:name)
  end
end
