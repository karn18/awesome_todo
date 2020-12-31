class Task < ApplicationRecord
  after_create_commit :render_for_create
  after_update_commit -> { broadcast_replace_to :tasks, target: "#{self.class.name.downcase}_#{id}", partial: 'tasks/task', locals: { task: self } }
  after_destroy_commit :render_for_destroy

  def render_for_create
    if Task.all.size == 1
      broadcast_replace_to :tasks, target: :tasks, partial: 'tasks/turbo_task', locals: { task: self }
    else
      broadcast_append_to :tasks, partial: 'tasks/task', locals: { task: self }
    end
  end

  def render_for_destroy
    if Task.all.size.zero?
      broadcast_replace_to :tasks, target: :tasks, partial: 'tasks/list', locals: { tasks: [] }
    else
      broadcast_action_to :tasks, action: "remove", target: "#{self.class.name.downcase}_#{id}"
    end
  end
end
