unit Fido.Logging.Appenders.PermanentFile;

interface

uses
  System.Classes,
  System.SysUtils,

  Spring.Logging.Appenders;

type
  TPermanentFileLogAppender = class(TStreamLogAppender)
  private
    procedure SetFilename(const Value: string);
  public
    constructor Create(const Filename: string);
  end;

implementation

{ TPermanentFileLogAppender }

constructor TPermanentFileLogAppender.Create(const Filename: string);
begin
  inherited CreateInternal(True, nil);
  SetFilename(Filename);
end;

procedure TPermanentFileLogAppender.SetFilename(const Value: string);
var
  Stream: TStream;
begin
  if not FileExists(Value) then
    Stream := TFileStream.Create(Value, fmCreate or fmShareDenyWrite)
  else
    Stream := TFileStream.Create(Value, fmOpenWrite or fmShareDenyWrite);
  Stream.Seek(0, soEnd);
  SetStream(Stream);
end;

end.
