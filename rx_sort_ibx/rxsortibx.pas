unit RxSortIBX;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TRxSortIBX = class(TComponent)
  private

  protected

  public

  published

  end;

procedure Register;

implementation
uses exsortibx;

{$R RxSortIBX.res}

procedure Register;
begin
  RegisterComponents('RX DBAware',[TRxSortIBX]);
end;

end.
