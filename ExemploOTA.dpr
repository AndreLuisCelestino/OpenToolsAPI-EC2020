library ExemploOTA;

{ *** Orienta��es para desenvolver o Wizard ***

1) "Linkar" a DLL com os pacotes de runtime:
  Project > Options > Packages > Runtime Packages >
  Marcar "Link with runtime packages"


2) Ap�s compilar a DLL, mova-a para qualquer outra pasta
  (necess�rio para que n�o ocorra erro de arquivo em uso),
  e fa�a o registro do Windows no seguinte caminho:

  "Computador\HKEY_CURRENT_USER\SOFTWARE\Embarcadero\BDS\XX.X\Experts"

  Onde XX.X � a vers�o do Delphi que voc� est� utilizando.

  Crie um novo valor de Cadeia de Caracteres e
  preencha com o caminho e nome da DLL (ex: C:\Tools\Wizard.dll)


3) Para conhecer e testar outras Interfaces do Open Tools API,
  abra o arquivo "ToolsAPI.pas" no caminho:
  "C:\Program Files (x86)\Embarcadero\Studio\XX.X\source\ToolsAPI"

  Onde XX.X � a vers�o do Delphi que voc� est� utilizando.

}

uses
  ToolsAPI,
  System.SysUtils,
  System.Classes,
  ECWizard in 'ECWizard.pas';

{$R *.res}

// fun��o para que o Delphi carregue a DLL
exports
  CarregarWizard Name WizardEntryPoint;

begin
end.
