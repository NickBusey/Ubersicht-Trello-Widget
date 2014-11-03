# Get your Trello API Key here: https://trello.com/1/appKey/generate
apiKey   = ''

# Replace 'INSERTYOURAPIKEY' belowe with your apiKey above, and navigate to the url.
# Goto: https://trello.com/1/authorize?key=INSERTYOURAPIKEY&name=Ubersicht+Trello+Widget&expiration=never&response_type=token
# Hit Authorize, and paste your token here.
token = ''

# Get your Board Id by navigating to the Board you want in Trello, and copying the bit after /b/ and before the last /
# For example a board named https://trello.com/b/5d9adhe0/my-stuff your Board Id is: 5d9adhe0
boardId = ''

# Finally enter the name of the List you want to have displayed
listName: 'Today'

# You're Done!

command: "curl -s 'https://api.trello.com/1/boards/#{boardId}/lists?fields=name&cards=open&card_fields=name&key=#{apiKey}&token=#{token}'"
refreshFrequency: 10000

update: (output, domEl) ->
  # $(domEl).html(output)
  # return

  data  = JSON.parse(output)
  for list of data
    listData = data[list] if data[list].name is this.listName
  $domEl = $(domEl)
  $domEl.html("<div class='entry listName'>#{listData.name}</div>")

  for item in listData.cards
    $domEl.append @renderItem(item)

renderItem: (data) ->
  """
    <div class='entry'>#{data.name}</div>
  """

style: """
  top: 5%
  left: 3%
  color: #fff
  font-family: Helvetica Neue
  text-align: center
  width: 340px

  .entry
    background-color: black
    opacity .7
    border-radius 5px
    margin-bottom 2px
  .listName
    font-size: 1.5em
"""
