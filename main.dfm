object fTextPad: TfTextPad
  Left = 227
  Top = 181
  Width = 870
  Height = 640
  Caption = 'TextPad'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object text: TRichEdit
    Left = 0
    Top = 0
    Width = 862
    Height = 594
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = textChange
  end
  object MainMenu: TMainMenu
    Left = 96
    Top = 56
    object extPad1: TMenuItem
      Caption = 'TextPad'
      object Save1: TMenuItem
        Caption = 'Save'
        OnClick = Save1Click
      end
      object Saveas1: TMenuItem
        Caption = 'Save as'
        OnClick = Saveas1Click
      end
      object Open1: TMenuItem
        Caption = 'Open'
        OnClick = Open1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        OnClick = Exit1Click
      end
    end
    object Optionen1: TMenuItem
      Caption = 'Optionen'
      object Schrift1: TMenuItem
        Caption = 'Schrift'
        OnClick = Schrift1Click
      end
      object Script1: TMenuItem
        Caption = 'Script'
      end
    end
    object About1: TMenuItem
      Caption = 'About'
      OnClick = About1Click
    end
  end
  object dSchrift: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 96
    Top = 24
  end
  object Open: TOpenDialog
    DefaultExt = '.txt'
    Filter = 
      'Text File (*.txt)|*.txt|Yeminy Text File (*.yem)|*.yem|Yeminy Co' +
      'nfig File (*.ycfg)|*.ycfg|Alle Files|*'
    Left = 64
    Top = 24
  end
  object Save: TSaveDialog
    DefaultExt = '.txt'
    Filter = 
      'Text File (*.txt)|*.txt|Yeminy Text File (*.yem)|*.yem|Yeminy Co' +
      'nfig File (*.ycfg)|*.ycfg|Alle Files|*'
    Left = 64
    Top = 56
  end
end
