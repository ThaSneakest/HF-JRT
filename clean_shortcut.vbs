' Credits to random/random for creating this.
Dim regEx, objShell, shortcut, newArguments, arguments
Set objShell = WScript.CreateObject("WScript.Shell")
Set shortcut = objShell.CreateShortcut(wscript.arguments(0))
arguments=shortcut.Arguments
Set regEx = New RegExp
regEx.Pattern = "http.*|--proxy-.*"
regEx.IgnoreCase = True
newArguments = regEx.Replace(arguments, "")
shortcut.Arguments = newArguments
shortcut.Save