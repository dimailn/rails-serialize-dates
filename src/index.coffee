import {set, get} from 'lodash'

import moment from 'moment'

POSTFIXES = [
  'At'
  'Date'
  'Till'
  'On'
]

serializeDates = (entity) ->
  preparedEntity =
    if entity instanceof Array
      []
    else
      {}

  for key, value of entity
    if POSTFIXES.some((p) -> ///\w+#{p}$///.test(key)) && value instanceof moment
      value = value.toISOString()
    else if typeof value is 'object' && value isnt null
      value = serializeDates(value)
    set(preparedEntity, key, value)

  preparedEntity


export default serializeDates
