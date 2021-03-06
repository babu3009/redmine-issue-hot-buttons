require 'redmine'

if Rails::VERSION::MAJOR < 3
  require 'dispatcher'
  object_to_prepare = Dispatcher
else
  object_to_prepare = Rails.configuration
end

object_to_prepare.to_prepare do
  require File.dirname(__FILE__) + '/lib/issues_controller_patch.rb'
  IssuesController.send(:include, IssueHotButtons::IssuesControllerPatch)
end

class Hooks < Redmine::Hook::ViewListener
  render_on :view_issues_show_details_bottom,
    :partial => 'hot_buttons/assets',
    :layout => false
end

Redmine::Plugin.register :issue_hot_buttons_plugin do
  name 'Issue Hot Buttons Plugin plugin'
  author 'Mike Kolganov, Thumbtack Inc.'
  description 'Plugin for Redmine that add buttons for often used actions to issue page'
  version '0.4.4'
  url 'http://thumbtack-technology.github.com/redmine-issue-hot-buttons'
  #author_url 'mailto:mike.kolganov@gmail.com'
  settings :partial => 'hot_buttons/settings'
end
