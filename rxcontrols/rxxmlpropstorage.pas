{ RxXMLPropStorage unit

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

unit RxXMLPropStorage;

{$I rx.inc}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, XMLPropStorage;

const
  defCFGFileExt = '.xcfg';

type

  { TRxXMLPropStorage }

  TRxXMLPropStorage = class(TXMLPropStorage)
  private
    FSeparateFiles: boolean;
    function FixPath2(const APath: String): String;
  protected
    function GetXMLFileName: string; override;
  public

  published
    property SeparateFiles:boolean read FSeparateFiles write FSeparateFiles;
  end;


implementation
uses LazFileUtils, LazUTF8, rxapputils;


function GetDefaultCfgName: string;
var
  S:string;
begin
  Result := ExtractFileName(ChangeFileExt(Application.ExeName, defCFGFileExt));
  S:=SysToUTF8(RxGetAppConfigDir(false));
  ForceDirectoriesUTF8(S);
  Result:=S+Result;
end;

{ TRxXMLPropStorage }

function TRxXMLPropStorage.FixPath2(const APath: String): String;
begin
  Result:=StringReplace(APath,'/', '.', [rfReplaceAll]);
end;

function TRxXMLPropStorage.GetXMLFileName: string;
var
  S: String;
begin
  if ExtractFileDir(FileName) <> '' then
    Result:=FileName
  else
  begin
    S:=GetDefaultCfgName;
    if FileName <> '' then
      Result:=AppendPathDelim(ExtractFileDir(S)) + FileName
    else
    begin
      if FSeparateFiles then
        Result:=AppendPathDelim(ExtractFileDir(S)) + FixPath2(RootSection) + defCFGFileExt
      else
        Result:=S;
    end;
  end;
  Result:=UTF8ToSys(Result);
end;

end.
