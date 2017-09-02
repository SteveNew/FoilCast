object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'FoilCast - cast YouTube to your Chromecast'
  ClientHeight = 56
  ClientWidth = 370
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 287
    Top = 9
    Width = 75
    Height = 36
    Caption = 'Cast Video'
    TabOrder = 0
    OnClick = Button1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 24
    Width = 273
    Height = 21
    EditLabel.Width = 122
    EditLabel.Height = 13
    EditLabel.Caption = 'Enter YouTube URL here:'
    TabOrder = 1
  end
  object IdUDPClient1: TIdUDPClient
    Active = True
    BroadcastEnabled = True
    BoundIP = '192.168.1.50'
    Port = 0
    Left = 64
    Top = 16
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 128
    Top = 16
  end
  object RESTClient1: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Params = <>
    HandleRedirects = True
    Left = 184
    Top = 16
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    SynchronizedEvents = False
    Left = 256
    Top = 16
  end
end
