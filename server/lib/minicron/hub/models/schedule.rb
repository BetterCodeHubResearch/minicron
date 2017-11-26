require Minicron::REQUIRE_PATH + 'hub/models/base'

module Minicron::Hub
  module Model
    class Schedule < Minicron::Hub::Model::Base
      belongs_to :job, counter_cache: true
      has_many :alerts, dependent: :destroy

      validates :job_id, presence: true, numericality: { only_integer: true, greater_than: 0 }

      # The formatted schedule
      def formatted
        Minicron::Hub::Model::Schedule.format(self)
      end

      # Format the schedule based on all it's components
      #
      # @param schedule [Minicron::Hub::Schedule]
      # @return string
      def self.format(schedule)
        # If it's not a 'special' schedule then build up the full schedule string
        if schedule.special == '' || schedule.special.nil?
          "#{schedule.minute} #{schedule.hour} #{schedule.day_of_the_month} #{schedule.month} #{schedule.day_of_the_week}"
        else
          schedule.special
        end
      end
    end
  end
end
