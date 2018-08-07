Schemas.UserProfile = new SimpleSchema(

  picture:
    type: String
    optional:true
    label: 'Profile picture'
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: 'ProfilePictures'

  firstName:
    type: String
    optional: false

  lastName:
    type: String
    optional: false

  birthday:
    type: Date
    optional: false

  gender:
    type: String
    label: 'Gender'
    allowedValues: Utils.sexorgenderList
    optional: false 

  phone:
    type: String
    optional: false  

  country:
    type: String
    label: 'Nationality'
    allowedValues: Utils.countryList
    optional: false

  location:
    type: String
    optional: false
    label: 'Address'
    autoform:
      type: 'map'
      geolocation: true
      searchBox: true
      autolocate: true

  interest:
    type: String
    label: 'Area Of Interest'
    allowedValues: Utils.interestList
    optional: false

  eligibility:
    type: String
    label: 'Work Eligibility'
    allowedValues: Utils.eligibleList
    optional: false

  terms:
    type: String
    label: 'Agree to Terms'
    allowedValues: Utils.agreeList
    optional: false

)

Schemas.User = new SimpleSchema(

  username:
    type: String
    regEx: /^[a-z0-9A-Z_]{3,15}$/
    optional: true


  emails:
    type: [Object]
    optional: true

  "emails.$.address":
    type: String
    regEx: SimpleSchema.RegEx.Email

  "emails.$.verified":
    type: Boolean

  createdAt:
    type: Date

  profile:
    type: Schemas.UserProfile
    optional: true

  services:
    type: Object
    optional: true
    blackbox: true

  roles:
    type: [String]
    blackbox: true
    optional: true
)

Meteor.users.attachSchema Schemas.User

# Export schemas
@StarterSchemas = Schemas

Meteor.users.helpers
  hasRole: (role) ->
    @roles?.indexOf(role) > -1