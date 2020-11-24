module Restforce
  module Bulk
    class Request
      include Restforce::Bulk::Attributes

      attr_accessor :sObject

      def initialize(attributes={})
        assign_attributes(attributes)
      end

      def content
        response = Restforce::Bulk.client.perform_request(:get, "job/#{job_id}/batch/#{batch_id}/request")
        parser   = results_parser_for(response.body).new

        parser.content_on(response.body)
      end

      protected

      def results_parser_for(body)
        body.is_a?(CSV::Table) ? Restforce::Bulk::Parser::Csv : Restforce::Bulk::Parser::Xml
      end
    end
  end
end
