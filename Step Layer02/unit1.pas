unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Spin, ComCtrls, atshapeline, Types;

type
	Layer_ = record
                Start:boolean;
		RunDulationTime_Act: integer;
		CounterDulationTime_Act: integer;
		Index: integer;
		CounterDulationTime_Set: integer;
		EndOfCounterDulation: boolean;
                UnderRunning: boolean;
                Enable:boolean;
                Mark:boolean;
	end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
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
    PageControl1: TPageControl;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    SpinEdit5: TSpinEdit;
    SpinEdit6: TSpinEdit;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox10EditingDone(Sender: TObject);
    procedure CheckBox11EditingDone(Sender: TObject);
    procedure CheckBox1EditingDone(Sender: TObject);
    procedure CheckBox3EditingDone(Sender: TObject);
    procedure CheckBox6EditingDone(Sender: TObject);
    procedure CheckBox8EditingDone(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Shape1MouseEnter(Sender: TObject);
    procedure Shape1Paint(Sender: TObject);
    procedure Shape2MouseEnter(Sender: TObject);
    procedure Shape2Paint(Sender: TObject);
    procedure Shape3MouseEnter(Sender: TObject);
    procedure Shape3Paint(Sender: TObject);
    procedure Shape4MouseEnter(Sender: TObject);
    procedure Shape4Paint(Sender: TObject);
    procedure Shape5MouseEnter(Sender: TObject);
    procedure Shape5Paint(Sender: TObject);
    procedure Shape6MouseEnter(Sender: TObject);
    procedure Shape6Paint(Sender: TObject);
    procedure Shape7MouseEnter(Sender: TObject);
    procedure Shape7Paint(Sender: TObject);
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
  private
    procedure ShowStatus();
    Function InLengthLayer(var Index_:integer):boolean;
    Function InLength_(Index_:integer):boolean;
    Function LowerLength_(Index_:integer):boolean;
    Function HigherLength_(Index_:integer):boolean;
  public

  end;

  //type
  //TIntArray = array[integer] of 1..5;

  type
  TIntArray = array of integer;

  //type
  //TIntArray = array[1..5] of integer;

var
  Form1: TForm1;
  Pattern1: array[1..5] of integer = (0,5,3,0,4);
  //Pattern1: TIntArray = (0,5,3,0,4);
  //Pattern1: TIntArray;
  Pattern1Run:boolean;
  Pattern1Index:integer;

  Layer: array[1..6] of Layer_;
  EventsList: TStringList;
  OldCurrentLayer:integer;

  MouseEnter_:integer;

implementation

{$R *.lfm}

{ TForm1 }

//var
//  slice1: TIntArray;
//begin
//  slice1 := Copy(MyStack, Low(MyStack), High(MyStack));

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
  if (Index_ >= Low(Layer)) and (Index_ <= High(Layer)) and (Index_>0) then
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

  Label6.Caption:=Layer[1].CounterDulationTime_Act.ToString+' t';
  Label7.Caption:=Layer[2].CounterDulationTime_Act.ToString+' t';
  Label8.Caption:=Layer[3].CounterDulationTime_Act.ToString+' t';
  Label9.Caption:=Layer[4].CounterDulationTime_Act.ToString+' t';
  Label10.Caption:=Layer[5].CounterDulationTime_Act.ToString+' t';
  Label11.Caption:=Layer[6].CounterDulationTime_Act.ToString+' t';

  if MouseEnter_=0 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   '  - Pattern1Run:= ' + Pattern1Run.ToString + chr(13)+
                   '  - Pattern1Index:= ' + Pattern1Index.ToString + chr(13);
  end;

  if MouseEnter_=1 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[1]' + chr(13)+
                   '  - Start:= ' + Layer[1].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[1].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDulation:= ' + Layer[1].EndOfCounterDulation.ToInteger.ToString + chr(13)+
                   '  - CounterDulationTime_Act:= ' + Layer[1].CounterDulationTime_Act.ToString + chr(13)+
                   '  - RunDulationTime_Act:= ' + Layer[1].RunDulationTime_Act.ToString + chr(13)+
                   '  - CounterDulationTime_Set:= ' + Layer[1].CounterDulationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[1].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=2 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[2]' + chr(13)+
                   '  - Start:= ' + Layer[2].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[2].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDulation:= ' + Layer[2].EndOfCounterDulation.ToInteger.ToString + chr(13)+
                   '  - CounterDulationTime_Act:= ' + Layer[2].CounterDulationTime_Act.ToString + chr(13)+
                   '  - RunDulationTime_Act:= ' + Layer[2].RunDulationTime_Act.ToString + chr(13)+
                   '  - CounterDulationTime_Set:= ' + Layer[2].CounterDulationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[2].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=3 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[3]' + chr(13)+
                   '  - Start:= ' + Layer[3].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[3].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDulation:= ' + Layer[3].EndOfCounterDulation.ToInteger.ToString + chr(13)+
                   '  - CounterDulationTime_Act:= ' + Layer[3].CounterDulationTime_Act.ToString + chr(13)+
                   '  - RunDulationTime_Act:= ' + Layer[3].RunDulationTime_Act.ToString + chr(13)+
                   '  - CounterDulationTime_Set:= ' + Layer[3].CounterDulationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[3].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=4 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[4]' + chr(13)+
                   '  - Start:= ' + Layer[4].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[4].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDulation:= ' + Layer[4].EndOfCounterDulation.ToInteger.ToString + chr(13)+
                   '  - CounterDulationTime_Act:= ' + Layer[4].CounterDulationTime_Act.ToString + chr(13)+
                   '  - RunDulationTime_Act:= ' + Layer[4].RunDulationTime_Act.ToString + chr(13)+
                   '  - CounterDulationTime_Set:= ' + Layer[4].CounterDulationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[4].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=5 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[5]' + chr(13)+
                   '  - Start:= ' + Layer[5].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[5].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDulation:= ' + Layer[5].EndOfCounterDulation.ToInteger.ToString + chr(13)+
                   '  - CounterDulationTime_Act:= ' + Layer[5].CounterDulationTime_Act.ToString + chr(13)+
                   '  - RunDulationTime_Act:= ' + Layer[5].RunDulationTime_Act.ToString + chr(13)+
                   '  - CounterDulationTime_Set:= ' + Layer[5].CounterDulationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[5].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=6 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[End]' + chr(13)+
                   '  - Start:= ' + Layer[6].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[6].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDulation:= ' + Layer[6].EndOfCounterDulation.ToInteger.ToString + chr(13)+
                   '  - CounterDulationTime_Act:= ' + Layer[6].CounterDulationTime_Act.ToString + chr(13)+
                   '  - RunDulationTime_Act:= ' + Layer[6].RunDulationTime_Act.ToString + chr(13)+
                   '  - CounterDulationTime_Set:= ' + Layer[6].CounterDulationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[6].Enable.ToInteger.ToString + chr(13);
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
  Layer[1].CounterDulationTime_Set:=SpinEdit1.Value;
end;

procedure TForm1.SpinEdit2EditingDone(Sender: TObject);
begin
  Layer[2].CounterDulationTime_Set:=SpinEdit2.Value;
end;

procedure TForm1.SpinEdit3EditingDone(Sender: TObject);
begin
  Layer[3].CounterDulationTime_Set:=SpinEdit3.Value;
end;

procedure TForm1.SpinEdit4EditingDone(Sender: TObject);
begin
  Layer[4].CounterDulationTime_Set:=SpinEdit4.Value;
end;

procedure TForm1.SpinEdit5EditingDone(Sender: TObject);
begin
  Layer[5].CounterDulationTime_Set:=SpinEdit5.Value;
end;

procedure TForm1.SpinEdit6EditingDone(Sender: TObject);
begin
  Layer[6].CounterDulationTime_Set:=SpinEdit6.Value;
end;

procedure TForm1.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:integer;
  i2:integer;
  CounterLayer:integer;
  LastLayerActive:boolean;
  CurrentLayer:integer;
  AllLayerDisable:boolean;
  EndLoop:boolean;
  PreEndLoop:boolean;
  Tempo:integer;
begin
  CurrentLayer:=0;
  if (Pattern1Run) then
  begin

    CounterLayer:=0;
    AllLayerDisable:=false;
    LastLayerActive:=false;

    for i := Low(Layer) to High(Layer)-1 do  //Reset mark
    begin
      Layer[i].Mark :=false;
    end;

    for i := Low(Pattern1) to High(Pattern1) do  //Check pattern
    begin
      if (Pattern1[i]<High(Layer)) then
      if InLengthLayer(Pattern1[i]) then
      if (Layer[Pattern1[i]].Enable) then begin Layer[Pattern1[i]].Mark:=true; end;
    end;
    //for i := Low(Layer) to High(Layer)-1 do  //Check working layer
    //begin
    //  if (not Layer[i].Enable) then begin Layer[i].Mark:=false; end;
    //end;
    for i := Low(Layer) to High(Layer)-1 do  //Check mark each working layer
    begin
      if (Layer[i].Mark=false) then begin CounterLayer:=CounterLayer+1; end;
    end;

    if (CounterLayer=High(Layer)-2) then LastLayerActive:=true;  //High(Layer)-2 =4
    if (CounterLayer=High(Layer)-1) then AllLayerDisable:=true;  //High(Layer)-1 =5

    if (not AllLayerDisable) and (Pattern1Index=0)then
    begin
      for i2 := Low(Pattern1) to High(Pattern1) do
      begin
        Pattern1Index:=Pattern1Index+1;
        if InLength_(Pattern1Index) then
        begin
          if InLengthLayer(Pattern1[Pattern1Index]) then
          begin
            Tempo:=Low(Layer);
            Tempo:=High(Layer);
            Tempo:=Pattern1[Pattern1Index];
            Layer[Pattern1[Pattern1Index]].Start:=true;
            break;
          end;
        end;
      end;
    end;
    if(AllLayerDisable)then
    begin
      Pattern1Index:=0;
      Layer[Pattern1[1]].Start:=false;
      Layer[Pattern1[2]].Start:=false;
      Layer[Pattern1[3]].Start:=false;
      Layer[Pattern1[4]].Start:=false;
      Layer[Pattern1[5]].Start:=false;
    end;

    //Set index with start
    EndLoop:=false;
    PreEndLoop:=false;
    i:=1;
    repeat
      PreEndLoop:=true;
      if InLength_(Pattern1Index) then
      begin   // Any begin to next/skip layer then recalculate
        if not InLengthLayer(Pattern1[Pattern1Index]) then
        begin
          PreEndLoop:=false;
          for i2 := Low(Pattern1) to High(Pattern1) do
          begin
            if InLength_(Pattern1Index) then
            if not InLengthLayer(Pattern1[Pattern1Index]) then begin Pattern1Index:=Pattern1Index+1; end;
          end;
          if InLength_(Pattern1Index) then
          if InLengthLayer(Pattern1[Pattern1Index]) then begin Layer[Pattern1[Pattern1Index]].Start:=true; end;
        end;
        if (HigherLength_(Pattern1Index)) then Pattern1Index:=High(Layer);
        if InLength_(Pattern1Index) then
        if InLengthLayer(Pattern1[Pattern1Index]) then
        if ((Not Layer[Pattern1[Pattern1Index]].Enable) and Layer[Pattern1[Pattern1Index]].Start) or (Layer[Pattern1[Pattern1Index]].Start and Layer[Pattern1[Pattern1Index]].EndOfCounterDulation) then
        begin
          PreEndLoop:=false;
          Layer[Pattern1[Pattern1Index]].Start:=false;
          Pattern1Index:=Pattern1Index+1;
          if InLength_(Pattern1Index) then
          if InLengthLayer(Pattern1[Pattern1Index]) then begin Layer[Pattern1[Pattern1Index]].Start:=true; end;
          if HigherLength_(Pattern1Index) then  Layer[High(Layer)].Start:=true;
        end;
      end;
      if (i=5) and LowerLength_(Pattern1Index) then
      begin
        PreEndLoop:=true;
      end;
      if HigherLength_(Pattern1Index) then
      begin   // Any begin to next/skip layer then recalculate
        if (not Layer[High(Layer)].Enable) or (not Layer[High(Layer)].Start) or (Layer[High(Layer)].Start and Layer[High(Layer)].EndOfCounterDulation) then
        begin
          Pattern1Index:=0;
          Layer[High(Layer)].Start:=false;
          PreEndLoop:=false;
        end;
        if (Layer[High(Layer)].Enable and (not LastLayerActive) and Layer[High(Layer)].Start) then
        begin
          Pattern1Index:=0;
          Layer[High(Layer)].Start:=false;
          PreEndLoop:=True;
        end;
      end;

      i:=i+1;
      if i>5 then
      begin
        i:=1;
        if PreEndLoop then EndLoop:=true;
      end;
    until EndLoop;

    //Process Dulation ( not for Start/Skip layer )  ( For Output layer only )
    for i := Low(Layer) to High(Layer) do
    begin
      if (Layer[i].CounterDulationTime_Act>=Layer[i].CounterDulationTime_Set) then
      begin
        Layer[i].EndOfCounterDulation:=true;
        Layer[i].UnderRunning:=false;
      end;
      if (Layer[i].CounterDulationTime_Act<Layer[i].CounterDulationTime_Set) then
      begin
        Layer[i].EndOfCounterDulation:=false;
        Layer[i].UnderRunning:=true;
      end;
      if Layer[i].Start and Layer[i].Enable then
      begin
        if Layer[i].CounterDulationTime_Act <= Layer[i].CounterDulationTime_Set then
          Layer[i].RunDulationTime_Act:=Layer[i].RunDulationTime_Act+1;
        if (Layer[i].CounterDulationTime_Act<Layer[i].CounterDulationTime_Set) then
          Layer[i].CounterDulationTime_Act:=Layer[i].CounterDulationTime_Act+1;
      end;
      if (not Layer[i].Enable) or (not Layer[i].Start) then
      begin
        Layer[i].UnderRunning:=false;
        Layer[i].RunDulationTime_Act:=0;
        Layer[i].CounterDulationTime_Act:=0;
        Layer[i].EndOfCounterDulation:=false;
      end;
    end;

    //Cursor position
    if Pattern1Index=0 then
    begin
      Shape13.Top:=Shape1.Top;
    end;
    if InLength_(Pattern1Index) then
    if Pattern1[Pattern1Index]=1 then
    begin
      Shape13.Top:=Shape2.Top;
    end;
    if InLength_(Pattern1Index) then
    if Pattern1[Pattern1Index]=2 then
    begin
      Shape13.Top:=Shape3.Top;
    end;
    if InLength_(Pattern1Index) then
    if Pattern1[Pattern1Index]=3 then
    begin
      Shape13.Top:=Shape4.Top;
    end;
    if InLength_(Pattern1Index) then
    if Pattern1[Pattern1Index]=4 then
    begin
      Shape13.Top:=Shape5.Top;
    end;
    if InLength_(Pattern1Index) then
    if Pattern1[Pattern1Index]=5 then
    begin
      Shape13.Top:=Shape6.Top;
    end;
    if Pattern1Index=6 then
    begin
      Shape13.Top:=Shape7.Top;
    end;

    //CurrentLayer
    if InLength_(Pattern1Index) then CurrentLayer:=Pattern1[Pattern1Index];
    if HigherLength_(Pattern1Index) then CurrentLayer:=Pattern1Index;
    if LowerLength_(Pattern1Index) then CurrentLayer:=0;

  end;

  if CurrentLayer<>OldCurrentLayer then
  begin
    OldCurrentLayer:=CurrentLayer;
    EventsList.Add('Layer: '+OldCurrentLayer.ToString);
  end;
  if EventsList.Count > 13 then EventsList.Delete(0);
  Memo1.Lines.Assign(EventsList);

  if (Pattern1Run) then Label14.Caption:='Index: '+Pattern1Index.ToString;
  if (Pattern1Run) then Label14.Caption:='Pattern1 Index: '+Pattern1Index.ToString+ ' Layer: ' + CurrentLayer.ToString;

  ShowStatus();

end;

procedure TForm1.Shape1Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape1.Width/2);
  y_:=round(shape1.Height/2);
  Shape1.Canvas.TextOut(5,y_-5,'0 [Start]');
end;

procedure TForm1.Shape2MouseEnter(Sender: TObject);
begin
  MouseEnter_:=1;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
begin
  MouseEnter_:=0;

  EventsList:=TStringList.Create;
  OldCurrentLayer:=-1;

  Pattern1Run:=false;
  Pattern1Index:=0;

  Label12.Caption:='Pattern1:' + chr(13);
  for i := 1 to 5 do
  begin
  Label12.Caption:=Label12.Caption+Pattern1[i].ToString;
  if i<5 then Label12.Caption:=Label12.Caption+', ';
  end;

  for i := 1 to 6 do
  begin
    Layer[i].Index:=i;
    Layer[i].Start:=false;
    Layer[i].UnderRunning:=false;
    Layer[i].EndOfCounterDulation:=false;
    Layer[i].CounterDulationTime_Act:=0;
    Layer[i].RunDulationTime_Act:=0;
    Layer[i].Mark:=false;
  end;

  Layer[1].Enable:=CheckBox1.Checked;
  Layer[2].Enable:=CheckBox3.Checked;
  Layer[3].Enable:=CheckBox6.Checked;
  Layer[4].Enable:=CheckBox8.Checked;
  Layer[5].Enable:=CheckBox10.Checked;
  Layer[6].Enable:=CheckBox11.Checked;

  Layer[1].CounterDulationTime_Set:=SpinEdit1.Value;
  Layer[2].CounterDulationTime_Set:=SpinEdit2.Value;
  Layer[3].CounterDulationTime_Set:=SpinEdit3.Value;
  Layer[4].CounterDulationTime_Set:=SpinEdit4.Value;
  Layer[5].CounterDulationTime_Set:=SpinEdit5.Value;
  Layer[6].CounterDulationTime_Set:=SpinEdit6.Value;

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

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  EventsList.Free;
end;

procedure TForm1.CheckBox1EditingDone(Sender: TObject);
begin
  if (CheckBox1.Checked) then begin Layer[1].Enable:=true; Shape2.Brush.Color:=clGreen; end;
  if (not CheckBox1.Checked) then begin Layer[1].Enable:=false; Shape2.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox10EditingDone(Sender: TObject);
begin
  if (CheckBox10.Checked) then begin Layer[5].Enable:=true; Shape6.Brush.Color:=clGreen; end;
  if (not CheckBox10.Checked) then begin Layer[5].Enable:=false; Shape6.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox11EditingDone(Sender: TObject);
begin
  Layer[6].Enable:=CheckBox11.Checked;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
begin
  Pattern1Run:=not Pattern1Run;
  if (Pattern1Run) then
  begin
    Pattern1Index:=0;
    for i := 1 to 6 do
    begin
      Layer[i].Start:=false;
      Layer[i].UnderRunning:=false;
      Layer[i].EndOfCounterDulation:=false;
      Layer[i].CounterDulationTime_Act:=0;
      Layer[i].RunDulationTime_Act:=0;
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
  if (CheckBox3.Checked) then begin Layer[2].Enable:=true; Shape3.Brush.Color:=clGreen; end;
  if (not CheckBox3.Checked) then begin Layer[2].Enable:=false; Shape3.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox6EditingDone(Sender: TObject);
begin
  if (CheckBox6.Checked) then begin Layer[3].Enable:=true; Shape4.Brush.Color:=clGreen; end;
  if (not CheckBox6.Checked) then begin Layer[3].Enable:=false; Shape4.Brush.Color:=clRed; end;
end;

procedure TForm1.CheckBox8EditingDone(Sender: TObject);
begin
  if (CheckBox8.Checked) then begin Layer[4].Enable:=true; Shape5.Brush.Color:=clGreen; end;
  if (not CheckBox8.Checked) then begin Layer[4].Enable:=false; Shape5.Brush.Color:=clRed; end;
end;

procedure TForm1.FormPaint(Sender: TObject);
begin

end;

procedure TForm1.Shape1MouseEnter(Sender: TObject);
begin
  MouseEnter_:=0;
end;

procedure TForm1.Shape2Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape2.Width/2);
  y_:=round(shape2.Height/2);
  Shape2.Canvas.TextOut(x_-5,y_-5,'1');
end;

procedure TForm1.Shape3MouseEnter(Sender: TObject);
begin
  MouseEnter_:=2;
end;

procedure TForm1.Shape3Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape3.Width/2);
  y_:=round(shape3.Height/2);
  Shape3.Canvas.TextOut(x_-5,y_-5,'2');
end;

procedure TForm1.Shape4MouseEnter(Sender: TObject);
begin
  MouseEnter_:=3;
end;

procedure TForm1.Shape4Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape4.Width/2);
  y_:=round(shape4.Height/2);
  Shape4.Canvas.TextOut(x_-5,y_-5,'3');
end;

procedure TForm1.Shape5MouseEnter(Sender: TObject);
begin
  MouseEnter_:=4;
end;

procedure TForm1.Shape5Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape5.Width/2);
  y_:=round(shape5.Height/2);
  Shape5.Canvas.TextOut(x_-5,y_-5,'4');
end;

procedure TForm1.Shape6MouseEnter(Sender: TObject);
begin
  MouseEnter_:=5;
end;

procedure TForm1.Shape6Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape6.Width/2);
  y_:=round(shape6.Height/2);
  Shape6.Canvas.TextOut(x_-5,y_-5,'5');
end;

procedure TForm1.Shape7MouseEnter(Sender: TObject);
begin
  MouseEnter_:=6;
end;

procedure TForm1.Shape7Paint(Sender: TObject);
var
  x_,y_:integer;
begin
  x_:=round(shape7.Width/2);
  y_:=round(shape7.Height/2);
  Shape7.Canvas.TextOut(5,y_-5,'6 [END]');
end;

end.

