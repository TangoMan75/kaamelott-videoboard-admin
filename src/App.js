import * as React from "react"
import { HydraAdmin, EditGuesser, ResourceGuesser } from "@api-platform/admin"
import {TextInput} from 'react-admin'
import InputGuesser from "@api-platform/admin/lib/InputGuesser";
import FieldGuesser from "@api-platform/admin/lib/FieldGuesser";

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

const App = () => (
  <HydraAdmin entrypoint="http://kaamelott-backend.localhost/api">
      <ResourceGuesser name={"clips"} edit={ClipEdit}/>
      <ResourceGuesser name={"episodes"}/>
      <ResourceGuesser name={"tags"}/>
      <ResourceGuesser name={"people"}/>
  </HydraAdmin>
)

export default App
