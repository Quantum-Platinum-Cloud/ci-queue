module CI
  module Queue
    module Common
      attr_reader :config

      # to override in classes including this module
      CONNECTION_ERRORS = [].freeze

      def flaky?(test)
        @config.flaky?(test)
      end

      def report_failure!
        config.circuit_breaker.report_failure!
      end

      def report_success!
        config.circuit_breaker.report_success!
      end

      def rescue_connection_errors(handler = ->(err) { nil })
        yield
      rescue *self::class::CONNECTION_ERRORS => err
        handler.call(err)
      end
    end
  end
end
