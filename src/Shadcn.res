module Button = {
  type variant =
    | @as("primary") Primary
    | @as("secondary") Secondary
    | @as("destructive") Destructive
    | @as("outline") Outline
    | @as("ghost") Ghost

  type props = {
    ...JsxDOM.domProps,
    variant?: variant,
    asChild?: bool,
  }

  @module("@/components/ui/button")
  external make: React.component<props> = "Button"
}
module Input = {
  type props = {
    ...JsxDOM.domProps,
  }
  @module("@/components/ui/input")
  external make: React.component<props> = "Input"
}
module Label = {
  type props = {
    ...JsxDOM.domProps,
  }
  @module("@/components/ui/label")
  external make: React.component<props> = "Label"
}
