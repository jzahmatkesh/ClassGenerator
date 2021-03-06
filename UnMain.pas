unit UnMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, ADODB, Clipbrd;

type
  TFmMain = class(TForm)
    Label1: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    SpeedButton1: TSpeedButton;
    ADOQuery1: TADOQuery;
    Notebook1: TNotebook;
    Panel1: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BtnGenerator: TSpeedButton;
    Shape4: TShape;
    MemSql: TMemo;
    EDSchema: TEdit;
    EDTable: TEdit;
    EDIP: TEdit;
    EDUserName: TEdit;
    EDPassword: TEdit;
    EDDataBase: TEdit;
    RdJava: TRadioButton;
    RDFlutter: TRadioButton;
    MemResult: TMemo;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BtnGeneratorClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FmMain: TFmMain;

implementation

{$R *.dfm}

procedure TFmMain.BtnGeneratorClick(Sender: TObject);
begin
  try
    if Not ADOQuery1.Active then
      ADOQuery1.ConnectionString := 'Provider=SQLOLEDB.1;Password='+EDPassword.Text+';Persist Security Info=True;User ID='+EDUserName.Text+';Initial Catalog='+EDDataBase.Text+';Data Source='+EDIP.Text
    Else
      ADOQuery1.Close;
    ADOQuery1.Parameters[0].Value := EDSchema.Text;
    ADOQuery1.Parameters[1].Value := EDTable.Text;
    if RdJava.Checked then
      ADOQuery1.Parameters[2].Value := 1
    else
      ADOQuery1.Parameters[2].Value := 2;
    ADOQuery1.Parameters[3].Value := MemSql.Lines.Text;
    ADOQuery1.Open;
    MemResult.Lines.Clear;
    while Not ADOQuery1.Eof do
    Begin
      MemResult.Lines.Add(ADOQuery1.Fields[0].AsString);
      ADOQuery1.Next;
    End;
  Except
    On E:Exception do
      MemResult.Lines.Text := 'Error: '+e.ToString
  end;
  Notebook1.PageIndex := 1;
end;

procedure TFmMain.SpeedButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFmMain.SpeedButton2Click(Sender: TObject);
begin
  Notebook1.PageIndex := 0;
end;

procedure TFmMain.SpeedButton3Click(Sender: TObject);
begin
  Clipboard.AsText := MemResult.Lines.Text;
end;

end.
