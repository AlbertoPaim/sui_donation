module 0x0::donation_system;

use sui::balance::{Self, Balance};
use sui::coin::{Self, Coin};
use sui::object::{Self, UID};
use sui::sui::SUI;
use sui::transfer;
use sui::tx_context::{Self, TxContext};

public struct DonationBox has key, store {
    id: UID,
    funds: Balance<SUI>,
    admin: address,
}

public entry fun create_donation_box(ctx: &mut TxContext) {
    let sender = tx_context::sender(ctx);

    let box = DonationBox {
        id: object::new(ctx),
        funds: balance::zero<SUI>(),
        admin: sender,
    };

    transfer::share_object(box);
}

public entry fun withdraw_funds(box: &mut DonationBox, ctx: &mut TxContext) {
    let sender = tx_context::sender(ctx);

    assert!(box.admin == sender, 0);
    let amount_to_withdraw = balance::value(&box.funds);

    assert!(amount_to_withdraw > 0, 1);

    let total_balance = balance::split(&mut box.funds, amount_to_withdraw);

    let withdrawal_coin = coin::from_balance(total_balance, ctx);

    transfer::public_transfer(withdrawal_coin, sender);
}

public entry fun donate(box: &mut DonationBox, coin_in: Coin<SUI>) {
    let received_balance = coin::into_balance(coin_in);

    balance::join(&mut box.funds, received_balance);
}

public fun get_total_donated(box: &DonationBox): u64 {
    balance::value(&box.funds)
}
