{����� ������������ ������ ������� ��� �����������. ���. 160 � �����
������ �����:
10
10 18 11 20 12 17 13 19 14 25 15 21 16 27 17 23 18 25 19 24
10
120
������ �������� �����:
3
10 18 11 20 12 17
10
10}
program backtracking;
{$APPTYPE CONSOLE}
uses
  SysUtils,
  Windows;

const
  Tick: array [0..1] of char = (' ', '*'); {�������� ��� ������}
  MaxN = 30; {������������ ����� ��������}

type
  Objects = record
              Value: Integer; {��������}
              Weight: Integer; {���}
            end;

var
  i: Integer; {�������}
  n: Integer; {���������� ��������}
  Obj: array [0..MaxN-1] of Objects; {������ ��������}
  LimW: Integer; {������� ������������ ���}
  TotV: Integer; {��������� ��������}
  s: set of byte; {������� ��������� ����������� ������ ��������}
  Opts: set of byte; {����������� ����� ����� ������������� � ������� �������}
  MaxV: Integer; {�������� ������ Opts}
  WeightInc: Integer; {��� ��������� ����}
  WeightLimit: Integer; {���������� ������ ����}

{TW � ������ ��� ������ s, ���������� �� ������ ������
AV � ��� ���������� � ������� s ��������}
procedure Try_(i, TW, AV: Integer);
  var
    AV1, TW1: Integer;
  begin
    if i<n
      then
        begin
          TW1:=TW+Obj[i].Weight;
          if TW1<=LimW {���� ��������� ���������}
            then
              begin
                s:=s+[i]; {�������� i-� ������}
                Try_(i+1,TW1,AV);
                s:=s-[i]; {��������� i-� ������}
              end;
          AV1:=AV-Obj[i].Value;
          if AV1 > MaxV {���� ���������� ���������}
            then Try_(i+1,TW,AV1);
        end
      else
        if AV>MaxV
          then {����� �������. ������� ���}
            begin
              MaxV:=AV;
              Opts:=s;
            end; {if AV>MaxV}
  end; {Try_}

begin {MAIN}
  {����}
  Write('Enter number of objects N = ');
  ReadLn(n);
  Write('Through SPASE enter weight of ',n,' object and it`s value: ');
  TotV := 0;
  for i := 0 to n-1 do
    begin
      Read(Obj[i].Weight);
      Read(Obj[i].Value);
      TotV := TotV + Obj[i].Value
    end; {for i}
  Readln;
  Write('Enter change step of weight: ');
  Readln(WeightInc);
  Write('Enter weight limit: ');
  Readln(WeightLimit);

  {������ ������}
  Write('Weight');
  for i := 0 to n-1 do
    Write(Obj[i].Weight:5);
  WriteLn;
  Write('Value ');
  for i := 0 to n-1 do
    Write(Obj[i].Value:5);
  WriteLn;
  Write('LimW '+#25);
  for i := 0 to n-1 do
    write(' ':5);
  WriteLn('MaxV':8);

  {�������� �����}
  LimW := 0;
  repeat
    LimW := LimW + WeightInc;
    MaxV := 0;
    s := [];
    Opts := [];
    Try_(0, 0, TotV);
    Write(LimW:5);
    for i := 0 to n-1 do
      if i in Opts
        then Write(Tick[1]:5)
        else Write(Tick[0]:5);
    WriteLn(MaxV:8);
  until LimW >= WeightLimit;
  ReadLn;
end.
