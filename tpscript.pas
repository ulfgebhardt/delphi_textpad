unit tpscript;

interface

uses sysutils,classes,ycfg,ComCtrls,Graphics,dialogs,windows;

type TScriptPart = class
       public
       Text:string;
       FontName:string;
       FontSize:integer;
       FontColor:integer;
       Bold:integer;
       Italic:integer;
       Underline:integer;
       StrikeOut:integer;
       Grosskleinschreibung:boolean;
       BisZeilenEnde:boolean;
       NurSeperiert:boolean;
       VorrigesWort:boolean;
       NaechstesWort:boolean;

end;

type TScript = class
       public
       ScriptParts:array of TScriptPart;
       changedebug:boolean;
       Font:TFont;

       procedure loadscript(Filepath:string);
       procedure setRich(Rich:TRichedit);

       destructor destroy;
       constructor create;
end;

implementation

constructor Tscript.create;
begin

  changedebug:=true;

end;

procedure TScript.setRich(Rich:TRichedit);
var i,j:integer;
   tempp:TPoint;
   font:TFont;
begin

  for i:=0 to length(ScriptParts)-1 do
    begin
    if ScriptParts[i].Grosskleinschreibung then
      begin
      if lowercase(copy(rich.lines.text,length(rich.lines.Text)-length(ScriptParts[i].text)-1,length(ScriptParts[i].text)))=lowercase(ScriptParts[i].text) then
        begin
        tempp:=rich.CaretPos;
        font:=rich.Font;
        changedebug:=false;
        rich.Lines.BeginUpdate;

        rich.SelStart:=length(rich.lines.Text)-length(ScriptParts[i].text)-2;
        rich.SelLength:=length(ScriptParts[i].text);

        changedebug:=false;

        if ScriptParts[i].FontName<>'' then rich.SelAttributes.Name:=ScriptParts[i].FontName;
        if ScriptParts[i].FontSize>0 then rich.SelAttributes.Size:=ScriptParts[i].FontSize;
        if ScriptParts[i].FontColor>0 then rich.SelAttributes.Color:=ScriptParts[i].FontColor;
        if ScriptParts[i].Bold=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsbold];
        if ScriptParts[i].Bold=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsbold];
        if ScriptParts[i].italic=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsitalic];
        if ScriptParts[i].italic=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsitalic];
        if ScriptParts[i].underline=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsunderline];
        if ScriptParts[i].underline=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsunderline];
        if ScriptParts[i].strikeout=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsstrikeout];
        if ScriptParts[i].strikeout=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsstrikeout];

        rich.CaretPos:=tempp;
        rich.SelLength:=2;
        rich.Font:=font;
        rich.Lines.EndUpdate;
        changedebug:=true;
        end;
      end else
        begin
        if lowercase(copy(rich.lines.text,length(rich.lines.Text)-length(ScriptParts[i].text)-1,length(ScriptParts[i].text)))=lowercase(ScriptParts[i].text) then
          begin
          tempp:=rich.CaretPos;
          font:=rich.Font;
          changedebug:=false;
          rich.Lines.BeginUpdate;

          rich.SelStart:=length(rich.lines.Text)-length(ScriptParts[i].text)-2;
          rich.SelLength:=length(ScriptParts[i].text);

          changedebug:=false;

          if ScriptParts[i].FontName<>'' then rich.SelAttributes.Name:=ScriptParts[i].FontName;
          if ScriptParts[i].FontSize>0 then rich.SelAttributes.Size:=ScriptParts[i].FontSize;
          if ScriptParts[i].FontColor>0 then rich.SelAttributes.Color:=ScriptParts[i].FontColor;
          if ScriptParts[i].Bold=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsbold];
          if ScriptParts[i].Bold=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsbold];
          if ScriptParts[i].italic=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsitalic];
          if ScriptParts[i].italic=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsitalic];
          if ScriptParts[i].underline=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsunderline];
          if ScriptParts[i].underline=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsunderline];
          if ScriptParts[i].strikeout=0 then rich.SelAttributes.Style:=rich.SelAttributes.Style-[fsstrikeout];
          if ScriptParts[i].strikeout=1 then rich.SelAttributes.Style:=rich.SelAttributes.Style+[fsstrikeout];

          rich.CaretPos:=tempp;
          rich.SelLength:=2;
          rich.Font:=font;
          rich.Lines.EndUpdate;
          changedebug:=true;
          end;
        end;
    end;

end;

procedure TScript.loadscript(Filepath:string);
var temps:TStringlist;
    i:integer;
begin

  if fileexists(filepath) then
    begin
    temps:=TStringlist.create;
    temps.LoadFromFile(filepath);
    for i:=0 to temps.Count-1 do
      begin
      if getnumberofdivides(temps.Strings[i],';')>=9 then
        begin
        setlength(Scriptparts,length(scriptparts)+1);
        Scriptparts[length(scriptparts)-1]:=TScriptpart.Create;
        Scriptparts[length(scriptparts)-1].Text:=dividestring(temps.Strings[i],';',1);
        Scriptparts[length(scriptparts)-1].FontName:=dividestring(temps.Strings[i],';',2);
        Scriptparts[length(scriptparts)-1].FontSize:=strtointdef(dividestring(temps.Strings[i],';',3),-1);
        Scriptparts[length(scriptparts)-1].FontColor:=strtointdef(dividestring(temps.Strings[i],';',4),-1);
        Scriptparts[length(scriptparts)-1].Bold:=strtointdef(dividestring(temps.Strings[i],';',5),-1);
        Scriptparts[length(scriptparts)-1].Italic:=strtointdef(dividestring(temps.Strings[i],';',6),-1);
        Scriptparts[length(scriptparts)-1].Underline:=strtointdef(dividestring(temps.Strings[i],';',7),-1);
        Scriptparts[length(scriptparts)-1].StrikeOut:=strtointdef(dividestring(temps.Strings[i],';',8),-1);
        if dividestring(temps.Strings[i],';',9)='1' then Scriptparts[length(scriptparts)-1].Grosskleinschreibung:=true else Scriptparts[length(scriptparts)-1].Grosskleinschreibung:=false;
        end;
      end;
    temps.Free;
    end;

end;

destructor TScript.destroy;
var i:integer;
begin

  for i:=0 to length(ScriptParts)-1 do Scriptparts[i].Free;

end;

end.

