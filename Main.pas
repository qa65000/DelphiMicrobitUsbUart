unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, Uni232c.Microbit, FMX.Objects;

type
  TMainForm = class(TForm)
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Send: TButton;
    Label1: TLabel;
    Uni232CForMicroBit1: TUni232CForMicroBit;
    open: TButton;
    Timer1: TTimer;
    Circle1: TCircle;
    Label2: TLabel;
    Circle2: TCircle;
    Label3: TLabel;
    procedure SendClick(Sender: TObject);
    procedure openClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private éŒ¾ }
  public
    { public éŒ¾ }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.openClick(Sender: TObject);
begin
  if( Uni232CForMicroBit1.Connect) then
  begin
   Label1.Text := IntToStr(Uni232CForMicroBit1.Close);
   Open.Text := 'Open';
  end
  else
  begin
{$ifdef MSWINDOWS}
   Uni232CForMicroBit1.Port := 12;  // COM3 ‚Æ‚©‚Ì3‚ðÝ’è‚·‚éŒ»Ý12”Ô‚ðÝ’è
{$endif}
   Label1.Text := IntToStr(Uni232CForMicroBit1.Open);
   Open.Text := 'Close';
  end;
end;

procedure TMainForm.SendClick(Sender: TObject);
var
  i: byte;
  Buffer: array [0 .. $3F] of byte;
  Count : Integer;
begin
  if( Uni232CForMicroBit1.Connect) then
  begin
  FillChar(Buffer,sizeof(Buffer),0);
  Count := Edit1.Text.length;
  if( Count >= Sizeof(Buffer) )  then Count := Sizeof(Buffer);
  for i := 0 to Count-1 do
{$ifdef MSWINDOWS}
    Buffer[i] := byte(Edit1.Text[i+1]);
{$else}
    Buffer[i] := byte(Edit1.Text[i]);
{$endif}
   Buffer[count] := byte('#');
   /////// Max Write Count = 64 ///////////////////////////////
    Uni232CForMicroBit1.Write(Edit1.Text.length+1, @Buffer);
  end

end;


procedure TMainForm.Timer1Timer(Sender: TObject);
VAR
   Data : array [0..64] of byte;
begin
    Circle1.Fill.Color := TAlphaColorRec.White;
    Circle2.Fill.Color := TAlphaColorRec.White;

    if( Uni232CForMicroBit1.Connect) then
    begin
      if(Uni232CForMicroBit1.Read(64,@DATA) <> 0 )then
      begin
      if Data[0] = byte('A') then Circle1.Fill.Color := TAlphaColorRec.Red;
      if Data[0] = byte('B') then Circle2.Fill.Color := TAlphaColorRec.Red;
      end;
    end

end;
end.
