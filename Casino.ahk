; You will likely have to mess with these values if
; your operating system is not exactly the same as
; the one it was built for.

global InitMove := -1900
global Move1 := 650
global Move2 := 1050
global Move3 := 1100
global Move4 := 950
global stop := false

; Calculate total distance to move the mouse back to the starting position
global MoveBack := -Move1 - Move2 - Move3 - Move4
global Moves := [Move1, Move2, Move3, Move4]  ; makes the loop way cleaner

; F1 hotkey starts the sequence
F1:: {
    global stop
    ; Move into a position where you can hit all slots
    Send "{Ctrl}"
    Send "{s down}"
    Sleep 750
    Send "{s up}"
    
    ; Move mouse to first slot
    MoveMouseRelative(InitMove, 0)
    stop := false
    
    ; Start looping through all slots
    Loop {
        if (stop) {
            break
        }
        
        pressE()
        
        for move in Moves {
            Sleep 150
            MoveMouseRelative(move, 0)
            pressE()
        }
        
        Sleep 200
        MoveMouseRelative(MoveBack, 0)
        Sleep 2000  ; Wait for slots to reset before repeating
    }
}

; F4 hotkey stops the loop
F4:: {
    global stop
    stop := true
}

; F5 hotkey to exit the script
F5:: ExitApp

; Function to move the mouse cursor by a relative offset
MoveMouseRelative(dx, dy) {
    DllCall("mouse_event", "UInt", 0x0001, "Int", dx, "Int", dy, "UInt", 0, "UPtr", 0)
}

; Function to press and release the 'E' key for the slots
pressE() {
    Send "{e down}"
    Sleep 50
    Send "{e up}"
    Sleep 50
}