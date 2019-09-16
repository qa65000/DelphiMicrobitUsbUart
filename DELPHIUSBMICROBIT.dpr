program DELPHIUSBMICROBIT;



uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMAINForm, MAINForm);
  Application.Run;
end.
