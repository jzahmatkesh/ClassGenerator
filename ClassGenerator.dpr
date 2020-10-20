program ClassGenerator;

uses
  Forms,
  UnMain in 'UnMain.pas' {FmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFmMain, FmMain);
  Application.Run;
end.
