<% if app.isStatic %>
tableFor '<%= model.namePlural %>', (t) ->
  t.head ->
    t.row -><% for (var i = 0; i < model.attributes.length; i++) { %>
      t.header '<%= model.attributes[i].name %>', sort: true<% } %>
  t.body ->
    for <%= model.name %> in @<%= model.namePlural %>
      t.row class: '<%= model.name %>', 'data-id': <%= model.name %>.get('id').toString(), -><% for (var i = 0; i < model.attributes.length; i++) { %>
        t.cell -> <%= model.name %>.get('<%= model.attributes[i].name %>')<% } %>
        t.cell ->
          linkTo 'Show', urlFor(<%= model.name %>)
          span '|'
          linkTo 'Edit', urlFor(<%= model.name %>, action: 'edit')
          span '|'
          linkTo 'Destroy', urlFor(<%= model.name %>), 'data-method': 'delete'
  t.foot ->
    t.row ->
      t.cell colspan: <%= model.attributes.length + 3 %>, ->
        linkTo 'New <%= model.humanName %>', urlFor(<%= app.namespace %>.<%= model.className %>, action: 'new')
<% else %>
tableFor '<%= model.namePlural %>', (t) ->
  t.head ->
    t.row -><% for (var i = 0; i < model.attributes.length; i++) { %>
      t.header '<%= model.attributes[i].name %>', sort: true<% } %>
  t.body ->
    text '{{#each <%= model.name %> in App.<%= model.namePlural %>Controller.all}}'
    t.row class: '<%= model.name %>', -><% for (var i = 0; i < model.attributes.length; i++) { %>
      t.cell '{{<%= model.name %>.<%= model.attributes[i].name %>}}'<% } %>
      t.cell ->
        a '{{action show <%= model.name %> href=true target="App.<%= model.namePlural %>Controller"}}', 'Show'
        span '|'
        a '{{action edit <%= model.name %> href=true target="App.<%= model.namePlural %>Controller"}}', 'Edit'
        span '|'
        a '{{action destroy <%= model.name %> href=true target="App.<%= model.namePlural %>Controller"}}', 'Destroy'
    text '{{/each}}'
  t.foot ->
    t.row ->
      t.cell colspan: <%= model.attributes.length + 3 %>, ->
        a '{{action new <%= model.name %> href=true target="App.<%= model.namePlural %>Controller"}}', 'New <%= model.humanName %>'
<% end %>
