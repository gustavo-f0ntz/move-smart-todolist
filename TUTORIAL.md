# 🚀 Guia Completo: TodoList Smart Contract em Move 

> **Desenvolvido por**: f0ntz  
> **Data**: 12 de Agosto, 2025  
> **Stack**: Move + Sui Blockchain  
> **Nível**: Iniciante a Intermediário  

---

## 📋 **Índice**

1. [Pré-requisitos](#pré-requisitos)
2. [Configuração Inicial](#configuração-inicial)
3. [Desenvolvimento Local](#desenvolvimento-local)
4. [Deploy na Testnet](#deploy-na-testnet)
5. [Testando Funcionalidades](#testando-funcionalidades)
6. [Comandos de Referência](#comandos-de-referência)
7. [Solução de Problemas](#solução-de-problemas)

---

## 🛠️ **Pré-requisitos**

### **Software necessário:**
- ✅ **Sui CLI** instalado
- ✅ **Git** instalado
- ✅ **VS Code** (recomendado)
- ✅ **Terminal** (bash/zsh)

### **Conhecimentos básicos:**
- 📚 Conceitos básicos de blockchain
- 💻 Linha de comando
- 📝 Estrutura de projetos

---

## ⚙️ **Configuração Inicial**

### **Passo 1: Verificar instalação do Sui**
```bash
# Verificar se Sui está instalado
sui --version

# Se não estiver instalado, seguir:
# https://docs.sui.io/guides/developer/getting-started/sui-install
```

### **Passo 2: Clonar o projeto**
```bash
# Clonar repositório
git clone https://github.com/gustavo-f0ntz/move-smart-todolist.git
cd move-smart-todolist

# Ou criar do zero seguindo a estrutura:
# Move.toml + sources/todo_list.move + tests/
```

### **Passo 3: Estrutura do projeto**
```
move-smart-todolist/
├── Move.toml              # Configuração do projeto
├── sources/
│   └── todo_list.move     # Smart contract principal
├── tests/
│   └── todo_list_tests.move
├── README.md
└── .gitignore
```

---

## 🏠 **Desenvolvimento Local**

### **Passo 4: Iniciar rede local do Sui**
```bash
# Iniciar localnet (primeira vez ou para limpar)
sui start --force-regenesis

# Para continuar trabalhando (mantém dados)
sui start
```

### **Passo 5: Verificar configuração**
```bash
# Ver redes disponíveis
sui client envs

# Ver endereço ativo
sui client active-address

# Ver saldo de gas
sui client gas
```

### **Passo 6: Build do projeto**
```bash
# Compilar o smart contract
sui move build

# Se der erro, verificar:
# - Sintaxe do código
# - Imports corretos
# - Move.toml configurado
```

### **Passo 7: Deploy local**
```bash
# Publicar na localnet
sui client publish --gas-budget 100000000

# Salvar Package ID (aparece no output)
export PACKAGE_ID=0x[SEU_PACKAGE_ID_AQUI]
```

### **Passo 8: Testar funcionalidades**
```bash
# Definir variáveis
export MY_ADDRESS=$(sui client active-address)

# Criar nova TodoList
sui client ptb \
  --gas-budget 100000000 \
  --assign sender @$MY_ADDRESS \
  --move-call $PACKAGE_ID::todo_list::new \
  --assign list \
  --transfer-objects "[list]" sender

# Salvar TodoList ID (aparece no output)
export TODO_LIST_ID=0x[SEU_TODO_LIST_ID_AQUI]

# Adicionar item
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::add @$TODO_LIST_ID '"Minha primeira tarefa"'

# Verificar conteúdo
sui client object $TODO_LIST_ID
```

---

## 🌐 **Deploy na Testnet**

### **Passo 9: Conectar na testnet**
```bash
# Mudar para testnet
sui client switch --env devnet

# Verificar conexão
sui client envs
# (devnet deve estar marcado como ativo)
```

### **Passo 10: Obter SUI de teste**
```bash
# Pedir SUI do faucet
sui client faucet

# Aguardar 1 minuto e verificar
sui client gas
# Deve mostrar ~10 SUI
```

### **Passo 11: Deploy na testnet**
```bash
# Publicar na testnet oficial
sui client publish --gas-budget 100000000

# Anotar o novo Package ID
export PACKAGE_ID_TESTNET=0x[NOVO_PACKAGE_ID]
```

### **Passo 12: Testar na testnet**
```bash
# Criar TodoList na testnet
sui client ptb \
  --gas-budget 100000000 \
  --assign sender @$(sui client active-address) \
  --move-call $PACKAGE_ID_TESTNET::todo_list::new \
  --assign list \
  --transfer-objects "[list]" sender

# Anotar TodoList ID
export TODO_LIST_ID_TESTNET=0x[NOVO_TODO_LIST_ID]

# Adicionar item de teste
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID_TESTNET::todo_list::add @$TODO_LIST_ID_TESTNET '"Testando na blockchain oficial! 🚀"'

# Verificar resultado
sui client object $TODO_LIST_ID_TESTNET
```

---

## 🧪 **Testando Funcionalidades**

### **Operações disponíveis:**

#### **1. Criar TodoList**
```bash
sui client ptb \
  --gas-budget 100000000 \
  --assign sender @$(sui client active-address) \
  --move-call $PACKAGE_ID::todo_list::new \
  --assign list \
  --transfer-objects "[list]" sender
```

#### **2. Adicionar item**
```bash
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::add @$TODO_LIST_ID '"Novo item"'
```

#### **3. Ver quantidade de itens**
```bash
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::length @$TODO_LIST_ID
```

#### **4. Remover item por índice**
```bash
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::remove @$TODO_LIST_ID 0
```

#### **5. Ver conteúdo completo**
```bash
sui client object $TODO_LIST_ID
```

#### **6. Deletar TodoList**
```bash
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::delete @$TODO_LIST_ID
```

---

## 📚 **Comandos de Referência**

### **Gerenciamento de rede:**
```bash
# Ver redes disponíveis
sui client envs

# Trocar para localnet
sui client switch --env local

# Trocar para testnet
sui client switch --env devnet

# Iniciar localnet
sui start

# Resetar localnet (apaga tudo)
sui start --force-regenesis
```

### **Gerenciamento de objetos:**
```bash
# Ver todos seus objetos
sui client objects

# Ver objeto específico
sui client object [OBJECT_ID]

# Ver saldo de gas
sui client gas

# Pedir SUI de teste (só testnet)
sui client faucet
```

### **Build e deploy:**
```bash
# Compilar projeto
sui move build

# Rodar testes
sui move test

# Publicar contrato
sui client publish --gas-budget 100000000
```

---

## 🆔 **IDs de Exemplo (Testnet)**

> **Atenção**: Estes IDs são específicos do nosso deploy. Cada deploy gera IDs únicos!

```bash
# Package ID (nosso deploy na testnet)
PACKAGE_ID=0x8494f8a117b0d18cf9fc4ddb0817c25a327841ed4c264ae57a286ea9d7180eaf

# TodoList ID (nossa instância de exemplo)
TODO_LIST_ID=0x67a253a4ba4e03d3731297fb4f883ef1d97744d6146fadd828f506877c05ae15

# Para usar:
export PACKAGE_ID=0x8494f8a117b0d18cf9fc4ddb0817c25a327841ed4c264ae57a286ea9d7180eaf
export TODO_LIST_ID=0x67a253a4ba4e03d3731297fb4f883ef1d97744d6146fadd828f506877c05ae15
```

---

## 🔧 **Solução de Problemas**

### **Erro: "Could not build PTB"**
```bash
# Verificar se variáveis estão definidas
echo $PACKAGE_ID
echo $TODO_LIST_ID

# Re-definir se necessário
export PACKAGE_ID=0x[SEU_ID]
export TODO_LIST_ID=0x[SEU_ID]
```

### **Erro: "Object does not exist"**
```bash
# Verificar se você está na rede certa
sui client envs

# Se mudou de rede, precisa re-deploy
sui client publish --gas-budget 100000000
```

### **Erro: "No gas coins"**
```bash
# Na testnet, pedir mais SUI
sui client faucet

# Na localnet, resetar
sui start --force-regenesis
```

### **Erro: "String com espaços"**
```bash
# Use aspas aninhadas para strings com espaços
'"String com espaços"'

# Exemplo:
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::add @$TODO_LIST_ID '"Minha tarefa com espaços"'
```

### **Sui não conecta/trava**
```bash
# Matar processos do Sui
pkill sui

# Aguardar e tentar novamente
sui start
```

---

## 🎯 **Conceitos Importantes**

### **`&mut` (Referência Mutável)**
- **O que é**: "Me empresta o objeto para modificar"
- **Quando usar**: Funções que alteram o estado
- **Exemplo**: `add(list: &mut TodoList, item: String)`

### **Ownership**
- **Owner**: Quem "possui" o objeto na blockchain
- **Transfer**: Mudar ownership
- **Imutável**: Objetos que nunca mudam de dono

### **PTB (Programmable Transaction Block)**
- **O que é**: Combinar múltiplas operações em uma transação
- **Vantagem**: Atomicidade + eficiência
- **Como usar**: `sui client ptb` + comandos

---

## 🔗 **Links Úteis**

- **Repositório**: https://github.com/gustavo-f0ntz/move-smart-todolist
- **Documentação Sui**: https://docs.sui.io/
- **Move Language**: https://move-language.github.io/move/
- **Explorer Testnet**: https://suiscan.xyz/testnet/

---

## 🎓 **Próximos Passos**

1. **Implementar testes unitários**
2. **Adicionar funcionalidades avançadas**
3. **Criar interface web**
4. **Explorar outros padrões Move**
5. **Contribuir para ecosystem Sui**

---

## 👨‍💻 **Créditos**

**Desenvolvido por**: f0ntz  
**Comunidade**: [Nome da Comunidade]  
**Data**: Agosto 2025  

> *"Pouco a pouco a gente vai ganhando forma!"* 🚀

---

**🎯 DICA FINAL**: Sempre use o CLI para verificar se tudo está funcionando. Os explorers web podem ter delay, mas o CLI sempre mostra a realidade da blockchain!
