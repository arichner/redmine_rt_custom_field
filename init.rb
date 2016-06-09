require 'redmine'

Redmine::Plugin.register :redmine_rt_custom_field do
  name 'RT num to ticket rm v2.5.x'
  author 'Aaron Richner'
  url 'https://github.com/arichner/redmine_rt_custom_field/' if respond_to?(:url)
  description 'Allows linking of a field to a RT ticket by linking to that ticket'
  version '0.2.0'

  requires_redmine :version_or_higher => '2.5.0'

  settings :partial => 'settings/redmine_rt_custom_field_settings',
    :default => {
      'rt_url' => 'http://path.to.rt.com/',
      'new_window' => 'true', 
    }
end
module Redmine
  module FieldFormat

    class RtFormat < LinkFormat
      include ActionView::Helpers::TextHelper
      include ActionView::Helpers::TagHelper

      add 'RT'
      # self.form_partial = 'custom_fields/formats/rt'

      # def format_as_rt(value)
      #   if Setting.plugin_redmine_rt_custom_field['new_window'] == "true"
      #     target = 'blank'
      #   else
      #     target = ''
      #   end
      #
      #   ActionController::Base.helpers.link_to(value, Setting.plugin_redmine_rt_custom_field['rt_url'] + "Ticket/Display.html?id=" + value, :target => target)
      # end

      def escape_html?
        false
      end

      def edit_as
        "string"
      end
    end
  end
end
