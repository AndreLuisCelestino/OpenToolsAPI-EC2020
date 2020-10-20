unit ECWizard;

interface

uses
  ToolsAPI;

type
  TECWizard = class(TInterfacedObject, IOTAWizard, IOTAMenuWizard)

    // assinaturas da Interface IOTAWizard
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;

    // assinatura da Interface IOTAMenuWizard
    function GetMenuText: string;

    // função para retornar a instância do editor de formulários
    function GetFormEditor: IOTAFormEditor;

    procedure AbrirNotepad(Sender: TObject);
    procedure AbrirDocumentacao(Sender: TObject);
    procedure ValidarNomeBotao(Sender: TObject);
  public
    constructor Create;
  end;

// declaração do método para carregar o Wizard
function CarregarWizard(BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc; var Terminate: TWizardTerminateProc): boolean; stdcall;

implementation

uses
  ShellAPI, WinApi.Windows, VCL.Menus, System.SysUtils, VCL.Dialogs;

{ TECWizard }

// implementação do método para carregar o Wizard
function CarregarWizard(BorlandIDEServices: IBorlandIDEServices;
  RegisterProc: TWizardRegisterProc; var Terminate: TWizardTerminateProc): boolean; stdcall;
begin
  result := True;
  RegisterProc(TECWizard.Create);
end;

procedure TECWizard.AbrirDocumentacao(Sender: TObject);
const
  DOCWIKI = 'http://docwiki.embarcadero.com/RADStudio/Sydney/e/index.php?search=';
var
  lViewer: IOTAEditView;
  lTextoSelecionado: string;
  lURL: string;
begin
  // obtém a instância do editor de códigos
  lViewer := (BorlandIDEServices as IOTAEditorServices).TopView;

  // obtém o texto selecionado no editor de códigos
  lTextoSelecionado := lViewer.GetBlock.Text;

  lURL := DOCWIKI + lTextoSelecionado;

  ShellExecute(0, 'open', PChar(lURL), '', '', SW_SHOWNORMAL);
end;

procedure TECWizard.AbrirNotepad(Sender: TObject);
begin
  ShellExecute(0, 'open', 'notepad.exe', nil, nil, SW_SHOWNORMAL);
end;

procedure TECWizard.AfterSave;
begin

end;

procedure TECWizard.BeforeSave;
begin

end;

constructor TECWizard.Create;
var
  MainMenu: TMainMenu;
  MenuWizard: TMenuItem;
  MenuNotepad: TMenuItem;
  MenuDocumentacao: TMenuItem;
  MenuValidacaoNomeBotao: TMenuItem;
begin
  // obtém a instância do menu principal da IDE
  MainMenu := (BorlandIDEServices as INTAServices).MainMenu;

  // cria o menu principal
  MenuWizard := TMenuItem.Create(MainMenu);
  MenuWizard.Caption := 'Wizard EC 2020';
  MenuWizard.Name := 'WizardEC2020';
  MainMenu.Items.Add(MenuWizard);

  // cria um submenu para abrir o notepad
  MenuNotepad := TMenuItem.Create(MenuWizard);
  MenuNotepad.Caption := 'Abrir Notepad';
  MenuNotepad.Name := 'AbrirNotepad';
  MenuNotepad.OnClick := AbrirNotepad;
  MenuWizard.Add(MenuNotepad);

  // cria um submenu para abrir a documentação
  MenuDocumentacao := TMenuItem.Create(MenuWizard);
  MenuDocumentacao.Caption := 'Abrir Documentação';
  MenuDocumentacao.Name := 'AbrirDocumentacao';
  MenuDocumentacao.OnClick := AbrirDocumentacao;
  MenuWizard.Add(MenuDocumentacao);

  // cria um submenu para acionar a validação do nome dos botões
  MenuValidacaoNomeBotao := TMenuItem.Create(MenuWizard);
  MenuValidacaoNomeBotao.Caption := 'Validar Nome Botão';
  MenuValidacaoNomeBotao.Name := 'ValidarNomeBotao';
  MenuValidacaoNomeBotao.OnClick := ValidarNomeBotao;
  MenuWizard.Add(MenuValidacaoNomeBotao);
end;

procedure TECWizard.Destroyed;
begin

end;

procedure TECWizard.Execute;
begin

end;

function TECWizard.GetFormEditor: IOTAFormEditor;
var
  lModule: IOTAModule;
  lEditor: IOTAEditor;
  i: Integer;
begin
  result := nil;

  // obtém a instância dos serviços de módulos da IDE
  lModule := (BorlandIDEServices as IOTAModuleServices).CurrentModule;

  // percorre os módulos para encontrar o editor de formulários
  for i := 0 to Pred(lModule.GetModuleFileCount) do
  begin
    lEditor := lModule.GetModuleFileEditor(i);
    if Supports(lEditor, IOTAFormEditor, result) then
      Break;
  end;
end;

function TECWizard.GetIDString: string;
begin
  // ID do Wizard (obrigatório)
  result := 'ECWizard';
end;

function TECWizard.GetMenuText: string;
begin
  // Texto do menu que irá ser exibido na IDE (obrigatório)
  result := 'Wizard EC 2020';
end;

function TECWizard.GetName: string;
begin
  // Nome do Wizard (obrigatório)
  result := 'ECWizard';
end;

function TECWizard.GetState: TWizardState;
begin
  // indica se o Wizard está habilitado
  result := [wsEnabled];
end;

procedure TECWizard.Modified;
begin

end;

procedure TECWizard.ValidarNomeBotao(Sender: TObject);
var
  lFormulario: IOTAComponent;
  lComponente: IOTAComponent;
  i: integer;
  lNome: string;
begin
  // obtém a instância do formulário aberto no editor de formulários
  lFormulario := GetFormEditor.GetRootComponent;

  // percorre o formulário para validar os botões
  for i := 0 to Pred(lFormulario.GetComponentCount) do
  begin

    lComponente := lFormulario.GetComponent(i);
    if lComponente.GetComponentType = 'TButton' then
    begin

      // obtém o nome do botão
      lComponente.GetPropValueByName('Name', lNome);

      // se o nome do botão não iniciar com "btn", corrige o nome
      if not lNome.StartsWith('btn') then
      begin
        ShowMessage('O nome do componente "' + lNome + '" não atende ao padrão!');

        // atualiza o valor da propriedade "Name"
        lNome := 'btn' + lNome;
        lComponente.SetPropByName('Name', lNome);
      end;

    end;

  end;
end;

end.
