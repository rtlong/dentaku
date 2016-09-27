require_relative '../exceptions'

module Dentaku
  module AST
    class Identifier < Node
      attr_reader :identifier

      def initialize(token)
        @identifier = token.value.downcase
      end

      def value(context={})
        v = context[identifier]
        case v
        when Node
          v.value(context)
        when NilClass
          raise UnboundVariableError.new([identifier])
        else
          v
        end
      end

      def dependencies(context={})
        context.has_key?(identifier) ? dependencies_of(context[identifier]) : [identifier]
      end

      def generate_constraints(context)
        type = context.resolve_identifier(self)
        context.add_constraint!([:syntax, self], type, Reason.identifier(self))
      end

      def pretty_print
        @identifier
      end

      private

      def dependencies_of(node)
        node.respond_to?(:dependencies) ? node.dependencies : []
      end
    end
  end
end
