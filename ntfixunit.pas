unit ntfixunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, process,Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,aboutunit,
  ExtCtrls;

type

  { TntfixForm }

  TntfixForm = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    fixBitBtn: TBitBtn;
    windowsImage: TImage;
    tuxImage: TImage;
    chainImage: TImage;
    ntfsEdit: TEdit;
    ext4Edit: TEdit;
    ntfsLabel: TLabel;
    ext4Label: TLabel;
    SelectDirectoryDialog1: TSelectDirectoryDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure fixBitBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  ntfixForm: TntfixForm;
  s: string;
  ntfsfolder: String;
  ntfsfolderValue: TextFile;
  ntfsdelfolderScript: TextFile;
  ext4folder: String;
  ext4folderValue: TextFile;
  ext4mkfolderScript: TextFile;
  linkntfsext4Script: TextFile;
  userhomepathVAR: Textfile;
  userhomepathSTR: string;
  prefixfolder: string;
implementation

{$R *.lfm}

{ TntfixForm }

procedure TntfixForm.BitBtn1Click(Sender: TObject);
begin
  if selectdirectoryDialog1.Execute then
  begin
    ntfsEdit.Text:= SelectDirectoryDialog1.FileName;
    ntfsEdit.Color := cldefault;
  end;

end;

procedure TntfixForm.BitBtn2Click(Sender: TObject);
begin
  if selectdirectoryDialog1.Execute then
  ext4Edit.Text:= SelectDirectoryDialog1.FileName;
end;

procedure TntfixForm.BitBtn3Click(Sender: TObject);
begin
  aboutForm.show;
end;

procedure TntfixForm.fixBitBtnClick(Sender: TObject);
begin
  //Create temporary folder for ntfix
  RunCommand('bash -c ''mkdir -p /tmp/ntfix/''', s);


  //Store paths in variables
  ntfsfolder := ntfsEdit.Text;
  ext4folder := ext4Edit.Text;




  //Delete Compatdata on NTFS disk

     // Assign custom ntfs path to file
     AssignFile(ntfsfolderValue, '/tmp/ntfix/ntfsfolder');
     Rewrite(ntfsfolderValue);
     Writeln(ntfsfolderValue,ntfsfolder);
     CloseFile(ntfsfolderValue);

     // Create custom script
     AssignFile(ntfsdelfolderScript, '/tmp/ntfix/ntfsdelfolderScript.sh');
     Rewrite(ntfsdelfolderScript);
     Writeln(ntfsdelfolderScript,'NTFSFOLDER=$(cat /tmp/ntfix/ntfsfolder)');  //Store destination folder in a Linux/Unix variable
     Writeln(ntfsdelfolderScript,'rm -r $NTFSFOLDER/steamapps/compatdata'); //Create correct command with custom folder
     CloseFile(ntfsdelfolderScript);

     //execute custom script to delete old compatdata
     RunCommand('bash -c ''sh /tmp/ntfix/ntfsdelfolderScript.sh''', s);




// Create compatdata on EXT4 disk

     // Assign custom ntfs path to file
     AssignFile(ext4folderValue, '/tmp/ntfix/ext4folder');
     Rewrite(ext4folderValue);
     Writeln(ext4folderValue,ext4folder);
     CloseFile(ext4folderValue);

     // Create custom script
     AssignFile(ext4mkfolderScript, '/tmp/ntfix/ext4mkfolderScript.sh');
     Rewrite(ext4mkfolderScript);
     Writeln(ext4mkfolderScript,'EXT4FOLDER=$(cat /tmp/ntfix/ext4folder)');  //Store destination folder in a Linux/Unix variable
     Writeln(ext4mkfolderScript,'mkdir -p $EXT4FOLDER/steamapps/compatdata'); //Create correct command with custom folder
     CloseFile(ext4mkfolderScript);

     //execute custom script to delete old compatdata
     RunCommand('bash -c ''sh /tmp/ntfix/ext4mkfolderScript.sh''', s);


// Create symbolic link with custom script

AssignFile(linkntfsext4Script, '/tmp/ntfix/linkntfsext4Script.sh');
Rewrite(linkntfsext4Script);
Writeln(linkntfsext4Script,'NTFSFOLDER=$(cat /tmp/ntfix/ntfsfolder)');  //Store destination folder in a Linux/Unix variable
Writeln(linkntfsext4Script,'EXT4FOLDER=$(cat /tmp/ntfix/ext4folder)');
Writeln(linkntfsext4Script,'ln -s $EXT4FOLDER/steamapps/compatdata $NTFSFOLDER/steamapps'); //Create correct command with custom folder
CloseFile(linkntfsext4Script);

//execute custom script to create symbolic link
RunCommand('bash -c ''sh /tmp/ntfix/linkntfsext4Script.sh''', s);

//Display chain icon
chainImage.Visible:=true;

// Popup a notification
 RunCommand('bash -c ''notify-send Symbolic_link_created''', s);



end;

procedure TntfixForm.FormCreate(Sender: TObject);
begin
    //Centralize window
  Left:=(Screen.Width-Width)  div 2;
  Top:=(Screen.Height-Height) div 2;

  //Create NTfix folder on home
  RunCommand('bash -c ''mkdir -p $HOME/NTfix/steamapps/compatdata''', s);




 //Read file $HOME variable and store result in tmp folder text file
 RunCommand('bash -c ''echo $HOME >> /tmp/ntfix/userhomepath''', s);

 // Assign Text file to variable
 AssignFile(userhomepathVAR, '/tmp/ntfix/userhomepath'); //
 Reset(userhomepathVAR);
 Readln(userhomepathVAR,userhomepathSTR); //Assign Text file to String
 CloseFile(userhomepathVAR);

 //Stock folder logging
 prefixfolder := userhomepathSTR+'/.local/share/Steam';
 ext4Edit.text:=prefixfolder;


end;

end.

