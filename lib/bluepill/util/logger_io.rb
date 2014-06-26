# -*- encoding: utf-8 -*-
module Bluepill
  module Util
    class LoggerIO < IO
      def initialize(logger, level)
        super(IO.sysopen "/dev/null","w")
        @logger = logger
        raise "Invalid logging level #{level}" unless Bluepill::Logger.LOG_METHODS.include?(level)
        @level = level
      end
      
      def write(msg)
        @logger.send(@level.to_s, msg)
      end
     
      def write_nonblock(msg)
        Thread.new do 
          write(msg)
        end
      end
      
    end
  end
end
