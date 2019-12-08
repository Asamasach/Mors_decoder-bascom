$regfile = "m8def.dat"
$crystal = 1000000
$baud = 4800
Config Portb = Output
Config Portd.6 = Output
Config Portc = Output
Config Int0 = Falling
Config Timer0 = Timer , Prescale = 1024
Config Timer1 = Timer , Prescale = 1024
Enable Interrupts
Enable Int0
Enable Ovf0
On Int0 Get_code
On Ovf0 Z
Dim A As Byte
Dim C As Word
Dim B As Byte
Dim Dd As Byte
Dim X As Byte
Dim Stringdata As String * 3

Stringdata = ""

Start Timer1

Do
Select Case Stringdata
Case "._" : Portb = &B00000001
Case "." : Portb = &B00000010
Case ".." : Portb = &B00000100
Case "___" : Portb = &B00001000
Case ".._" : Portb = &B00010000
Case Else : Portb = &B00000000

End Select
Loop



Get_code:
Set Portd.6
X = 0
timer1 = 0
Start timer1
Q:
If Pind.2 = 0 Then
Goto Q
End If

Stop timer1
C = timer1


If C > 2 Then
If C < 350 Then
Stringdata = Stringdata + "."
Print Stringdata
Reset Dd.b
Else
Stringdata = Stringdata + "_"
print stringdata
Set Dd.b
End If
Incr B
If B > 3 Then
B = 0

End If
End If
Portc = Dd
Return

Z:
Stop Timer0
Timer0 = 0
Incr X
If X = 20 Then
Reset Portd.6
Stringdata = ""
Dd = 0
B = 0
Portc = Dd
End If
Start Timer0
Return