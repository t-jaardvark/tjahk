#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Function to change case and type result
ChangeCase(transformation) {
    OldClipboard := ClipboardAll  ; Save current clipboard
    Clipboard := ""  ; Clear clipboard
    Send, ^c  ; Copy selected text
    ClipWait, 2
    if ErrorLevel
    {
        MsgBox, Failed to copy text to clipboard
        return
    }

    text := Clipboard

    if (transformation = "lower")
        StringLower, text, text
    else if (transformation = "upper")
        StringUpper, text, text
    else if (transformation = "sentence")
    {
        StringLower, text, text
        StringUpper, text, text, T
    }
    else if (transformation = "title")
        StringUpper, text, text, T

    SendInput, %text%  ; Type the transformed text

    Clipboard := OldClipboard  ; Restore original clipboard
}

TypeClipboardText() {
    OldClipboard := ClipboardAll  ; Save current clipboard
    Clipboard := Clipboard  ; Convert to text-only
    SendInput, {Raw}%Clipboard%
    Clipboard := OldClipboard  ; Restore original clipboard
}


SetNumLockState, On
NumLock::Return ; numlock on all the time
#NumPad0::#0  ;make numpad numbers equivalent to number row
#NumPad1::#1
#NumPad2::#2
#NumPad3::#3
#NumPad4::#4
#NumPad5::#5
#NumPad6::#6
#NumPad7::#7
#NumPad8::#8
#NumPad9::#9

; Hotkeys (using Notepad++ style shortcuts)
^u::ChangeCase("upper")       ; Ctrl+U for UPPERCASE
^+u::ChangeCase("lower")      ; Ctrl+Shift+U for lowercase
!u::ChangeCase("sentence")    ; Alt+U for Sentence case
^+!u::ChangeCase("title")     ; Ctrl+Shift+Alt+U for Title Case

; New hotkey for typing out text-only clipboard content
^+v::TypeClipboardText()      ; Ctrl+Shift+V to type out text-only clipboard content

return