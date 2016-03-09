unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls, about, ycfg, tpscript;

type
  TfTextPad = class(TForm)
    text: TRichEdit;
    MainMenu: TMainMenu;
    extPad1: TMenuItem;
    About1: TMenuItem;
    Schrift1: TMenuItem;
    Exit1: TMenuItem;
    dSchrift: TFontDialog;
    Save1: TMenuItem;
    Open1: TMenuItem;
    N1: TMenuItem;
    Open: TOpenDialog;
    Save: TSaveDialog;
    Optionen1: TMenuItem;
    Script1: TMenuItem;
    Saveas1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure Schrift1Click(Sender: TObject);
    procedure loadconfig;
    procedure saveconfig;
    function askReally:word;
    procedure About1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Save1Click(Sender: TObject);
    procedure Saveas1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure textChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    textname:string;
    scriptname:string;
    script:TScript;
  end;

var
  fTextPad: TfTextPad;

implementation

{$R *.dfm}

procedure TfTextPad.loadconfig;
var temps:TStringlist;
begin

  if fileexists(extractfilepath(Application.exename)+'textpad.ycfg') then
    begin
    temps:=TStringlist.Create;

    temps.LoadFromFile(extractfilepath(Application.exename)+'textpad.ycfg');

    text.Font.Color:=getycfgint(temps,'Color',000000);
    text.Font.Name:=getycfgstr(temps,'Font');
    text.Font.Size:=getycfgint(temps,'Fontsize',12);
    if getycfgbool(temps,'Bold') then text.Font.Style := text.Font.Style + [fsBold] else text.Font.Style := text.Font.Style - [fsBold];
    if getycfgbool(temps,'Italic') then text.Font.Style := text.Font.Style + [fsItalic] else text.Font.Style := text.Font.Style - [fsItalic];
    if getycfgbool(temps,'Underline') then text.Font.Style := text.Font.Style + [fsUnderline] else text.Font.Style := text.Font.Style - [fsUnderline];
    if getycfgbool(temps,'StrikeOut') then text.Font.Style := text.Font.Style + [fsStrikeOut] else text.Font.Style := text.Font.Style - [fsStrikeOut];

    scriptname:=extractfilepath(Application.exename)+getycfgstr(temps,'Script');

    temps.Free;
    end;

end;

procedure TfTextPad.saveconfig;
var temps:TStringlist;
begin

  if fileexists(extractfilepath(Application.exename)+'textpad.ycfg') then
    begin
    temps:=TStringlist.Create;

    temps.LoadFromFile(extractfilepath(Application.exename)+'textpad.ycfg');

    setycfgint(temps,'Color',text.font.color);
    setycfgstr(temps,'Font',text.Font.Name);
    setycfgint(temps,'Fontsize',text.Font.size);
    if Integer(fsBold in Text.Font.Style)>0 then setycfgbool(temps,'Bold',true) else setycfgbool(temps,'Bold',false);
    if Integer(fsItalic in Text.Font.Style)>0 then setycfgbool(temps,'Italic',true) else setycfgbool(temps,'Italic',false);
    if Integer(fsUnderline in Text.Font.Style)>0 then setycfgbool(temps,'Underline',true) else setycfgbool(temps,'Underline',false);
    if Integer(fsStrikeOut in Text.Font.Style)>0 then setycfgbool(temps,'StrikeOut',true) else setycfgbool(temps,'StrikeOut',false);

    temps.SaveToFile(extractfilepath(Application.exename)+'textpad.ycfg');

    temps.Free;
    end;

end;

procedure TfTextPad.Exit1Click(Sender: TObject);
begin

  Application.Terminate;

end;

procedure TfTextPad.Schrift1Click(Sender: TObject);
begin

  dSchrift.Font:=text.Font;
  if dSchrift.Execute then text.Font:=dSchrift.Font;

end;

procedure TfTextPad.About1Click(Sender: TObject);
begin

  showabout(Application);

end;

procedure TfTextPad.FormCreate(Sender: TObject);
begin

  loadconfig;

  Script:=TScript.Create;

  Script.loadscript(scriptname);

  textname:='';

  open.InitialDir:=extractfilepath(Application.exename);
  save.InitialDir:=extractfilepath(Application.exename);

  text.SelLength:=2;

end;

procedure TfTextPad.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  saveconfig;

end;

function TfTextPad.askReally:word;
begin

  result:=messagedlg('Du hast nocht gespeichert - Daten Speichern?',mtwarning,[mbyes,mbno,mbAbort],0);

end;

procedure TfTextPad.Save1Click(Sender: TObject);
var temps:TStringlist;
begin

  temps:=TStringlist.Create;

  temps.Text:=text.Lines.Text;

  if textname='' then
    begin
    if save.Execute then
      begin
      textname:=save.FileName;
      temps.SaveToFile(textname);

      end;
    end else temps.SaveToFile(textname);

  text.Modified:=false;

  fTextPad.caption:='TextPad - '+extractfilename(textname);

  temps.Free;

end;

procedure TfTextPad.Saveas1Click(Sender: TObject);
var temps:TStringlist;
begin

  temps:=TStringlist.Create;

  temps.Text:=text.Lines.Text;

  if save.Execute then
    begin
    textname:=save.FileName;
    temps.SaveToFile(textname);
    end;

  text.Modified:=false;

  fTextPad.caption:='TextPad - '+extractfilename(textname);

  temps.Free;

end;

procedure TfTextPad.Open1Click(Sender: TObject);
var tempw:word;
begin

  if text.Modified then
    begin
    tempw:=askReally;

    if tempw=mryes then Save1Click(self);
    if tempw=mrabort then exit;
    end;

  if open.Execute then
    begin
    textname:=open.FileName;
    text.Lines.LoadFromFile(textname);
    end;

  text.Modified:=false;

  fTextPad.caption:='TextPad - '+extractfilename(textname);

end;

procedure TfTextPad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var tempw:word;
begin

  if text.Modified then
    begin
    tempw:=askReally;

    if tempw=mryes then Save1Click(self);
    if tempw=mrabort then canclose:=false;
    end;

end;

procedure TfTextPad.textChange(Sender: TObject);
var temp:TPoint;
begin

  text.SelLength:=2;

  if script.changedebug then script.setRich(text);

end;

end.
