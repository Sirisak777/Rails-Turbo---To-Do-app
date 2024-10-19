class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete]

  # อื่นๆ เช่น index, create, new
  ...
  def index
    @tasks = Task.where(status: :incomplete)
    @task = Task.new
    @categories = Category.all 
  end

  def create
    puts params.inspect  # แสดงข้อมูลที่ส่งมาใน console
  
    @task = Task.new(task_params)  # สร้าง Task ใหม่จากข้อมูลใน params
  
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: 'Task was successfully created.' }
        format.turbo_stream
      else
        format.html { render :new }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@task, partial: "tasks/form", locals: { task: @task }) }
      end
    end
  end
  
  def task_params
    params.require(:task).permit(:name, :status, :category_id)
  end
  
  
  def show
    # แสดงรายละเอียดของงาน
  end

  def edit
    # แสดงฟอร์มสำหรับแก้ไขงาน
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    # ลบงาน
  end

  def complete
    # ทำเครื่องหมายว่างานว่าเสร็จสิ้น
  end
  ...

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :status, :category_id)
    end
    
end
