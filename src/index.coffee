fs = require 'fs'
jade = require 'jade'
Compiler = require 'metaserve/src/compiler'

class JadeCompiler extends Compiler

    default_options:
        base_dir: './views'
        ext: 'jade'

    compile: (jade_filename, cb) ->
        options = @options
        fs.readFile jade_filename, (err, file_str) ->
            cb err, {
                content_type: 'text/html'
                source: file_str
                compiled: jade.compile(file_str, {filename: options.base_dir + '/_.jade'})()
            }

module.exports = (options={}) ->
    new JadeCompiler().set(options)

