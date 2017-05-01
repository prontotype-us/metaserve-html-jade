fs = require 'fs'
jade = require 'jade'
path = require 'path'

VERBOSE = process.env.METASERVE_VERBOSE?

module.exports =
    ext: 'jade'

    default_config:
        content_type: 'text/html'

    compile: (filename, config, context, cb) ->
        console.log '[JadeCompiler.compile]', filename, config if VERBOSE

        fs.readFile filename, (err, file_str) ->
            filename = path.join config.static_dir, '_.jade'
            jade_compiler = jade.compile file_str, {filename}
            html = jade_compiler(context)

            cb err, {
                content_type: config.content_type
                source: file_str
                compiled: html
            }

