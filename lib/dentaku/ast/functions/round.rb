require_relative '../function'

Dentaku::AST::Function.register("round(:numeric) = :numeric", ->(numeric) {
  numeric.round(0)
})
