import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    console.log('connected')
  }

  reset() {
    this.element.reset()
  }
}
