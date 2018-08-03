#include ../benchmark.ahk

reps := 100000
DllCall( "QueryPerformanceFrequency", "Int64*", ticksPerSec)

; \/ \/ \/ \/ Set pre-run data \/ \/ \/ \/
DllCall( "LoadLibrary", "Str", "gdiplus")
DllCall( "gdiplus.dll\GdiplusStartup", "Ptr", pToken, "Ptr", &si, "Ptr", 0)
; /\ /\ /\ /\ Set pre-run data /\ /\ /\ /\

DllCall("QueryPerformanceCounter", "Int64*", startTick)
Loop %reps% {
	; \/ \/ \/ \/ Run benchmark \/ \/ \/ \/
	DllCall( "gdiplus\GdipGetImageEncodersSize", "UInt*", nCount, "UInt*", nSize)
	; /\ /\ /\ /\ Run benchmark /\ /\ /\ /\
}
DllCall("QueryPerformanceCounter", "Int64*", endTick)


; \/ \/ \/ \/ Clean up benchmark \/ \/ \/ \/
DllCall( "gdiplus\GdiplusShutdown", Ptr, pToken)
; /\ /\ /\ /\ Clean up benchmark /\ /\ /\ /\

FormatResult(reps, startTick, endTick, ticksPerSec, "String DllCall")

; \/ \/ \/ \/ Set pre-run data \/ \/ \/ \/
DllCall( "LoadLibrary", "Str", "gdiplus")
DllCall( "gdiplus\GdiplusStartup", "Ptr", pToken, "Ptr", &si, "Ptr", 0)
pGetImageEncodersSize := DllCall("GetProcAddress","Ptr",DllCall("GetModuleHandle","Str","gdiplus","Ptr"),"AStr","GdipGetImageEncodersSize","Ptr")
; /\ /\ /\ /\ Set pre-run data /\ /\ /\ /\

DllCall("QueryPerformanceCounter", "Int64*", startTick)
Loop %reps% {
	; \/ \/ \/ \/ Run benchmark \/ \/ \/ \/
	DllCall( pGetImageEncodersSize, "UInt*", nCount, "UInt*", nSize)
	; /\ /\ /\ /\ Run benchmark /\ /\ /\ /\
}
DllCall("QueryPerformanceCounter", "Int64*", endTick)


; \/ \/ \/ \/ Clean up benchmark \/ \/ \/ \/
DllCall( "gdiplus\GdiplusShutdown", Ptr, pToken)
; /\ /\ /\ /\ Clean up benchmark /\ /\ /\ /\

FormatResult(reps, startTick, endTick, ticksPerSec, "Pointer DllCall")
