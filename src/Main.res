%%raw("import '@/app/globals.css'")

ReactDOM.querySelector("#root")
->Option.getExn
->ReactDOM.Client.createRoot
->ReactDOM.Client.Root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>,
)
