sysPath = require 'path'
yaml = require('js-yaml')
extend = require('node.extend')

module.exports = class EmberI18nYamlCompiler
  brunchPlugin: yes
  type: 'javascript'
  extension: 'yml'
  
  constructor: (@config) ->
    null

  compile: (data, path, callback) ->
  
    callback null, "jQuery.extend(Ember.I18n.translations, #{JSON.stringify(@flattenHash(yaml.load(data)))});"

  flattenHash: (data, prev = "") ->
    final = {}
    for k,v of data
      key = if prev is "" then k else "#{prev}.#{k}"
      if 'object' is typeof v
        extend true, final, this.flattenHash(v, key)
      else
        final[key] = v
    final