class Task < ApplicationRecord
  after_create_commit -> { broadcast_append_to :tasks, partial: 'tasks/task', locals: { task: self } }
  after_update_commit -> { broadcast_replace_to :tasks, target: "#{self.class.name.downcase}_#{id}", partial: 'tasks/task', locals: { task: self } }
  after_destroy_commit -> { broadcast_action_to :tasks, action: "remove", target: "#{self.class.name.downcase}_#{id}" }
end
