; Copyright (c) 2018 Alexander Geasimov <samik.mechanic@gmail.com>

#define AppName "MY-SDK"
#define AppIDEName "MY-Eclipse"
#define AppVersion "VERSION"
#define AppExeName "eclipse.exe"

[Setup]
AppId=MYSDK
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher=My Company Publisher
DefaultDirName={pf}\MyCompany\{#AppName}
OutputBaseFilename={#AppName}-SETUP
Compression=lzma
SolidCompression=yes
DisableWelcomePage=True
DisableReadyMemo=True
AlwaysShowComponentsList=False
ShowComponentSizes=False
AlwaysShowDirOnReadyPage=True
UsePreviousGroup=False
Uninstallable=yes
MinVersion=0,6.1
SetupLogging=True
VersionInfoVersion={#AppVersion}
AppContact=samik.mechanic@gmail.com
UninstallLogMode=new
UninstallDisplayName={#AppName}
UninstallDisplayIcon={app}\{#AppExeName}
DefaultGroupName={#AppName}
OutputDir=output
AppCopyright=GPL
VersionInfoCopyright=GPL
VersionInfoProductName={#AppName}
VersionInfoProductVersion={#AppVersion}
VersionInfoDescription=My custom toolchain
VersionInfoCompany=My Company
VersionInfoProductTextVersion={#AppVersion}
LicenseFile=license.txt
InfoBeforeFile=sdk_contents.txt
ChangesEnvironment=True
DisableDirPage=auto
UsePreviousAppDir=False
AllowNoIcons=True
ArchitecturesInstallIn64BitMode=x64
ArchitecturesAllowed=x64

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked;

[Files]
; Eclipse distribution
Source: "TEMP_DRIVE\*"; DestDir: "\\?\{app}"; Flags: ignoreversion createallsubdirs recursesubdirs 64bit; Attribs: system
; Toolchain
Source: "..\..\my_toolchain\*"; DestDir: "{app}\my-ide\"; Flags: ignoreversion createallsubdirs recursesubdirs 64bit; Attribs: system
; Toolchain and Cygwin libraries
Source: "my-ide\lib\*"; DestDir: "{app}\my-ide\lib"; Flags: ignoreversion createallsubdirs recursesubdirs 64bit
; Toolchain and Cygwin additional files
Source: "my-ide\usr\*"; DestDir: "{app}\my-ide\usr"; Flags: ignoreversion createallsubdirs recursesubdirs 64bit
; JRE distribution (mind the folder name!)
Source: "jre1.8.0_151\*"; DestDir: "{app}\jre"; Flags: ignoreversion createallsubdirs recursesubdirs 64bit; Attribs: system
; Command Line interface
Source: "scripts\sdkcmd.bat"; DestDir: "{app}"

[Icons]
; Eclipse launch icon in Start menu
Name: "{group}\{#AppIDEName}"; Filename: "{app}\{#AppExeName}"
; Command Line launch icon in Start menu
Name: "{group}\{#AppName} Command Prompt"; Filename: "{%COMSPEC}"; WorkingDir: "{app}\my-ide\bin"; Parameters: "/k ""{app}\sdkcmd.bat"""; Comment: "{#AppName} Command Prompt"
; Eclipse launch shortcut on Desktop
Name: "{commondesktop}\{#AppIDEName}"; Filename: "{app}\{#AppExeName}"; Tasks: desktopicon
; Quick Launch icon in QuickLaunch toolbar
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#AppIDEName}"; Filename: "{app}\{#AppExeName}"; Tasks: quicklaunchicon
Name: "{group}\{cm:UninstallProgram, {#AppName}}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\{#AppExeName}"; WorkingDir: "{app}"; Flags: nowait postinstall skipifsilent unchecked 64bit; Description: "{cm:LaunchProgram,{#StringChange(AppIDEName, '&', '&&')}}"

[CustomMessages]
en.OldInstallError=Another MY-SDK installation detected.%nIt is not allowed to have multiple copies of SDK on your computer.%n%nDo you wish to uninstall the previous version?%nPressing No will terminate the Setup.
ru.OldInstallError=Обнаружена другая установка MY-SDK.%nПрисутствие нескольких копий SDK на одном компьютере не допускается.%n%nЖелаете удалить существующую версию?%nНажатие кнопки Нет приведет к отмене установки.
en.MaintenanceWindowTitle=MY-SDK Maintenance
en.MaintenanceWindowText=Setup has detected another MY-SDK installation.%nChoose an option to continue
ru.MaintenanceWindowTitle=Обслуживание MY-SDK
ru.MaintenanceWindowText=Обнаружена установленная копия MY-SDK.%nВыберите опцию для продолжения
en.MaintenanceReadyWindowTitle=Ready for maintenance
en.MaintenanceReadyWindowText=Setup is now ready to perform the selected actions for MY-SDK
ru.MaintenanceReadyWindowTitle=Всё готово к обслуживанию
ru.MaintenanceReadyWindowText=Программа установки готова к выполнению выбранных операций для MY-SDK
en.UpdateReadyText=Click Update to continue with the installation.
ru.UpdateReadyText=Нажмите "Обновить", чтобы продолжить.
en.ReinstallReadyText=Click Reinstall to continue with the installation.
ru.ReinstallReadyText=Нажмите "Переустановить", чтобы продолжить.
en.RemoveReadyText=Click Remove to continue with the installation.
ru.RemoveReadyText=Нажмите "Удалить", чтобы продолжить.
en.HintReadyText=If you wish to choose another option, click Back.
ru.HintReadyText=Если вы хотите изменить выбор, нажмите "Назад".
en.UpdateButtonText=Update
en.UpdateLabelText=Update current MY-SDK installation to the newest version.
ru.UpdateButtonText=Обновить
ru.UpdateLabelText=Обновить текущую установку MY-SDK  до последней версии.
en.ReinstallButtonText=Reinstall
en.ReinstallReadyButtonText=Reinstall
en.ReinstallLabelText=Remove current version of MY-SDK and install the newest version.
ru.ReinstallButtonText=Переустановить
ru.ReinstallReadyButtonText=Переустан
ru.ReinstallLabelText=Удалить текущую версию MY-SDK и установить новую версию.
en.RemoveButtonText=Remove
en.RemoveLabelText=Completely remove existing MY-SDK installation and exit.
ru.RemoveButtonText=Удалить
ru.RemoveLabelText=Полностью удалить текущую версию MY-SDK и выйти.
en.CurrentInstallPath=MY-SDK location:%n
ru.CurrentInstallPath=Текущее расположение MY-SDK:%n
en.VersionLabelText=Version:
ru.VersionLabelText=Версия:
en.UpdatePopupText=Preparing for update...
ru.UpdatePopupText=Подготовка к обновлению...

[InstallDelete]

[UninstallDelete]
Type: filesandordirs; Name: "{app}"

[Code]
type
  INSTALLSTATE = Longint;
const
  EnvironmentKey = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment'; { Registry path for PATH env. variable. }
var
  UninstallString: String;
  PrevInstallLocation: String;
  PrevSelectedTasks: String;
  UpdateLabel: TLabel;
  ReinstallLabel: TLabel;
  RemoveLabel: TLabel;
  ActionReadyLabel: TLabel;
  CurrentInstallLabel: TLabel;
  CurrentInstallPath: TLabel;
  UpdateRadioButton: TRadioButton;
  ReinstallRadioButton: TRadioButton;
  RemoveRadioButton: TRadioButton;
  ForceClose: Boolean;
  Maintained: Boolean;
  MaintenancePageID: Integer;
  MaintenanceReadyPageID: Integer;
  PreparePopup: TSetupForm;

function MaintainAction(Page: TWizardPage): Boolean;
var
uResultCode: Integer;
begin
  Result := False;
  if UpdateRadioButton.Checked then begin
    PreparePopup := CreateCustomForm;
    with PreparePopup do begin
      BorderStyle := bsNone;
      ClientWidth       := ScaleX(250);
      ClientHeight      := ScaleY(80);
      CenterInsideControl(WizardForm, True);
    end;
    with TLabel.Create(PreparePopup) do begin
      Parent    := PreparePopup;
      Caption   := ExpandConstant('{cm:UpdatePopupText}');
      Font.Size := 10;
      Height    := ScaleY(20);
      Left      := (Parent.Width - Width) div 2;
      Top       := (Parent.Height - Height) div 2;
    end;
    PreparePopup.Show;
    WizardForm.DirEdit.Text := PrevInstallLocation;
    if Exec(UninstallString, '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES', '', SW_HIDE, ewWaitUntilTerminated, uResultCode) then begin
      Maintained := True;
      Result := True;
    end;
    PreparePopup.Free;
  end
  else if ReinstallRadioButton.Checked then begin
    Exec(UninstallString, '', '', SW_SHOW, ewWaitUntilTerminated, uResultCode);
    if uResultCode = 0 then
      Result := True;
  end
  else if RemoveRadioButton.Checked then begin
    Exec(UninstallString, '', '', SW_SHOW, ewWaitUntilTerminated, uResultCode);
    if uResultCode = 0 then begin
      Result := True;
      ForceClose := True;
      WizardForm.Close;
    end;
  end;
end;

function CreateMaintenancePage(PreviousPageId: Integer): Integer;
var
  Page: TWizardPage;
begin
  Page := CreateCustomPage(PreviousPageId, ExpandConstant('{cm:MaintenanceWindowTitle}'), ExpandConstant('{cm:MaintenanceWindowText}'));

  UpdateRadioButton := TRadioButton.Create(Page);
  with UpdateRadioButton do
  begin
      Parent     := Page.Surface;
      Caption    := ExpandConstant('{cm:UpdateButtonText}');
      Font.Style := [fsBold];
      Left       := ScaleX(16);
      Top        := ScaleY(0);
      Width      := ScaleX(150);
      Height     := ScaleY(17);
      Checked    := True;
      TabOrder   := 0;
      TabStop    := True;
  end;
  
  UpdateLabel := TLabel.Create(Page);
  with UpdateLabel do
  begin
      Parent  := Page.Surface;
      Caption := ExpandConstant('{cm:UpdateLabelText}');
      Left    := ScaleX(32);
      Top     := UpdateRadioButton.Top + UpdateRadioButton.Height + 8;
      Width   := ScaleX(500);
      Height  := ScaleY(17);
  end;

  ReinstallRadioButton := TRadioButton.Create(Page);
  with ReinstallRadioButton do
  begin
      Parent     := Page.Surface;
      Caption    := ExpandConstant('{cm:ReinstallButtonText}');
      Font.Style := [fsBold];
      Left       := ScaleX(16);
      Top        := UpdateLabel.Top + UpdateLabel.Height + 16;
      Width      := ScaleX(150);
      Height     := ScaleY(17);
      Checked    := False;
      TabOrder   := 1;
      TabStop    := True;
  end;
  
  ReinstallLabel := TLabel.Create(Page);
  with ReinstallLabel do
  begin
      Parent  := Page.Surface;
      Caption := ExpandConstant('{cm:ReinstallLabelText}');
      Left    := ScaleX(32);
      Top     := ReinstallRadioButton.Top + ReinstallRadioButton.Height + 8;
      Width   := ScaleX(500);
      Height  := ScaleY(17);
  end;

  RemoveRadioButton := TRadioButton.Create(Page);
  with RemoveRadioButton do
  begin
      Parent     := Page.Surface;
      Caption    := ExpandConstant('{cm:RemoveButtonText}');
      Font.Style := [fsBold];
      Left       := ScaleX(16);
      Top        := ReinstallLabel.Top + ReinstallLabel.Height + 16;
      Width      := ScaleX(150);
      Height     := ScaleY(17);
      Checked    := False;
      TabOrder   := 2;
      TabStop    := True;
  end;
  
  RemoveLabel := TLabel.Create(Page);
  with RemoveLabel do
  begin
      Parent  := Page.Surface;
      Caption := ExpandConstant('{cm:RemoveLabelText}');
      Left    := ScaleX(32);
      Top     := RemoveRadioButton.Top + RemoveRadioButton.Height + 8;
      Width   := ScaleX(500);
      Height  := ScaleY(17);
  end;

  CurrentInstallLabel := TLabel.Create(Page);
  CurrentInstallLabel := TLabel.Create(Page);
  with CurrentInstallLabel do
  begin
      Parent  := Page.Surface;
      Caption := ExpandConstant('{cm:CurrentInstallPath}');
      Font.Style := [fsBold];
      Left    := ScaleX(16);
      Top     := RemoveLabel.Top + RemoveLabel.Height + 40;
      Width   := ScaleX(500);
      Height  := ScaleY(17);
  end;

  CurrentInstallPath := TLabel.Create(Page);
  with CurrentInstallPath do
  begin
      Parent  := Page.Surface;
      Caption := ExpandConstant(PrevInstallLocation);
      Left    := ScaleX(32);
      Top     := CurrentInstallLabel.Top + CurrentInstallLabel.Height;
      Width   := ScaleX(500);
      Height  := ScaleY(17);
  end;

  Result := Page.ID;
end;

function CreateMaintenanceReadyPage(PreviousPageId: Integer): Integer;
var
  Page: TwizardPage;
begin
  Page := CreateCustomPage(PreviousPageId, ExpandConstant('{cm:MaintenanceReadyWindowTitle}'), ExpandConstant('{cm:MaintenanceReadyWindowText}'));
  ActionReadyLabel := TLabel.Create(Page);

  with ActionReadyLabel do
  begin
    Parent  := Page.Surface;
    Left    := ScaleX(16);
    Top     := ScaleY(0);
    Width   := ScaleX(500);
    Height  := ScaleY(17);
    end;

  with TLabel.Create(Page) do
  begin
      Parent     := Page.Surface;
      Caption    := ExpandConstant('{cm:HintReadyText}');
      Left       := ScaleX(16);
      Top        := ActionReadyLabel.Top + 32;
      Width      := ScaleX(500);
      Height     := ScaleY(17);
  end;
  
  Page.OnNextButtonClick := @MaintainAction;
  Result := Page.ID;
end;

function GetUninstallString(): String;
var
InstPath: String;
sUninstallString: String;
begin
  InstPath := ExpandConstant('Software\Microsoft\Windows\CurrentVersion\Uninstall\{#emit SetupSetting("AppId")}_is1');
  sUninstallString := '';
  if not RegQueryStringValue(HKLM, InstPath, 'UninstallString', sUninstallString) then
    RegQueryStringValue(HKCU, InstPath, 'UninstallString', sUninstallString);
  if not RegQueryStringValue(HKLM, InstPath, 'InstallLocation', PrevInstallLocation) then
    RegQueryStringValue(HKCU, InstPath, 'InstallLocation', PrevInstallLocation);
  if not RegQueryStringValue(HKLM, InstPath, 'Inno Setup: Selected Tasks', PrevSelectedTasks) then
    RegQueryStringValue(HKCU, InstPath, 'Inno Setup: Selected Tasks', PrevSelectedTasks);
  Result := sUninstallString;
  UninstallString := RemoveQuotes(sUninstallString);
  PrevInstallLocation := RemoveQuotes(PrevInstallLocation);
  PrevSelectedTasks := RemoveQuotes(PrevSelectedTasks);
end;

procedure InitializeWizard();
var
  VersionLabel: TNewStaticText;
begin
  VersionLabel := TNewStaticText.Create(WizardForm);
  with VersionLabel do
  begin
    Parent := WizardForm;
    Caption := ExpandConstant('{cm:VersionLabelText}') + Format(' %s', ['{#SetupSetting("AppVersion")}']);
    Left := ScaleX(16);
    Top := WizardForm.BackButton.Top + (WizardForm.BackButton.Height div 2) - (VersionLabel.Height div 2)
  end;
  if GetUninstallString() <> '' then begin
    MaintenancePageID := CreateMaintenancePage(wpInfoBefore);
    MaintenanceReadyPageID := CreateMaintenanceReadyPage(MaintenancePageID);
  end;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = MaintenanceReadyPageID then begin
    if UpdateRadioButton.Checked then begin
      ActionReadyLabel.Caption := ExpandConstant('{cm:UpdateReadyText}');
      WizardForm.NextButton.Caption := ExpandConstant('{cm:UpdateButtonText}');
    end;
    if ReinstallRadioButton.Checked then begin
      ActionReadyLabel.Caption := ExpandConstant('{cm:ReinstallReadyText}');
      WizardForm.NextButton.Caption := ExpandConstant('{cm:ReinstallReadyButtonText}');
    end;
    if RemoveRadioButton.Checked then begin
      ActionReadyLabel.Caption := ExpandConstant('{cm:RemoveReadyText}');
      WizardForm.NextButton.Caption := ExpandConstant('{cm:RemoveButtonText}');
    end;
  end;
end;

procedure CancelButtonClick(CurPageID: Integer; var Cancel, Confirm: Boolean);
begin
  Confirm := not ForceClose;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
var
  taskIndex: Integer;
begin
  Result := False;
  if Maintained then begin
    if (PageID = wpSelectDir) or
       (PageID = wpInfoBefore) or
       (PageID = wpSelectProgramGroup) or
       (PageID = wpReady) then
      Result := UpdateRadioButton.Checked;
    if (PageID = wpSelectTasks) then begin
      taskIndex := WizardForm.TasksList.Items.IndexOf(ExpandConstant('{cm:CreateDesktopIcon}'));
      if Pos(',desktopicon,', ',' + PrevSelectedTasks + ',') > 0 then
        WizardForm.TasksList.Checked[taskIndex] := True;
      taskIndex := WizardForm.TasksList.Items.IndexOf(ExpandConstant('{cm:CreateQuickLaunchIcon}'));
      if Pos(',quicklaunchicon,', ',' + PrevSelectedTasks + ',') > 0 then
        WizardForm.TasksList.Checked[taskIndex] := True;
      Result := UpdateRadioButton.Checked;
    end;
  end;
end;
