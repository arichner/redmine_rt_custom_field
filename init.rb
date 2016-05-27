require 'redmine'

Redmine::Plugin.register :redmine_rt_custom_field do
  name 'RT num to ticket'
  author 'Steve Morrissey'
  url 'https://github.com/uberamd/redmine_rt_custom_field/' if respond_to?(:url)
  description 'Allows linking of a field to a RT ticket by linking to that ticket'
  version '0.1.1'

  requires_redmine :version_or_higher => '0.9.0'

  settings :partial => 'settings/redmine_rt_custom_field_settings',
    :default => {
      'rt_url' => 'http://path.to.rt.com/',
      'new_window' => 'true', 
    }
end
module Redmine
  module FieldFormat

    class RtFormat < RecordList
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::TagHelper

      add 'RT'

      def format_as_rt(value)
        if Setting.plugin_redmine_rt_custom_field['new_window'] == "true"
          target = 'blank'
        else
          target = ''
        end

        ActionController::Base.helpers.link_to(value, Setting.plugin_redmine_rt_custom_field['rt_url'] + "Ticket/Display.html?id=" + value, :target => target)
      end

      def escape_html?
        false
      end

      def edit_as
        "string"
      end
    end
  end
end
