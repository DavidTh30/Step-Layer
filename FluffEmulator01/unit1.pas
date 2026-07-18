unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, simpleipc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Memo1: TMemo;
    PageControl1: TPageControl;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    SimpleIPCServer1: TSimpleIPCServer;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SimpleIPCServer1Message(Sender: TObject);
    procedure SimpleIPCServer1MessageQueued(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.SimpleIPCServer1Message(Sender: TObject);
////var
////  s: string;
begin
  Memo1.Append('SimpleIPCServer1Message:');
  //while IpcServer.PeekMessage(0, True) do
  //  IpcServer.ReadMessage;
  ////s:=SimpleIPCServer1.StringMessage;
  ////Label1.Caption:=s;
end;

procedure TForm1.SimpleIPCServer1MessageQueued(Sender: TObject);
var
  s: string;
begin
  Memo1.Append('SimpleIPCServer1MessageQueued:');
  SimpleIPCServer1.ReadMessage;
  s:=SimpleIPCServer1.StringMessage;
  Memo1.Append(s);
  if (s='Device1=On') then
  begin
    Shape1.Brush.Color:=clGreen;
  end;
  if (s='Device1=Off') then
  begin
    Shape1.Brush.Color:=clWhite;
  end;
  if (s='Device2=On') then
  begin
    Shape2.Brush.Color:=clGreen;
  end;
  if (s='Device2=Off') then
  begin
    Shape2.Brush.Color:=clWhite;
  end;
  if (s='Device3=On') then
  begin
    Shape3.Brush.Color:=clGreen;
  end;
  if (s='Device3=Off') then
  begin
    Shape3.Brush.Color:=clWhite;
  end;
  if (s='Device4=On') then
  begin
    Shape4.Brush.Color:=clGreen;
  end;
  if (s='Device4=Off') then
  begin
    Shape4.Brush.Color:=clWhite;
  end;
  if (s='Device5=On') then
  begin
    Shape5.Brush.Color:=clGreen;
  end;
  if (s='Device5=Off') then
  begin
    Shape5.Brush.Color:=clWhite;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SimpleIPCServer1.ServerID:='Fluff01';
  SimpleIPCServer1.Global:=true;
  SimpleIPCServer1.StartServer;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if SimpleIPCServer1.Active then Label2.Caption:='Active';
  if not SimpleIPCServer1.Active then Label2.Caption:='not Active';
end;

procedure TForm1.Button1Click(Sender: TObject);
begin

  SimpleIPCServer1.Active:=not SimpleIPCServer1.Active;
  if SimpleIPCServer1.Active then Label2.Caption:='Active';
  if not SimpleIPCServer1.Active then Label2.Caption:='not Active';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Append(SimpleIPCServer1.InstanceID);
  //if (SimpleIPCServer1.Message.StringMessage=nil) then exit;
  //Memo1.Append(SimpleIPCServer1.Message.StringMessage);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit1EditingDone(Sender: TObject);
begin
  SimpleIPCServer1.Active := false;
  SimpleIPCServer1.StopServer;
  SimpleIPCServer1.ServerID:=Edit1.Text;
  SimpleIPCServer1.StartServer;
  SimpleIPCServer1.Active := true;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  SimpleIPCServer1.StopServer;
end;

end.

