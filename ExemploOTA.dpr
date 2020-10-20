library ExemploOTA;

{ *** Orientações para desenvolver o Wizard ***

1) "Linkar" a DLL com os pacotes de runtime:
  Project > Options > Packages > Runtime Packages >
  Marcar "Link with runtime packages"


2) Após compilar a DLL, mova-a para qualquer outra pasta
  (necessário para que não ocorra erro de arquivo em uso),
  e faça o registro do Windows no seguinte caminho:

  "Computador\HKEY_CURRENT_USER\SOFTWARE\Embarcadero\BDS\XX.X\Experts"

  Onde XX.X é a versão do Delphi que você está utilizando.

  Crie um novo valor de Cadeia de Caracteres e
  preencha com o caminho e nome da DLL (ex: C:\Tools\Wizard.dll)


3) Para conhecer e testar outras Interfaces do Open Tools API,
  abra o arquivo "ToolsAPI.pas" no caminho:
  "C:\Program Files (x86)\Embarcadero\Studio\XX.X\source\ToolsAPI"

  Onde XX.X é a versão do Delphi que você está utilizando.

}

uses
  ToolsAPI,
  System.SysUtils,
  System.Classes,
  ECWizard in 'ECWizard.pas';

{$R *.res}

// função para que o Delphi carregue a DLL
exports
  CarregarWizard Name WizardEntryPoint;

begin
end.
