{normalize} = require 'path'

fs = require 'fs'

shared = require './shared'

tester = require './tester'

module.exports = dev = shared.dev =

    before: tester.before

    testDir: 'test'

    sourceDir: 'lib'

    walkDepth: 3

    walkWidth: 3

    compileTo: undefined

    reporters: require './reporters'

    init: (callback) ->

        {pipe} = objective

        pipe.on 'prompt.commands.register.ask', (command) ->

            command.create 'createModule',

                description: '(dev) Create new module in the current project.'

                run: require('./commands/create_module')

                help: """

                Usage: dev.createModule #{dev.testDir}/path/to/module_name [templateName]

                Creates the '#{dev.testDir}' file and the corresponding '#{dev.sourceDir}' file.

                    ie.

                        #{dev.testDir}/path/to/module_name.js
                        #{dev.sourceDir}/path/to/module_name.js

                The paths match up so that when the '#{dev.sourceDir}' file changes the
                corresponding '#{dev.testDir}' file can be found and run.

                It is recommended to use underscores between the name parts
                so that the module injector can be used in tests.

                    ie.  

                        module_name.js will be injectable as ModuleName
                        (provided that it is unique project-wide)

                If templateName is specified the corresponding template will be used.

                    ie.

                        ~/.objective/templates/dev/templateName_spec.js


                NOTE: The templates are only installed upon registration. (--register)

                """

                autoComplete: (args, callback) ->

                    return callback null, null if args.length > 2


                    if args.length == 1

                        return callback null,

                            type: 'path'

                            startIn: normalize dev.testDir + '/'

                            onlyDirectories: true



                    if args.length == 2

                        try
                        
                            directory = fs.readdirSync process.env.HOME + '/.objective/templates/dev'

                            matches = []

                            for file in directory

                                if file.match new RegExp "_spec.#{shared.language}"

                                    matches.push file.replace "_spec.#{shared.language}", ''

                            callback null, matches

                        catch

                            callback null, null

            command.create 'renameModule',

                description: '(dev) Deletes module from the current project.'

                run: (args, callback) ->

                    callback()


            command.create 'destroyModule',

                description: '(dev) Deletes module from the current project.'

                run: (args, callback) ->

                    callback()

            # command.create 'dev.killModule',

            #     description: 'Deletes module and performs git rm.'

            #     run: (args, callback) ->

            #         callback()

            command.create 'testModule',

                description: '(dev) Test a specific module.'

                run: (args, callback) ->

                    callback()

            command.create 'testAll',

                description: '(dev) Test all modules.'

                run: (args, callback) ->

                    callback()


        # pipe.on 'files.recurse.start', ({path}, next) ->

        #     # console.log start: path

        #     next()

        # pipe.on 'files.recurse.entering', ({path}, next) ->

        #     # console.log entering: path

        #     next()

        # pipe.on 'files.recurse.found', ({path}, next) ->

        #     next()


        # pipe.on 'files.recurse.end', (data, next) ->

        #     # console.log end: data

        #     next()

        # pipe.on 'files.recurse.error', (error, next) ->

        #     # console.log error: error

        #     next()


        callback()

