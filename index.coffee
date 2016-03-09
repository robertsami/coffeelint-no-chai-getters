CHAI_GETTERS = [
  'ok'
]

module.exports = class NoChaiGetters

  rule:
    name: 'no_chai_getters'
    level: 'error'
    message: 'Using chai matcher without function invocation is forbidden'
    description: 'Checks for chai getters at the end of a line'

  lintNodeHelper: (node, astApi, inCall) ->
    node.eachChild (child) =>
      if child.constructor.name == 'Access' and (child.name.value in CHAI_GETTERS) and inCall
        @errors.push astApi.createError {
          lineNumber: child.locationData.first_line + 1
        }
      childInCall = child.constructor.name == 'Call' or (inCall and child.constructor.name != 'Block')
      @lintNodeHelper(child, astApi, childInCall)
      return
    return

  lintNode: (node, astApi) ->
    @lintNodeHelper node, astApi, false
    return

  lintAST: (node, astApi) ->
    @lintNode node, astApi
    return
