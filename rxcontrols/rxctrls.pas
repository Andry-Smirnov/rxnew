{ rxctrls unit

  Copyright (C) 2005-2021 Lagunov Aleksey alexs75@yandex.ru and Lazarus team
  original conception from rx library for Delphi (c)

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version with the following modification:

  As a special exception, the copyright holders of this library give you
  permission to link this library with independent modules to produce an
  executable, regardless of the license terms of these independent modules,and
  to copy and distribute the resulting executable under terms of your choice,
  provided that you also meet, for each linked independent module, the terms
  and conditions of the license of that module. An independent module is a
  module which is not derived from or based on this library. If you modify
  this library, you may extend this exception to your version of the library,
  but you are not obligated to do so. If you do not wish to do so, delete this
  exception statement from your version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

unit rxctrls;

{$I rx.inc}

interface

uses LResources, LCLType, LCLIntf, LMessages, Classes, Controls, Graphics,
  StdCtrls, ExtCtrls, Forms, Buttons, Menus, RxConst, IniFiles, GraphType
  {, Placemnt};

type
  TPositiveInt = 1..MaxInt;

(*
{ TTextListBox }

  TTextListBox = class(TCustomListBox)
  private
    FMaxWidth: Integer;
{$IFNDEF WIN32}
    FTabWidth: Integer;
    procedure SetTabWidth(Value: Integer);
{$ENDIF}
    procedure ResetHorizontalExtent;
    procedure SetHorizontalExtent;
    function GetItemWidth(Index: Integer): Integer;
  protected
{$IFNDEF WIN32}
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
{$ENDIF}
    procedure WndProc(var Message: TMessage); override;
  published
    property Align;
    property BorderStyle;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property IntegralHeight;
{$IFDEF RX_D4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
{$IFDEF WIN32}
  {$IFNDEF VER90}
    property ImeMode;
    property ImeName;
  {$ENDIF}
{$ENDIF}
    property ItemHeight;
    property Items;
    property MultiSelect;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
{$IFDEF WIN32}
    property TabWidth;
{$ELSE}
    property TabWidth: Integer read FTabWidth write SetTabWidth default 0;
{$ENDIF}
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF WIN32}
    property OnStartDrag;
{$ENDIF}
{$IFDEF RX_D5}
    property OnContextPopup;
{$ENDIF}
{$IFDEF RX_D4}
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

{ TRxCustomListBox }

  TGetItemWidthEvent = procedure(Control: TWinControl; Index: Integer;
    var Width: Integer) of object;

  TRxCustomListBox = class(TWinControl)
  private
    FItems: TStrings;
    FBorderStyle: TBorderStyle;
    FCanvas: TCanvas;
    FColumns: Integer;
    FItemHeight: Integer;
    FStyle: TListBoxStyle;
    FIntegralHeight: Boolean;
    FMultiSelect: Boolean;
    FSorted: Boolean;
    FExtendedSelect: Boolean;
    FTabWidth: Integer;
    FSaveItems: TStringList;
    FSaveTopIndex: Integer;
    FSaveItemIndex: Integer;
    FAutoScroll: Boolean;
    FGraySelection: Boolean;
    FMaxItemWidth: Integer;
    FOnDrawItem: TDrawItemEvent;
    FOnMeasureItem: TMeasureItemEvent;
    FOnGetItemWidth: TGetItemWidthEvent;
    procedure ResetHorizontalExtent;
    procedure SetHorizontalExtent;
    function GetAutoScroll: Boolean;
    function GetItemHeight: Integer; virtual;
    function GetItemIndex: Integer;
    function GetSelCount: Integer;
    function GetSelected(Index: Integer): Boolean;
    function GetTopIndex: Integer;
    procedure SetAutoScroll(Value: Boolean);
    procedure SetBorderStyle(Value: TBorderStyle);
    procedure SetColumnWidth;
    procedure SetColumns(Value: Integer);
    procedure SetExtendedSelect(Value: Boolean);
    procedure SetIntegralHeight(Value: Boolean);
    procedure SetItemHeight(Value: Integer);
    procedure SetItemIndex(Value: Integer);
    procedure SetMultiSelect(Value: Boolean);
    procedure SetSelected(Index: Integer; Value: Boolean);
    procedure SetSorted(Value: Boolean);
    procedure SetStyle(Value: TListBoxStyle);
    procedure SetTabWidth(Value: Integer);
    procedure SetTopIndex(Value: Integer);
    procedure SetGraySelection(Value: Boolean);
    procedure SetOnDrawItem(Value: TDrawItemEvent);
    procedure SetOnGetItemWidth(Value: TGetItemWidthEvent);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
{$IFDEF WIN32}
//    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
{$ENDIF}
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function CreateItemList: TStrings; virtual;
    function GetItemWidth(Index: Integer): Integer; virtual;
    procedure WndProc(var Message: TMessage); override;
    procedure DragCanceled; override;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); virtual;
    procedure MeasureItem(Index: Integer; var Height: Integer); virtual;
    function GetItemData(Index: Integer): Longint; dynamic;
    procedure SetItemData(Index: Integer; AData: LongInt); dynamic;
    procedure SetItems(Value: TStrings); virtual;
    procedure ResetContent; dynamic;
    procedure DeleteString(Index: Integer); dynamic;
    property AutoScroll: Boolean read GetAutoScroll write SetAutoScroll default False;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Columns: Integer read FColumns write SetColumns default 0;
    property ExtendedSelect: Boolean read FExtendedSelect write SetExtendedSelect default True;
    property GraySelection: Boolean read FGraySelection write SetGraySelection default False;
    property IntegralHeight: Boolean read FIntegralHeight write SetIntegralHeight default False;
    property ItemHeight: Integer read GetItemHeight write SetItemHeight;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelect default False;
    property ParentColor default False;
    property Sorted: Boolean read FSorted write SetSorted default False;
    property Style: TListBoxStyle read FStyle write SetStyle default lbStandard;
    property TabWidth: Integer read FTabWidth write SetTabWidth default 0;
    property OnDrawItem: TDrawItemEvent read FOnDrawItem write SetOnDrawItem;
    property OnMeasureItem: TMeasureItemEvent read FOnMeasureItem write FOnMeasureItem;
    property OnGetItemWidth: TGetItemWidthEvent read FOnGetItemWidth write SetOnGetItemWidth;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    procedure DefaultDrawText(X, Y: Integer; const S: string);
    function ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
    function ItemRect(Index: Integer): TRect;
    property Canvas: TCanvas read FCanvas;
    property Items: TStrings read FItems write SetItems;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
    property SelCount: Integer read GetSelCount;
    property Selected[Index: Integer]: Boolean read GetSelected write SetSelected;
    property TopIndex: Integer read GetTopIndex write SetTopIndex;
  published
    property TabStop default True;
  end;

{ TRxCheckListBox }

  TCheckKind = (ckCheckBoxes, ckRadioButtons, ckCheckMarks);
  TChangeStateEvent = procedure (Sender: TObject; Index: Integer) of object;

  TRxCheckListBox = class(TRxCustomListBox)
  private
    FAllowGrayed: Boolean;
    FCheckKind: TCheckKind;
    FSaveStates: TList;
    FDrawBitmap: TBitmap;
    FCheckWidth, FCheckHeight: Integer;
    FReserved: Integer;
    FInUpdateStates: Boolean;
    FIniLink: TIniLink;
    FOnClickCheck: TNotifyEvent;
    FOnStateChange: TChangeStateEvent;
    procedure ResetItemHeight;
    function GetItemHeight: Integer; override;
    procedure DrawCheck(R: TRect; AState: TCheckBoxState; Enabled: Boolean);
    procedure SetCheckKind(Value: TCheckKind);
    procedure SetChecked(Index: Integer; AChecked: Boolean);
    function GetChecked(Index: Integer): Boolean;
    procedure SetState(Index: Integer; AState: TCheckBoxState);
    function GetState(Index: Integer): TCheckBoxState;
    procedure SetItemEnabled(Index: Integer; Value: Boolean);
    function GetItemEnabled(Index: Integer): Boolean;
    function GetAllowGrayed: Boolean;
    procedure ToggleClickCheck(Index: Integer);
    procedure InvalidateCheck(Index: Integer);
    procedure InvalidateItem(Index: Integer);
    function CreateCheckObject(Index: Integer): TObject;
    function FindCheckObject(Index: Integer): TObject;
    function GetCheckObject(Index: Integer): TObject;
    function IsCheckObject(Index: Integer): Boolean;
    procedure ReadVersion(Reader: TReader);
    procedure WriteVersion(Writer: TWriter);
    procedure ReadCheckData(Reader: TReader);
    procedure WriteCheckData(Writer: TWriter);
    procedure InternalSaveStates(IniFile: TObject; const Section: string);
    procedure InternalRestoreStates(IniFile: TObject; const Section: string);
    function GetStorage: TFormPlacement;
    procedure SetStorage(Value: TFormPlacement);
    procedure IniSave(Sender: TObject);
    procedure IniLoad(Sender: TObject);
    procedure UpdateCheckStates;
    function GetCheckedIndex: Integer;
    procedure SetCheckedIndex(Value: Integer);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    function CreateItemList: TStrings; override;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure DefineProperties(Filer: TFiler); override;
    function GetItemWidth(Index: Integer): Integer; override;
    function GetItemData(Index: Integer): LongInt; override;
    procedure SetItemData(Index: Integer; AData: LongInt); override;
    procedure KeyPress(var Key: Char); override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure ResetContent; override;
    procedure DeleteString(Index: Integer); override;
    procedure ClickCheck; dynamic;
    procedure ChangeItemState(Index: Integer); dynamic;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    procedure WMDestroy(var Msg: TWMDestroy); message WM_DESTROY;
    function GetCheckWidth: Integer;
    procedure SetItems(Value: TStrings); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
{$IFDEF WIN32}
    procedure SaveStatesReg(IniFile: TRegIniFile);
    procedure RestoreStatesReg(IniFile: TRegIniFile);
{$ENDIF WIN32}
    procedure SaveStates(IniFile: TIniFile);
    procedure RestoreStates(IniFile: TIniFile);
    procedure ApplyState(AState: TCheckBoxState; EnabledOnly: Boolean);
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property State[Index: Integer]: TCheckBoxState read GetState write SetState;
    property EnabledItem[Index: Integer]: Boolean read GetItemEnabled write SetItemEnabled;
  published
    property AllowGrayed: Boolean read GetAllowGrayed write FAllowGrayed default False;
    property CheckKind: TCheckKind read FCheckKind write SetCheckKind default ckCheckBoxes;
    property CheckedIndex: Integer read GetCheckedIndex write SetCheckedIndex default -1;
    property IniStorage: TFormPlacement read GetStorage write SetStorage;
    property Align;
    property AutoScroll default True;
    property BorderStyle;
    property Color;
    property Columns;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property GraySelection;
{$IFDEF RX_D4}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
{$ENDIF}
{$IFDEF WIN32}
  {$IFNDEF VER90}
    property ImeMode;
    property ImeName;
  {$ENDIF}
{$ENDIF}
    property IntegralHeight;
    property ItemHeight;
    property Items stored False;
    property MultiSelect;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabWidth;
    property Visible;
    property OnStateChange: TChangeStateEvent read FOnStateChange write FOnStateChange;
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetItemWidth;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF WIN32}
    property OnStartDrag;
{$ENDIF}
{$IFDEF RX_D5}
    property OnContextPopup;
{$ENDIF}
{$IFDEF RX_D4}
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;
*)
const
  clbDefaultState = cbUnchecked;
  clbDefaultEnabled = True;

  { TRxCustomLabel }

type
  TShadowPosition = (spLeftTop, spLeftBottom, spRightBottom, spRightTop);
  {$IFNDEF RX_D3}
  TTextLayout = (tlTop, tlCenter, tlBottom);
  {$ENDIF}

  TRxCustomLabel = class(TGraphicControl)
  private
    FFocusControl: TWinControl;
    FAlignment: TAlignment;
    FAutoSize: boolean;
    FLayout: TTextLayout;
    FShadowColor: TColor;
    FShadowSize: byte;
    FShadowPos: TShadowPosition;
    FWordWrap: boolean;
    FShowAccelChar: boolean;
    FShowFocus: boolean;
    FFocused: boolean;
    FMouseInControl: boolean;
    FDragging: boolean;
    FLeftMargin: integer;
    FRightMargin: integer;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    procedure DoDrawText(var Rect: TRect; Flags: word);
    function GetTransparent: boolean;
    procedure UpdateTracking;
    procedure SetAlignment(Value: TAlignment);
    {$IFNDEF RX_D6}
    procedure SetAutoSize(Value: boolean);
    {$ENDIF}
    procedure SetFocusControl(Value: TWinControl);
    procedure SetLayout(Value: TTextLayout);
    procedure SetLeftMargin(Value: integer);
    procedure SetRightMargin(Value: integer);
    procedure SetShadowColor(Value: TColor);
    procedure SetShadowSize(Value: byte);
    procedure SetShadowPos(Value: TShadowPosition);
    procedure SetShowAccelChar(Value: boolean);
    procedure SetTransparent(Value: boolean);
    procedure SetWordWrap(Value: boolean);
    procedure SetShowFocus(Value: boolean);
    procedure CMTextChanged(var Message: TLMessage); message CM_TEXTCHANGED;
    procedure CMFocusChanged(var Message: TLMessage); message CM_FOCUSCHANGED;
    procedure CMFontChanged(var Message: TLMessage); message CM_FONTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TLMessage); message CM_ENABLEDCHANGED;
    procedure CMMouseEnter(var Message: TLMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TLMessage); message CM_MOUSELEAVE;
    procedure CMVisibleChanged(var Message: TLMessage); message CM_VISIBLECHANGED;
(*
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure WMRButtonUp(var Message: TWMRButtonUp); message WM_RBUTTONUP;
*)
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer); override;
    //    procedure SetAutoSize(Value: Boolean); override;
    procedure AdjustBounds;
    function GetDefaultFontColor: TColor; virtual;
    function GetLabelCaption: string; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
    procedure MouseEnter; dynamic;
    procedure MouseLeave; dynamic;
    property Alignment: TAlignment read FAlignment write SetAlignment default
      taLeftJustify;
    property AutoSize: boolean read FAutoSize write SetAutoSize default True;
    property FocusControl: TWinControl read FFocusControl write SetFocusControl;
    property Layout: TTextLayout read FLayout write SetLayout default tlTop;
    property LeftMargin: integer read FLeftMargin write SetLeftMargin default 0;
    property RightMargin: integer read FRightMargin write SetRightMargin default 0;
    property ShadowColor: TColor read FShadowColor write SetShadowColor default
      clBtnHighlight;
    property ShadowSize: byte read FShadowSize write SetShadowSize default 1;
    property ShadowPos: TShadowPosition
      read FShadowPos write SetShadowPos default spLeftTop;
    property ShowAccelChar: boolean
      read FShowAccelChar write SetShowAccelChar default True;
    property ShowFocus: boolean read FShowFocus write SetShowFocus default False;
    property Transparent: boolean read GetTransparent write SetTransparent default False;
    property WordWrap: boolean read FWordWrap write SetWordWrap default False;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
  public
    constructor Create(AOwner: TComponent); override;
    property Canvas;
    property MouseInControl: boolean read FMouseInControl;
  end;

  { TRxLabel }

  TRxLabel = class(TRxCustomLabel)
  published
    property Align;
    property Alignment;
    property AutoSize;
    property Caption;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property Anchors;
    property Constraints;
    property DragKind;
    {$IFDEF RX_D4}
    property BiDiMode;
    property ParentBiDiMode;
    {$ENDIF}
    property BorderSpacing;
    property Layout;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShadowColor;
    property ShadowSize;
    property ShadowPos;
    property ShowAccelChar;
    property ShowFocus;
    property ShowHint;
    property Transparent;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDrag;
    property OnContextPopup;
    property OnEndDock;
    property OnStartDock;
  end;


  { TSecretPanel }

  TGlyphLayout = (glGlyphLeft, glGlyphRight, glGlyphTop, glGlyphBottom);
  TScrollDirection = (sdVertical, sdHorizontal);
  TPanelDrawEvent = procedure(Sender: TObject; Canvas: TCanvas;
    Rect: TRect) of object;

  TSecretPanel = class(TCustomPanel)
  private
    FActive: boolean;
    FAlignment: TAlignment;
    FLines: TStrings;
    FCycled: boolean;
    FScrollCnt: integer;
    FMaxScroll: integer;
    FTxtDivider: byte;
    FFirstLine: integer;
    FTimer: TTimer;
    FTxtRect: TRect;
    FPaintRect: TRect;
    FGlyphOrigin: TPoint;
    FMemoryImage: TBitmap;
    FGlyph: TBitmap;
    FHiddenList: TList;
    FTextStyle: TPanelBevel;
    FDirection: TScrollDirection;
    FGlyphLayout: TGlyphLayout;
    FOnPaintClient: TPanelDrawEvent;
    FOnStartPlay: TNotifyEvent;
    FOnStopPlay: TNotifyEvent;
    FAsyncDrawing: boolean;
    procedure SetAsyncDrawing(Value: boolean);
    function GetInflateWidth: integer;
    function GetInterval: cardinal;
    procedure SetInterval(Value: cardinal);
    procedure SetGlyph(Value: TBitmap);
    procedure SetLines(Value: TStrings);
    procedure SetActive(Value: boolean);
    procedure SetAlignment(Value: TAlignment);
    procedure SetGlyphLayout(Value: TGlyphLayout);
    procedure SetTextStyle(Value: TPanelBevel);
    procedure SetDirection(Value: TScrollDirection);
    procedure RecalcDrawRect;
    procedure PaintGlyph;
    procedure PaintText;
    procedure UpdateMemoryImage;
    procedure GlyphChanged(Sender: TObject);
    procedure LinesChanged(Sender: TObject);
    procedure CMFontChanged(var Message: TLMessage); message CM_FONTCHANGED;
    procedure CMColorChanged(var Message: TLMessage); message CM_COLORCHANGED;
    //    procedure WMSize(var Message: TLMessage); message LM_SIZE;
    procedure WMSize(var Message: TLMSize); message LM_SIZE;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure Paint; override;
    procedure PaintClient(ACanvas: TCanvas; Rect: TRect); virtual;
    procedure TimerExpired(Sender: TObject); virtual;
    procedure StartPlay; dynamic;
    procedure StopPlay; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Play;
    procedure Stop;
    property Canvas;
  published
    property AsyncDrawing: boolean read FAsyncDrawing write SetAsyncDrawing default True;
    property Active: boolean read FActive write SetActive default False;
    property Alignment: TAlignment read FAlignment write SetAlignment default taCenter;
    property Cycled: boolean read FCycled write FCycled default False;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GlyphLayout: TGlyphLayout
      read FGlyphLayout write SetGlyphLayout default glGlyphLeft;
    property Interval: cardinal read GetInterval write SetInterval default 30;
    property Lines: TStrings read FLines write SetLines;
    property ScrollDirection: TScrollDirection
      read FDirection write SetDirection default sdVertical;
    property TextStyle: TPanelBevel read FTextStyle write SetTextStyle default bvNone;
    property Anchors;
    property Constraints;
    property DragKind;
    {$IFDEF RX_D4}
    property BiDiMode;
    property ParentBiDiMode;
    {$ENDIF}
    property Align;
    property BevelInner;
    property BevelOuter default bvLowered;
    property BevelWidth;
    property BorderWidth;
    property BorderStyle;
    property DragCursor;
    property DragMode;
    property Color;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnPaintClient: TPanelDrawEvent read FOnPaintClient write FOnPaintClient;
    property OnStartPlay: TNotifyEvent read FOnStartPlay write FOnStartPlay;
    property OnStopPlay: TNotifyEvent read FOnStopPlay write FOnStopPlay;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnStartDrag;
    property OnContextPopup;
    property OnEndDock;
    property OnStartDock;
    property OnResize;
  end;

  { TRxSpeedButton }
(*

  TRxNumGlyphs = 1..5;
  TRxDropDownMenuPos = (dmpBottom, dmpRight);
  TRxButtonState = (rbsUp, rbsDisabled, rbsDown, rbsExclusive, rbsInactive);
*)

  TRxSpeedButton = class(TSpeedButton)
  private
    FAllowTimer: boolean;
    FInitRepeatPause: word;
    FRepeatPause: word;
    FRepeatTimer: TTimer;
    procedure SetAllowTimer(const AValue: boolean);
    procedure TimerExpired(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AllowTimer: boolean read FAllowTimer write SetAllowTimer default False;
    property InitPause: word read FInitRepeatPause write FInitRepeatPause default 500;
    property RepeatInterval: word read FRepeatPause write FRepeatPause default 100;
  end;

(*
{ TButtonImage }

  TButtonImage = class(TObject)
  private
    FGlyph: TObject;
    FButtonSize: TPoint;
    FCaption: TCaption;
    function GetNumGlyphs: TRxNumGlyphs;
    procedure SetNumGlyphs(Value: TRxNumGlyphs);
    function GetWordWrap: Boolean;
    procedure SetWordWrap(Value: Boolean);
    function GetAlignment: TAlignment;
    procedure SetAlignment(Value: TAlignment);
    function GetGlyph: TBitmap;
    procedure SetGlyph(Value: TBitmap);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Invalidate;
{$IFDEF WIN32}
    procedure DrawEx(Canvas: TCanvas; X, Y, Margin, Spacing: Integer;
      Layout: TButtonLayout; AFont: TFont; Images: TImageList;
      ImageIndex: Integer; Flags: Word);
{$ENDIF}
    procedure Draw(Canvas: TCanvas; X, Y, Margin, Spacing: Integer;
      Layout: TButtonLayout; AFont: TFont; Flags: Word);
    property Alignment: TAlignment read GetAlignment write SetAlignment;
    property Caption: TCaption read FCaption write FCaption;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property NumGlyphs: TRxNumGlyphs read GetNumGlyphs write SetNumGlyphs;
    property ButtonSize: TPoint read FButtonSize write FButtonSize;
    property WordWrap: Boolean read GetWordWrap write SetWordWrap;
  end;

{ TRxButtonGlyph }

  TRxButtonGlyph = class
  private
    FOriginal: TBitmap;
    FGlyphList: TImageList;
    FIndexs: array[TRxButtonState] of Integer;
    FTransparentColor: TColor;
    FNumGlyphs: TRxNumGlyphs;
    FWordWrap: Boolean;
    FAlignment: TAlignment;
    FOnChange: TNotifyEvent;
    procedure GlyphChanged(Sender: TObject);
    procedure SetGlyph(Value: TBitmap);
    procedure SetNumGlyphs(Value: TRxNumGlyphs);
    function MapColor(Color: TColor): TColor;
  protected
    procedure MinimizeCaption(Canvas: TCanvas; const Caption: string;
      Buffer: PChar; MaxLen, Width: Integer);
    function CreateButtonGlyph(State: TRxButtonState): Integer;
{$IFDEF WIN32}
    function CreateImageGlyph(State: TRxButtonState; Images: TImageList;
      Index: Integer): Integer;
{$ENDIF}
    procedure CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
      var Caption: string; Layout: TButtonLayout; Margin, Spacing: Integer;
      PopupMark: Boolean; var GlyphPos: TPoint; var TextBounds: TRect;
      Flags: Word {$IFDEF WIN32}; Images: TImageList; ImageIndex: Integer
      {$ENDIF});
  public
    constructor Create;
    destructor Destroy; override;
    procedure Invalidate;
    function DrawButtonGlyph(Canvas: TCanvas; X, Y: Integer;
      State: TRxButtonState): TPoint;
{$IFDEF WIN32}
    function DrawButtonImage(Canvas: TCanvas; X, Y: Integer; Images: TImageList;
      ImageIndex: Integer; State: TRxButtonState): TPoint;
    function DrawEx(Canvas: TCanvas; const Client: TRect; const Caption: string;
      Layout: TButtonLayout; Margin, Spacing: Integer; PopupMark: Boolean;
      Images: TImageList; ImageIndex: Integer; State: TRxButtonState;
      Flags: Word): TRect;
{$ENDIF}
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string;
      TextBounds: TRect; State: TRxButtonState; Flags: Word);
    procedure DrawPopupMark(Canvas: TCanvas; X, Y: Integer;
      State: TRxButtonState);
    function Draw(Canvas: TCanvas; const Client: TRect; const Caption: string;
      Layout: TButtonLayout; Margin, Spacing: Integer; PopupMark: Boolean;
      State: TRxButtonState; Flags: Word): TRect;
    property Alignment: TAlignment read FAlignment write FAlignment;
    property Glyph: TBitmap read FOriginal write SetGlyph;
    property NumGlyphs: TRxNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

function DrawShadowText(DC: HDC; Str: PChar; Count: Integer; var Rect: TRect;
  Format: Word; ShadowSize: Byte; ShadowColor: TColorRef;
  ShadowPos: TShadowPosition): Integer;

function CheckBitmap: TBitmap;
*)

type

  { TRxDBRadioGroup }

  { TRxRadioGroup }

  TRxRadioGroup = class(TRadioGroup)
  private
    function GetItemEnabled(Index: integer): boolean;
    procedure SetItemEnabled(Index: integer; AValue: boolean);
  public
    property ItemEnabled[Index: integer]: boolean
      read GetItemEnabled write SetItemEnabled;
  end;

implementation


uses SysUtils, Dialogs, rxlclutils, Math, RxAppUtils, ImgList,
  ActnList, InterfaceBase;

const
  Alignments: array [TAlignment] of word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  WordWraps: array[boolean] of word = (0, DT_WORDBREAK);
(*
{ TTextListBox }

procedure TTextListBox.SetHorizontalExtent;
begin
  SendMessage(Handle, LB_SETHORIZONTALEXTENT, FMaxWidth, 0);
end;

function TTextListBox.GetItemWidth(Index: Integer): Integer;
var
  ATabWidth: Longint;
  S: string;
begin
  S := Items[Index] + 'x';
  if TabWidth > 0 then begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    Result := LoWord(GetTabbedTextExtent(Canvas.Handle, @S[1], Length(S),
      1, ATabWidth));
  end
  else Result := Canvas.TextWidth(S);
end;

procedure TTextListBox.ResetHorizontalExtent;
var
  I: Integer;
begin
  FMaxWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxWidth := Max(FMaxWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;

{$IFNDEF WIN32}

procedure TTextListBox.SetTabWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FTabWidth <> Value then begin
    FTabWidth := Value;
    RecreateWnd;
  end;
end;

procedure TTextListBox.CreateParams(var Params: TCreateParams);
const
  TabStops: array[Boolean] of Longword = (0, LBS_USETABSTOPS);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or TabStops[FTabWidth <> 0];
end;

procedure TTextListBox.CreateWnd;
begin
  inherited CreateWnd;
  if FTabWidth <> 0 then
    SendMessage(Handle, LB_SETTABSTOPS, 1, Longint(@FTabWidth));
end;

{$ENDIF}

procedure TTextListBox.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    LB_ADDSTRING, LB_INSERTSTRING:
      begin
        inherited WndProc(Message);
        FMaxWidth := Max(FMaxWidth, GetItemWidth(Message.Result));
        SetHorizontalExtent;
      end;
    LB_DELETESTRING:
      begin
        if GetItemWidth(Message.wParam) >= FMaxWidth then begin
          Perform(WM_HSCROLL, SB_TOP, 0);
          inherited WndProc(Message);
          ResetHorizontalExtent;
        end
        else inherited WndProc(Message);
      end;
    LB_RESETCONTENT:
      begin
        FMaxWidth := 0;
        SetHorizontalExtent;
        Perform(WM_HSCROLL, SB_TOP, 0);
        inherited WndProc(Message);
      end;
    WM_SETFONT:
      begin
        inherited WndProc(Message);
        Canvas.Font.Assign(Self.Font);
        ResetHorizontalExtent;
        Exit;
      end;
    else inherited WndProc(Message);
  end;
end;

{ TRxCustomListBox implementation copied from STDCTRLS.PAS and modified }

{ TRxListBoxStrings }

type
  TRxListBoxStrings = class(TStrings)
  private
    ListBox: TRxCustomListBox;
  protected
{$IFNDEF RX_D3}
    procedure Error(Msg: Word; Data: Integer);
{$ENDIF}
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    function GetObject(Index: Integer): TObject; override;
    procedure PutObject(Index: Integer; AObject: TObject); override;
    procedure SetUpdateState(Updating: Boolean); override;
  public
    function Add(const S: string): Integer; override;
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
  end;

{$IFNDEF RX_D3}
procedure TRxListBoxStrings.Error(Msg: Word; Data: Integer);

{$IFDEF WIN32}
  function ReturnAddr: Pointer;
  asm
          MOV     EAX,[EBP+4]
  end;
{$ELSE}
  function ReturnAddr: Pointer; assembler;
  asm
          MOV     AX,[BP].Word[2]
          MOV     DX,[BP].Word[4]
  end;
{$ENDIF}

begin
  raise EStringListError.CreateFmt('%s: %d', [LoadStr(Msg),
    Data]) at ReturnAddr;
end;
{$ENDIF}

function TRxListBoxStrings.GetCount: Integer;
begin
  Result := SendMessage(ListBox.Handle, LB_GETCOUNT, 0, 0);
end;

function TRxListBoxStrings.Get(Index: Integer): string;
var
  Len: Integer;
{$IFDEF WIN32}
  Text: array[0..4095] of Char;
{$ENDIF}
begin
  Len := SendMessage(ListBox.Handle, LB_GETTEXT, Index,
    {$IFDEF WIN32} LongInt(@Text) {$ELSE} LongInt(@Result) {$ENDIF});
  if Len < 0 then Error(SListIndexError, Index);
{$IFDEF WIN32}
  SetString(Result, Text, Len);
{$ELSE}
  System.Move(Result[0], Result[1], Len);
  Result[0] := Char(Len);
{$ENDIF}
end;

function TRxListBoxStrings.GetObject(Index: Integer): TObject;
begin
  Result := TObject(ListBox.GetItemData(Index));
  if Longint(Result) = LB_ERR then Error(SListIndexError, Index);
end;

procedure TRxListBoxStrings.PutObject(Index: Integer; AObject: TObject);
begin
  ListBox.SetItemData(Index, LongInt(AObject));
end;

function TRxListBoxStrings.Add(const S: string): Integer;
{$IFNDEF WIN32}
var
  Text: array[0..255] of Char;
{$ENDIF}
begin
{$IFDEF WIN32}
  Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, LongInt(PChar(S)));
{$ELSE}
  Result := SendMessage(ListBox.Handle, LB_ADDSTRING, 0, LongInt(StrPCopy(Text, S)));
{$ENDIF}
  if Result < 0 then raise EOutOfResources.Create(ResStr(SInsertLineError));
end;

procedure TRxListBoxStrings.Insert(Index: Integer; const S: string);
{$IFNDEF WIN32}
var
  Text: array[0..255] of Char;
{$ENDIF}
begin
  if SendMessage(ListBox.Handle, LB_INSERTSTRING, Index,
{$IFDEF WIN32}
    Longint(PChar(S))) < 0 then
{$ELSE}
    Longint(StrPCopy(Text, S))) < 0 then
{$ENDIF}
      raise EOutOfResources.Create(ResStr(SInsertLineError));
end;

procedure TRxListBoxStrings.Delete(Index: Integer);
begin
  ListBox.DeleteString(Index);
end;

procedure TRxListBoxStrings.Clear;
begin
  ListBox.ResetContent;
end;

procedure TRxListBoxStrings.SetUpdateState(Updating: Boolean);
begin
  SendMessage(ListBox.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then ListBox.Refresh;
end;

{ TRxCustomListBox }

procedure ListIndexError(Index: Integer);

{$IFDEF WIN32}
  function ReturnAddr: Pointer;
  asm
          MOV     EAX,[EBP+4]
  end;
{$ELSE}
  function ReturnAddr: Pointer; assembler;
  asm
          MOV     AX,[BP].Word[2]
          MOV     DX,[BP].Word[4]
  end;
{$ENDIF}

begin
{$IFDEF RX_D3}
  raise EStringListError.CreateFmt(SListIndexError, [Index]) at ReturnAddr;
{$ELSE}
  raise EStringListError.CreateFmt('%s: %d', [LoadStr(SListIndexError),
    Index]) at ReturnAddr;
{$ENDIF}
end;

constructor TRxCustomListBox.Create(AOwner: TComponent);
const
  ListBoxStyle = [csSetCaption, csDoubleClicks];
begin
  inherited Create(AOwner);
{$IFDEF WIN32}
  if NewStyleControls then ControlStyle := ListBoxStyle
  else ControlStyle := ListBoxStyle + [csFramed];
{$ELSE}
  ControlStyle := ListBoxStyle + [csFramed];
{$ENDIF}
  Width := 121;
  Height := 97;
  TabStop := True;
  ParentColor := False;
  FItems := CreateItemList;
  TRxListBoxStrings(FItems).ListBox := Self;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  FItemHeight := 16;
  FBorderStyle := bsSingle;
  FExtendedSelect := True;
end;

destructor TRxCustomListBox.Destroy;
begin
  inherited Destroy;
  FCanvas.Free;
  FItems.Free;
  FSaveItems.Free;
end;

function TRxCustomListBox.CreateItemList: TStrings;
begin
  Result := TRxListBoxStrings.Create;
end;

function TRxCustomListBox.GetItemData(Index: Integer): LongInt;
begin
  Result := SendMessage(Handle, LB_GETITEMDATA, Index, 0);
end;

procedure TRxCustomListBox.SetItemData(Index: Integer; AData: LongInt);
begin
  SendMessage(Handle, LB_SETITEMDATA, Index, AData);
end;

procedure TRxCustomListBox.DeleteString(Index: Integer);
begin
  SendMessage(Handle, LB_DELETESTRING, Index, 0);
end;

procedure TRxCustomListBox.SetHorizontalExtent;
begin
  SendMessage(Handle, LB_SETHORIZONTALEXTENT, FMaxItemWidth, 0);
end;

function TRxCustomListBox.GetItemWidth(Index: Integer): Integer;
var
  ATabWidth: Longint;
  S: string;
begin
  if (Style <> lbStandard) and Assigned(FOnGetItemWidth) and
    Assigned(FOnDrawItem) then
  begin
    Result := 0;
    FOnGetItemWidth(Self, Index, Result);
  end
  else begin
    S := Items[Index] + 'x';
    if TabWidth > 0 then begin
      {if (FTabChar > #0) then
        for I := 1 to Length(S) do
          if S[I] = FTabChar then S[I] := #9;}
      ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
      Result := LoWord(GetTabbedTextExtent(Canvas.Handle, @S[1], Length(S),
        1, ATabWidth));
    end
    else Result := Canvas.TextWidth(S);
  end;
end;

procedure TRxCustomListBox.ResetHorizontalExtent;
var
  I: Integer;
begin
  FMaxItemWidth := 0;
  for I := 0 to Items.Count - 1 do
    FMaxItemWidth := Max(FMaxItemWidth, GetItemWidth(I));
  SetHorizontalExtent;
end;

procedure TRxCustomListBox.ResetContent;
begin
  SendMessage(Handle, LB_RESETCONTENT, 0, 0);
end;

procedure TRxCustomListBox.Clear;
begin
  FItems.Clear;
end;

procedure TRxCustomListBox.SetColumnWidth;
begin
  if FColumns > 0 then
    SendMessage(Handle, LB_SETCOLUMNWIDTH, (Width + FColumns - 3) div
      FColumns, 0);
end;

procedure TRxCustomListBox.SetColumns(Value: Integer);
begin
  if FColumns <> Value then
    if (FColumns = 0) or (Value = 0) then begin
      FColumns := Value;
      RecreateWnd;
    end
    else begin
      FColumns := Value;
      if HandleAllocated then SetColumnWidth;
    end;
end;

function TRxCustomListBox.GetItemIndex: Integer;
begin
  Result := SendMessage(Handle, LB_GETCURSEL, 0, 0);
end;

function TRxCustomListBox.GetSelCount: Integer;
begin
  Result := SendMessage(Handle, LB_GETSELCOUNT, 0, 0);
end;

procedure TRxCustomListBox.SetItemIndex(Value: Integer);
begin
  if GetItemIndex <> Value then
    SendMessage(Handle, LB_SETCURSEL, Value, 0);
end;

procedure TRxCustomListBox.SetExtendedSelect(Value: Boolean);
begin
  if Value <> FExtendedSelect then begin
    FExtendedSelect := Value;
    RecreateWnd;
  end;
end;

procedure TRxCustomListBox.SetIntegralHeight(Value: Boolean);
begin
  if Value <> FIntegralHeight then begin
    FIntegralHeight := Value;
    RecreateWnd;
  end;
end;

function TRxCustomListBox.GetAutoScroll: Boolean;
begin
  Result := FAutoScroll and (Columns = 0);
end;

procedure TRxCustomListBox.SetOnDrawItem(Value: TDrawItemEvent);
begin
  if Assigned(FOnDrawItem) <> Assigned(Value) then begin
    FOnDrawItem := Value;
    Perform(WM_HSCROLL, SB_TOP, 0);
    if HandleAllocated then
      if AutoScroll then ResetHorizontalExtent
      else SendMessage(Handle, LB_SETHORIZONTALEXTENT, 0, 0);
  end
  else FOnDrawItem := Value;
end;

procedure TRxCustomListBox.SetOnGetItemWidth(Value: TGetItemWidthEvent);
begin
  if Assigned(FOnGetItemWidth) <> Assigned(Value) then begin
    FOnGetItemWidth := Value;
    Perform(WM_HSCROLL, SB_TOP, 0);
    if HandleAllocated then
      if AutoScroll then ResetHorizontalExtent
      else SendMessage(Handle, LB_SETHORIZONTALEXTENT, 0, 0);
  end
  else FOnGetItemWidth := Value;
end;

procedure TRxCustomListBox.SetAutoScroll(Value: Boolean);
begin
  if AutoScroll <> Value then begin
    FAutoScroll := Value;
    Perform(WM_HSCROLL, SB_TOP, 0);
    if HandleAllocated then begin
      if AutoScroll then ResetHorizontalExtent
      else SendMessage(Handle, LB_SETHORIZONTALEXTENT, 0, 0);
    end;
  end;
end;

function TRxCustomListBox.GetItemHeight: Integer;
var
  R: TRect;
begin
  Result := FItemHeight;
  if HandleAllocated and (FStyle = lbStandard) then begin
    Perform(LB_GETITEMRECT, 0, Longint(@R));
    Result := R.Bottom - R.Top;
  end;
end;

procedure TRxCustomListBox.SetItemHeight(Value: Integer);
begin
  if (FItemHeight <> Value) and (Value > 0) then begin
    FItemHeight := Value;
    RecreateWnd;
  end;
end;

procedure TRxCustomListBox.SetTabWidth(Value: Integer);
begin
  if Value < 0 then Value := 0;
  if FTabWidth <> Value then begin
    FTabWidth := Value;
    RecreateWnd;
  end;
end;

procedure TRxCustomListBox.SetMultiSelect(Value: Boolean);
begin
  if FMultiSelect <> Value then begin
    FMultiSelect := Value;
    RecreateWnd;
  end;
end;

function TRxCustomListBox.GetSelected(Index: Integer): Boolean;
var
  R: Longint;
begin
  R := SendMessage(Handle, LB_GETSEL, Index, 0);
  if R = LB_ERR then ListIndexError(Index);
  Result := LongBool(R);
end;

procedure TRxCustomListBox.SetSelected(Index: Integer; Value: Boolean);
begin
  if MultiSelect then begin
    if SendMessage(Handle, LB_SETSEL, Ord(Value), Index) = LB_ERR then
      ListIndexError(Index);
  end
  else begin
    if Value then SetItemIndex(Index)
    else if (ItemIndex = Index) then SetItemIndex(-1);
  end;
end;

procedure TRxCustomListBox.SetSorted(Value: Boolean);
begin
  if FSorted <> Value then begin
    FSorted := Value;
    RecreateWnd;
  end;
end;

procedure TRxCustomListBox.SetStyle(Value: TListBoxStyle);
begin
  if FStyle <> Value then begin
    FStyle := Value;
    RecreateWnd;
  end;
end;

function TRxCustomListBox.GetTopIndex: Integer;
begin
  Result := SendMessage(Handle, LB_GETTOPINDEX, 0, 0);
end;

procedure TRxCustomListBox.SetBorderStyle(Value: TBorderStyle);
begin
  if FBorderStyle <> Value then begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

procedure TRxCustomListBox.SetTopIndex(Value: Integer);
begin
  if GetTopIndex <> Value then SendMessage(Handle, LB_SETTOPINDEX, Value, 0);
end;

procedure TRxCustomListBox.SetGraySelection(Value: Boolean);
begin
  if FGraySelection <> Value then begin
    FGraySelection := Value;
    if not Focused then Invalidate;
  end;
end;

procedure TRxCustomListBox.SetItems(Value: TStrings);
begin
  Items.Assign(Value);
end;

function TRxCustomListBox.ItemAtPos(Pos: TPoint; Existing: Boolean): Integer;
var
  Count: Integer;
  ItemRect: TRect;
begin
  if PtInRect(ClientRect, Pos) then begin
    Result := TopIndex;
    Count := Items.Count;
    while Result < Count do begin
      Perform(LB_GETITEMRECT, Result, Longint(@ItemRect));
      if PtInRect(ItemRect, Pos) then Exit;
      Inc(Result);
    end;
    if not Existing then Exit;
  end;
  Result := -1;
end;

function TRxCustomListBox.ItemRect(Index: Integer): TRect;
var
  Count: Integer;
begin
  Count := Items.Count;
  if (Index = 0) or (Index < Count) then
    Perform(LB_GETITEMRECT, Index, Longint(@Result))
  else if Index = Count then begin
    Perform(LB_GETITEMRECT, Index - 1, Longint(@Result));
    OffsetRect(Result, 0, Result.Bottom - Result.Top);
  end
  else FillChar(Result, SizeOf(Result), 0);
end;

procedure TRxCustomListBox.CreateParams(var Params: TCreateParams);
type
  PSelects = ^TSelects;
  TSelects = array[Boolean] of Longword;
const
  BorderStyles: array[TBorderStyle] of Longword = (0, WS_BORDER);
  Styles: array[TListBoxStyle] of Longword =
    (0, LBS_OWNERDRAWFIXED, LBS_OWNERDRAWVARIABLE
    {$IFDEF RX_D6}, LBS_OWNERDRAWFIXED, LBS_OWNERDRAWFIXED{$ENDIF});
  Sorteds: array[Boolean] of Longword = (0, LBS_SORT);
  MultiSelects: array[Boolean] of Longword = (0, LBS_MULTIPLESEL);
  ExtendSelects: array[Boolean] of Longword = (0, LBS_EXTENDEDSEL);
  IntegralHeights: array[Boolean] of Longword = (LBS_NOINTEGRALHEIGHT, 0);
  MultiColumns: array[Boolean] of Longword = (0, LBS_MULTICOLUMN);
  TabStops: array[Boolean] of Longword = (0, LBS_USETABSTOPS);
var
  Selects: PSelects;
begin
  inherited CreateParams(Params);
  CreateSubClass(Params, 'LISTBOX');
  with Params do begin
{$IFNDEF WIN32}
    Inc(X); Inc(Y);
    Dec(Width, 2); Dec(Height, 2);
{$ENDIF}
    Selects := @MultiSelects;
    if FExtendedSelect then Selects := @ExtendSelects;
    Style := Style or (WS_HSCROLL or WS_VSCROLL or LBS_HASSTRINGS or
      LBS_NOTIFY) or Styles[FStyle] or Sorteds[FSorted] or
      Selects^[FMultiSelect] or IntegralHeights[FIntegralHeight] or
      MultiColumns[FColumns <> 0] or BorderStyles[FBorderStyle] or
      TabStops[FTabWidth <> 0];
{$IFDEF WIN32}
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
{$ENDIF}
    WindowClass.Style := WindowClass.Style and not (CS_HREDRAW or CS_VREDRAW);
  end;
end;

procedure TRxCustomListBox.CreateWnd;
var
  W, H: Integer;
begin
  W := Width;
  H := Height;
  inherited CreateWnd;
  SetWindowPos(Handle, 0, Left, Top, W, H, SWP_NOZORDER or SWP_NOACTIVATE);
  if FTabWidth <> 0 then
    SendMessage(Handle, LB_SETTABSTOPS, 1, Longint(@FTabWidth));
  SetColumnWidth;
  if FSaveItems <> nil then begin
    FItems.Assign(FSaveItems);
    SetTopIndex(FSaveTopIndex);
    SetItemIndex(FSaveItemIndex);
    FSaveItems.Free;
    FSaveItems := nil;
  end;
end;

procedure TRxCustomListBox.DestroyWnd;
begin
  if FItems.Count > 0 then begin
    FSaveItems := TStringList.Create;
    FSaveItems.Assign(FItems);
    FSaveTopIndex := GetTopIndex;
    FSaveItemIndex := GetItemIndex;
  end;
  inherited DestroyWnd;
end;

procedure TRxCustomListBox.WndProc(var Message: TMessage);
begin
  if AutoScroll then begin
    case Message.Msg of
      LB_ADDSTRING, LB_INSERTSTRING:
        begin
          inherited WndProc(Message);
          FMaxItemWidth := Max(FMaxItemWidth, GetItemWidth(Message.Result));
          SetHorizontalExtent;
          Exit;
        end;
      LB_DELETESTRING:
        begin
          if GetItemWidth(Message.wParam) >= FMaxItemWidth then begin
            Perform(WM_HSCROLL, SB_TOP, 0);
            inherited WndProc(Message);
            ResetHorizontalExtent;
          end
          else inherited WndProc(Message);
          Exit;
        end;
      LB_RESETCONTENT:
        begin
          FMaxItemWidth := 0;
          SetHorizontalExtent;
          Perform(WM_HSCROLL, SB_TOP, 0);
          inherited WndProc(Message);
          Exit;
        end;
      WM_SETFONT:
        begin
          inherited WndProc(Message);
          Canvas.Font.Assign(Self.Font);
          ResetHorizontalExtent;
          Exit;
        end;
    end;
  end;
  {for auto drag mode, let listbox handle itself, instead of TControl}
  if not (csDesigning in ComponentState) and ((Message.Msg = WM_LBUTTONDOWN) or
    (Message.Msg = WM_LBUTTONDBLCLK)) and not Dragging then
  begin
    if DragMode = dmAutomatic then begin
      if IsControlMouseMsg(TWMMouse(Message)) then Exit;
      ControlState := ControlState + [csLButtonDown];
      Dispatch(Message);  {overrides TControl's BeginDrag}
      Exit;
    end;
  end;
  inherited WndProc(Message);
end;

procedure TRxCustomListBox.WMLButtonDown(var Message: TWMLButtonDown);
var
  ItemNo: Integer;
  ShiftState: TShiftState;
begin
  ShiftState := KeysToShiftState(Message.Keys);
  if (DragMode = dmAutomatic) and FMultiSelect then begin
    if not (ssShift in ShiftState) or (ssCtrl in ShiftState) then begin
      ItemNo := ItemAtPos(SmallPointToPoint(Message.Pos), True);
      if (ItemNo >= 0) and (Selected[ItemNo]) then begin
        BeginDrag(False);
        Exit;
      end;
    end;
  end;
  inherited;
  if (DragMode = dmAutomatic) and not (FMultiSelect and
    ((ssCtrl in ShiftState) or (ssShift in ShiftState))) then
    BeginDrag(False);
end;

procedure TRxCustomListBox.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  if csDesigning in ComponentState then DefaultHandler(Msg)
  else inherited;
end;

procedure TRxCustomListBox.CNCommand(var Message: TWMCommand);
begin
  case Message.NotifyCode of
    LBN_SELCHANGE:
      begin
{$IFDEF RX_D3}
        inherited Changed;
{$ENDIF}
        Click;
      end;
    LBN_DBLCLK: DblClick;
  end;
end;

procedure TRxCustomListBox.WMPaint(var Message: TWMPaint);

  procedure PaintListBox;
  var
    DrawItemMsg: TWMDrawItem;
    MeasureItemMsg: TWMMeasureItem;
    DrawItemStruct: TDrawItemStruct;
    MeasureItemStruct: TMeasureItemStruct;
    R: TRect;
    Y, I, H, W: Integer;
  begin
    { Initialize drawing records }
    DrawItemMsg.Msg := CN_DRAWITEM;
    DrawItemMsg.DrawItemStruct := @DrawItemStruct;
    DrawItemMsg.Ctl := Handle;
    DrawItemStruct.CtlType := ODT_LISTBOX;
    DrawItemStruct.itemAction := ODA_DRAWENTIRE;
    DrawItemStruct.itemState := 0;
    DrawItemStruct.hDC := Message.DC;
    DrawItemStruct.CtlID := Handle;
    DrawItemStruct.hwndItem := Handle;
    { Intialize measure records }
    MeasureItemMsg.Msg := CN_MEASUREITEM;
    MeasureItemMsg.IDCtl := Handle;
    MeasureItemMsg.MeasureItemStruct := @MeasureItemStruct;
    MeasureItemStruct.CtlType := ODT_LISTBOX;
    MeasureItemStruct.CtlID := Handle;
    { Draw the listbox }
    Y := 0;
    I := TopIndex;
    GetClipBox(Message.DC, R);
    H := Height;
    W := Width;
    while Y < H do begin
      MeasureItemStruct.itemID := I;
      if I < Items.Count then
        MeasureItemStruct.itemData := Longint(Pointer(Items.Objects[I]));
      MeasureItemStruct.itemWidth := W;
      MeasureItemStruct.itemHeight := FItemHeight;
      DrawItemStruct.itemData := MeasureItemStruct.itemData;
      DrawItemStruct.itemID := I;
      Dispatch(MeasureItemMsg);
      DrawItemStruct.rcItem := Rect(0, Y, MeasureItemStruct.itemWidth,
        Y + Integer(MeasureItemStruct.itemHeight));
      Dispatch(DrawItemMsg);
      Inc(Y, MeasureItemStruct.itemHeight);
      Inc(I);
      if I >= Items.Count then break;
    end;
  end;

begin
  if Message.DC <> 0 then PaintListBox
  else inherited;
end;

procedure TRxCustomListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  SetColumnWidth;
end;

procedure TRxCustomListBox.DragCanceled;
var
  M: TWMMouse;
{$IFDEF WIN32}
  MousePos: TPoint;
{$ENDIF}
begin
  with M do begin
    Msg := WM_LBUTTONDOWN;
{$IFDEF WIN32}
    GetCursorPos(MousePos);
    Pos := PointToSmallPoint(ScreenToClient(MousePos));
{$ELSE}
    GetCursorPos(Pos);
    Pos := ScreenToClient(Pos);
{$ENDIF}
    Keys := 0;
    Result := 0;
  end;
  DefaultHandler(M);
  M.Msg := WM_LBUTTONUP;
  DefaultHandler(M);
end;

procedure TRxCustomListBox.DefaultDrawText(X, Y: Integer; const S: string);
var
  ATabWidth: Longint;
begin
{$IFDEF RX_D4}
  TControlCanvas(FCanvas).UpdateTextFlags;
{$ENDIF}
  if FTabWidth = 0 then FCanvas.TextOut(X, Y, S)
  else begin
    ATabWidth := Round((TabWidth * Canvas.TextWidth('0')) * 0.25);
    TabbedTextOut(FCanvas.Handle, X, Y, @S[1], Length(S), 1, ATabWidth, X);
  end;
end;

procedure TRxCustomListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
begin
  if Assigned(FOnDrawItem) then FOnDrawItem(Self, Index, Rect, State)
  else begin
    FCanvas.FillRect(Rect);
    if Index < Items.Count then begin
{$IFDEF RX_D4}
      if not UseRightToLeftAlignment then Inc(Rect.Left, 2)
      else Dec(Rect.Right, 2);
{$ELSE}
      Inc(Rect.Left, 2);
{$ENDIF}
      DefaultDrawText(Rect.Left, Max(Rect.Top, (Rect.Bottom +
        Rect.Top - Canvas.TextHeight('Wy')) div 2), Items[Index]);
    end;
  end;
end;

procedure TRxCustomListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if Assigned(FOnMeasureItem) then FOnMeasureItem(Self, Index, Height)
end;

procedure TRxCustomListBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
begin
  with Message.DrawItemStruct^ do begin
{$IFDEF WIN32}
 {$IFDEF RX_D5}
    State := TOwnerDrawState(LongRec(itemState).Lo);
 {$ELSE}
    State := TOwnerDrawState(WordRec(LongRec(itemState).Lo).Lo);
 {$ENDIF}
{$ELSE}
    State := TOwnerDrawState(WordRec(itemState).Lo);
{$ENDIF}
    FCanvas.Handle := hDC;
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    if (Integer(itemID) >= 0) and (odSelected in State) then begin
      with FCanvas do
        if not (csDesigning in ComponentState) and FGraySelection and
          not Focused then
        begin
          Brush.Color := clBtnFace;
          if ColorToRGB(Font.Color) = ColorToRGB(clBtnFace) then
            Font.Color := clBtnText;
        end
        else begin
          Brush.Color := clHighlight;
          Font.Color := clHighlightText
        end;
    end;
    if Integer(itemID) >= 0 then DrawItem(itemID, rcItem, State)
    else FCanvas.FillRect(rcItem);
    if odFocused in State then DrawFocusRect(hDC, rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TRxCustomListBox.CNMeasureItem(var Message: TWMMeasureItem);
begin
  with Message.MeasureItemStruct^ do begin
    itemHeight := FItemHeight;
    if FStyle = lbOwnerDrawVariable then
      MeasureItem(itemID, Integer(itemHeight));
  end;
end;

procedure TRxCustomListBox.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if FGraySelection and MultiSelect and (SelCount > 1) then Invalidate;
end;

procedure TRxCustomListBox.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  if FGraySelection and MultiSelect and (SelCount > 1) then Invalidate;
end;

{$IFDEF WIN32}
procedure TRxCustomListBox.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (FBorderStyle = bsSingle) then RecreateWnd;
  inherited;
end;
{$ENDIF}

{ TCheckListBoxItem }

type
  TCheckListBoxItem = class
  private
    FData: LongInt;
    FState: TCheckBoxState;
    FEnabled: Boolean;
    function GetChecked: Boolean;
  public
    constructor Create;
    property Checked: Boolean read GetChecked;
    property Enabled: Boolean read FEnabled write FEnabled;
    property State: TCheckBoxState read FState write FState;
  end;

constructor TCheckListBoxItem.Create;
begin
  inherited Create;
  FState := clbDefaultState;
  FEnabled := clbDefaultEnabled;
end;

function TCheckListBoxItem.GetChecked: Boolean;
begin
  Result := FState = cbChecked;
end;

{ TCheckListBoxStrings }

type
  TCheckListBoxStrings = class(TRxListBoxStrings)
  public
    procedure Exchange(Index1, Index2: Integer); override;
    procedure Move(CurIndex, NewIndex: Integer); override;
  end;

procedure TCheckListBoxStrings.Exchange(Index1, Index2: Integer);
var
  TempEnabled1, TempEnabled2: Boolean;
  TempState1, TempState2: TCheckBoxState;
begin
  with TRxCheckListBox(ListBox) do begin
    TempState1 := State[Index1];
    TempEnabled1 := EnabledItem[Index1];
    TempState2 := State[Index2];
    TempEnabled2 := EnabledItem[Index2];
    inherited Exchange(Index1, Index2);
    State[Index1] := TempState2;
    EnabledItem[Index1] := TempEnabled2;
    State[Index2] := TempState1;
    EnabledItem[Index2] := TempEnabled1;
  end;
end;

procedure TCheckListBoxStrings.Move(CurIndex, NewIndex: Integer);
var
  TempEnabled: Boolean;
  TempState: TCheckBoxState;
begin
  with TRxCheckListBox(ListBox) do begin
    TempState := State[CurIndex];
    TempEnabled := EnabledItem[CurIndex];
    inherited Move(CurIndex, NewIndex);
    State[NewIndex] := TempState;
    EnabledItem[NewIndex] := TempEnabled;
  end;
end;

{ TRxCheckListBox }

const
  FCheckBitmap: TBitmap = nil;

function CheckBitmap: TBitmap;
begin
  if FCheckBitmap = nil then begin
    FCheckBitmap := TBitmap.Create;
    FCheckBitmap.Handle := LoadBitmap(hInstance, 'CHECK_IMAGES');
  end;
  Result := FCheckBitmap;
end;

procedure DestroyLocals; far;
begin
  if FCheckBitmap <> nil then begin
    FCheckBitmap.Free;
    FCheckBitmap := nil;
  end;
end;

const
  InternalVersion = 202; { for backward compatibility only }

constructor TRxCheckListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAutoScroll := True;
  with CheckBitmap do begin
    FCheckWidth := Width div 6;
    FCheckHeight := Height div 3;
  end;
  FDrawBitmap := TBitmap.Create;
  with FDrawBitmap do begin
    Width := FCheckWidth;
    Height := FCheckHeight;
  end;
  FIniLink := TIniLink.Create;
  FIniLink.OnSave := IniSave;
  FIniLink.OnLoad := IniLoad;
end;

destructor TRxCheckListBox.Destroy;
begin
  FSaveStates.Free;
  FSaveStates := nil;
  FDrawBitmap.Free;
  FDrawBitmap := nil;
  FIniLink.Free;
  inherited Destroy;
end;

procedure TRxCheckListBox.Loaded;
begin
  inherited Loaded;
  UpdateCheckStates;
end;

function TRxCheckListBox.CreateItemList: TStrings;
begin
  Result := TCheckListBoxStrings.Create;
end;

const
  sCount = 'Count';
  sItem = 'Item';

procedure TRxCheckListBox.InternalSaveStates(IniFile: TObject;
  const Section: string);
var
  I: Integer;
begin
  IniEraseSection(IniFile, Section);
  IniWriteInteger(IniFile, Section, sCount, Items.Count);
  for I := 0 to Items.Count - 1 do
    IniWriteInteger(IniFile, Section, sItem + IntToStr(I), Integer(State[I]));
end;

procedure TRxCheckListBox.InternalRestoreStates(IniFile: TObject;
  const Section: string);
var
  I: Integer;
  ACount: Integer;
begin
  ACount := Min(IniReadInteger(IniFile, Section, sCount, 0), Items.Count);
  for I := 0 to ACount - 1 do begin
    State[I] := TCheckBoxState(IniReadInteger(IniFile, Section,
      sItem + IntToStr(I), Integer(clbDefaultState)));
    if (State[I] = cbChecked) and (FCheckKind = ckRadioButtons) then Exit;
  end;
end;

{$IFDEF WIN32}
procedure TRxCheckListBox.SaveStatesReg(IniFile: TRegIniFile);
begin
  InternalSaveStates(IniFile, GetDefaultSection(Self));
end;

procedure TRxCheckListBox.RestoreStatesReg(IniFile: TRegIniFile);
begin
  InternalRestoreStates(IniFile, GetDefaultSection(Self));
end;
{$ENDIF WIN32}

procedure TRxCheckListBox.SaveStates(IniFile: TIniFile);
begin
  InternalSaveStates(IniFile, GetDefaultSection(Self));
end;

procedure TRxCheckListBox.RestoreStates(IniFile: TIniFile);
begin
  InternalRestoreStates(IniFile, GetDefaultSection(Self));
end;

function TRxCheckListBox.GetStorage: TFormPlacement;
begin
  Result := FIniLink.Storage;
end;

procedure TRxCheckListBox.SetStorage(Value: TFormPlacement);
begin
  FIniLink.Storage := Value;
end;

procedure TRxCheckListBox.IniSave(Sender: TObject);
begin
  if (Name <> '') and (FIniLink.IniObject <> nil) then
    InternalSaveStates(FIniLink.IniObject, FIniLink.RootSection +
      GetDefaultSection(Self));
end;

procedure TRxCheckListBox.IniLoad(Sender: TObject);
begin
  if (Name <> '') and (FIniLink.IniObject <> nil) then
    InternalRestoreStates(FIniLink.IniObject, FIniLink.RootSection +
      GetDefaultSection(Self));
end;

procedure TRxCheckListBox.ReadCheckData(Reader: TReader);
var
  I: Integer;
begin
  Items.BeginUpdate;
  try
    Reader.ReadListBegin;
    Clear;
    while not Reader.EndOfList do begin
      I := Items.Add(Reader.ReadString);
      if FReserved >= InternalVersion then begin
        State[I] := TCheckBoxState(Reader.ReadInteger);
        EnabledItem[I] := Reader.ReadBoolean;
      end
      else begin { for backward compatibility only }
        Checked[I] := Reader.ReadBoolean;
        EnabledItem[I] := Reader.ReadBoolean;
        if FReserved > 0 then
          State[I] := TCheckBoxState(Reader.ReadInteger);
      end;
    end;
    Reader.ReadListEnd;
    UpdateCheckStates;
  finally
    Items.EndUpdate;
  end;
end;

procedure TRxCheckListBox.WriteCheckData(Writer: TWriter);
var
  I: Integer;
begin
  with Writer do begin
    WriteListBegin;
    for I := 0 to Items.Count - 1 do begin
      WriteString(Items[I]);
      WriteInteger(Integer(Self.State[I]));
      WriteBoolean(EnabledItem[I]);
    end;
    WriteListEnd;
  end;
end;

procedure TRxCheckListBox.ReadVersion(Reader: TReader);
begin
  FReserved := Reader.ReadInteger;
end;

procedure TRxCheckListBox.WriteVersion(Writer: TWriter);
begin
  Writer.WriteInteger(InternalVersion);
end;

procedure TRxCheckListBox.DefineProperties(Filer: TFiler);

{$IFDEF WIN32}
  function DoWrite: Boolean;
  var
    I: Integer;
    Ancestor: TRxCheckListBox;
  begin
    Result := False;
    Ancestor := TRxCheckListBox(Filer.Ancestor);
    if (Ancestor <> nil) and (Ancestor.Items.Count = Items.Count) and
      (Ancestor.Items.Count > 0) then
      for I := 1 to Items.Count - 1 do begin
        Result := (CompareText(Items[I], Ancestor.Items[I]) <> 0) or
          (State[I] <> Ancestor.State[I]) or
          (EnabledItem[I] <> Ancestor.EnabledItem[I]);
        if Result then Break;
      end
    else Result := Items.Count > 0;
  end;
{$ENDIF}

begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('InternalVersion', ReadVersion, WriteVersion,
    {$IFDEF WIN32} Filer.Ancestor = nil {$ELSE} True {$ENDIF});
  Filer.DefineProperty('Strings', ReadCheckData, WriteCheckData,
    {$IFDEF WIN32} DoWrite {$ELSE} Items.Count > 0 {$ENDIF});
end;

procedure TRxCheckListBox.CreateWnd;
begin
  inherited CreateWnd;
  if FSaveStates <> nil then begin
    FSaveStates.Free;
    FSaveStates := nil;
  end;
  ResetItemHeight;
end;

procedure TRxCheckListBox.DestroyWnd;
begin
  inherited DestroyWnd;
end;

procedure TRxCheckListBox.WMDestroy(var Msg: TWMDestroy);
var
  I: Integer;
begin
  if Items.Count > 0 then begin
    if FSaveStates <> nil then FSaveStates.Clear
    else FSaveStates := TList.Create;
    for I := 0 to Items.Count - 1 do begin
      FSaveStates.Add(TObject(MakeLong(Ord(EnabledItem[I]), Word(State[I]))));
      FindCheckObject(I).Free;
    end;
  end;
  inherited;
end;

procedure TRxCheckListBox.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    if Style and (LBS_OWNERDRAWFIXED or LBS_OWNERDRAWVARIABLE) = 0 then
      Style := Style or LBS_OWNERDRAWFIXED;
end;

procedure TRxCheckListBox.SetItems(Value: TStrings);
var
  I: Integer;
begin
  Items.BeginUpdate;
  try
    inherited SetItems(Value);
    if (Value <> nil) and (Value is TRxListBoxStrings) and
      (TRxListBoxStrings(Value).ListBox <> nil) and
      (TRxListBoxStrings(Value).ListBox is TRxCheckListBox) then
    begin
      for I := 0 to Items.Count - 1 do
        if I < Value.Count then begin
          Self.State[I] := TRxCheckListBox(TRxListBoxStrings(Value).ListBox).State[I];
          EnabledItem[I] := TRxCheckListBox(TRxListBoxStrings(Value).ListBox).EnabledItem[I];
        end;
    end;
  finally
    Items.EndUpdate;
  end;
end;

function TRxCheckListBox.GetItemWidth(Index: Integer): Integer;
begin
  Result := inherited GetItemWidth(Index) + GetCheckWidth;
end;

function TRxCheckListBox.GetCheckWidth: Integer;
begin
  Result := FCheckWidth + 2;
end;

function TRxCheckListBox.GetAllowGrayed: Boolean;
begin
  Result := FAllowGrayed and (FCheckKind in [ckCheckBoxes, ckCheckMarks]);
end;

procedure TRxCheckListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

function TRxCheckListBox.GetItemHeight: Integer;
var
  R: TRect;
begin
  Result := FItemHeight;
  if HandleAllocated and ((FStyle = lbStandard) or
    ((FStyle = lbOwnerDrawFixed) and not Assigned(FOnDrawItem))) then
  begin
    Perform(LB_GETITEMRECT, 0, Longint(@R));
    Result := R.Bottom - R.Top;
  end;
end;

procedure TRxCheckListBox.ResetItemHeight;
var
  H: Integer;
begin
  if (Style = lbStandard) or ((Style = lbOwnerDrawFixed) and
    not Assigned(FOnDrawItem)) then
  begin
    Canvas.Font := Font;
    H := Max(Canvas.TextHeight('Wg'), FCheckHeight);
    if Style = lbOwnerDrawFixed then H := Max(H, FItemHeight);
    Perform(LB_SETITEMHEIGHT, 0, H);
    if (H * Items.Count) <= ClientHeight then
      SetScrollRange(Handle, SB_VERT, 0, 0, True);
  end;
end;

procedure TRxCheckListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  R: TRect;
  SaveEvent: TDrawItemEvent;
begin
  if Index < Items.Count then begin
    R := Rect;
{$IFDEF RX_D4}
    if not UseRightToLeftAlignment then begin
      R.Right := Rect.Left;
      R.Left := R.Right - GetCheckWidth;
    end
    else
    begin
      R.Left := Rect.Right;
      R.Right := R.Left + GetCheckWidth;
    end;
{$ELSE}
    R.Right := Rect.Left;
    R.Left := R.Right - GetCheckWidth;
{$ENDIF}
    DrawCheck(R, GetState(Index), EnabledItem[Index]);
    if not EnabledItem[Index] then
      if odSelected in State then Canvas.Font.Color := clInactiveCaptionText
      else Canvas.Font.Color := clGrayText;
  end;
  if (Style = lbStandard) and Assigned(FOnDrawItem) then begin
    SaveEvent := OnDrawItem;
    OnDrawItem := nil;
    try
      inherited DrawItem(Index, Rect, State);
    finally
      OnDrawItem := SaveEvent;
    end;
  end
  else inherited DrawItem(Index, Rect, State);
end;

procedure TRxCheckListBox.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do
{$IFDEF RX_D4}
    if not UseRightToLeftAlignment then
      rcItem.Left := rcItem.Left + GetCheckWidth
    else
      rcItem.Right := rcItem.Right - GetCheckWidth;
{$ELSE}
    rcItem.Left := rcItem.Left + GetCheckWidth;
{$ENDIF}
  inherited;
end;

procedure TRxCheckListBox.DrawCheck(R: TRect; AState: TCheckBoxState;
  Enabled: Boolean);
const
  CheckImages: array[TCheckBoxState, TCheckKind, Boolean] of Integer =
    (((3, 0), (9,  6), (15, 12)),   { unchecked }
     ((4, 1), (10, 7), (16, 13)),   { checked   }
     ((5, 2), (11, 8), (17, 14)));  { grayed    }
var
  DrawRect: TRect;
  SaveColor: TColor;
begin
  DrawRect.Left := R.Left + (R.Right - R.Left - FCheckWidth) div 2;
  DrawRect.Top := R.Top + (R.Bottom - R.Top - FCheckHeight) div 2;
  DrawRect.Right := DrawRect.Left + FCheckWidth;
  DrawRect.Bottom := DrawRect.Top + FCheckHeight;
  SaveColor := Canvas.Brush.Color;
  AssignBitmapCell(CheckBitmap, FDrawBitmap, 6, 3,
    CheckImages[AState, FCheckKind, Enabled]);
  Canvas.Brush.Color := Self.Color;
  try
    Canvas.BrushCopy(DrawRect, FDrawBitmap, Bounds(0, 0, FCheckWidth,
      FCheckHeight), CheckBitmap.TransparentColor and not PaletteMask);
  finally
    Canvas.Brush.Color := SaveColor;
  end;
end;

procedure TRxCheckListBox.ApplyState(AState: TCheckBoxState;
  EnabledOnly: Boolean);
var
  I: Integer;
begin
  if FCheckKind in [ckCheckBoxes, ckCheckMarks] then
    for I := 0 to Items.Count - 1 do
      if not EnabledOnly or EnabledItem[I] then begin
        State[I] := AState;
      end;
end;

function TRxCheckListBox.GetCheckedIndex: Integer;
var
  I: Integer;
begin
  Result := -1;
  if FCheckKind = ckRadioButtons then
    for I := 0 to Items.Count - 1 do
      if State[I] = cbChecked then begin
        Result := I;
        Exit;
      end;
end;

procedure TRxCheckListBox.SetCheckedIndex(Value: Integer);
begin
  if (FCheckKind = ckRadioButtons) and (Items.Count > 0) then
    SetState(Max(Value, 0), cbChecked);
end;

procedure TRxCheckListBox.UpdateCheckStates;
begin
  if (FCheckKind = ckRadioButtons) and (Items.Count > 0) then begin
    FInUpdateStates := True;
    try
      SetState(Max(GetCheckedIndex, 0), cbChecked);
    finally
      FInUpdateStates := False;
    end;
  end;
end;

procedure TRxCheckListBox.SetCheckKind(Value: TCheckKind);
begin
  if FCheckKind <> Value then begin
    FCheckKind := Value;
    UpdateCheckStates;
    Invalidate;
  end;
end;

procedure TRxCheckListBox.SetChecked(Index: Integer; AChecked: Boolean);
const
  CheckStates: array[Boolean] of TCheckBoxState = (cbUnchecked, cbChecked);
begin
  SetState(Index, CheckStates[AChecked]);
end;

procedure TRxCheckListBox.SetState(Index: Integer; AState: TCheckBoxState);
var
  I: Integer;
begin
  if (AState <> GetState(Index)) or FInUpdateStates then begin
    if (FCheckKind = ckRadioButtons) and (AState = cbUnchecked) and
      (GetCheckedIndex = Index) then Exit;
    TCheckListBoxItem(GetCheckObject(Index)).State := AState;
    if (FCheckKind = ckRadioButtons) and (AState = cbChecked) then
      for I := Items.Count - 1 downto 0 do begin
        if (I <> Index) and (GetState(I) = cbChecked) then begin
          TCheckListBoxItem(GetCheckObject(I)).State := cbUnchecked;
          InvalidateCheck(I);
        end;
      end;
    InvalidateCheck(Index);
    if not (csReading in ComponentState) then ChangeItemState(Index);
  end;
end;

procedure TRxCheckListBox.SetItemEnabled(Index: Integer; Value: Boolean);
begin
  if Value <> GetItemEnabled(Index) then begin
    TCheckListBoxItem(GetCheckObject(Index)).Enabled := Value;
    InvalidateItem(Index);
  end;
end;

procedure TRxCheckListBox.InvalidateCheck(Index: Integer);
var
  R: TRect;
begin
  R := ItemRect(Index);
{$IFDEF RX_D4}
  if not UseRightToLeftAlignment then R.Right := R.Left + GetCheckWidth
  else R.Left := R.Right - GetCheckWidth;
{$ELSE}
  R.Right := R.Left + GetCheckWidth;
{$ENDIF}
  InvalidateRect(Handle, @R, not (csOpaque in ControlStyle));
  UpdateWindow(Handle);
end;

procedure TRxCheckListBox.InvalidateItem(Index: Integer);
var
  R: TRect;
begin
  R := ItemRect(Index);
  InvalidateRect(Handle, @R, not (csOpaque in ControlStyle));
  UpdateWindow(Handle);
end;

function TRxCheckListBox.GetChecked(Index: Integer): Boolean;
begin
  if IsCheckObject(Index) then
    Result := TCheckListBoxItem(GetCheckObject(Index)).GetChecked
  else Result := False;
end;

function TRxCheckListBox.GetState(Index: Integer): TCheckBoxState;
begin
  if IsCheckObject(Index) then
    Result := TCheckListBoxItem(GetCheckObject(Index)).State
  else Result := clbDefaultState;
  if (FCheckKind = ckRadioButtons) and (Result <> cbChecked) then
    Result := cbUnchecked;
end;

function TRxCheckListBox.GetItemEnabled(Index: Integer): Boolean;
begin
  if IsCheckObject(Index) then
    Result := TCheckListBoxItem(GetCheckObject(Index)).Enabled
  else Result := clbDefaultEnabled;
end;

procedure TRxCheckListBox.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case Key of
    ' ': 
      begin
        ToggleClickCheck(ItemIndex);
        Key := #0;
      end;
    '+':
      begin
        ApplyState(cbChecked, True);
        ClickCheck;
      end;
    '-':
      begin
        ApplyState(cbUnchecked, True);
        ClickCheck;
      end;
  end;
end;

procedure TRxCheckListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Index: Integer;
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then begin
    Index := ItemAtPos(Point(X,Y), True);
    if (Index <> -1) then begin
{$IFDEF RX_D4}
      if not UseRightToLeftAlignment then begin
        if X - ItemRect(Index).Left < GetCheckWidth then
          ToggleClickCheck(Index);
      end
      else begin
        Dec(X, ItemRect(Index).Right - GetCheckWidth);
        if (X > 0) and (X < GetCheckWidth) then
          ToggleClickCheck(Index);
      end;
{$ELSE}
      if X - ItemRect(Index).Left < GetCheckWidth then
        ToggleClickCheck(Index);
{$ENDIF}
    end;
  end;
end;

procedure TRxCheckListBox.ToggleClickCheck(Index: Integer);
var
  State: TCheckBoxState;
begin
  if (Index >= 0) and (Index < Items.Count) and EnabledItem[Index] then begin
    State := Self.State[Index];
    case State of
      cbUnchecked:
        if AllowGrayed then State := cbGrayed else State := cbChecked;
      cbChecked: State := cbUnchecked;
      cbGrayed: State := cbChecked;
    end;
    Self.State[Index] := State;
    ClickCheck;
  end;
end;

procedure TRxCheckListBox.ChangeItemState(Index: Integer);
begin
  if Assigned(FOnStateChange) then FOnStateChange(Self, Index);
end;

procedure TRxCheckListBox.ClickCheck;
begin
  if Assigned(FOnClickCheck) then FOnClickCheck(Self);
end;

function TRxCheckListBox.GetItemData(Index: Integer): LongInt;
var
  Item: TCheckListBoxItem;
begin
  Result := 0;
  if IsCheckObject(Index) then begin
    Item := TCheckListBoxItem(GetCheckObject(Index));
    if Item <> nil then Result := Item.FData;
  end;
end;

function TRxCheckListBox.GetCheckObject(Index: Integer): TObject;
begin
  Result := FindCheckObject(Index);
  if Result = nil then Result := CreateCheckObject(Index);
end;

function TRxCheckListBox.FindCheckObject(Index: Integer): TObject;
var
  ItemData: Longint;
begin
  Result := nil;
  ItemData := inherited GetItemData(Index);
  if ItemData = LB_ERR then ListIndexError(Index)
  else begin
    Result := TCheckListBoxItem(ItemData);
    if not (Result is TCheckListBoxItem) then Result := nil;
  end;
end;

function TRxCheckListBox.CreateCheckObject(Index: Integer): TObject;
begin
  Result := TCheckListBoxItem.Create;
  inherited SetItemData(Index, LongInt(Result));
end;

function TRxCheckListBox.IsCheckObject(Index: Integer): Boolean;
begin
  Result := FindCheckObject(Index) <> nil;
end;

procedure TRxCheckListBox.SetItemData(Index: Integer; AData: LongInt);
var
  Item: TCheckListBoxItem;
  L: Longint;
begin
  Item := TCheckListBoxItem(GetCheckObject(Index));
  Item.FData := AData;
  if (FSaveStates <> nil) and (FSaveStates.Count > 0) then begin
    L := Longint(Pointer(FSaveStates[0]));
    Item.FState := TCheckBoxState(LongRec(L).Hi);
    Item.FEnabled := LongRec(L).Lo <> 0;
    FSaveStates.Delete(0);
  end;
end;

procedure TRxCheckListBox.ResetContent;
var
  I: Integer;
begin
  for I := Items.Count - 1 downto 0 do begin
    if IsCheckObject(I) then GetCheckObject(I).Free;
    inherited SetItemData(I, 0);
  end;
  inherited ResetContent;
end;

procedure TRxCheckListBox.DeleteString(Index: Integer);
begin
  if IsCheckObject(Index) then GetCheckObject(Index).Free;
  inherited SetItemData(Index, 0);
  inherited DeleteString(Index);
end;
*)
  { TRxCustomLabel }

function DrawShadowText(DC: HDC; Str: PChar; Count: integer; var Rect: TRect;
  Format: word; ShadowSize: byte; ShadowColor: TColorRef;
  ShadowPos: TShadowPosition): integer;
var
  RText, RShadow: TRect;
  Color: TColorRef;
begin
  RText := Rect;
  RShadow := Rect;
  Color := SetTextColor(DC, ShadowColor);
  case ShadowPos of
    spLeftTop: OffsetRect(RShadow, -ShadowSize, -ShadowSize);
    spRightBottom: OffsetRect(RShadow, ShadowSize, ShadowSize);
    spLeftBottom:
    begin
      {OffsetRect(RText, ShadowSize, 0);}
      OffsetRect(RShadow, -ShadowSize, ShadowSize);
    end;
    spRightTop:
    begin
      {OffsetRect(RText, 0, ShadowSize);}
      OffsetRect(RShadow, ShadowSize, -ShadowSize);
    end;
  end; { case }
  Result := DrawText(DC, Str, Count, RShadow, Format);
  if Result > 0 then Inc(Result, ShadowSize);
  SetTextColor(DC, Color);
  DrawText(DC, Str, Count, RText, Format);
  UnionRect(Rect, RText, RShadow);
end;

{ TRxRadioGroup }

function TRxRadioGroup.GetItemEnabled(Index: integer): boolean;
var
  R: TRadioButton;
begin
  if (Index < -1) or (Index >= Items.Count) then
    RaiseIndexOutOfBounds(Self, Items, Index);
  R := FindComponent('RadioButton' + IntToStr(Index)) as TRadioButton;
  if Assigned(R) then
    Result := R.Enabled
  else
    Result := False;
end;

procedure TRxRadioGroup.SetItemEnabled(Index: integer; AValue: boolean);
var
  R: TRadioButton;
begin
  if (Index < -1) or (Index >= Items.Count) then
    RaiseIndexOutOfBounds(Self, Items, Index);
  R := FindComponent('RadioButton' + IntToStr(Index)) as TRadioButton;
  if Assigned(R) then
    R.Enabled := AValue;
end;

constructor TRxCustomLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  {.$IFDEF WIN32}
  ControlStyle := ControlStyle + [csReplicatable];
  {.$ENDIF}
  Width := 65;
  Height := 17;
  FAutoSize := True;
  FShowAccelChar := True;
  FShadowColor := clBtnHighlight;
  FShadowSize := 1;
  FShadowPos := spLeftTop;
end;

function TRxCustomLabel.GetLabelCaption: string;
begin
  Result := Caption;
end;

function TRxCustomLabel.GetDefaultFontColor: TColor;
begin
  Result := Font.Color;
end;

procedure TRxCustomLabel.DoDrawText(var Rect: TRect; Flags: word);
var
  AText: string;
  PosShadow: TShadowPosition;
  SizeShadow: byte;
  ColorShadow: TColor;
begin
  AText := GetLabelCaption;
  if (Flags and DT_CALCRECT <> 0) and ((AText = '') or FShowAccelChar and
    (AText[1] = '&') and (AText[2] = #0)) then AText := AText + ' ';
  if not FShowAccelChar then Flags := Flags or DT_NOPREFIX;
  {$IFDEF USED_BiDi}
  Flags := DrawTextBiDiModeFlags(Flags);
  {$ENDIF}
  Canvas.Font := Font;
  Canvas.Font.Color := GetDefaultFontColor;
  PosShadow := FShadowPos;
  SizeShadow := FShadowSize;
  ColorShadow := FShadowColor;
  if not Enabled then
  begin
    if (FShadowSize = 0) and NewStyleControls then
    begin
      PosShadow := spRightBottom;
      SizeShadow := 1;
    end;
    Canvas.Font.Color := clGrayText;
    ColorShadow := clBtnHighlight;
  end;
  DrawShadowText(Canvas.Handle, PChar(AText), Length(AText), Rect, Flags,
    SizeShadow, ColorToRGB(ColorShadow), PosShadow);
end;

procedure TRxCustomLabel.Paint;
var
  Rect: TRect;
  DrawStyle: integer;
begin
  if not Enabled and not (csDesigning in ComponentState) then
    FDragging := False;

  with Canvas do
  begin
    if not Transparent then
    begin
      Brush.Color := Self.Color;
      Brush.Style := bsSolid;
      FillRect(ClientRect);
    end;
    Brush.Style := bsClear;
    Rect := ClientRect;
    Inc(Rect.Left, FLeftMargin);
    Dec(Rect.Right, FRightMargin);
    InflateRect(Rect, -1, 0);
    DrawStyle := {DT_EXPANDTABS or }WordWraps[FWordWrap] or Alignments[FAlignment];
    { Calculate vertical layout }
    if FLayout <> tlTop then
    begin
      DoDrawText(Rect, DrawStyle or DT_CALCRECT);
      Rect.Left := ClientRect.Left + FLeftMargin;
      Rect.Right := ClientRect.Right - FRightMargin;
      if FLayout = tlBottom then OffsetRect(Rect, 0, Height - Rect.Bottom)
      else
        OffsetRect(Rect, 0, (Height - Rect.Bottom) div 2);
    end;
    DoDrawText(Rect, DrawStyle);
    if FShowFocus and Assigned(FFocusControl) and FFocused and not
      (csDesigning in ComponentState) then
    begin
      InflateRect(Rect, 1, 0);
      Brush.Color := Self.Color;
      //      DrawFocusRect(Rect);
      FrameRect(Rect);
    end;
  end;
end;

procedure TRxCustomLabel.AdjustBounds;
var
  DC: HDC;
  X: integer;
  Rect: TRect;
  AAlignment: TAlignment;
begin
  if AutoSize then
  begin
    Rect := ClientRect;
    Inc(Rect.Left, FLeftMargin);
    Dec(Rect.Right, FRightMargin);
    InflateRect(Rect, -1, 0);
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Rect, {DT_EXPANDTABS or }DT_CALCRECT or WordWraps[FWordWrap]);
    Dec(Rect.Left, FLeftMargin);
    Inc(Rect.Right, FRightMargin);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    InflateRect(Rect, 1, 0);
    X := Left;
    AAlignment := FAlignment;
    {$IFDEF USED_BiDi}
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    {$ENDIF}
    if AAlignment = taRightJustify then Inc(X, Width - Rect.Right);
    SetBounds(X, Top, Rect.Right, Rect.Bottom);
  end;
end;

procedure TRxCustomLabel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetAutoSize(Value: boolean);
begin
  if AutoSize <> Value then
  begin
    FAutoSize := Value;
    AdjustBounds;
  end;
end;

procedure TRxCustomLabel.SetLayout(Value: TTextLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetLeftMargin(Value: integer);
begin
  if FLeftMargin <> Value then
  begin
    FLeftMargin := Max(Value, 0);
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetRightMargin(Value: integer);
begin
  if FRightMargin <> Value then
  begin
    FRightMargin := Max(Value, 0);
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetShadowColor(Value: TColor);
begin
  if Value <> FShadowColor then
  begin
    FShadowColor := Value;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetShadowSize(Value: byte);
begin
  if Value <> FShadowSize then
  begin
    FShadowSize := Value;
    AdjustBounds;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetShadowPos(Value: TShadowPosition);
begin
  if Value <> FShadowPos then
  begin
    FShadowPos := Value;
    Invalidate;
  end;
end;

function TRxCustomLabel.GetTransparent: boolean;
begin
  Result := not (csOpaque in ControlStyle);
end;

procedure TRxCustomLabel.SetFocusControl(Value: TWinControl);
begin
  FFocusControl := Value;
  {.$IFDEF WIN32}
  if Value <> nil then Value.FreeNotification(Self);
  {.$ENDIF}
  if FShowFocus then Invalidate;
end;

procedure TRxCustomLabel.SetShowAccelChar(Value: boolean);
begin
  if FShowAccelChar <> Value then
  begin
    FShowAccelChar := Value;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetTransparent(Value: boolean);
begin
  if Transparent <> Value then
  begin
    if Value then ControlStyle := ControlStyle - [csOpaque]
    else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetShowFocus(Value: boolean);
begin
  if FShowFocus <> Value then
  begin
    FShowFocus := Value;
    Invalidate;
  end;
end;

procedure TRxCustomLabel.SetWordWrap(Value: boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    AdjustBounds;
  end;
end;

procedure TRxCustomLabel.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FocusControl := nil;
end;

procedure TRxCustomLabel.MouseEnter;
begin
  if Assigned(FOnMouseEnter) then FOnMouseEnter(Self);
end;

procedure TRxCustomLabel.MouseLeave;
begin
  if Assigned(FOnMouseLeave) then FOnMouseLeave(Self);
end;

procedure TRxCustomLabel.UpdateTracking;
var
  P: TPoint;
  OldValue: boolean;
begin
  OldValue := FMouseInControl;
  GetCursorPos(P);
  FMouseInControl := Enabled and (FindDragTarget(P, True) = Self) and
    IsForegroundTask;
  if (FMouseInControl <> OldValue) then
    if FMouseInControl then MouseEnter
    else
      MouseLeave;
end;

procedure TRxCustomLabel.CMFocusChanged(var Message: TLMessage);
var
  Active: boolean;
begin
  Active := Assigned(FFocusControl) {and (Message.Sender = FFocusControl)};
  if FFocused <> Active then
  begin
    FFocused := Active;
    if FShowFocus then Invalidate;
  end;
  inherited;
end;

procedure TRxCustomLabel.CMTextChanged(var Message: TLMessage);
begin
  Invalidate;
  AdjustBounds;
end;

procedure TRxCustomLabel.CMFontChanged(var Message: TLMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TRxCustomLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if (FFocusControl <> nil) and Enabled and ShowAccelChar and
    IsAccel(Message.CharCode, GetLabelCaption) then
    with FFocusControl do
      if CanFocus then
      begin
        SetFocus;
        Message.Result := 1;
      end;
end;

{procedure TRxCustomLabel.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    FDragging := True;
  end;
end;

procedure TRxCustomLabel.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging and (Button = mbLeft) then FDragging := False;
  UpdateTracking;
end;
}
procedure TRxCustomLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  UpdateTracking;
end;

procedure TRxCustomLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  UpdateTracking;
end;
(*
procedure TRxCustomLabel.WMRButtonDown(var Message: TWMRButtonDown);
begin
  inherited;
  UpdateTracking;
end;

procedure TRxCustomLabel.WMRButtonUp(var Message: TWMRButtonUp);
begin
  inherited;
  UpdateTracking;
end;
*)
procedure TRxCustomLabel.CMEnabledChanged(var Message: TLMessage);
begin
  inherited;
  UpdateTracking;
end;

procedure TRxCustomLabel.CMVisibleChanged(var Message: TLMessage);
begin
  inherited;
  if Visible then UpdateTracking;
end;

procedure TRxCustomLabel.CMMouseEnter(var Message: TLMessage);
begin
  inherited;
  if not FMouseInControl and Enabled and IsForegroundTask then
  begin
    FMouseInControl := True;
    MouseEnter;
  end;
end;

procedure TRxCustomLabel.CMMouseLeave(var Message: TLMessage);
begin
  inherited;
  if FMouseInControl and Enabled and not FDragging then
  begin
    FMouseInControl := False;
    MouseLeave;
  end;
end;

{ TSecretPanel }

constructor TSecretPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FScrollCnt := 0;
  FAlignment := taCenter;
  FActive := False;
  FTxtDivider := 1;
  FGlyphLayout := glGlyphLeft;
  ControlStyle := ControlStyle - [csSetCaption];
  BevelOuter := bvLowered;
  FTextStyle := bvNone;
  FLines := TStringList.Create;
  TStringList(FLines).OnChange := @LinesChanged;
  FGlyph := TBitmap.Create;
  FGlyph.OnChange := @GlyphChanged;
  FHiddenList := TList.Create;
  FTimer := TTimer.Create(Self);
  with FTimer do
  begin
    Enabled := False;
    OnTimer := @TimerExpired;
    Interval := 30;
    {$IFDEF RX_D3}
    //    SyncEvent := False;
    FAsyncDrawing := True;
    {$ENDIF}
  end;
end;

destructor TSecretPanel.Destroy;
begin
  SetActive(False);
  FGlyph.OnChange := nil;
  FGlyph.Free;
  TStringList(FLines).OnChange := nil;
  FLines.Free;
  FHiddenList.Free;
  inherited Destroy;
end;

procedure TSecretPanel.GlyphChanged(Sender: TObject);
begin
  if Active then
  begin
    UpdateMemoryImage;
    Invalidate;
  end;
end;

procedure TSecretPanel.LinesChanged(Sender: TObject);
begin
  if Active then
  begin
    FScrollCnt := 0;
    UpdateMemoryImage;
    Invalidate;
  end;
end;

procedure TSecretPanel.CMFontChanged(var Message: TLMessage);
begin
  inherited;
  if Active then UpdateMemoryImage;
end;

procedure TSecretPanel.CMColorChanged(var Message: TLMessage);
begin
  inherited;
  if Active then UpdateMemoryImage;
end;

//procedure TSecretPanel.WMSize(var Message: TLMessage);
procedure TSecretPanel.WMSize(var Message: TLMSize);
begin
  inherited;
  if Active then
  begin
    UpdateMemoryImage;
    Invalidate;
  end;
end;

{$IFDEF RX_D3}
procedure TSecretPanel.SetAsyncDrawing(Value: boolean);
begin
  if FAsyncDrawing <> Value then
  begin
    //    FTimer.SyncEvent := not Value;
    FAsyncDrawing := Value;
  end;
end;
{$ENDIF RX_D3}

procedure TSecretPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  inherited AlignControls(AControl, Rect);
  if (AControl = nil) and Active then UpdateMemoryImage;
end;

function TSecretPanel.GetInflateWidth: integer;
begin
  Result := BorderWidth;
  if BevelOuter <> bvNone then Inc(Result, BevelWidth);
  if BevelInner <> bvNone then Inc(Result, BevelWidth);
end;

procedure TSecretPanel.RecalcDrawRect;
const
  MinOffset = 3;
var
  InflateWidth: integer;
  LastLine: integer;
begin
  FTxtRect := GetClientRect;
  FPaintRect := FTxtRect;
  InflateWidth := GetInflateWidth;
  InflateRect(FPaintRect, -InflateWidth, -InflateWidth);
  Inc(InflateWidth, MinOffset);
  InflateRect(FTxtRect, -InflateWidth, -InflateWidth);
  with FGlyphOrigin do
  begin
    case FGlyphLayout of
      glGlyphLeft:
      begin
        X := FTxtRect.Left;
        Y := (FTxtRect.Bottom + FTxtRect.Top - Glyph.Height) div 2;
        if Y < FTxtRect.Top then Y := FTxtRect.Top;
        if Glyph.Width > 0 then
        begin
          Inc(X, MinOffset);
          FTxtRect.Left := X + Glyph.Width + InflateWidth;
        end;
      end;
      glGlyphRight:
      begin
        Y := (FTxtRect.Bottom + FTxtRect.Top - Glyph.Height) div 2;
        if Y < FTxtRect.Top then Y := FTxtRect.Top;
        X := FTxtRect.Right - Glyph.Width;
        if Glyph.Width > 0 then
        begin
          Dec(X, MinOffset);
          if X < FTxtRect.Left then X := FTxtRect.Left;
          FTxtRect.Right := X - InflateWidth;
        end;
      end;
      glGlyphTop:
      begin
        Y := FTxtRect.Top;
        X := (FTxtRect.Right + FTxtRect.Left - Glyph.Width) div 2;
        if X < FTxtRect.Left then X := FTxtRect.Left;
        if Glyph.Height > 0 then
        begin
          Inc(Y, MinOffset);
          FTxtRect.Top := Y + Glyph.Height + (InflateWidth + MinOffset);
        end;
      end;
      glGlyphBottom:
      begin
        X := (FTxtRect.Right + FTxtRect.Left - Glyph.Width) div 2;
        if X < FTxtRect.Left then X := FTxtRect.Left;
        Y := FTxtRect.Bottom - Glyph.Height;
        if Glyph.Height > 0 then
        begin
          Dec(Y, MinOffset);
          if Y < FTxtRect.Top then Y := FTxtRect.Top;
          FTxtRect.Bottom := Y - (InflateWidth + MinOffset);
        end;
      end;
    end;
  end;
  if FDirection = sdHorizontal then
  begin
    LastLine := FLines.Count - 1;
    while (LastLine >= 0) and (Trim(FLines[LastLine]) = '') do
      Dec(LastLine);
    InflateWidth := HeightOf(FTxtRect) - (LastLine + 1 - FFirstLine) * FTxtDivider;
    if InflateWidth > 0 then
      InflateRect(FTxtRect, 0, -InflateWidth div 2);
  end;
  with FTxtRect do
    if (Left >= Right) or (Top >= Bottom) then FTxtRect := Rect(0, 0, 0, 0);
end;

procedure TSecretPanel.PaintGlyph;
begin
  if not FGlyph.Empty then
  begin
    RecalcDrawRect;
    Canvas.Draw(FGlyphOrigin.X, FGlyphOrigin.Y, FGlyph);
    //DrawBitmapTransparent(Canvas, FGlyphOrigin.X, FGlyphOrigin.Y, FGlyph, FGlyph.TransparentColor and not PaletteMask);
  end;
end;

procedure TSecretPanel.PaintText;
var
  STmp: array[0..255] of char;
  R: TRect;
  I: integer;
  Flags: longint;
begin
  if (FLines.Count = 0) or IsRectEmpty(FTxtRect) or not HandleAllocated then
    Exit;
  {$IFDEF RX_D3}
  FMemoryImage.Canvas.Lock;
  try
    {$ENDIF}
    with FMemoryImage.Canvas do
    begin
      I := SaveDC(Handle);
      try
        with FTxtRect do
          MoveWindowOrg(Handle, -Left, -Top);
        Brush.Color := Self.Color;
        PaintClient(FMemoryImage.Canvas, FPaintRect);
      finally
        RestoreDC(Handle, I);
        SetBkMode(Handle, Transparent);
      end;
    end;
    R := Bounds(0, 0, WidthOf(FTxtRect), HeightOf(FTxtRect));
    if FDirection = sdHorizontal then
    begin
      {$IFDEF RX_D4}
      if IsRightToLeft then
      begin
        R.Right := R.Left + FScrollCnt;
        R.Left := R.Right - (FMaxScroll - WidthOf(FTxtRect));
      end
      else
      begin
        R.Left := R.Right - FScrollCnt;
        R.Right := R.Left + (FMaxScroll - WidthOf(FTxtRect));
      end;
      {$ELSE}
      R.Left := R.Right - FScrollCnt;
      R.Right := R.Left + (FMaxScroll - WidthOf(FTxtRect));
      {$ENDIF}
    end
    else
    begin { sdVertical }
      R.Top := R.Bottom - FScrollCnt;
    end;
    R.Bottom := R.Top + FTxtDivider;
    Flags := {DT_EXPANDTABS or }Alignments[FAlignment] or DT_SINGLELINE or
      DT_NOCLIP or DT_NOPREFIX;
    {$IFDEF USED_BiDi}
    Flags := DrawTextBiDiModeFlags(Flags);
    {$ENDIF}
    for I := FFirstLine to FLines.Count do
    begin
      if I = FLines.Count then StrCopy(STmp, ' ')
      else
        StrPLCopy(STmp, FLines[I], SizeOf(STmp) - 1);
      if R.Top >= HeightOf(FTxtRect) then Break
      else if R.Bottom > 0 then
      begin
        if FTextStyle <> bvNone then
        begin
          FMemoryImage.Canvas.Font.Color := clBtnHighlight;
          case FTextStyle of
            bvLowered:
            begin
              OffsetRect(R, 1, 1);
              DrawText(FMemoryImage.Canvas.Handle, STmp, -1, R, Flags);
              OffsetRect(R, -1, -1);
            end;
            bvRaised:
            begin
              OffsetRect(R, -1, -1);
              DrawText(FMemoryImage.Canvas.Handle, STmp, -1, R, Flags);
              OffsetRect(R, 1, 1);
            end;
          end;
          FMemoryImage.Canvas.Font.Color := Self.Font.Color;
          SetBkMode(FMemoryImage.Canvas.Handle, Transparent);
        end;
        DrawText(FMemoryImage.Canvas.Handle, STmp, -1, R, Flags);
      end;
      OffsetRect(R, 0, FTxtDivider);
    end;
    {$IFDEF RX_D3}
    Canvas.Lock;
    try
      {$ENDIF}
      BitBlt(Canvas.Handle, FTxtRect.Left, FTxtRect.Top, FMemoryImage.Width,
        FMemoryImage.Height, FMemoryImage.Canvas.Handle, 0, 0, SRCCOPY);
      //      ValidateRect(Handle, @FTxtRect);
      {$IFDEF RX_D3}
    finally
      Canvas.Unlock;
    end;
    {$ENDIF}
    {$IFDEF RX_D3}
  finally
    FMemoryImage.Canvas.Unlock;
  end;
  {$ENDIF}
end;

procedure TSecretPanel.PaintClient(ACanvas: TCanvas; Rect: TRect);
begin
  if Assigned(FOnPaintClient) then FOnPaintClient(Self, ACanvas, Rect)
  else
    ACanvas.FillRect(Rect);
end;

procedure TSecretPanel.Paint;
var
  Rect: TRect;
  TopColor, BottomColor: TColor;
  SaveIndex: integer;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then BottomColor := clBtnHighlight;
  end;

begin
  Rect := GetClientRect;
  if BevelOuter <> bvNone then
  begin
    AdjustColors(BevelOuter);
    //    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    WidgetSet.Frame3d(Canvas.Handle, Rect, BevelWidth, BevelOuter);
  end;
  //  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  WidgetSet.Frame3d(Canvas.Handle, Rect, BorderWidth, BevelOuter);
  if BevelInner <> bvNone then
  begin
    AdjustColors(BevelInner);
    //    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
    WidgetSet.Frame3d(Canvas.Handle, Rect, BorderWidth, BevelInner);
  end;
  SaveIndex := SaveDC(Canvas.Handle);
  try
    with Rect do
      IntersectClipRect(Canvas.Handle, Left, Top, Right, Bottom);
    Canvas.Brush.Color := Self.Color;
    PaintClient(Canvas, Rect);
  finally
    RestoreDC(Canvas.Handle, SaveIndex);
  end;
  if Active then
  begin
    PaintGlyph;
    PaintText;
  end;
end;

procedure TSecretPanel.StartPlay;
begin
  if Assigned(FOnStartPlay) then FOnStartPlay(Self);
end;

procedure TSecretPanel.StopPlay;
begin
  if Assigned(FOnStopPlay) then FOnStopPlay(Self);
end;

procedure TSecretPanel.TimerExpired(Sender: TObject);
begin
  if (FScrollCnt < FMaxScroll) then
  begin
    Inc(FScrollCnt);
    if Assigned(FMemoryImage) then PaintText;
  end
  else if Cycled then
  begin
    FScrollCnt := 0;
    if Assigned(FMemoryImage) then PaintText;
  end
  else
  begin
    {.$IFDEF RX_D3}
    //    FTimer.Synchronize(Stop);
    {.$ELSE}
    SetActive(False);
    {.$ENDIF}
  end;
end;

procedure TSecretPanel.UpdateMemoryImage;
var
  Metrics: TTextMetric;
  I: integer;
begin
  if FMemoryImage = nil then FMemoryImage := TBitmap.Create;
  {.$IFDEF RX_D3}
  FMemoryImage.Canvas.Lock;
  try
    {.$ENDIF}
    FFirstLine := 0;
    while (FFirstLine < FLines.Count) and (Trim(FLines[FFirstLine]) = '') do
      Inc(FFirstLine);
    Canvas.Font := Self.Font;
    GetTextMetrics(Canvas.Handle, Metrics);
    FTxtDivider := Metrics.tmHeight + Metrics.tmExternalLeading;
    if FTextStyle <> bvNone then Inc(FTxtDivider);
    RecalcDrawRect;
    if FDirection = sdHorizontal then
    begin
      FMaxScroll := 0;
      for I := FFirstLine to FLines.Count - 1 do
        FMaxScroll := Max(FMaxScroll, Canvas.TextWidth(FLines[I]));
      Inc(FMaxScroll, WidthOf(FTxtRect));
    end
    else
    begin { sdVertical }
      FMaxScroll := ((FLines.Count - FFirstLine) * FTxtDivider) +
        HeightOf(FTxtRect);
    end;
    FMemoryImage.Width := WidthOf(FTxtRect);
    FMemoryImage.Height := HeightOf(FTxtRect);
    with FMemoryImage.Canvas do
    begin
      Font := Self.Font;
      Brush.Color := Self.Color;
      SetBkMode(Handle, Transparent);
    end;
    {.$IFDEF RX_D3}
  finally
    FMemoryImage.Canvas.UnLock;
  end;
  {.$ENDIF}
end;

function TSecretPanel.GetInterval: cardinal;
begin
  Result := FTimer.Interval;
end;

procedure TSecretPanel.SetInterval(Value: cardinal);
begin
  FTimer.Interval := Value;
end;

procedure TSecretPanel.Play;
begin
  SetActive(True);
end;

procedure TSecretPanel.Stop;
begin
  SetActive(False);
end;

procedure TSecretPanel.SetActive(Value: boolean);
var
  I: integer;
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if FActive then
    begin
      FScrollCnt := 0;
      UpdateMemoryImage;
      try
        FTimer.Enabled := True;
        StartPlay;
      except
        FActive := False;
        FTimer.Enabled := False;
        raise;
      end;
    end
    else
    begin
      {.$IFDEF RX_D3}
      FMemoryImage.Canvas.Lock;
      { ensure that canvas is locked before timer is disabled }
      {.$ENDIF}
      FTimer.Enabled := False;
      FScrollCnt := 0;
      FMemoryImage.Free;
      FMemoryImage := nil;
      StopPlay;
      if (csDesigning in ComponentState) and not
        (csDestroying in ComponentState) then
        ValidParentForm(Self).Designer.Modified;
    end;
    if not (csDestroying in ComponentState) then
      for I := 0 to Pred(ControlCount) do
      begin
        if FActive then
        begin
          if Controls[I].Visible then FHiddenList.Add(Controls[I]);
          if not (csDesigning in ComponentState) then
            Controls[I].Visible := False;
        end
        else
        if FHiddenList.IndexOf(Controls[I]) >= 0 then
        begin
          Controls[I].Visible := True;
          Controls[I].Invalidate;
          if (csDesigning in ComponentState) then Controls[I].Update;
        end;
      end;
    if not FActive then FHiddenList.Clear;
    Invalidate;
  end;
end;

procedure TSecretPanel.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    if Active then Invalidate;
  end;
end;

procedure TSecretPanel.SetGlyph(Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;

procedure TSecretPanel.SetDirection(Value: TScrollDirection);
begin
  if FDirection <> Value then
  begin
    FDirection := Value;
    if FActive then
    begin
      FScrollCnt := 0;
      UpdateMemoryImage;
      Invalidate;
    end;
  end;
end;

procedure TSecretPanel.SetTextStyle(Value: TPanelBevel);
begin
  if FTextStyle <> Value then
  begin
    FTextStyle := Value;
    if FActive then
    begin
      UpdateMemoryImage;
      Invalidate;
    end;
  end;
end;

procedure TSecretPanel.SetGlyphLayout(Value: TGlyphLayout);
begin
  if FGlyphLayout <> Value then
  begin
    FGlyphLayout := Value;
    if FActive then
    begin
      UpdateMemoryImage;
      Invalidate;
    end;
  end;
end;

procedure TSecretPanel.SetLines(Value: TStrings);
begin
  FLines.Assign(Value);
end;
(*
{ TGlyphList }

type
  TGlyphList = class(TImageList)
  private
    FUsed: TBits;
    FCount: Integer;
    function AllocateIndex: Integer;
  public
    constructor CreateSize(AWidth, AHeight: Integer);
    destructor Destroy; override;
    function Add(Image, Mask: TBitmap): Integer;
    function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
{$IFDEF WIN32}
{$IFNDEF RX_D3} { Delphi 2.0 bug fix }
    procedure ReplaceMasked(Index: Integer; NewImage: TBitmap; MaskColor: TColor);
{$ENDIF}
{$ENDIF}
    procedure Delete(Index: Integer);
    property Count: Integer read FCount;
  end;

{ TGlyphCache }

  TGlyphCache = class
  private
    FGlyphLists: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetList(AWidth, AHeight: Integer): TGlyphList;
    procedure ReturnList(List: TGlyphList);
    function Empty: Boolean;
  end;

{ TGlyphList }

constructor TGlyphList.CreateSize(AWidth, AHeight: Integer);
begin
{$IFDEF WIN32}
  inherited CreateSize(AWidth, AHeight);
{$ELSE}
  inherited Create(AWidth, AHeight);
{$ENDIF}
  FUsed := TBits.Create;
end;

destructor TGlyphList.Destroy;
begin
  FUsed.Free;
  inherited Destroy;
end;

function TGlyphList.AllocateIndex: Integer;
begin
  Result := FUsed.OpenBit;
  if Result >= FUsed.Size then begin
    Result := inherited Add(nil, nil);
    FUsed.Size := Result + 1;
  end;
  FUsed[Result] := True;
end;

{$IFDEF WIN32}
{$IFNDEF RX_D3} { Delphi 2.0 bug fix }
procedure TGlyphList.ReplaceMasked(Index: Integer; NewImage: TBitmap; MaskColor: TColor);
var
  TempIndex: Integer;
  Image, Mask: TBitmap;
begin
  if HandleAllocated then begin
    TempIndex := inherited AddMasked(NewImage, MaskColor);
    if TempIndex <> -1 then
    try
      Image := TBitmap.Create;
      Mask := TBitmap.Create;
      try
        with Image do begin
          Height := Self.Height;
          Width := Self.Width;
        end;
        with Mask do begin
          Monochrome := True; { fix }
          Height := Self.Height;
          Width := Self.Width;
        end;
        ImageList_Draw(Handle, TempIndex, Image.Canvas.Handle, 0, 0, ILD_NORMAL);
        ImageList_Draw(Handle, TempIndex, Mask.Canvas.Handle, 0, 0, ILD_MASK);
        if not ImageList_Replace(Handle, Index, Image.Handle, Mask.Handle) then
          raise EInvalidOperation.Create(LoadStr(SReplaceImage));
      finally
        Image.Free;
        Mask.Free;
      end;
    finally
      inherited Delete(TempIndex);
    end
    else raise EInvalidOperation.Create(LoadStr(SReplaceImage));
  end;
  Change;
end;
{$ENDIF}
{$ENDIF}

function TGlyphList.Add(Image, Mask: TBitmap): Integer;
begin
  Result := AllocateIndex;
  Replace(Result, Image, Mask);
  Inc(FCount);
end;

function TGlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
begin
  Result := AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;

procedure TGlyphList.Delete(Index: Integer);
begin
  if FUsed[Index] then begin
    Dec(FCount);
    FUsed[Index] := False;
  end;
end;

{ TGlyphCache }

constructor TGlyphCache.Create;
begin
  inherited Create;
  FGlyphLists := TList.Create;
end;

destructor TGlyphCache.Destroy;
begin
  FGlyphLists.Free;
  inherited Destroy;
end;

function TGlyphCache.GetList(AWidth, AHeight: Integer): TGlyphList;
var
  I: Integer;
begin
  for I := FGlyphLists.Count - 1 downto 0 do begin
    Result := FGlyphLists[I];
    with Result do
      if (AWidth = Width) and (AHeight = Height) then Exit;
  end;
  Result := TGlyphList.CreateSize(AWidth, AHeight);
  FGlyphLists.Add(Result);
end;

procedure TGlyphCache.ReturnList(List: TGlyphList);
begin
  if List = nil then Exit;
  if List.Count = 0 then begin
    FGlyphLists.Remove(List);
    List.Free;
  end;
end;

function TGlyphCache.Empty: Boolean;
begin
  Result := FGlyphLists.Count = 0;
end;

const
  GlyphCache: TGlyphCache = nil;

{ TRxButtonGlyph }

constructor TRxButtonGlyph.Create;
var
  I: TRxButtonState;
begin
  inherited Create;
  FOriginal := TBitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clFuchsia;
  FAlignment := taCenter;
  FNumGlyphs := 1;
  for I := Low(I) to High(I) do FIndexs[I] := -1;
  if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
end;

destructor TRxButtonGlyph.Destroy;
begin
  FOriginal.Free;
  Invalidate;
  if Assigned(GlyphCache) and GlyphCache.Empty then begin
    GlyphCache.Free;
    GlyphCache := nil;
  end;
  inherited Destroy;
end;

procedure TRxButtonGlyph.Invalidate;
var
  I: TRxButtonState;
begin
  for I := Low(I) to High(I) do begin
    if Assigned(FGlyphList) then
      if (FIndexs[I] <> -1) then TGlyphList(FGlyphList).Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
  GlyphCache.ReturnList(TGlyphList(FGlyphList));
  FGlyphList := nil;
end;

procedure TRxButtonGlyph.GlyphChanged(Sender: TObject);
var
  Glyphs: Integer;
begin
  if Sender = FOriginal then begin
    Invalidate;
    if (FOriginal <> nil) and (FOriginal.Height > 0) then begin
      FTransparentColor := FOriginal.TransparentColor and not PaletteMask;
      if FOriginal.Width mod FOriginal.Height = 0 then begin
        Glyphs := FOriginal.Width div FOriginal.Height;
        if Glyphs > (Ord(High(TRxButtonState)) + 1) then Glyphs := 1;
        SetNumGlyphs(Glyphs);
      end;
    end;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TRxButtonGlyph.SetGlyph(Value: TBitmap);
begin
  Invalidate;
  FOriginal.Assign(Value);
end;

procedure TRxButtonGlyph.SetNumGlyphs(Value: TRxNumGlyphs);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then begin
    Invalidate;
    FNumGlyphs := Value;
  end;
end;

function TRxButtonGlyph.MapColor(Color: TColor): TColor;
var
  Index: Byte;
begin
  if (Color = FTransparentColor) or (ColorToRGB(Color) =
    ColorToRGB(clBtnFace)) then Result := Color
  else begin
    Color := ColorToRGB(Color);
    Index := Byte(Longint(Word(GetRValue(Color)) * 77 +
      Word(GetGValue(Color)) * 150 + Word(GetBValue(Color)) * 29) shr 8);
    Result := RGB(Index, Index, Index);
  end;
end;

{$IFDEF WIN32}
function TRxButtonGlyph.CreateImageGlyph(State: TRxButtonState;
  Images: TImageList; Index: Integer): Integer;
var
  TmpImage, Mask: TBitmap;
  IWidth, IHeight, X, Y: Integer;
begin
  if (State = rbsDown) then State := rbsUp;
  Result := FIndexs[State];
  if (Result <> -1) or (Images.Width = 0) or (Images.Height = 0) or
    (Images.Count = 0) then Exit;
  IWidth := Images.Width;
  IHeight := Images.Height;
  if FGlyphList = nil then begin
    if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    case State of
      rbsUp, rbsDown, rbsExclusive:
        begin
          with TmpImage.Canvas do begin
            FillRect(Rect(0, 0, IWidth, IHeight));
            ImageList_Draw(Images.Handle, Index, Handle, 0, 0, ILD_NORMAL);
          end;
          Mask := TBitmap.Create;
          try
            with Mask do begin
              Monochrome := True;
              Height := IHeight;
              Width := IWidth;
            end;
            with Mask.Canvas do begin
              FillRect(Rect(0, 0, IWidth, IHeight));
              ImageList_Draw(Images.Handle, Index, Handle, 0, 0, ILD_MASK);
            end;
            FIndexs[State] := TGlyphList(FGlyphList).Add(TmpImage, Mask);
          finally
            Mask.Free;
          end;
        end;
      rbsDisabled:
        begin
          TmpImage.Canvas.Brush.Color := clBtnFace;
          TmpImage.Canvas.FillRect(Rect(0, 0, IWidth, IHeight));
          ImageListDrawDisabled(Images, TmpImage.Canvas, 0, 0, Index,
            clBtnHighlight, clBtnShadow, True);
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage,
            ColorToRGB(clBtnFace));
        end;
      rbsInactive:
        begin
          TmpImage.Canvas.Brush.Color := clBtnFace;
          TmpImage.Canvas.FillRect(Rect(0, 0, IWidth, IHeight));
          ImageList_Draw(Images.Handle, Index, TmpImage.Canvas.Handle, 0, 0,
            ILD_NORMAL);
          with TmpImage do begin
            for X := 0 to Width - 1 do
              for Y := 0 to Height - 1 do
                Canvas.Pixels[X, Y] := MapColor(Canvas.Pixels[X, Y]);
          end;
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage,
            ColorToRGB(clBtnFace));
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
end;
{$ENDIF}

function TRxButtonGlyph.CreateButtonGlyph(State: TRxButtonState): Integer;
var
  TmpImage, MonoBmp: TBitmap;
  IWidth, IHeight, X, Y: Integer;
  IRect, ORect: TRect;
  I: TRxButtonState;
begin
  if (State = rbsDown) and (NumGlyphs < 3) then State := rbsUp;
  Result := FIndexs[State];
  if (Result <> -1) or (FOriginal.Width = 0) or (FOriginal.Height = 0) or
    FOriginal.Empty then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then begin
    if GlyphCache = nil then GlyphCache := TGlyphCache.Create;
    FGlyphList := GlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    I := State;
    if Ord(I) >= NumGlyphs then I := rbsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      rbsUp, rbsDown, rbsExclusive:
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, FTransparentColor);
        end;
      rbsDisabled:
        if NumGlyphs > 1 then begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, FTransparentColor);
        end
        else begin
          MonoBmp := CreateDisabledBitmap(FOriginal, clBlack);
          try
            FIndexs[State] := TGlyphList(FGlyphList).AddMasked(MonoBmp,
              ColorToRGB(clBtnFace));
          finally
            MonoBmp.Free;
          end;
        end;
      rbsInactive:
        if NumGlyphs > 4 then begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, FTransparentColor);
        end
        else begin
          with TmpImage do begin
            for X := 0 to Width - 1 do
              for Y := 0 to Height - 1 do
                Canvas.Pixels[X, Y] := MapColor(FOriginal.Canvas.Pixels[X, Y]);
          end;
          FIndexs[State] := TGlyphList(FGlyphList).AddMasked(TmpImage, FTransparentColor);
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;

procedure TRxButtonGlyph.DrawPopupMark(Canvas: TCanvas; X, Y: Integer;
  State: TRxButtonState);
var
  AColor: TColor;

  procedure DrawMark;
  var
    I: Integer;
  begin
    with Canvas do begin
      for I := 0 to 6 do begin
        Pixels[X + I, Y - 1] := AColor;
        if (I > 0) and (I < 6) then begin
          Pixels[X + I, Y] := AColor;
          if (I > 1) and (I < 5) then Pixels[X + I, Y + 1] := AColor;
        end;
      end;
      Pixels[X + 3, Y + 2] := AColor;
    end;
  end;

begin
  if State = rbsDisabled then begin
    AColor := clBtnHighlight;
    Inc(X, 1); Inc(Y, 1);
    DrawMark;
    Dec(X, 1); Dec(Y, 1);
    AColor := clBtnShadow;
  end
  else AColor := clBtnText;
  DrawMark;
end;

function TRxButtonGlyph.DrawButtonGlyph(Canvas: TCanvas; X, Y: Integer;
  State: TRxButtonState): TPoint;
var
  Index: Integer;
begin
  Result := Point(0, 0);
  if (FOriginal = nil) or (FOriginal.Width = 0) or (FOriginal.Height = 0) or
    FOriginal.Empty then Exit;
  Index := CreateButtonGlyph(State);
  if Index >= 0 then begin
{$IFDEF WIN32}
    ImageList_Draw(FGlyphList.Handle, Index, Canvas.Handle, X, Y, ILD_NORMAL);
{$ELSE}
    FGlyphList.Draw(Canvas, X, Y, Index);
{$ENDIF}
    Result := Point(FGlyphList.Width, FGlyphList.Height);
  end;
end;

{$IFDEF WIN32}
function TRxButtonGlyph.DrawButtonImage(Canvas: TCanvas; X, Y: Integer;
  Images: TImageList; ImageIndex: Integer; State: TRxButtonState): TPoint;
var
  Index: Integer;
begin
  Result := Point(0, 0);
  if (Images = nil) or (ImageIndex < 0) or (ImageIndex >= Images.Count) then
    Exit;
  if State = rbsDisabled then begin
    ImageListDrawDisabled(Images, Canvas, X, Y, ImageIndex, clBtnHighlight,
      clBtnShadow, True);
  end
  else if State = rbsInactive then begin
    Index := CreateImageGlyph(State, Images, ImageIndex);
    if Index >= 0 then
      ImageList_Draw(FGlyphList.Handle, Index, Canvas.Handle, X, Y, ILD_NORMAL);
  end
  else
    ImageList_Draw(Images.Handle, ImageIndex, Canvas.Handle, X, Y, ILD_NORMAL);
  Result := Point(Images.Width, Images.Height);
end;
{$ENDIF}

procedure TRxButtonGlyph.MinimizeCaption(Canvas: TCanvas; const Caption: string;
  Buffer: PChar; MaxLen, Width: Integer);
var
  I: Integer;
{$IFNDEF WIN32}
  P: PChar;
{$ENDIF}
  Lines: TStrings;
begin
  StrPLCopy(Buffer, Caption, MaxLen);
  if FWordWrap then Exit;
  Lines := TStringList.Create;
  try
{$IFDEF WIN32}
    Lines.Text := Caption;
    for I := 0 to Lines.Count - 1 do
      Lines[I] := MinimizeText(Lines[I], Canvas, Width);
    StrPLCopy(Buffer, TrimRight(Lines.Text), MaxLen);
{$ELSE}
    Lines.SetText(Buffer);
    for I := 0 to Lines.Count - 1 do
      Lines[I] := MinimizeText(Lines[I], Canvas, Width);
    P := Lines.GetText;
    try
      StrPLCopy(Buffer, TrimRight(StrPas(P)), MaxLen);
    finally
      StrDispose(P);
    end;
{$ENDIF}
  finally
    Lines.Free;
  end;
end;

procedure TRxButtonGlyph.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TRxButtonState; Flags: Word);
var
  CString: array[0..255] of Char;
begin
  Canvas.Brush.Style := bsClear;
  StrPLCopy(CString, Caption, SizeOf(CString) - 1);
  Flags := DT_VCENTER or WordWraps[FWordWrap] or Flags;
  if State = rbsDisabled then begin
    with Canvas do begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      DrawText(Handle, CString, Length(Caption), TextBounds, Flags);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      DrawText(Handle, CString, Length(Caption), TextBounds, Flags);
    end;
  end
  else DrawText(Canvas.Handle, CString, -1, TextBounds, Flags);
end;

procedure TRxButtonGlyph.CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
  var Caption: string; Layout: TButtonLayout; Margin, Spacing: Integer;
  PopupMark: Boolean; var GlyphPos: TPoint; var TextBounds: TRect; Flags: Word
  {$IFDEF WIN32}; Images: TImageList; ImageIndex: Integer {$ENDIF});
var
  TextPos: TPoint;
  MaxSize, ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
  CString: array[0..255] of Char;
begin
  { calculate the item sizes }
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom - Client.Top);
{$IFDEF WIN32}
  if Assigned(Images) and (Images.Width > 0) and (ImageIndex >= 0) and
    (ImageIndex < Images.Count) then
    GlyphSize := Point(Images.Width, Images.Height)
  else
{$ENDIF}
  if FOriginal <> nil then
    GlyphSize := Point(FOriginal.Width div FNumGlyphs, FOriginal.Height)
  else GlyphSize := Point(0, 0);
  if Layout in [blGlyphLeft, blGlyphRight] then begin
    MaxSize.X := ClientSize.X - GlyphSize.X;
    if Margin <> -1 then Dec(MaxSize.X, Margin);
    if Spacing <> -1 then Dec(MaxSize.X, Spacing);
    if PopupMark then Dec(MaxSize.X, 9);
    MaxSize.Y := ClientSize.Y;
  end
  else { blGlyphTop, blGlyphBottom } begin
    MaxSize.X := ClientSize.X;
    MaxSize.Y := ClientSize.Y - GlyphSize.Y;
    if Margin <> -1 then Dec(MaxSize.Y, Margin);
    if Spacing <> -1 then Dec(MaxSize.Y, Spacing);
  end;
  MaxSize.X := Max(0, MaxSize.X);
  MaxSize.Y := Max(0, MaxSize.Y);
  MinimizeCaption(Canvas, Caption, CString, SizeOf(CString) - 1, MaxSize.X);
  Caption := StrPas(CString);
  if Length(Caption) > 0 then begin
    TextBounds := Rect(0, 0, MaxSize.X, 0);
    DrawText(Canvas.Handle, CString, -1, TextBounds, DT_CALCRECT or DT_CENTER
      or DT_VCENTER or WordWraps[FWordWrap] or Flags);
  end
  else TextBounds := Rect(0, 0, 0, 0);
  TextBounds.Bottom := Max(TextBounds.Top, TextBounds.Top +
    Min(MaxSize.Y, HeightOf(TextBounds)));
  TextBounds.Right := Max(TextBounds.Left, TextBounds.Left +
    Min(MaxSize.X, WidthOf(TextBounds)));
  TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
    TextBounds.Top);
  if PopupMark then
    if ((GlyphSize.X = 0) or (GlyphSize.Y = 0)) or (Layout = blGlyphLeft) then
      Inc(TextSize.X, 9)
    else if (GlyphSize.X > 0) then
      Inc(GlyphSize.X, 6);
  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [blGlyphLeft, blGlyphRight] then begin
    GlyphPos.Y := (ClientSize.Y div 2) - (GlyphSize.Y div 2);
    TextPos.Y := (ClientSize.Y div 2) - (TextSize.Y div 2);
  end
  else begin
    GlyphPos.X := (ClientSize.X div 2) - (GlyphSize.X div 2);
    TextPos.X := (ClientSize.X div 2) - (TextSize.X div 2);
  end;
  { if there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (GlyphSize.X = 0) then Spacing := 0;
  { adjust Margin and Spacing }
  if Margin = -1 then begin
    if Spacing = -1 then begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else Margin := (ClientSize.Y - TotalSize.Y) div 3;
      Spacing := Margin;
    end
    else begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.X div 2) - (TotalSize.X div 2)
      else Margin := (ClientSize.Y div 2) - (TotalSize.Y div 2);
    end;
  end
  else begin
    if Spacing = -1 then begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y -
        (Margin + GlyphSize.Y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.X div 2) - (TextSize.X div 2)
      else Spacing := (TotalSize.Y div 2) - (TextSize.Y div 2);
    end;
  end;
  case Layout of
    blGlyphLeft:
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
      end;
    blGlyphRight:
      begin
        GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    blGlyphTop:
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
      end;
    blGlyphBottom:
      begin
        GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
      end;
  end;
  { fixup the result variables }
  Inc(GlyphPos.X, Client.Left);
  Inc(GlyphPos.Y, Client.Top);
  OffsetRect(TextBounds, TextPos.X + Client.Left, TextPos.Y + Client.Top);
end;

{$IFDEF WIN32}
function TRxButtonGlyph.Draw(Canvas: TCanvas; const Client: TRect;
  const Caption: string; Layout: TButtonLayout; Margin, Spacing: Integer;
  PopupMark: Boolean; State: TRxButtonState; Flags: Word): TRect;
begin
  Result := DrawEx(Canvas, Client, Caption, Layout, Margin, Spacing,
    PopupMark, nil, -1, State, Flags);
end;
{$ENDIF}

{$IFDEF WIN32}
function TRxButtonGlyph.DrawEx(Canvas: TCanvas; const Client: TRect;
  const Caption: string; Layout: TButtonLayout; Margin, Spacing: Integer;
  PopupMark: Boolean; Images: TImageList; ImageIndex: Integer;
  State: TRxButtonState; Flags: Word): TRect;
{$ELSE}
function TRxButtonGlyph.Draw(Canvas: TCanvas; const Client: TRect;
  const Caption: string; Layout: TButtonLayout; Margin, Spacing: Integer;
  PopupMark: Boolean; State: TRxButtonState; Flags: Word): TRect;
{$ENDIF}
var
{$IFDEF WIN32}
  UseImages: Boolean;
{$ENDIF}
  GlyphPos, PopupPos: TPoint;
  TextBounds: TRect;
  CaptionText: string;
begin
  CaptionText := Caption;
  CalcButtonLayout(Canvas, Client, CaptionText, Layout, Margin, Spacing,
    PopupMark, GlyphPos, TextBounds, Flags {$IFDEF WIN32}, Images,
    ImageIndex {$ENDIF});
{$IFDEF WIN32}
  UseImages := False;
  if Assigned(Images) and (ImageIndex >= 0) and (ImageIndex < Images.Count) and
    (Images.Width > 0) then
  begin
    UseImages := True;
    PopupPos := DrawButtonImage(Canvas, GlyphPos.X, GlyphPos.Y, Images,
      ImageIndex, State);
  end else
{$ENDIF}
  PopupPos := DrawButtonGlyph(Canvas, GlyphPos.X, GlyphPos.Y, State);
  DrawButtonText(Canvas, CaptionText, TextBounds, State, Flags);
  if PopupMark then
    if (Layout <> blGlyphLeft) and (((FOriginal <> nil) and
      (FOriginal.Width > 0)) {$IFDEF WIN32} or UseImages {$ENDIF}) then
    begin
      PopupPos.X := GlyphPos.X + PopupPos.X + 1;
      PopupPos.Y := GlyphPos.Y + PopupPos.Y div 2;
      DrawPopupMark(Canvas, PopupPos.X, PopupPos.Y, State);
    end
    else begin
      if CaptionText <> '' then
        PopupPos.X := TextBounds.Right + 3
      else
        PopupPos.X := (Client.Left + Client.Right - 7) div 2;
      PopupPos.Y := TextBounds.Top  + HeightOf(TextBounds) div 2;
      DrawPopupMark(Canvas, PopupPos.X, PopupPos.Y, State);
    end;
  Result := TextBounds;
end;

const
{$IFNDEF RX_D4}
  Pattern: TBitmap = nil;
{$ENDIF}
  ButtonCount: Integer = 0;

{ DrawButtonFrame - returns the remaining usable area inside the Client rect }

function DrawButtonFrame(Canvas: TCanvas; const Client: TRect;
  IsDown, IsFlat: Boolean; Style: TButtonStyle): TRect;
var
  NewStyle: Boolean;
begin
  Result := Client;
  NewStyle := (Style = bsNew) or (NewStyleControls and (Style = bsAutoDetect));
  if IsDown then begin
    if NewStyle then begin
      Frame3D(Canvas, Result, clWindowFrame, clBtnHighlight, 1);
      if not IsFlat then
        Frame3D(Canvas, Result, clBtnShadow, clBtnFace, 1);
    end
    else begin
      if IsFlat then
        Frame3D(Canvas, Result, clWindowFrame, clBtnHighlight, 1)
      else begin
        Frame3D(Canvas, Result, clWindowFrame, clWindowFrame, 1);
        Canvas.Pen.Color := clBtnShadow;
        Canvas.PolyLine([Point(Result.Left, Result.Bottom - 1),
          Point(Result.Left, Result.Top), Point(Result.Right, Result.Top)]);
      end;
    end;
  end
  else begin
    if NewStyle then begin
      if IsFlat then 
        Frame3D(Canvas, Result, clBtnHighlight, clBtnShadow, 1)
      else begin
        Frame3D(Canvas, Result, clBtnHighlight, clWindowFrame, 1);
        Frame3D(Canvas, Result, clBtnFace, clBtnShadow, 1);
      end; 
    end
    else begin
      if IsFlat then
        Frame3D(Canvas, Result, clBtnHighlight, clWindowFrame, 1)
      else begin
        Frame3D(Canvas, Result, clWindowFrame, clWindowFrame, 1);
        Frame3D(Canvas, Result, clBtnHighlight, clBtnShadow, 1);
      end;
    end;
  end;
  InflateRect(Result, -1, -1);
end;

{ TButtonImage }

constructor TButtonImage.Create;
begin
  FGlyph := TRxButtonGlyph.Create;
  NumGlyphs := 1;
  FButtonSize := Point(24, 23);
end;

destructor TButtonImage.Destroy;
begin
  FGlyph.Free;
  inherited Destroy;
end;

procedure TButtonImage.Invalidate;
begin
  TRxButtonGlyph(FGlyph).Invalidate;
end;

function TButtonImage.GetNumGlyphs: TRxNumGlyphs;
begin
  Result := TRxButtonGlyph(FGlyph).NumGlyphs;
end;

procedure TButtonImage.SetNumGlyphs(Value: TRxNumGlyphs);
begin
  TRxButtonGlyph(FGlyph).NumGlyphs := Value;
end;

function TButtonImage.GetWordWrap: Boolean;
begin
  Result := TRxButtonGlyph(FGlyph).WordWrap;
end;

procedure TButtonImage.SetWordWrap(Value: Boolean);
begin
  TRxButtonGlyph(FGlyph).WordWrap := Value;
end;

function TButtonImage.GetGlyph: TBitmap;
begin
  Result := TRxButtonGlyph(FGlyph).Glyph;
end;

procedure TButtonImage.SetGlyph(Value: TBitmap);
begin
  TRxButtonGlyph(FGlyph).Glyph := Value;
end;

function TButtonImage.GetAlignment: TAlignment;
begin
  Result := TRxButtonGlyph(FGlyph).Alignment;
end;

procedure TButtonImage.SetAlignment(Value: TAlignment);
begin
  TRxButtonGlyph(FGlyph).Alignment := Value;
end;

{$IFDEF WIN32}
procedure TButtonImage.Draw(Canvas: TCanvas; X, Y, Margin, Spacing: Integer;
  Layout: TButtonLayout; AFont: TFont; Flags: Word);
begin
  DrawEx(Canvas, X, Y, Margin, Spacing, Layout, AFont, nil, -1, Flags);
end;
{$ENDIF}

{$IFDEF WIN32}
procedure TButtonImage.DrawEx(Canvas: TCanvas; X, Y, Margin, Spacing: Integer;
  Layout: TButtonLayout; AFont: TFont; Images: TImageList; ImageIndex: Integer;
  Flags: Word);
{$ELSE}
procedure TButtonImage.Draw(Canvas: TCanvas; X, Y, Margin, Spacing: Integer;
  Layout: TButtonLayout; AFont: TFont; Flags: Word);
{$ENDIF}
var
  Target: TRect;
  SaveColor: Integer;
  SaveFont: TFont;
begin
  SaveColor := Canvas.Brush.Color;
  SaveFont := TFont.Create;
  SaveFont.Assign(Canvas.Font);
  try
    Target := Bounds(X, Y, FButtonSize.X, FButtonSize.Y);
    Canvas.Brush.Color := clBtnFace;
    Canvas.FillRect(Target);
    Frame3D(Canvas, Target, clBtnShadow, clWindowFrame, 1);
    Frame3D(Canvas, Target, clBtnHighlight, clBtnShadow, 1);
    if AFont <> nil then Canvas.Font := AFont;
{$IFDEF WIN32}
    TRxButtonGlyph(FGlyph).DrawEx(Canvas, Target, Caption, Layout, Margin,
      Spacing, False, Images, ImageIndex, rbsUp, Flags);
{$ELSE}
    TRxButtonGlyph(FGlyph).Draw(Canvas, Target, Caption, Layout, Margin,
      Spacing, False, rbsUp, Flags);
{$ENDIF}
  finally
    Canvas.Font.Assign(SaveFont);
    SaveFont.Free;
    Canvas.Brush.Color := SaveColor;
  end;
end;

{$ENDIF RX_D4}

{$IFDEF WIN32}
initialization
  FCheckBitmap := nil;
finalization
  DestroyLocals;
{$ELSE}
initialization
  FCheckBitmap := nil;
  AddExitProc(DestroyLocals);
{$ENDIF}
*)

{ TRxSpeedButton }

procedure TRxSpeedButton.SetAllowTimer(const AValue: boolean);
begin
  if FAllowTimer = AValue then exit;
  FAllowTimer := AValue;
  if not FAllowTimer and (FRepeatTimer <> nil) then
  begin
    FRepeatTimer.Enabled := False;
    FRepeatTimer.Free;
    FRepeatTimer := nil;
  end;
end;

procedure TRxSpeedButton.TimerExpired(Sender: TObject);
begin
  FRepeatTimer.Interval := RepeatInterval;
  if (FState = bsDown) and MouseCapture then
  try
    Click;
  except
    FRepeatTimer.Enabled := False;
    raise;
  end;
end;

procedure TRxSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    if FAllowTimer then
    begin
      if FRepeatTimer = nil then
        FRepeatTimer := TTimer.Create(nil);
      FRepeatTimer.Interval := InitPause;
      FRepeatTimer.OnTimer := @TimerExpired;
      FRepeatTimer.Enabled := True;
    end;
  end;
end;

procedure TRxSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FRepeatTimer <> nil then FRepeatTimer.Enabled := False;
end;

constructor TRxSpeedButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInitRepeatPause := 500;
  FRepeatPause := 100;
end;

destructor TRxSpeedButton.Destroy;
begin
  inherited Destroy;
  if FRepeatTimer <> nil then FRepeatTimer.Free;
end;

end.
