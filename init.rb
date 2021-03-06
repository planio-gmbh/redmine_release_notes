# Copyright � 2012  Harry Garrood
# This file is a part of redmine_release_notes.

# redmine_release_notes is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# redmine_release_notes is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with redmine_release_notes.  If not, see <http://www.gnu.org/licenses/>.

require 'redmine'
require 'redmine_release_notes/hooks'

# Patches to the Redmine core.
require 'dispatcher'
Dispatcher.to_prepare :redmine_release_notes do
  require_dependency 'issue'
  
  unless Issue.included_modules.include?(RedmineReleaseNotes::IssuePatch)
    Issue.send(:include, RedmineReleaseNotes::IssuePatch)
  end
end

Redmine::Plugin.register :redmine_release_notes do
  name 'Redmine release notes plugin'
  author 'Harry Garrood'
  description 'A plugin for managing release notes.'
  version '1.1.0'
  author_url 'https://github.com/hdgarrood'
  
  project_module :release_notes do
    permission :release_notes, { :release_notes => [:index, :new, :generate, :mark_version_as_generated] }, :public => true
  end
  
  menu :project_menu, :release_notes, { :controller => 'release_notes', :action => 'index' }, :caption => :Release_notes, :param => :project_id
  
end
