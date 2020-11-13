import * as React from "react"
import { HydraAdmin, EditGuesser, ResourceGuesser } from "@api-platform/admin"
import { TextInput } from 'react-admin'
import InputGuesser from "@api-platform/admin/lib/InputGuesser";
import FieldGuesser from "@api-platform/admin/lib/FieldGuesser";
import CreateGuesser from "@api-platform/admin/lib/CreateGuesser";

const clipEditItems = []
for (let prop in {'name': false, 'url': false, 'duration': false, 'partOfEpisode': true, 'characters': true, 'tags': true}) {
    clipEditItems.push(prop ? <InputGuesser key={prop} source={prop} /> : <FieldGuesser key={prop} source={prop} />)
}

const ClipEdit = props => (
    <EditGuesser {...props}>
        {clipEditItems}
        <TextInput source={"citation"} key={"citation"} multiline fullWidth />
    </EditGuesser>
)

const ClipCreate = props => (
    <CreateGuesser {...props}>
        {clipEditItems}
        <TextInput source={"citation"} key={"citation"} multiline fullWidth />
    </CreateGuesser>
)

// Replace with your own API entrypoint
// For instance if https://example.com/api/books is the path to the collection of book resources, then the entrypoint is https://example.com/api
const App = () => (
  <HydraAdmin entrypoint="http://kaamelott-backend.localhost/api">
      <ResourceGuesser name={"clips"} edit={ClipEdit} create={ClipCreate}/>
      <ResourceGuesser name={"episodes"}/>
      <ResourceGuesser name={"tags"}/>
      <ResourceGuesser name={"people"}/>
  </HydraAdmin>
)

export default App
