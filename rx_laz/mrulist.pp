{*******************************************************}
{                                                       }
{         Delphi VCL Extensions (RX)                    }
{                                                       }
{         Copyright (c) 1997, 1998 Master-Bank          }
{                                                       }
{*******************************************************}

{$mode objfpc}
{$h+}

unit MRUList;

interface

uses SysUtils, Classes, LResources, Menus, IniFiles, Placement;

type
  TRecentStrings = class;

{ TMRUManager }

  TGetItemEvent = procedure (Sender: TObject; var ACaption: string;
    var ShortCut: TShortCut; UserData: Longint) of object;
  TReadItemEvent = procedure (Sender: TObject; IniFile: TCustomInifile;
    const Section: string; Index: Integer; var RecentName: string;
    var UserData: Longint) of object;
  TWriteItemEvent = procedure (Sender: TObject; IniFile: TCustomIniFile;
    const Section: string; Index: Integer; const RecentName: string;
    UserData: Longint) of object;
  TClickMenuEvent = procedure (Sender: TObject; const RecentName,
    ACaption: string; UserData: PtrInt) of object;

  TAccelDelimiter = (adTab, adSpace);
  TRecentMode = (rmInsert, rmAppend);

  TMRUManager = class(TComponent)
  private
    FList: TStrings;
    FItems: TList;
    FIniLink: TIniLink;
    FSeparateSize: Word;
    FAutoEnable: Boolean;
    FAutoUpdate: Boolean;
    FShowAccelChar: Boolean;
    FRemoveOnSelect: Boolean;
    FStartAccel: Cardinal;
    FAccelDelimiter: TAccelDelimiter;
    FRecentMenu: TMenuItem;
    FOnChange: TNotifyEvent;
    FOnGetItem: TGetItemEvent;
    FOnClick: TClickMenuEvent;
    FOnReadItem: TReadItemEvent;
    FOnWriteItem: TWriteItemEvent;
    procedure ListChanged(Sender: TObject);
    procedure ClearRecentMenu;
    procedure SetRecentMenu(Value: TMenuItem);
    procedure SetSeparateSize(Value: Word);
    function GetStorage: TFormPlacement;
    procedure SetStorage(Value: TFormPlacement);
    function GetCapacity: Integer;
    procedure SetCapacity(Value: Integer);
    function GetMode: TRecentMode;
    procedure SetMode(Value: TRecentMode);
    procedure SetStartAccel(Value: Cardinal);
    procedure SetShowAccelChar(Value: Boolean);
    procedure SetAccelDelimiter(Value: TAccelDelimiter);
    procedure SetAutoEnable(Value: Boolean);
    procedure AddMenuItem(Item: TMenuItem);
    procedure MenuItemClick(Sender: TObject);
    procedure IniSave(Sender: TObject);
    procedure IniLoad(Sender: TObject);
    procedure InternalLoad(Ini: TCustomInifile; const Section: string);
    procedure InternalSave(Ini: TCustomIniFile; const Section: string);
  protected
    procedure Change; dynamic;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoReadItem(Ini: TCustomIniFile; const Section: string;
      Index: Integer; var RecentName: string; var UserData: Longint); dynamic;
    procedure DoWriteItem(Ini: TCustomIniFile; const Section: string; Index: Integer;
      const RecentName: string; UserData: Longint); dynamic;
    procedure GetItemData(var Caption: string; var ShortCut: TShortCut;
      UserData: Longint); dynamic;
    procedure DoClick(const RecentName, Caption: string; UserData: PtrInt); dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Add(const RecentName: string; UserData: Longint);
    procedure Clear;
    procedure Remove(const RecentName: string);
    procedure UpdateRecentMenu;
    procedure LoadFromIni(Ini: TCustomIniFile; const Section: string);
    procedure SaveToIni(Ini: TCustomIniFile; const Section: string);
    property Strings: TStrings read FList;
  published
    property AccelDelimiter: TAccelDelimiter read FAccelDelimiter write SetAccelDelimiter default adTab;
    property AutoEnable: Boolean read FAutoEnable write SetAutoEnable default True;
    property AutoUpdate: Boolean read FAutoUpdate write FAutoUpdate default True;
    property Capacity: Integer read GetCapacity write SetCapacity default 10;
    property Mode: TRecentMode read GetMode write SetMode default rmInsert;
    property RemoveOnSelect: Boolean read FRemoveOnSelect write FRemoveOnSelect default False;
    property IniStorage: TFormPlacement read GetStorage write SetStorage;
    property SeparateSize: Word read FSeparateSize write SetSeparateSize default 0;
    property RecentMenu: TMenuItem read FRecentMenu write SetRecentMenu;
    property ShowAccelChar: Boolean read FShowAccelChar write SetShowAccelChar default True;
    property StartAccel: Cardinal read FStartAccel write SetStartAccel default 1;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnClick: TClickMenuEvent read FOnClick write FOnClick;
    property OnGetItemData: TGetItemEvent read FOnGetItem write FOnGetItem;
    property OnReadItem: TReadItemEvent read FOnReadItem write FOnReadItem;
    property OnWriteItem: TWriteItemEvent read FOnWriteItem write FOnWriteItem;
  end;

{ TRecentStrings }

  TRecentStrings = class(TStringList)
  private
    FMaxSize: Integer;
    FMode: TRecentMode;
    procedure SetMaxSize(Value: Integer);
  public
    constructor Create;
    function Add(const S: string): Integer; override;
    procedure AddStrings(NewStrings: TStrings); override;
    procedure DeleteExceed;
    procedure Remove(const S: String);
    property MaxSize: Integer read FMaxSize write SetMaxSize;
    property Mode: TRecentMode read FMode write FMode;
  end;

Procedure Register;

implementation

{$R mrulist.res}

uses Controls, AppUtils;

const
  siRecentItem = 'Item_%d';
  siRecentData = 'User_%d';

Procedure Register;

begin
 RegisterComponents('RX Controls',[TMRUManager]);
end;


{ TMRUManager }

constructor TMRUManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FList := TRecentStrings.Create;
  FItems := TList.Create;
  TRecentStrings(FList).OnChange := @ListChanged;
  FIniLink := TIniLink.Create;
  FIniLink.OnSave := @IniSave;
  FIniLink.OnLoad := @IniLoad;
  FAutoUpdate := True;
  FAutoEnable := True;
  FShowAccelChar := True;
  FStartAccel := 1;
end;

destructor TMRUManager.Destroy;
begin
  ClearRecentMenu;
  FIniLink.Free;
  TRecentStrings(FList).OnChange := nil;
  FList.Free;
  FItems.Free;
  FItems := nil;
  inherited Destroy;
end;

procedure TMRUManager.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent = RecentMenu) and (Operation = opRemove) then
    RecentMenu := nil;
end;

procedure TMRUManager.GetItemData(var Caption: string; var ShortCut: TShortCut;
  UserData: Longint);
begin
  if Assigned(FOnGetItem) then FOnGetItem(Self, Caption, ShortCut, UserData);
end;

procedure TMRUManager.DoClick(const RecentName, Caption: string; UserData: PtrInt);
begin
  if Assigned(FOnClick) then FOnClick(Self, RecentName, Caption, UserData);
end;

procedure TMRUManager.MenuItemClick(Sender: TObject);
var
  I: Integer;
begin
  if Sender is TMenuItem then begin
    I := TMenuItem(Sender).Tag;
    if (I >= 0) and (I < FList.Count) then
      try
        DoClick(FList[I], TMenuItem(Sender).Caption, PtrInt(FList.Objects[I]));
      finally
        if RemoveOnSelect then Remove(FList[I]);
      end;
  end;
end;

function TMRUManager.GetCapacity: Integer;
begin
  Result := TRecentStrings(FList).MaxSize;
end;

procedure TMRUManager.SetCapacity(Value: Integer);
begin
  TRecentStrings(FList).MaxSize := Value;
end;

function TMRUManager.GetMode: TRecentMode;
begin
  Result := TRecentStrings(FList).Mode;
end;

procedure TMRUManager.SetMode(Value: TRecentMode);
begin
  TRecentStrings(FList).Mode := Value;
end;

function TMRUManager.GetStorage: TFormPlacement;
begin
  Result := FIniLink.Storage;
end;

procedure TMRUManager.SetStorage(Value: TFormPlacement);
begin
  FIniLink.Storage := Value;
end;

procedure TMRUManager.SetAutoEnable(Value: Boolean);
begin
  if FAutoEnable <> Value then begin
    FAutoEnable := Value;
    if Assigned(FRecentMenu) and FAutoEnable then
      FRecentMenu.Enabled := FRecentMenu.Count > 0;
  end;
end;

procedure TMRUManager.SetStartAccel(Value: Cardinal);
begin
  if FStartAccel <> Value then begin
    FStartAccel := Value;
    if FAutoUpdate then UpdateRecentMenu;
  end;
end;

procedure TMRUManager.SetAccelDelimiter(Value: TAccelDelimiter);
begin
  if FAccelDelimiter <> Value then begin
    FAccelDelimiter := Value;
    if FAutoUpdate and ShowAccelChar then UpdateRecentMenu;
  end;
end;

procedure TMRUManager.SetShowAccelChar(Value: Boolean);
begin
  if FShowAccelChar <> Value then begin
    FShowAccelChar := Value;
    if FAutoUpdate then UpdateRecentMenu;
  end;
end;

procedure TMRUManager.Add(const RecentName: string; UserData: Longint);
begin
  FList.AddObject(RecentName, TObject(PtrInt(UserData)));
end;

procedure TMRUManager.Clear;
begin
  FList.Clear;
end;

procedure TMRUManager.Remove(const RecentName: string);
begin
  TRecentStrings(FList).Remove(RecentName);
end;

procedure TMRUManager.AddMenuItem(Item: TMenuItem);
begin
  if Assigned(Item) then begin
    FRecentMenu.Add(Item);
    FItems.Add(Item);
  end;
end;

{ Must be moved to Controls}
Function GetShortHint(const Hint: WideString): WideString;
var
  I: Integer;
begin
  I := Pos('|', Hint);
  if I = 0 then
    Result := Hint
  else
    Result := Copy(Hint, 1, I - 1);
end;
function GetLongHint(const Hint: WideString): WideString;
var
  I: Integer;
begin
  I := Pos('|', Hint);
  if I = 0 then
    Result := Hint
  else
    Result := Copy(Hint, I + 1, Maxint);
end;

{ Must be moved to Menus}
function NewLine: TMenuItem;
begin
  Result := TMenuItem.Create(nil);
  Result.Caption := '-';
end;

function NewItem(const ACaption: WideString; AShortCut: TShortCut;
  AChecked, AEnabled: Boolean; AOnClick: TNotifyEvent; hCtx: THelpContext;
  const AName: string): TMenuItem;
begin
  Result := TMenuItem.Create(nil);
  with Result do
  begin
    Caption := ACaption;
    ShortCut := AShortCut;
    OnClick := AOnClick;
    HelpContext := hCtx;
    Checked := AChecked;
    Enabled := AEnabled;
    Name := AName;
  end;
end;


procedure TMRUManager.UpdateRecentMenu;
const
  AccelDelimChars: array[TAccelDelimiter] of Char = (#9, ' ');
var
  I: Integer;
  L: Cardinal;
  S: string;
  C: string[2];
  ShortCut: TShortCut;
  Item: TMenuItem;
begin
  ClearRecentMenu;
  if Assigned(FRecentMenu) then begin
    if (FList.Count > 0) and (FRecentMenu.Count > 0) then
      AddMenuItem(NewLine);
    for I := 0 to FList.Count - 1 do begin
      if (FSeparateSize > 0) and (I > 0) and (I mod FSeparateSize = 0) then
        AddMenuItem(NewLine);
      S := FList[I];
      ShortCut := scNone;
      GetItemData(S, ShortCut, Longint(PtrInt(FList.Objects[I])));
      Item := NewItem(GetShortHint(S), ShortCut, False, True,
        @MenuItemClick, 0, '');
      Item.Hint := GetLongHint(S);
      if FShowAccelChar then begin
        L := Cardinal(I) + FStartAccel;
        if L < 10 then
          C := '&' + Char(Ord('0') + L)
        else if L <= (Ord('Z') + 10) then
          C := '&' + Char(L + Ord('A') - 10)
        else
          C := ' ';
        Item.Caption := C + AccelDelimChars[FAccelDelimiter] + Item.Caption;
      end;
      Item.Tag := I;
      AddMenuItem(Item);
    end;
    if AutoEnable then FRecentMenu.Enabled := FRecentMenu.Count > 0;
  end;
end;

procedure TMRUManager.ClearRecentMenu;
var
  Item: TMenuItem;
begin
  while FItems.Count > 0 do begin
    Item := TMenuItem(FItems.Last);
    if Assigned(FRecentMenu) and (FRecentMenu.IndexOf(Item) >= 0) then
      Item.Free;
    FItems.Remove(Item);
  end;
  if Assigned(FRecentMenu) and AutoEnable then
    FRecentMenu.Enabled := FRecentMenu.Count > 0;
end;

procedure TMRUManager.SetRecentMenu(Value: TMenuItem);
begin
  ClearRecentMenu;
  FRecentMenu := Value;
{$IFDEF MSWINDOWS}
  if Value <> nil then Value.FreeNotification(Self);
{$ENDIF}
  UpdateRecentMenu;
end;

procedure TMRUManager.SetSeparateSize(Value: Word);
begin
  if FSeparateSize <> Value then begin
    FSeparateSize := Value;
    if FAutoUpdate then UpdateRecentMenu;
  end;
end;

procedure TMRUManager.ListChanged(Sender: TObject);
begin
  if Sender=nil then ;
  Change;
  if FAutoUpdate then UpdateRecentMenu;
end;

procedure TMRUManager.IniSave(Sender: TObject);
begin
  if Sender=nil then ;
  if (Name <> '') and (FIniLink.IniObject <> nil) then
    InternalSave(FIniLink.IniObject, FIniLink.RootSection +
      GetDefaultSection(Self));
end;

procedure TMRUManager.IniLoad(Sender: TObject);
begin
  if Sender=nil then ;
  if (Name <> '') and (FIniLink.IniObject <> nil) then
    InternalLoad(FIniLink.IniObject, FIniLink.RootSection +
      GetDefaultSection(Self));
end;

procedure TMRUManager.Change;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TMRUManager.DoReadItem(Ini: TCustomIniFile; const Section: string;
  Index: Integer; var RecentName: string; var UserData: Longint);
begin
  if Assigned(FOnReadItem) then
    FOnReadItem(Self, Ini, Section, Index, RecentName, UserData)
  else begin
    RecentName := Ini.ReadString( Section, Format(siRecentItem, [Index]), RecentName);
    UserData := Ini.ReadInteger( Section, Format(siRecentData, [Index]), UserData);
  end;
end;

procedure TMRUManager.DoWriteItem(Ini: TCustomIniFile; const Section: string;
  Index: Integer; const RecentName: string; UserData: Longint);
begin
  if Assigned(FOnWriteItem) then
    FOnWriteItem(Self, Ini, Section, Index, RecentName, UserData)
  else begin
    Ini.WriteString(Section, Format(siRecentItem, [Index]), RecentName);
    if UserData = 0 then
      Ini.DeleteKey(Section, Format(siRecentData, [Index]))
    else
      Ini.WriteInteger(Section, Format(siRecentData, [Index]), UserData);
  end;
end;

procedure TMRUManager.InternalLoad(Ini: TCustomIniFile; const Section: string);
var
  I: Integer;
  S: string;
  UserData: Longint;
  AMode: TRecentMode;
begin
  AMode := Mode;
  FList.BeginUpdate;
  try
    FList.Clear;
    Mode := rmInsert;
    for I := TRecentStrings(FList).MaxSize - 1 downto 0 do begin
      S := '';
      UserData := 0;
      DoReadItem(Ini,Section, I, S, UserData);
      if S <> '' then Add(S, UserData);
    end;
  finally
    Mode := AMode;
    FList.EndUpdate;
  end;
end;

procedure TMRUManager.InternalSave(Ini: TCustomInifile; const Section: string);
var
  I: Integer;
begin
  Ini.EraseSection(Section);
  for I := 0 to FList.Count - 1 do
    DoWriteItem(Ini, Section, I, FList[I], Longint(PtrInt(FList.Objects[I])));
end;

procedure TMRUManager.LoadFromIni(Ini: TCustomIniFile; const Section: string);
begin
  InternalLoad(Ini, Section);
end;

procedure TMRUManager.SaveToIni(Ini: TCustomIniFile; const Section: string);
begin
  InternalSave(Ini, Section);
end;

{ TRecentStrings }

constructor TRecentStrings.Create;
begin
  inherited Create;
  FMaxSize := 10;
  FMode := rmInsert;
end;

Function Max(A,B : Integer) : Integer;

begin
  If A>B then
    Result:=A
  else
    Result:=B;
end;

Function Min(A,B : Integer) : Integer;

begin
  If A>B then
    Result:=B
  else
    Result:=A;
end;

procedure TRecentStrings.SetMaxSize(Value: Integer);
begin
  if FMaxSize <> Value then begin
    FMaxSize := Max(1, Value);
    DeleteExceed;
  end;
end;

procedure TRecentStrings.DeleteExceed;
var
  I: Integer;
begin
  BeginUpdate;
  try
    if FMode = rmInsert then begin
      for I := Count - 1 downto FMaxSize do Delete(I);
    end
    else begin { rmAppend }
      while Count > FMaxSize do Delete(0);
    end;
  finally
    EndUpdate;
  end;
end;

procedure TRecentStrings.Remove(const S: String);
var
  I: Integer;
begin
  I := IndexOf(S);
  if I >= 0 then Delete(I);
end;

function TRecentStrings.Add(const S: String): Integer;
begin
  Result := IndexOf(S);
  if Result >= 0 then begin
    if FMode = rmInsert then Move(Result, 0)
    else { rmAppend } Move(Result, Count - 1);
  end
  else begin
    BeginUpdate;
    try
      if FMode = rmInsert then Insert(0, S)
      else { rmAppend } Insert(Count, S);
      DeleteExceed;
    finally
      EndUpdate;
    end;
  end;
  if FMode = rmInsert then Result := 0
  else { rmAppend } Result := Count - 1;
end;

procedure TRecentStrings.AddStrings(NewStrings: TStrings);
var
  I: Integer;
begin
  BeginUpdate;
  try
    if FMode = rmInsert then begin
      for I := Min(NewStrings.Count, FMaxSize) - 1 downto 0 do
        AddObject(NewStrings[I], NewStrings.Objects[I]);
    end
    else begin { rmAppend }
      for I := 0 to Min(NewStrings.Count, FMaxSize) - 1 do
        AddObject(NewStrings[I], NewStrings.Objects[I]);
    end;
    DeleteExceed;
  finally
    EndUpdate;
  end;
end;

end.
