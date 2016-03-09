program TextPad;

uses
  Forms,
  main in 'main.pas' {fTextPad},
  tpscript in 'tpscript.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfTextPad, fTextPad);
  Application.Run;
end.
