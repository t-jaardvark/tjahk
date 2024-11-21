#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn All, StdOut  ; Enable warnings to assist with detecting common errors.
#SingleInstance
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetNumLockState, On
SetCapsLockState, AlwaysOff  ; Disable CapsLock and keep it off
SetScrollLockState, On  ; Ensure Scroll Lock is always on
; End of auto-execute section
return



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

ExtractPhoneNumber() {
    ; Save current clipboard
    OldClipboard := ClipboardAll
    Clipboard := ""  ; Clear clipboard
    Send, ^c  ; Copy selected text
    ClipWait, 2
    if ErrorLevel
    {
        Clipboard := OldClipboard  ; Restore original clipboard if copy fails
        return
    }

    phone := Clipboard

    ; Regex to match the format (xxx) xxx-xxxx
    if RegExMatch(phone, "^\(\d{3}\) \d{3}-\d{4}$")
    {
        ; Remove everything except digits
        phone := RegExReplace(phone, "[^\d]")
        Clipboard := phone  ; Copy the result to clipboard
    }
    else
    {
        Clipboard := OldClipboard  ; Restore original clipboard if format doesn't match
    }
}

NumLock::Return ; numlock on all the time
CapsLock::Return  ; Prevent the CapsLock key from toggling
ScrollLock::Return  ; Prevent the Scroll Lock key from toggling

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

^+u::ChangeCase("upper")      ; Ctrl+Shift+U for UPPERCASE
^u::ChangeCase("lower")       ; Ctrl+U for lowercase
!u::ChangeCase("sentence")    ; Alt+U for Sentence case
^+!u::ChangeCase("title")     ; Ctrl+Shift+Alt+U for Title Case
^+v::TypeClipboardText()      ; Ctrl+Shift+V to type out text-only clipboard content
#p::ExtractPhoneNumber() ; Win+P Extract Digits from phone number phone number and type digits (Win+P)