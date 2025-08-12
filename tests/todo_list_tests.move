#[test_only]
module todo_list::todo_list_tests;

use todo_list::todo_list;
use std::string;

#[test]
fun test_create_new_todo_list() {
    let mut ctx = tx_context::dummy();
    
    // Criar uma nova TodoList
    let todo_list = todo_list::new(&mut ctx);
    
    // Verificar se está vazia
    assert!(todo_list::length(&todo_list) == 0, 0);
    
    // Limpar
    todo_list::delete(todo_list);
}

#[test]
fun test_add_items_to_list() {
    let mut ctx = tx_context::dummy();
    
    // Criar lista
    let mut todo_list = todo_list::new(&mut ctx);
    
    // Adicionar items
    let item1 = string::utf8(b"Estudar Move");
    let item2 = string::utf8(b"Fazer exercicios");
    
    todo_list::add(&mut todo_list, item1);
    todo_list::add(&mut todo_list, item2);
    
    // Verificar quantidade
    assert!(todo_list::length(&todo_list) == 2, 1);
    
    // Limpar
    todo_list::delete(todo_list);
}

#[test]
fun test_remove_item_from_list() {
    let mut ctx = tx_context::dummy();
    
    // Criar lista e adicionar items
    let mut todo_list = todo_list::new(&mut ctx);
    let item1 = string::utf8(b"Item 1");
    let item2 = string::utf8(b"Item 2");
    let item3 = string::utf8(b"Item 3");
    
    todo_list::add(&mut todo_list, item1);
    todo_list::add(&mut todo_list, item2);
    todo_list::add(&mut todo_list, item3);
    
    // Remover item do meio (indice 1)
    let removed_item = todo_list::remove(&mut todo_list, 1);
    
    // Verificar se removeu o item correto
    assert!(removed_item == string::utf8(b"Item 2"), 2);
    
    // Verificar se a quantidade diminuiu
    assert!(todo_list::length(&todo_list) == 2, 3);
    
    // Limpar
    todo_list::delete(todo_list);
}

#[test]
fun test_empty_list_length() {
    let mut ctx = tx_context::dummy();
    
    let todo_list = todo_list::new(&mut ctx);
    assert!(todo_list::length(&todo_list) == 0, 4);
    
    todo_list::delete(todo_list);
}

#[test, expected_failure]
fun test_remove_from_empty_list_should_fail() {
    let mut ctx = tx_context::dummy();
    
    let mut todo_list = todo_list::new(&mut ctx);
    
    // Tentar remover de lista vazia (deve falhar)
    let _removed = todo_list::remove(&mut todo_list, 0);
    
    todo_list::delete(todo_list);
}

#[test, expected_failure]
fun test_remove_invalid_index_should_fail() {
    let mut ctx = tx_context::dummy();
    
    let mut todo_list = todo_list::new(&mut ctx);
    todo_list::add(&mut todo_list, string::utf8(b"Item unico"));
    
    // Tentar remover índice inválido (deve falhar)
    let _removed = todo_list::remove(&mut todo_list, 10);
    
    todo_list::delete(todo_list);
}
