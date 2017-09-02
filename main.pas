unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdUDPServer, IdGlobal, IdSocketHandle,
  IdBaseComponent, IdComponent, IdUDPBase, Vcl.StdCtrls, IdUDPClient,
  IPPeerClient, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  IdTCPConnection, IdTCPClient, IdHTTP, REST.Types, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    IdUDPClient1: TIdUDPClient;
    IdHTTP1: TIdHTTP;
    LabeledEdit1: TLabeledEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  p: word;
  ip, r, desc, servURL, appURL: string;
  res: TStringList;
begin
  // DIAL Service Discovery
  IdUDPClient1.Send('239.255.255.250', 1900, 'M-SEARCH * HTTP/1.1' + #13#10 +
     'HOST: 239.255.255.250:1900' + #13#10 +
     'MAN: "ssdp:discover"'+ #13#10 +
     'MX: 3'+ #13#10 +
     'ST: urn:dial-multiscreen-org:service:dial:1'+ #13#10 +
  //   'ST: ssdp:all'+ #13#10 +
     #13#10);
  IdUDPClient1.ReceiveTimeout := 1000;
  r := IdUDPClient1.ReceiveString(ip, p);
  desc := '';
  if p<>0 then
  begin
    res := TStringList.Create;
    res.Text := r;
    for r in res do
    begin
      if Pos('LOCATION: ', r)=1 then
      begin
        desc := Copy(r, 11 , 9999); // http://192.168.1.55:8008/ssdp/device-desc.xml
        Break;
      end;
    end;
    res.Free;
  end;
  IdHTTP1.Get(desc);
  servURL := IdHTTP1.Response.RawHeaders.Values['Application-URL'];
  servURL := copy(servURL,1,Length(servURL)-1);  // DIAL REST Service URL

  // DIAL REST Service
  appURL := servURL+'/YouTube';   // http://192.168.1.55:8008/apps/YouTube
  IdHTTP1.Get(appURL);
  if (IdHTTP1.ResponseCode=200) then
  begin
    RESTRequest1.Resource := appURL;
    RESTRequest1.AddParameter('v', Copy(LabeledEdit1.Text, Pos('?v=', LabeledEdit1.Text)+3, 9999));
    RESTRequest1.Method := rmPOST;
    RESTRequest1.Execute;
  end;
end;

end.
