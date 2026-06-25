unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Spin, atshapeline;

type
	Layer_ = record
                Start:boolean;
		RunDurationTime_Act: integer;
		CounterDurationTime_Act: integer;
		Index: integer;
		CounterDurationTime_Set: integer;
		EndOfCounterDuration: boolean;
                UnderRunning: boolean;
                Enable:boolean;
	end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
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
    Label13: TLabel;
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
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
    procedure Timer1Timer(Sender: TObject);
  private
    procedure ShowStatus();
  public

  end;

var
  Form1: TForm1;
  Pattern1: array[1..5] of integer = (2,5,3,1,4);
  Pattern2: array[1..8] of integer = (2,1,3,4,5,4,1,3);
  Pattern1Run:boolean;
  Pattern1Index:integer;
  Pattern2Run:boolean;
  Pattern2Index:integer;

  Layer: array[1..6] of Layer_;
  EventsList: TStringList;
  OldCurrentLayer:integer;

  MouseEnter_:integer;

  LastLayerActive:boolean;
  AllLayerDisable:boolean;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.ShowStatus();
begin

  Label6.Caption:=Layer[1].CounterDurationTime_Act.ToString+' t';
  Label7.Caption:=Layer[2].CounterDurationTime_Act.ToString+' t';
  Label8.Caption:=Layer[3].CounterDurationTime_Act.ToString+' t';
  Label9.Caption:=Layer[4].CounterDurationTime_Act.ToString+' t';
  Label10.Caption:=Layer[5].CounterDurationTime_Act.ToString+' t';
  Label11.Caption:=Layer[6].CounterDurationTime_Act.ToString+' t';

  if MouseEnter_=0 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   '  - Pattern1Run:= ' + Pattern1Run.ToInteger.ToString + chr(13)+
                   '  - Pattern1Index:= ' + Pattern1Index.ToString + chr(13)+
                   '  - Pattern2Run:= ' + Pattern2Run.ToInteger.ToString + chr(13)+
                   '  - Pattern2Index:= ' + Pattern2Index.ToString + chr(13)+
                   '  - LastLayerActive:= ' + LastLayerActive.ToInteger.ToString + chr(13)+
                   '  - AllLayerDisable:= ' + AllLayerDisable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=1 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[1]' + chr(13)+
                   '  - Start:= ' + Layer[1].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[1].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Layer[1].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Layer[1].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Layer[1].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Layer[1].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[1].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=2 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[2]' + chr(13)+
                   '  - Start:= ' + Layer[2].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[2].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Layer[2].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Layer[2].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Layer[2].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Layer[2].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[2].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=3 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[3]' + chr(13)+
                   '  - Start:= ' + Layer[3].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[3].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Layer[3].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Layer[3].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Layer[3].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Layer[3].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[3].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=4 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[4]' + chr(13)+
                   '  - Start:= ' + Layer[4].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[4].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Layer[4].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Layer[4].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Layer[4].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Layer[4].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[4].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=5 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[5]' + chr(13)+
                   '  - Start:= ' + Layer[5].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[5].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Layer[5].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Layer[5].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Layer[5].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Layer[5].CounterDurationTime_Set.ToString + chr(13)+
                   '  - Enable:= ' + Layer[5].Enable.ToInteger.ToString + chr(13);
  end;

  if MouseEnter_=6 then
  begin
  Label15.Caption:='Status: ' + chr(13)+
                   'Layer[End]' + chr(13)+
                   '  - Start:= ' + Layer[6].Start.ToInteger.ToString + chr(13)+
                   '  - UnderRunning:= ' + Layer[6].UnderRunning.ToInteger.ToString + chr(13)+
                   '  - EndOfCounterDuration:= ' + Layer[6].EndOfCounterDuration.ToInteger.ToString + chr(13)+
                   '  - CounterDurationTime_Act:= ' + Layer[6].CounterDurationTime_Act.ToString + chr(13)+
                   '  - RunDurationTime_Act:= ' + Layer[6].RunDurationTime_Act.ToString + chr(13)+
                   '  - CounterDurationTime_Set:= ' + Layer[6].CounterDurationTime_Set.ToString + chr(13)+
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
  Layer[1].CounterDurationTime_Set:=SpinEdit1.Value;
end;

procedure TForm1.SpinEdit2EditingDone(Sender: TObject);
begin
  Layer[2].CounterDurationTime_Set:=SpinEdit2.Value;
end;

procedure TForm1.SpinEdit3EditingDone(Sender: TObject);
begin
  Layer[3].CounterDurationTime_Set:=SpinEdit3.Value;
end;

procedure TForm1.SpinEdit4EditingDone(Sender: TObject);
begin
  Layer[4].CounterDurationTime_Set:=SpinEdit4.Value;
end;

procedure TForm1.SpinEdit5EditingDone(Sender: TObject);
begin
  Layer[5].CounterDurationTime_Set:=SpinEdit5.Value;
end;

procedure TForm1.SpinEdit6EditingDone(Sender: TObject);
begin
  Layer[6].CounterDurationTime_Set:=SpinEdit6.Value;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  i:integer;
  CounterLayer:integer;
  CurrentLayer:integer;
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
    for i := 1 to 5 do
    begin
      if(not Layer[i].Enable) then CounterLayer:=CounterLayer+1;
    end;
    if (CounterLayer=4) then LastLayerActive:=true;
    if (CounterLayer=5) then AllLayerDisable:=true;

    if(Pattern1Index=0)then begin Pattern1Index:=1; Layer[Pattern1[Pattern1Index]].Start:=true; end;
    if(AllLayerDisable)then begin Pattern1Index:=0; Layer[Pattern1[1]].Start:=false; end;

    //for i := 1 to 5 do
    //begin
    //  if (Pattern1Index>0) and (Pattern1Index<6) then
    //  if ((Pattern1[Pattern1Index]=i) and Layer[i].Start) then
    //  begin
    //    if((not Layer[i].Enable) and Layer[i].Start) then
    //    begin
    //      Layer[i].Start:=false;
    //      Pattern1Index:=Pattern1Index+1;
    //      if (Pattern1Index<6) then Layer[Pattern1[Pattern1Index]].Start:=true;
    //      if (Pattern1Index>=6) then Layer[6].Start:=true;
    //    end;
    //    if(Layer[i].EndOfCounterDuration and Layer[i].Start) then
    //    begin
    //      Layer[i].Start:=false;
    //      Pattern1Index:=Pattern1Index+1;
    //      if (Pattern1Index<6) then Layer[Pattern1[Pattern1Index]].Start:=true;
    //      if (Pattern1Index>=6) then Layer[6].Start:=true;
    //    end;
    //  end;
    //
    //  if (Pattern1Index>0) and (Pattern1Index<6) then
    //  if (not Layer[Pattern1[Pattern1Index]].Start) then
    //  begin
    //
    //  end;
    //end;

    EndLoop:=false;
    PreEndLoop:=false;
    i:=1;
    repeat

      if (Pattern1Index>0) and (Pattern1Index<6) then
      if ((Pattern1[Pattern1Index]=i) and Layer[i].Start) then
      begin
        if((not Layer[i].Enable) and Layer[i].Start) then
        begin
          Layer[i].Start:=false;
          Pattern1Index:=Pattern1Index+1;
          if (Pattern1Index<6) then begin Layer[Pattern1[Pattern1Index]].Start:=true; PreEndLoop:=true; end;
          if (Pattern1Index>=6) then begin Layer[6].Start:=true; PreEndLoop:=true; end;
        end;
        if(Layer[i].EndOfCounterDuration and Layer[i].Start) then
        begin
          Layer[i].Start:=false;
          Pattern1Index:=Pattern1Index+1;
          if (Pattern1Index<6) then begin Layer[Pattern1[Pattern1Index]].Start:=true; PreEndLoop:=true; end;
          if (Pattern1Index>=6) then begin Layer[6].Start:=true; PreEndLoop:=true; end;
        end;
      end;

      if (Pattern1Index<=0) or (Pattern1Index>=6) then PreEndLoop:=true;
      if (Pattern1Index>0) and (Pattern1Index<6) then
      if (Layer[Pattern1[Pattern1Index]].Enable) and (not Layer[Pattern1[Pattern1Index]].EndOfCounterDuration) and (Layer[Pattern1[Pattern1Index]].Start) then  PreEndLoop:=true;
      if (Pattern1Index>0) and (Pattern1Index<6) then
      if (not Layer[Pattern1[Pattern1Index]].Enable) and (Layer[Pattern1[Pattern1Index]].Start) then  PreEndLoop:=false;

      if (Pattern1Index>0) and (Pattern1Index<6) then
      Tempo:=Pattern1[Pattern1Index];

      i:=i+1;
      if i>5 then
      begin
        i:=1;
        if PreEndLoop then EndLoop:=true;
      end;
    until EndLoop;

    if ((Pattern1Index=6) and Layer[6].Start) then
    begin
      if(not LastLayerActive)then
      begin
        Layer[6].Start:=false;
        Pattern1Index:=0;
      end;
      if((not Layer[6].Enable) and Layer[6].Start) then
      begin
        Layer[6].Start:=false;
        Pattern1Index:=0;
      end;
      if(Layer[6].EndOfCounterDuration and Layer[6].Start) then
      begin
        Layer[6].Start:=false;
        Pattern1Index:=0;
      end;
    end;

    for i := 1 to 6 do
    begin
      if (Layer[i].CounterDurationTime_Act>=Layer[i].CounterDurationTime_Set) then
      begin
        Layer[i].EndOfCounterDuration:=true;
        Layer[i].UnderRunning:=false;
      end;
      if Layer[i].Start and Layer[i].Enable then
      begin
        if Layer[i].RunDurationTime_Act <= Layer[i].CounterDurationTime_Set then
        Layer[i].RunDurationTime_Act:=Layer[i].RunDurationTime_Act+1;
      end;
      if Layer[i].Start and Layer[i].Enable then
      if (Layer[i].CounterDurationTime_Act<Layer[i].CounterDurationTime_Set) then
      begin
        Layer[i].CounterDurationTime_Act:=Layer[i].CounterDurationTime_Act+1;
      end;
      if (Layer[i].CounterDurationTime_Act<Layer[i].CounterDurationTime_Set) then
      begin
        Layer[i].EndOfCounterDuration:=false;
        Layer[i].UnderRunning:=true;
      end;
      if (not Layer[i].Enable) or (not Layer[i].Start) then
      begin
        if (Pattern1Index>0) and (Pattern1Index<6) then  CurrentLayer:=Pattern1[Pattern1Index];
        if (Pattern1Index>0) and (Pattern1Index<6) then
        if (Pattern1[Pattern1Index] <> Layer[i].Index) then
        Layer[i].Start:=false;
        Layer[i].UnderRunning:=false;
        Layer[i].RunDurationTime_Act:=0;
        Layer[i].CounterDurationTime_Act:=0;
      end;

    end;

    if Pattern1Index=0 then
    begin
      Shape13.Top:=Shape1.Top;
    end;
    if (Pattern1Index>0) and (Pattern1Index<6) then
    if Pattern1[Pattern1Index]=1 then
    begin
      Shape13.Top:=Shape2.Top;
    end;
    if (Pattern1Index>0) and (Pattern1Index<6) then
    if Pattern1[Pattern1Index]=2 then
    begin
      Shape13.Top:=Shape3.Top;
    end;
    if (Pattern1Index>0) and (Pattern1Index<6) then
    if Pattern1[Pattern1Index]=3 then
    begin
      Shape13.Top:=Shape4.Top;
    end;
    if (Pattern1Index>0) and (Pattern1Index<6) then
    if Pattern1[Pattern1Index]=4 then
    begin
      Shape13.Top:=Shape5.Top;
    end;
    if (Pattern1Index>0) and (Pattern1Index<6) then
    if Pattern1[Pattern1Index]=5 then
    begin
      Shape13.Top:=Shape6.Top;
    end;
    if Pattern1Index=6 then
    begin
      Shape13.Top:=Shape7.Top;
    end;

    if (Pattern1Index>0) and (Pattern1Index<6) then CurrentLayer:=Pattern1[Pattern1Index];
    if (Pattern1Index>=6) then CurrentLayer:=Pattern1Index;
    if (Pattern1Index<=0) then CurrentLayer:=0;

  end;

  if (Pattern2Run) then
  begin

    CounterLayer:=0;
    AllLayerDisable:=false;
    LastLayerActive:=false;
    for i := 1 to 5 do
    begin
      if(not Layer[i].Enable) then CounterLayer:=CounterLayer+1;
    end;
    if (CounterLayer=4) then LastLayerActive:=true;
    if (CounterLayer=5) then AllLayerDisable:=true;

    if(Pattern2Index=0)then begin Pattern2Index:=1; Layer[Pattern2[Pattern2Index]].Start:=true; end;
    if(AllLayerDisable)then begin Pattern2Index:=0; Layer[Pattern2[1]].Start:=false; end;

    EndLoop:=false;
    PreEndLoop:=false;
    i:=1;
    repeat

      if (Pattern2Index>0) and (Pattern2Index<9) then
      if ((Pattern2[Pattern2Index]=i) and Layer[i].Start) then
      begin
        if((not Layer[i].Enable) and Layer[i].Start) then
        begin
          Layer[i].Start:=false;
          Pattern2Index:=Pattern2Index+1;
          if (Pattern2Index<9) then begin Layer[Pattern2[Pattern2Index]].Start:=true; PreEndLoop:=true; end;
          if (Pattern2Index>=9) then begin Layer[6].Start:=true; PreEndLoop:=true; end;
        end;
        if(Layer[i].EndOfCounterDuration and Layer[i].Start) then
        begin
          Layer[i].Start:=false;
          Pattern2Index:=Pattern2Index+1;
          if (Pattern2Index<9) then begin Layer[Pattern2[Pattern2Index]].Start:=true; PreEndLoop:=true; end;
          if (Pattern2Index>=9) then begin Layer[6].Start:=true; PreEndLoop:=true; end;
        end;
      end;

      if (Pattern2Index<=0) or (Pattern2Index>=9) then PreEndLoop:=true;
      if (Pattern2Index>0) and (Pattern2Index<9) then
      if (Layer[Pattern2[Pattern2Index]].Enable) and (not Layer[Pattern2[Pattern2Index]].EndOfCounterDuration) and (Layer[Pattern2[Pattern2Index]].Start) then  PreEndLoop:=true;
      if (Pattern2Index>0) and (Pattern2Index<9) then
      if (not Layer[Pattern2[Pattern2Index]].Enable) and (Layer[Pattern2[Pattern2Index]].Start) then  PreEndLoop:=false;

      if (Pattern2Index>0) and (Pattern2Index<9) then
      Tempo:=Pattern2[Pattern2Index];

      i:=i+1;
      if i>8 then
      begin
        i:=1;
        if PreEndLoop then EndLoop:=true;
      end;
    until EndLoop;

    if ((Pattern2Index=9) and Layer[6].Start) then
    begin
      if(not LastLayerActive)then
      begin
        Layer[6].Start:=false;
        Pattern2Index:=0;
      end;
      if((not Layer[6].Enable) and Layer[6].Start) then
      begin
        Layer[6].Start:=false;
        Pattern2Index:=0;
      end;
      if(Layer[6].EndOfCounterDuration and Layer[6].Start) then
      begin
        Layer[6].Start:=false;
        Pattern2Index:=0;
      end;
    end;

    for i := 1 to 6 do
    begin
      if (Layer[i].CounterDurationTime_Act>=Layer[i].CounterDurationTime_Set) then
      begin
        Layer[i].EndOfCounterDuration:=true;
        Layer[i].UnderRunning:=false;
      end;
      if Layer[i].Start and Layer[i].Enable then
      begin
        if Layer[i].RunDurationTime_Act <= Layer[i].CounterDurationTime_Set then
        Layer[i].RunDurationTime_Act:=Layer[i].RunDurationTime_Act+1;
      end;
      if Layer[i].Start and Layer[i].Enable then
      if (Layer[i].CounterDurationTime_Act<Layer[i].CounterDurationTime_Set) then
      begin
        Layer[i].CounterDurationTime_Act:=Layer[i].CounterDurationTime_Act+1;
      end;
      if (Layer[i].CounterDurationTime_Act<Layer[i].CounterDurationTime_Set) then
      begin
        Layer[i].EndOfCounterDuration:=false;
        Layer[i].UnderRunning:=true;
      end;
      if (not Layer[i].Enable) or (not Layer[i].Start) then
      begin
        if (Pattern2Index>0) and (Pattern2Index<9) then  CurrentLayer:=Pattern2[Pattern2Index];
        if (Pattern2Index>0) and (Pattern2Index<9) then
        if (Pattern2[Pattern2Index] <> Layer[i].Index) then
        if (Layer[i].Start) then
        Layer[i].Start:=false;
        Layer[i].UnderRunning:=false;
        Layer[i].RunDurationTime_Act:=0;
        Layer[i].CounterDurationTime_Act:=0;
      end;
    end;

    if Pattern2Index=0 then
    begin
      Shape13.Top:=Shape1.Top;
    end;
    if (Pattern2Index>0) and (Pattern2Index<9) then
    if Pattern2[Pattern2Index]=1 then
    begin
      Shape13.Top:=Shape2.Top;
    end;
    if (Pattern2Index>0) and (Pattern2Index<9) then
    if Pattern2[Pattern2Index]=2 then
    begin
      Shape13.Top:=Shape3.Top;
    end;
    if (Pattern2Index>0) and (Pattern2Index<9) then
    if Pattern2[Pattern2Index]=3 then
    begin
      Shape13.Top:=Shape4.Top;
    end;
    if (Pattern2Index>0) and (Pattern2Index<9) then
    if Pattern2[Pattern2Index]=4 then
    begin
      Shape13.Top:=Shape5.Top;
    end;
    if (Pattern2Index>0) and (Pattern2Index<9) then
    if Pattern2[Pattern2Index]=5 then
    begin
      Shape13.Top:=Shape6.Top;
    end;
    if Pattern2Index=9 then
    begin
      Shape13.Top:=Shape7.Top;
    end;

    if (Pattern2Index>0) and (Pattern2Index<9) then CurrentLayer:=Pattern2[Pattern2Index];
    if (Pattern2Index>=9) then CurrentLayer:=Pattern2Index;
    if (Pattern2Index<=0) then CurrentLayer:=0;

  end;

  if CurrentLayer<>OldCurrentLayer then
  begin
    OldCurrentLayer:=CurrentLayer;
    EventsList.Add('Layer: '+OldCurrentLayer.ToString);
  end;
  if EventsList.Count > 13 then EventsList.Delete(0);
  Memo1.Lines.Assign(EventsList);

  if (Pattern1Run) then Label14.Caption:='Index: '+Pattern1Index.ToString;
  if (Pattern2Run) then Label14.Caption:='Index: '+Pattern2Index.ToString;
  if (Pattern1Run) then Label14.Caption:='Pattern1 Index: '+Pattern1Index.ToString+ ' Layer: ' + CurrentLayer.ToString;
  if (Pattern2Run) then Label14.Caption:='Pattern2 Index: '+Pattern2Index.ToString+ ' Layer: ' + CurrentLayer.ToString;

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
  Pattern2Run:=false;
  Pattern1Index:=0;
  Pattern2Index:=0;

  Label12.Caption:='Pattern1:' + chr(13);
  for i := 1 to 5 do
  begin
  Label12.Caption:=Label12.Caption+Pattern1[i].ToString;
  if i<5 then Label12.Caption:=Label12.Caption+', ';
  end;

  Label13.Caption:='Pattern2:' + chr(13);
  for i := 1 to 8 do
  begin
  Label13.Caption:=Label13.Caption+Pattern2[i].ToString;
  if i<8 then Label13.Caption:=Label13.Caption+', ';
  end;

  for i := 1 to 6 do
  begin
    Layer[i].Index:=i;
    Layer[i].Start:=false;
    Layer[i].UnderRunning:=false;
    Layer[i].EndOfCounterDuration:=false;
    Layer[i].CounterDurationTime_Act:=0;
    Layer[i].RunDurationTime_Act:=0;
  end;

  Layer[1].Enable:=CheckBox1.Checked;
  Layer[2].Enable:=CheckBox3.Checked;
  Layer[3].Enable:=CheckBox6.Checked;
  Layer[4].Enable:=CheckBox8.Checked;
  Layer[5].Enable:=CheckBox10.Checked;
  Layer[6].Enable:=CheckBox11.Checked;

  Layer[1].CounterDurationTime_Set:=SpinEdit1.Value;
  Layer[2].CounterDurationTime_Set:=SpinEdit2.Value;
  Layer[3].CounterDurationTime_Set:=SpinEdit3.Value;
  Layer[4].CounterDurationTime_Set:=SpinEdit4.Value;
  Layer[5].CounterDurationTime_Set:=SpinEdit5.Value;
  Layer[6].CounterDurationTime_Set:=SpinEdit6.Value;

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
    Button2.Enabled:=false;
    Pattern1Index:=0;
    for i := 1 to 6 do
    begin
      Layer[i].Start:=false;
      Layer[i].UnderRunning:=false;
      Layer[i].EndOfCounterDuration:=false;
      Layer[i].CounterDurationTime_Act:=0;
      Layer[i].RunDurationTime_Act:=0;
    end;
  end
  else
  begin
    Button2.Enabled:=true;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Pattern2Run:=not Pattern2Run;
  if (Pattern2Run) then
  begin
    Button1.Enabled:=false;
    Pattern2Index:=0;
  end
  else
  begin
    Button1.Enabled:=true;
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

