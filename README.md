# Donation System – Sui Move Smart Contract

Este repositório contém um contrato inteligente escrito em **Move** para a blockchain **Sui**, que implementa um sistema simples de **doações em SUI** com controle administrativo para saque dos fundos.

## 📦 Visão Geral

O contrato permite:

- Criar uma **DonationBox** compartilhada
- Receber doações em **SUI**
- Consultar o total doado
- Permitir que apenas o **administrador** saque os fundos

## 🧱 Estrutura do Contrato


module 0x0::donation_system;

## Struct DonationBox

public struct DonationBox has key, store {
    id: UID,
    funds: Balance<SUI>,
    admin: address,
}


## Funções Públicas

public entry fun create_donation_box(ctx: &mut TxContext)

Cria uma nova DonationBox e a compartilha na rede.

O criador se torna o administrador

O saldo inicial é 0 SUI

A DonationBox é um shared object

## donate

public entry fun donate(box: &mut DonationBox, coin_in: Coin<SUI>)

Permite que qualquer usuário envie SUI para a DonationBox.

Converte Coin<SUI> em Balance<SUI>

Soma ao saldo existente

## withdraw_funds

public entry fun withdraw_funds(box: &mut DonationBox, ctx: &mut TxContext)

Permite que o administrador saque todo o saldo acumulado.

## Regras:

Apenas o endereço admin pode chamar

O saldo deve ser maior que 0

Todo o valor é sacado de uma vez

## Segurança:

assert!(box.admin == sender, 0)

assert!(amount_to_withdraw > 0, 1)


## get_total_donated

public fun get_total_donated(box: &DonationBox): u64

Retorna o total de SUI doado à DonationBox.

Desenvolvido por Alberto Paim
Blockchain: Sui
Linguagem: Move
