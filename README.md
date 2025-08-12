# 📋 TodoList em Move

Um smart contract simples de lista de tarefas implementado em **Move** para a blockchain **Sui**.

## 🚀 Funcionalidades

- ✅ **Criar** uma nova TodoList
- ✅ **Adicionar** itens à lista
- ✅ **Remover** itens por índice
- ✅ **Consultar** quantidade de itens
- ✅ **Deletar** a lista completamente

## 📁 Estrutura do Projeto

```
todo_list/
├── Move.toml          # Configuração do projeto
├── sources/
│   └── todo_list.move # Smart contract principal
└── tests/
    └── todo_list_tests.move # Testes (se existir)
```

## 🛠️ Como usar

### 1. Build do projeto
```bash
sui move build
```

### 2. Publicar na blockchain
```bash
sui client publish --gas-budget 100000000
```

### 3. Criar uma nova TodoList
```bash
sui client ptb \
  --gas-budget 100000000 \
  --assign sender @$MY_ADDRESS \
  --move-call $PACKAGE_ID::todo_list::new \
  --assign list \
  --transfer-objects "[list]" sender
```

### 4. Adicionar um item
```bash
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::add @$TODO_LIST_ID '"Minha tarefa"'
```

### 5. Ver quantidade de itens
```bash
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::length @$TODO_LIST_ID
```

### 6. Remover um item (por índice)
```bash
sui client ptb --gas-budget 10000000 \
  --move-call $PACKAGE_ID::todo_list::remove @$TODO_LIST_ID 0
```

## 📝 Estrutura do Smart Contract

```move
public struct TodoList has key, store {
    id: UID,
    items: vector<String>
}
```

### Funções disponíveis:
- `new()` - Cria uma nova TodoList
- `add(list, item)` - Adiciona um item
- `remove(list, index)` - Remove item por índice
- `length(list)` - Retorna quantidade de itens
- `delete(list)` - Deleta a lista

## 🔧 Tecnologias

- **Move** - Linguagem de programação
- **Sui** - Blockchain
- **Git** - Controle de versão

## 👨‍💻 Autor

Desenvolvido com ❤️ durante o aprendizado de Move!

---

**Nota**: Este é um projeto educacional para aprender os conceitos básicos de Move e Sui blockchain.
