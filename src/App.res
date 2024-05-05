type rec input = {
  id: string,
  password: string,
  hobbies: array<hobby>,
}
and hobby = {value: string}

module Form = ReactHookForm.Make({
  type t = input
})

module FormInput = {
  module Id = Form.MakeInput({
    type t = string
    let name = "id"
    let config = ReactHookForm.Rules.make({
      required: true,
    })
  })

  module Password = Form.MakeInput({
    type t = string
    let name = "password"
    let config = ReactHookForm.Rules.make({
      required: true,
    })
  })

  module Hobbies = Form.MakeInputArray({
    type t = hobby
    let name = "hobbies"
    let config = ReactHookForm.Rules.empty()
  })
}

@react.component
let make = () => {
  let form = Form.use(
    ~config={
      defaultValues: {id: "", password: "", hobbies: []},
    },
  )
  let hobbies = FormInput.Hobbies.useFieldArray(form, ())

  let formState = form->Form.formState
  let isValid = formState.isValid

  let handleClearPassword = _ => {
    form->FormInput.Password.setValue("")
  }

  let handleAddHubby = _ => {
    hobbies->FormInput.Hobbies.append({
      value: ``,
    })
  }

  React.useEffect0(() => {
    form->FormInput.Id.focus
    None
  })

  <main className="mx-auto mt-12 max-w-[800px]">
    <p> {`Form state isValid ? ${formState.isValid->string_of_bool}`->React.string} </p>
    <form
      className="flex flex-row gap-4 mx-auto"
      onSubmit={form->Form.handleSubmit((input, _) => {
        Js.log((input.id, input.password, input.hobbies))
      })}>
      <div className="w-1/2 flex flex-col gap-4">
        <Label htmlFor="id">
          {"Id"->React.string}
          {form->FormInput.Id.renderWithRegister(<Input placeholder="id" type_="text" />, ())}
        </Label>
        {form
        ->FormInput.Id.error
        ->Belt.Option.mapWithDefault(React.null, error => {
          <p> {error.message->React.string} </p>
        })}
        <Label>
          {"Password"->React.string}
          {form->FormInput.Password.renderWithRegister(
            <Input placeholder="password" type_="password" />,
            (),
          )}
        </Label>
        {form
        ->FormInput.Password.error
        ->Belt.Option.mapWithDefault(React.null, error => {
          <p> {error.message->React.string} </p>
        })}
        <div className="border p-2 rounded">
          <header className="flex flex-row items-center justify-between mb-8">
            <h2 className="font-semibold"> {"Hobbies"->React.string} </h2>
            <Button type_="button" variant={Secondary} onClick={handleAddHubby}>
              {`Add new hubby`->React.string}
            </Button>
          </header>
          <div className="flex flex-col gap-2">
            {hobbies
            ->FormInput.Hobbies.fields
            ->Belt.Array.mapWithIndex((index, field) => {
              <div key={field->FormInput.Hobbies.id}>
                {form->FormInput.Hobbies.renderWithIndexRegister(
                  index,
                  <Input type_="text" />,
                  ~property="value",
                  (),
                )}
                <p> {`Current value: ${field.value}`->React.string} </p>
              </div>
            })
            ->React.array}
          </div>
        </div>
      </div>
      <div className="flex flex-row items-center gap-4 self-start">
        <Button type_="button" onClick={handleClearPassword}>
          {`Clear password`->React.string}
        </Button>
        <Button disabled={!isValid} type_="submit"> {`Submit`->React.string} </Button>
      </div>
    </form>
  </main>
}
