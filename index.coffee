module.exports = class NoImplicitReturns

  rule:
    name: 'no_chai_getters'
    level: 'error'
    message: 'Using chai matcher without function invocation is forbidden'
    description: 'Checks for chai getters at the end of a line'

  lintLine: (line, lineApi) ->
    tokens = line.split('.')
    if tokens.length <= 1
      return
    if tokens[tokens.length - 1] in ['calledOnce']
      @errors.push lineApi.createError
        message: 'Using chai matcher without function invocation is forbidden'
        level: 'error'
