unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Spin, ComCtrls, Types, simpleipc;

type
	Layer_ = record
                Start:boolean;
		RunDurationTime_Act: integer;
		CounterDurationTime_Act: integer;
		Index: integer;
		CounterDurationTime_Set: integer;
		EndOfCounterDuration: boolean;
                Running: boolean;
                StartUp: boolean;
                Enable:boolean;
                Mark:boolean;
	end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox8: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    PageControl1: TPageControl;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    SimpleIPCClient1: TSimpleIPCClient;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    SpinEdit7: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Timer1: TTimer;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox10EditingDone(Sender: TObject);
    procedure CheckBox11EditingDone(Sender: TObject);
    procedure CheckBox1EditingDone(Sender: TObject);
    procedure CheckBox2EditingDone(Sender: TObject);
    procedure CheckBox3EditingDone(Sender: TObject);
    procedure CheckBox6EditingDone(Sender: TObject);
    procedure CheckBox8EditingDone(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Shape1MouseEnter(Sender: TObject);
    procedure Shape1Paint(Sender: TObject);
    procedure Shape2MouseEnter(Sender: TObject);
    procedure Shape14Paint(Sender: TObject);
    procedure Shape3MouseEnter(Sender: TObject);
    procedure Shape15Paint(Sender: TObject);
    procedure Shape4MouseEnter(Sender: TObject);
    procedure Shape16Paint(Sender: TObject);
    procedure Shape5MouseEnter(Sender: TObject);
    procedure Shape17Paint(Sender: TObject);
    procedure Shape6MouseEnter(Sender: TObject);
    procedure Shape18Paint(Sender: TObject);
    procedure Shape7MouseEnter(Sender: TObject);
    procedure Shape19Paint(Sender: TObject);
    procedure Shape8Paint(Sender: TObject);
    procedure SpinEdit1EditingDone(Sender: TObject);
    procedure SpinEdit2EditingDone(Sender: TObject);
    procedure SpinEdit3EditingDone(Sender: TObject);
    procedure SpinEdit4EditingDone(Sender: TObject);
    procedure SpinEdit5EditingDone(Sender: TObject);
    procedure SpinEdit6EditingDone(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    procedure ShowStatus();
    Function InLengthLayer(var Index_:integer):boolean;
    Function InLength_(Index_:integer):boolean;
    Function LowerLength_(Index_:integer):boolean;
    Function HigherLength_(Index_:integer):boolean;
  public
    procedure Log(Line:string;Msg:string; Memo:TMemo);
    procedure AShapePaint(Sender: TObject);
    procedure FindActiveServers(); //Don't use because not good
    procedure SendMessage_(s:String);
    Function DetectServer():boolean;
    procedure SendLogMessage_(s:String);
  end;

  type
    BOOL = boolean;
    INT = integer;

  type
    Device_ = record
      Start: BOOL;
      DeviceID: INT;
      IS_StartUp: BOOL;
      IS_Running: BOOL;
      EndOfCounterDuration: BOOL;
      CounterDurationTime_Act: INT;
      RunDurationTime_Act: INT;
      CounterDurationTime_Set: INT;
      Enable: BOOL;
      Mark: BOOL;
   end;

  type
    TIntArray = array of integer;

  //type
  //TIntArray = array[1..5] of integer;

var
  Form1: TForm1;
  //Pattern1: array[1..5] of integer = (0,5,3,0,4);

  //Array Pattern:=[init 0] [Data 1...10] [END 11]
  Pattern1: array of integer = (0, 1, 2, 3, 4, 5,
                                   6, 0, 0, 0, 0,
                                0);  //Pattern[0] is start   Pattern[11] is End

  //----------------------------------------------------------
  Pattern1Index:INT =0; //Position 0 and Position 11 is for init
  BeginPattern:INT =0; //Init Array position of Pattern
  FirstPattern:INT =1; //First Array position of Pattern
  LastPattern:INT =10; //Last  Array position of Pattern
  TotalScanPattern:INT =10; //[Total pattern] of Pattern
  EndPattern:INT =11; //End of Array position of Pattern

  InitBlankDevice:INT =0;   //Init Blank Device number 0
  FirstDevice:INT = 1;  //First device
  LastDevice:INT = 5;   //Last device (Total device)
  EndDevice:INT =6;     //End Layer is use for only have one device left
  TotalScanDevice:INT =6; //[Total Device] + [End]
  FirstPatternIndex:INT =0;  //First index in pattern that device enable
  LastPatternIndex:INT =0;  //Last index in pattern that device enable
  ActiveRestartPattern: BOOL =true;
  //----------------------------------------------------------

  StartStepLayer:BOOL = false; //Start cycle function

  //Array Device:=[init 0] [DeviceID 1...5] [END(Virtual) 6]
  Device:array of Device_;

  LastDeviceActive:BOOL;
  AllDeviceDisable:BOOL;

  EventsList: TStringList;
  OldCurrentLayer:INT;

  MouseEnter_:INT;

  AShape: array of TShape;

  OldDevice:array of INT;

implementation

{$R *.lfm}

{ TForm1 }

//var
//  slice1: TIntArray;
//begin
//  slice1 := Copy(MyStack, Low(MyStack), High(MyStack));
procedure TForm1.Log(Line:string;Msg:string; Memo:TMemo);
begin
  Memo.Append('Line:'+Line+ ' value=' + Msg);
end;

procedure TForm1.FindActiveServers();  //Don't use because not good
var
  IPCClient: TSimpleIPCClient;
  CandidateIDs: array[0..3] of string;// Or array of string for older FPC versions
  SrvID: string;
begin
  timer2.Enabled:=false;
  SimpleIPCClient1.Disconnect;
  SimpleIPCClient1.Active:=false;

  // List of IDs you expect or want to test for
  //CandidateIDs := ['ServerOne', 'ServerTwo', 'AppInstance_123', 'MyServerID'];
  CandidateIDs[0]:='Fluff01';
  CandidateIDs[1]:='FluffSilo01';
  CandidateIDs[2]:='Silo01';
  CandidateIDs[3]:='Suction01';

  IPCClient := TSimpleIPCClient.Create(nil);
  try
    for SrvID in CandidateIDs do
    begin
      IPCClient.ServerID := SrvID;
      //IPCClient.Global := True; // Match the Global setting of your servers

      if IPCClient.ServerRunning then
      begin
        Log({$i %LINE%},'Active server found with ID: '+ SrvID,Memo3);
        SimpleIPCClient1.Disconnect;
        SimpleIPCClient1.Active:=false;
        SimpleIPCClient1.ServerID:=SrvID;
        SimpleIPCClient1.Active:=true;
        SimpleIPCClient1.Connect;
        break;
      end;
    end;
  finally
    IPCClient.Free;
  end;
  timer2.Enabled:=true;
end;

Function TForm1.DetectServer():boolean;
var
  IPCClient: TSimpleIPCClient;
  CandidateIDs: array[0..3] of string;
  SrvID: string;
  Detect:boolean;
begin

  //CandidateIDs := ['ServerOne', 'ServerTwo', 'AppInstance_123', 'MyServerID'];
  CandidateIDs[0]:='Fluff01';
  CandidateIDs[1]:='FluffSilo01';
  CandidateIDs[2]:='Silo01';
  CandidateIDs[3]:='Suction01';

  IPCClient := TSimpleIPCClient.Create(nil);
  try
    Detect:=false;
    for SrvID in CandidateIDs do
    begin
      IPCClient.ServerID := SrvID;
      if IPCClient.ServerRunning then
      begin
        Detect:=true;
        break;
      end;
    end;
  finally
    IPCClient.Disconnect;
    IPCClient.Active:=false;
    IPCClient.Free;
  end;

    result := Detect;
end;

procedure TForm1.SendMessage_(s:String);
var
  IPCClient: TSimpleIPCClient;
  CandidateIDs: array[0..3] of string;// Or array of string for older FPC versions
  SrvID: string;
begin

  // List of IDs you expect or want to test for
  //CandidateIDs := ['ServerOne', 'ServerTwo', 'AppInstance_123', 'MyServerID'];
  CandidateIDs[0]:='Fluff01';
  CandidateIDs[1]:='FluffSilo01';
  CandidateIDs[2]:='Silo01';
  CandidateIDs[3]:='Suction01';

  IPCClient := TSimpleIPCClient.Create(nil);
  try
    for SrvID in CandidateIDs do
    begin
      IPCClient.ServerID := SrvID;
      //IPCClient.Global := True; // Match the Global setting of your servers

      if IPCClient.ServerRunning then
      begin
        IPCClient.Active:=true;
        IPCClient.Connect;
        IPCClient.SendStringMessage(s);
        break;
      end;
    end;
  finally
    IPCClient.Disconnect;
    IPCClient.Active:=false;
    IPCClient.Free;
  end;
end;

procedure TForm1.SendLogMessage_(s:String);
var
  IPCClient: TSimpleIPCClient;
  CandidateIDs: array[0..3] of string;// Or array of string for older FPC versions
  SrvID: string;
begin

  // List of IDs you expect or want to test for
  //CandidateIDs := ['ServerOne', 'ServerTwo', 'AppInstance_123', 'MyServerID'];
  CandidateIDs[0]:='MessageLogConsole20';
  CandidateIDs[1]:='MessageLogConsole50';
  CandidateIDs[2]:='MessageLogConsole100';
  CandidateIDs[3]:='MessageLogConsole200';

  IPCClient := TSimpleIPCClient.Create(nil);
  try
    for SrvID in CandidateIDs do
    begin
      IPCClient.ServerID := SrvID;
      //IPCClient.Global := True; // Match the Global setting of your servers

      if IPCClient.ServerRunning then
      begin
        IPCClient.Active:=true;
        IPCClient.Connect;
        IPCClient.SendStringMessage(s);
        break;
      end;
    end;
  finally
    IPCClient.Disconnect;
    IPCClient.Active:=false;
    IPCClient.Free;
  end;
end;

procedure TForm1.AShapePaint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_ := TShape(Sender).Width;
  y_ := TShape(Sender).Height;
  //showmessage(x_.ToString);
  x_:=round(x_/2);
  y_:=round(y_/2);
  TShape(Sender).Canvas.TextOut(x_-5,y_-0,Pattern1[TShape(Sender).Tag].ToString);
  TShape(Sender).Canvas.Font.Size:=6;
  TShape(Sender).Canvas.TextOut(3,y_-18,TShape(Sender).Tag.ToString);
end;

procedure Push(var Arr: TIntArray; Value: Integer);
begin
  SetLength(Arr, Length(Arr) + 1); // Expand the array
  //Insert(99, Arr, 0); // Inserts 99 at index 0
  Arr[High(Arr)] := Value;         // High() returns the last index
end;

procedure Pop(var Arr: TIntArray);
begin
  if Length(Arr) = 0 then
    raise Exception.Create('Stack underflow: Array is empty');
  //Delete(Arr, Length(Arr)-1, 1); // Removes 1 elements starting at last index
  //Result := Arr[High(Arr)];        // Get the last item
  SetLength(Arr, Length(Arr) - 1); // Shrink the array
end;

Function TForm1.InLengthLayer(var Index_:integer):boolean;
begin
  if (Index_ >= Low(Device)) and (Index_ <= High(Device)) and (Index_>0) then
    result := true
  else
    result := false;
End;

Function TForm1.InLength_(Index_:integer):boolean;
begin
  //for i := Low(myArray) to High(myArray) do
  //Length(MyArray)

  if (Index_ >= Low(Pattern1)) and (Index_ <= High(Pattern1)) and (Index_>0) then
    result := true
  else
    result := false;
End;

Function TForm1.LowerLength_(Index_:integer):boolean;
begin
  if ((Index_ < Low(Pattern1)) or (Index_<=0)) then
    result := true
  else
    result := false;
End;

Function TForm1.HigherLength_(Index_:integer):boolean;
begin
  if (Index_ > High(Pattern1)) then
    result := true
  else
    result := false
End;

procedure TForm1.ShowStatus();
begin

  Label6.Caption:=Device[FirstDevice].CounterDurationTime_Act.ToString+' t';
  Label7.Caption:=Device[2].CounterDurationTime_Act.ToString+' t';
  Label8.Caption:=Device[3].CounterDurationTime_Act.ToString+' t';
  Label9.Caption:=Device[4].CounterDurationTime_Act.ToString+' t';
  Label10.Caption:=Device[5].CounterDurationTime_Act.ToString+' t';
  Label11.Caption:=Device[EndDevice].CounterDurationTime_Act.ToString+' t';

  if MouseEnter_=0 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   '  - Pattern1Run:= ' + StartStepLayer.ToInteger.ToString + chr(13)+
                   '  - Pattern1Index:= ' + Pattern1Index.ToString + chr(13)+
                   '  - LastDeviceActive:= ' + LastDeviceActive.ToInteger.ToString + chr(13)+
                   '  - AllDeviceDisable:= ' + AllDeviceDisable.ToInteger.ToString + chr(13)+
                   '  - FirstPatternIndex:= ' + FirstPatternIndex.ToString + chr(13)+
                   '  - LastPatternIndex:= ' + LastPatternIndex.ToString + chr(13);
  end;

  if MouseEnter_=1 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Device[1]' + chr(13)+
                   '  - Start:= ' + Device[1].Start.ToInteger.ToString + chr(13)+
                   '  - StartUp:= ' + Device[1].IS_StartUp.ToInteger.ToString + chr(13)+
                   '  - Running:= ' + Device[1].IS_Running.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Device[1].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Device[1].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Device[1].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Device[1].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Device[1].Enable.ToInteger.ToString + chr(13)+
                   '  - Mark:= ' + Device[1].Mark.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=2 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Device[2]' + chr(13)+
                   '  - Start:= ' + Device[2].Start.ToInteger.ToString + chr(13)+
                   '  - StartUp:= ' + Device[2].IS_StartUp.ToInteger.ToString + chr(13)+
                   '  - Running:= ' + Device[2].IS_Running.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Device[2].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Device[2].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Device[2].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Device[2].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Device[2].Enable.ToInteger.ToString + chr(13)+
                   '  - Mark:= ' + Device[2].Mark.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=3 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Device[3]' + chr(13)+
                   '  - Start:= ' + Device[3].Start.ToInteger.ToString + chr(13)+
                   '  - StartUp:= ' + Device[3].IS_StartUp.ToInteger.ToString + chr(13)+
                   '  - Running:= ' + Device[3].IS_Running.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Device[3].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Device[3].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Device[3].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Device[3].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Device[3].Enable.ToInteger.ToString + chr(13)+
                   '  - Mark:= ' + Device[3].Mark.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=4 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Device[4]' + chr(13)+
                   '  - Start:= ' + Device[4].Start.ToInteger.ToString + chr(13)+
                   '  - StartUp:= ' + Device[4].IS_StartUp.ToInteger.ToString + chr(13)+
                   '  - Running:= ' + Device[4].IS_Running.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Device[4].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Device[4].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Device[4].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Device[4].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Device[4].Enable.ToInteger.ToString + chr(13)+
                   '  - Mark:= ' + Device[4].Mark.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=5 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Device[5]' + chr(13)+
                   '  - Start:= ' + Device[5].Start.ToInteger.ToString + chr(13)+
                   '  - StartUp:= ' + Device[5].IS_StartUp.ToInteger.ToString + chr(13)+
                   '  - Running:= ' + Device[5].IS_Running.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Device[5].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Device[5].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Device[5].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Device[5].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Device[5].Enable.ToInteger.ToString + chr(13)+
                   '  - Mark:= ' + Device[5].Mark.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=6 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Device[End]' + chr(13)+
                   '  - Start:= ' + Device[6].Start.ToInteger.ToString + chr(13)+
                   '  - StartUp:= ' + Device[6].IS_StartUp.ToInteger.ToString + chr(13)+
                   '  - Running:= ' + Device[6].IS_Running.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Device[6].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Device[6].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Device[6].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Device[6].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Device[6].Enable.ToInteger.ToString + chr(13)+
                   '  - Mark:= ' + Device[6].Mark.ToInteger.ToString + chr(13);
  end;
end;

procedure TForm1.Shape8Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape8.Width/2);
  y_:=round(shape8.Height/2);
  Shape8.Canvas.TextOut(x_-5,y_-5,'##');
end;

procedure TForm1.SpinEdit1EditingDone(Sender: TObject);
begin
  Device[1].CounterDurationTime_Set:=SpinEdit1.Value;
end;

procedure TForm1.SpinEdit2EditingDone(Sender: TObject);
begin
  Device[2].CounterDurationTime_Set:=SpinEdit2.Value;
end;

procedure TForm1.SpinEdit3EditingDone(Sender: TObject);
begin
  Device[3].CounterDurationTime_Set:=SpinEdit3.Value;
end;

procedure TForm1.SpinEdit4EditingDone(Sender: TObject);
begin
  Device[4].CounterDurationTime_Set:=SpinEdit4.Value;
end;

procedure TForm1.SpinEdit5EditingDone(Sender: TObject);
begin
  Device[5].CounterDurationTime_Set:=SpinEdit5.Value;
end;

procedure TForm1.SpinEdit6EditingDone(Sender: TObject);
begin
  Device[EndDevice].CounterDurationTime_Set:=SpinEdit6.Value;
end;

procedure TForm1.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:INT;
  i2:INT;
  CounterLayer:INT;
  CurrentDevice:INT;
  EndLoop:BOOL;
  VirtualLoop:BOOL;
  Tempo:INT;
begin
  CurrentDevice:=0;
  if (StartStepLayer) then
  begin

    CounterLayer:=0;
    AllDeviceDisable:=false;
    LastDeviceActive:=false;

    FOR i := FirstDevice TO LastDevice DO  //Reset device mark
    begin
      Device[i].Mark :=false;
    end;

    FirstPatternIndex:=0;  //begin initiate FirstPatternIndex
    LastPatternIndex:=0;   //begin initiate LastPatternIndex
    FOR i := FirstPattern TO LastPattern DO  //Check pattern
    begin
      IF (Pattern1[i] >= FirstDevice) AND (Pattern1[i] <= LastDevice) THEN
      if (Device[Pattern1[i]].Enable) then
      begin
        if (FirstPatternIndex=0) then FirstPatternIndex:=i;
        Device[Pattern1[i]].Mark:=true; LastPatternIndex:=i;
      end;
    end;

    FOR i := FirstDevice TO LastDevice DO  //Check Mark Device
    begin
      if (Device[i].Mark=false) then begin CounterLayer:=CounterLayer+1; end;
    end;

    if (CounterLayer=LastDevice-1) then LastDeviceActive:=true;
    if (CounterLayer=LastDevice) then AllDeviceDisable:=true;

    //Main cycle loop
    EndLoop:=false;
    VirtualLoop:=false;
    if (not Device[EndDevice].Start) then
    if (not AllDeviceDisable) and (Pattern1Index>=FirstPattern) AND (Pattern1Index<=LastPattern)then
    begin
      if (Pattern1[Pattern1Index]>=FirstDevice) and (Pattern1[Pattern1Index]<=LastDevice) THEN
      if Device[Pattern1[Pattern1Index]].EndOfCounterDuration or (not Device[Pattern1[Pattern1Index]].Enable) then
      begin
        if (LastDeviceActive) then
        begin
          EndLoop:=true;
          Log({$i %LINE%},Pattern1[Pattern1Index].ToString,Memo2);
          Device[Pattern1[Pattern1Index]].Start:=false;
          if ActiveRestartPattern then
          begin
            if Device[EndDevice].Enable then VirtualLoop:=true;
            Pattern1Index:=0;
          end;
          if not ActiveRestartPattern then
          begin
            if Device[EndDevice].Enable then
              VirtualLoop:=true
            else
            begin
              Pattern1Index:=LastPatternIndex;
              Log({$i %LINE%},Pattern1[Pattern1Index].ToString,Memo2);
              Device[Pattern1[Pattern1Index]].Start:=true;
            end;
          end;
        end;
        if (not LastDeviceActive) then
          for i2 := FirstPattern TO LastPattern DO
          begin
            if (Pattern1[i2]>=FirstDevice) and (Pattern1[i2]<=LastDevice) THEN
            if (Device[Pattern1[i2]].Enable and (i2 > Pattern1Index)) then
            begin
              Log({$i %LINE%},Pattern1[Pattern1Index].ToString,Memo2);
              Device[Pattern1[Pattern1Index]].Start:=false;
	      Device[Pattern1[Pattern1Index]].CounterDurationTime_Act := 0;
              Device[Pattern1[Pattern1Index]].RunDurationTime_Act := 0;
              Device[Pattern1[Pattern1Index]].EndOfCounterDuration:=false;
              Pattern1Index:=i2;
              Log({$i %LINE%},Pattern1[Pattern1Index].ToString,Memo2);
              Device[Pattern1[Pattern1Index]].Start:=true;
              break;
            end;
          end;
        if (Device[Pattern1[Pattern1Index]].EndOfCounterDuration or (not Device[Pattern1[Pattern1Index]].Enable)) and (not LastDeviceActive) then
        begin
          EndLoop:=true;
          Log({$i %LINE%},Pattern1[Pattern1Index].ToString,Memo2);
          Device[Pattern1[Pattern1Index]].Start:=false;
          if ActiveRestartPattern then Pattern1Index:=0;
          if not ActiveRestartPattern then
          begin
            Pattern1Index:=FirstPatternIndex;
            Log({$i %LINE%},Pattern1[Pattern1Index].ToString,Memo2);
            Device[Pattern1[Pattern1Index]].Start:=true;
          end;
        end;
      end;
    end;
	
    //Virtual loop
    if (VirtualLoop or Device[EndDevice].Start)then
    begin
      Device[EndDevice].Start:=true;
      if (Device[EndDevice].EndOfCounterDuration or (not Device[EndDevice].Enable)) then
      begin
        Device[EndDevice].start:=false;
        //----------------------------------------------------------------------------------------
        //if (LastDeviceActive) then
        //begin
          EndLoop:=true;
          if ActiveRestartPattern then
          begin
            Pattern1Index:=0;
          end;
          if not ActiveRestartPattern then
          begin
            Pattern1Index:=LastPatternIndex;
            Log({$i %LINE%},Pattern1[Pattern1Index].ToString,Memo2);
            Device[Pattern1[Pattern1Index]].Start:=true;
          end;
        //end;
        //----------------------------------------------------------------------------------------
      end;
    end;

    //Set index with start (Not for virtual)
    if (not Device[EndDevice].Start) then
    if not EndLoop then
    if (not AllDeviceDisable) and ((Pattern1Index<FirstPattern) or (Pattern1Index>LastPattern)) then
    begin
      if (LastDeviceActive) then
      begin
        if Not Device[Pattern1[Pattern1Index]].EndOfCounterDuration then
        begin
          Pattern1Index:=LastPatternIndex;
          Device[Pattern1[Pattern1Index]].Start:=true;
        end;
        if Device[Pattern1[Pattern1Index]].EndOfCounterDuration then
        begin
          Device[Pattern1[Pattern1Index]].Start:=false;
          if ActiveRestartPattern then Pattern1Index:=0;
          if not ActiveRestartPattern then
          begin
            Pattern1Index:=LastPatternIndex;
            Device[Pattern1[Pattern1Index]].Start:=true;
          end;
        end;
      end;
      if (not LastDeviceActive) then
        for i2 := FirstPattern TO LastPattern DO
        begin
          if (Pattern1[i2]>=FirstDevice) and (Pattern1[i2]<=LastDevice) THEN
          if (Device[Pattern1[i2]].Enable and (i2 <> Pattern1Index)) then
          begin
            Pattern1Index:=i2;
            Device[Pattern1[Pattern1Index]].Start:=true;
            break;
          end;
        end;
    end;

    if(AllDeviceDisable)then
    begin
      Pattern1Index:=0;
      for i := FirstDevice to EndDevice do
      begin
          Device[i].Start:=false;
      end;
    end;


    //Auto Duration time process ** not for Start/Skip device
    for i := FirstDevice to EndDevice do
    begin
      if (not Device[i].Enable) or (not Device[i].Start) then
      begin
        Device[i].IS_StartUp:=false;
        Device[i].IS_Running:=false;
        Device[i].EndOfCounterDuration:=false;
        Device[i].RunDurationTime_Act:=0;
        Device[i].CounterDurationTime_Act:=0;
      end;
      if (Device[i].CounterDurationTime_Act>=Device[i].CounterDurationTime_Set) then
      begin
	    if Device[i].Start then Device[i].EndOfCounterDuration:=true;
		if Not Device[i].Start then Device[i].EndOfCounterDuration:=false;
        Device[i].IS_StartUp:=false;
      end;
      if (Device[i].CounterDurationTime_Act<Device[i].CounterDurationTime_Set) then
      begin
        Device[i].EndOfCounterDuration:=false;
        if Device[i].Start then Device[i].IS_StartUp:=true;
		if Not Device[i].Start then Device[i].IS_StartUp:=false;
      end;
      if Device[i].Start and Device[i].Enable then
      begin
        Device[i].IS_Running:=true;
        if Device[i].RunDurationTime_Act <= Device[i].CounterDurationTime_Set then
          Device[i].RunDurationTime_Act:=Device[i].RunDurationTime_Act+1;
        if (Device[i].CounterDurationTime_Act<Device[i].CounterDurationTime_Set) then
          Device[i].CounterDurationTime_Act:=Device[i].CounterDurationTime_Act+1;
      end;
    end;

  end;

  // Case turn off step layer system
  IF (StartStepLayer = false) THEN
  begin
    Pattern1Index := 0;
    FOR i := FirstDevice TO EndDevice DO
    begin
      Device[i].Start := false;
      Device[i].IS_StartUp := false;
      Device[i].IS_Running := false;
      Device[i].Mark := false;
      Device[i].EndOfCounterDuration := false;
      Device[i].CounterDurationTime_Act := 0;
      Device[i].RunDurationTime_Act := 0;
    end;
  end;

  //Cursor position
    if Pattern1Index=0 then
    begin
      Shape13.Top:=Shape1.Top;
      CurrentDevice:=0;
    end;
    if Device[FirstDevice].Start then
    begin
      Shape13.Top:=Shape14.Top;
      CurrentDevice:=1;
    end;
    if Device[FirstDevice+1].Start then
    begin
      Shape13.Top:=Shape15.Top;
      CurrentDevice:=2;
    end;
    if Device[FirstDevice+2].Start then
    begin
      Shape13.Top:=Shape16.Top;
      CurrentDevice:=3;
    end;
    if Device[FirstDevice+3].Start then
    begin
      Shape13.Top:=Shape17.Top;
      CurrentDevice:=4;
    end;
    if Device[FirstDevice+4].Start then
    begin
      Shape13.Top:=Shape18.Top;
      CurrentDevice:=5;
    end;
    if Device[LastDevice].Start then
    begin
      //Shape13.Top:=Shape18.Top;
      CurrentDevice:=6;
    end;
    if Device[EndDevice].Start then
    begin
      Shape13.Top:=Shape19.Top;
      CurrentDevice:=7;
    end;

  if CurrentDevice<>OldCurrentLayer then
  begin
    OldCurrentLayer:=CurrentDevice;
    if OldCurrentLayer < FirstDevice then
    begin
      EventsList.Add('Device: '+OldCurrentLayer.ToString+ ' [Start (Init/Bank)]');
      SendLogMessage_('Device: '+OldCurrentLayer.ToString+ ' [Start (Init/Bank)]');
    end;

    if (OldCurrentLayer >= FirstDevice) and (OldCurrentLayer <= LastDevice) then
    begin
      EventsList.Add('Device: '+OldCurrentLayer.ToString);
      SendLogMessage_('Device: '+OldCurrentLayer.ToString);
    end;
    if OldCurrentLayer > LastDevice then
    begin
      EventsList.Add('Device: '+OldCurrentLayer.ToString+ ' [End (Wait/Virtual)]');
      SendLogMessage_('Device: '+OldCurrentLayer.ToString+ ' [End (Wait/Virtual)]');
    end;
  end;
  if EventsList.Count > 13 then EventsList.Delete(0);
  Memo1.Lines.Assign(EventsList);

  if (Not StartStepLayer) then Label14.Caption:='Index: '+Pattern1Index.ToString;
  if (StartStepLayer) then Label14.Caption:='Pattern1 Index: '+Pattern1Index.ToString+ ' Device: ' + CurrentDevice.ToString;

  ShowStatus();

end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  i:integer;
begin

  if High(OldDevice)<>High(Device)then
  begin
    SetLength(OldDevice, Length(Device));
    for i:= Low(Device) to High(Device) do
    begin
      OldDevice[i]:=-1;
    end;
  end;

  if not DetectServer() then
  begin
    Log({$i %LINE%},'Server= off',Memo3);
    for i:= Low(Device) to High(Device) do
    begin
      OldDevice[i]:=-1;
    end;
  end;
  if DetectServer() then
  begin
    for i:= FirstDevice to LastDevice do
    begin
      if (Device[i].Start) and (OldDevice[i]<>1) then
      begin
        OldDevice[i]:=1;
        Log({$i %LINE%},'Send message to Server',Memo3);
        SendMessage_('Device'+i.ToString+'=On');
      end;
      if (not Device[i].Start) and (OldDevice[i]<>0) then
      begin
        OldDevice[i]:=0;
        Log({$i %LINE%},'Send message to Server',Memo3);
        SendMessage_('Device'+i.ToString+'=Off');
      end;
    end;
  end

end;

procedure TForm1.Shape1Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape1.Width/2);
  y_:=round(shape1.Height/2);
  Shape1.Canvas.TextOut(5,y_-9,InitBlankDevice.ToString+' [Start (Blank)]');
end;

procedure TForm1.Shape2MouseEnter(Sender: TObject);
begin
  MouseEnter_:=1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  //Array Pattern:=[init 0] [Data 1...10] [END 11]
  //SetLength(Pattern1, 11);
  //Pattern1:=[0, 0, 2, 1, 5, 4,
  //              3, 0, 5, 2, 1,
  //           0];

  //Array Device:=[init 0] [DeviceID 1...5] [DeviceID 6 (Hold/Virtual)] [END(Virtual) 7]
  SetLength(Device, 8);

  //initiate----------------------------------------------------------
  Pattern1Index :=0; //Position 0 and Position 11 is for init
  BeginPattern :=Low(Pattern1); //Init Array position of Pattern
  FirstPattern :=Low(Pattern1)+1; //First Array position of Pattern
  LastPattern :=High(Pattern1)-1; //Last  Array position of Pattern
  TotalScanPattern :=High(Pattern1)-1; //[Total pattern] of Pattern
  EndPattern :=High(Pattern1); //End of Array position of Pattern

  InitBlankDevice :=Low(Device);   //Init Blank Device number 0
  FirstDevice := Low(Device)+1;  //First device
  LastDevice := High(Device)-1;   //Last device (Total device)
  EndDevice :=High(Device);     //End Layer is use for only have one device left or use as virtual device
  TotalScanDevice :=EndDevice; //[Total Device] + [End]
  LastPatternIndex :=0; // 0 because not initiate yet
  ActiveRestartPattern:= CheckBox2.Checked;
  //----------------------------------------------------------

  StartStepLayer:=false;

  MouseEnter_:=0;

  EventsList:=TStringList.Create;
  OldCurrentLayer:=-1;

  Label12.Caption:='Pattern1:' + chr(13);
  for i := FirstPattern to LastPattern do
  begin
  Label12.Caption:=Label12.Caption+Pattern1[i].ToString;
  if i<LastPattern then Label12.Caption:=Label12.Caption+', ';
  end;

  for i := FirstDevice to EndDevice do
  begin
    Device[i].DeviceID:=i;
    Device[i].Start:=false;
    Device[i].IS_StartUp:=false;
    Device[i].IS_Running:=false;
    Device[i].EndOfCounterDuration:=false;
    Device[i].CounterDurationTime_Act:=0;
    Device[i].RunDurationTime_Act:=0;
    Device[i].Mark:=false;
  end;

  Device[1].Enable:=CheckBox1.Checked;
  Device[2].Enable:=CheckBox3.Checked;
  Device[3].Enable:=CheckBox6.Checked;
  Device[4].Enable:=CheckBox8.Checked;
  Device[5].Enable:=CheckBox10.Checked;
  Device[LastDevice].Enable:=true;
  Device[EndDevice].Enable:=CheckBox11.Checked;

  Device[1].CounterDurationTime_Set:=SpinEdit1.Value;
  Device[2].CounterDurationTime_Set:=SpinEdit2.Value;
  Device[3].CounterDurationTime_Set:=SpinEdit3.Value;
  Device[4].CounterDurationTime_Set:=SpinEdit4.Value;
  Device[5].CounterDurationTime_Set:=SpinEdit5.Value;
  Device[LastDevice].CounterDurationTime_Set:=100;
  Device[EndDevice].CounterDurationTime_Set:=SpinEdit6.Value;

  if (CheckBox1.Checked) then Shape2.Brush.Color:=clGreen;
  if (not CheckBox1.Checked) then Shape2.Brush.Color:=clRed;

  if (CheckBox3.Checked) then Shape3.Brush.Color:=clGreen;
  if (not CheckBox3.Checked) then Shape3.Brush.Color:=clRed;

  if (CheckBox6.Checked) then Shape4.Brush.Color:=clGreen;
  if (not CheckBox6.Checked) then Shape4.Brush.Color:=clRed;

  if (CheckBox8.Checked) then Shape5.Brush.Color:=clGreen;
  if (not CheckBox8.Checked) then Shape5.Brush.Color:=clRed;

  if (CheckBox10.Checked) then Shape6.Brush.Color:=clGreen;
  if (not CheckBox10.Checked) then Shape6.Brush.Color:=clRed;

  if (CheckBox11.Checked) then Shape7.Brush.Color:=clGreen;
  if (not CheckBox11.Checked) then Shape7.Brush.Color:=clRed;

  //SetLength(AShape, Length(AShape) + 1);
  SetLength(AShape, EndPattern);
  for i := BeginPattern to EndPattern do
  begin
    AShape[0]:= TShape.Create(TabSheet2);
    AShape[0].Parent := TabSheet2;
    AShape[0].Tag:=i;
    AShape[0].Visible:=true;
    AShape[0].Top:=5;
    if (i >= FirstPattern) and (i<=LastPattern) then AShape[0].Top:=7+40;
    AShape[0].Left:=5+(i*40);
    AShape[0].Width:=40;
    AShape[0].Height:=40;
    AShape[0].Shape := stRectangle; // Options: stRectangle, stSquare, stEllipse, etc.
    AShape[0].Brush.Color:=clWhite;
    AShape[0].OnPaint:= @AShapePaint;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  EventsList.Free;
end;

procedure TForm1.CheckBox1EditingDone(Sender: TObject);
begin
  if (CheckBox1.Checked) then begin Device[1].Enable:=true; Shape2.Brush.Color:=clGreen; end;
  if (not CheckBox1.Checked) then begin Device[1].Enable:=false; Shape2.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox2EditingDone(Sender: TObject);
begin
  ActiveRestartPattern:= CheckBox2.Checked;
end;

procedure TForm1.CheckBox10EditingDone(Sender: TObject);
begin
  if (CheckBox10.Checked) then begin Device[5].Enable:=true; Shape6.Brush.Color:=clGreen; end;
  if (not CheckBox10.Checked) then begin Device[5].Enable:=false; Shape6.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox11EditingDone(Sender: TObject);
begin
  if (CheckBox11.Checked) then begin Device[EndDevice].Enable:=true; Shape7.Brush.Color:=clGreen; end;
  if (not CheckBox11.Checked) then begin Device[EndDevice].Enable:=false; Shape7.Brush.Color:=clRed; end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
begin
  StartStepLayer:=not StartStepLayer;
  if (StartStepLayer) then
  begin
    Pattern1Index:=0;
    for i := FirstDevice to EndDevice do
    begin
      Device[i].Start:=false;
      Device[i].IS_StartUp:=false;
      Device[i].IS_Running:=false;
      Device[i].EndOfCounterDuration:=false;
      Device[i].CounterDurationTime_Act:=0;
      Device[i].RunDurationTime_Act:=0;
      Device[i].Mark:=false;
    end;
  end
  else
  begin

  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i:integer;
  Tempo:TIntArray;
  cc : array of integer;

begin
  Tempo:=[3,4,5];
  cc:=[5,5,5];

  for i := Low(Pattern1) to High(Pattern1) do
  begin
  Push(Tempo,Pattern1[i]);
  end;

  Label12.Caption:='Pattern1:' + chr(13);
  for i := 1 to 5 do
  begin
  Label12.Caption:=Label12.Caption+Pattern1[i].ToString;
  if i<5 then Label12.Caption:=Label12.Caption+', ';
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  i:integer;
  vv:TIntArray;
begin

  Pop(vv);

  Label12.Caption:='Pattern1:' + chr(13);
  for i := 1 to 5 do
  begin
  Label12.Caption:=Label12.Caption+Pattern1[i].ToString;
  if i<5 then Label12.Caption:=Label12.Caption+', ';
  end;
end;

procedure TForm1.CheckBox3EditingDone(Sender: TObject);
begin
  if (CheckBox3.Checked) then begin Device[2].Enable:=true; Shape3.Brush.Color:=clGreen; end;
  if (not CheckBox3.Checked) then begin Device[2].Enable:=false; Shape3.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox6EditingDone(Sender: TObject);
begin
  if (CheckBox6.Checked) then begin Device[3].Enable:=true; Shape4.Brush.Color:=clGreen; end;
  if (not CheckBox6.Checked) then begin Device[3].Enable:=false; Shape4.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox8EditingDone(Sender: TObject);
begin
  if (CheckBox8.Checked) then begin Device[4].Enable:=true; Shape5.Brush.Color:=clGreen; end;
  if (not CheckBox8.Checked) then begin Device[4].Enable:=false; Shape5.Brush.Color:=clRed; end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Timer2.Enabled:=false;
  SimpleIPCClient1.Disconnect;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin

end;

procedure TForm1.Shape1MouseEnter(Sender: TObject);
begin
  MouseEnter_:=0;
end;

procedure TForm1.Shape14Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape14.Width/2);
  y_:=round(shape14.Height/2);
  Shape14.Canvas.TextOut(x_-5,y_-9,'1');
end;

procedure TForm1.Shape3MouseEnter(Sender: TObject);
begin
  MouseEnter_:=2;
end;

procedure TForm1.Shape15Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape15.Width/2);
  y_:=round(shape15.Height/2);
  Shape15.Canvas.TextOut(x_-5,y_-9,'2');
end;

procedure TForm1.Shape4MouseEnter(Sender: TObject);
begin
  MouseEnter_:=3;
end;

procedure TForm1.Shape16Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape16.Width/2);
  y_:=round(shape16.Height/2);
  Shape16.Canvas.TextOut(x_-5,y_-9,'3');
end;

procedure TForm1.Shape5MouseEnter(Sender: TObject);
begin
  MouseEnter_:=4;
end;

procedure TForm1.Shape17Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape17.Width/2);
  y_:=round(shape17.Height/2);
  Shape17.Canvas.TextOut(x_-5,y_-9,'4');
end;

procedure TForm1.Shape6MouseEnter(Sender: TObject);
begin
  MouseEnter_:=5;
end;

procedure TForm1.Shape18Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape18.Width/2);
  y_:=round(shape18.Height/2);
  Shape18.Canvas.TextOut(x_-5,y_-9,'5');
end;

procedure TForm1.Shape7MouseEnter(Sender: TObject);
begin
  MouseEnter_:=6;
end;

procedure TForm1.Shape19Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape19.Width/2);
  y_:=round(shape19.Height/2);
  Shape19.Canvas.TextOut(5,y_-9,EndDevice.ToString+' [END (Virtual)]');
end;

end.

