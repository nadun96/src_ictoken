import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Option "mo:base/Option";
import Text "mo:base/Text";
import Debug "mo:base/Debug";

actor Token {
    let owner : Principal = Principal.fromText("czpkh-bqzqp-f3o3v-e3ckk-3magc-vnzjc-nmhle-ym5ju-jrtma-wm5pj-oqe");
    var totalSupply : Nat.Nat = 1000000000;
    var symbol : Text.Text = "NAND";

    var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply);

    public query func balanceOf(who : Principal) : async Nat {
        let balance : Nat = switch (balances.get(who)) {
            case null 0;
            case (?result) result;
        };
        return balance;
    };

    public query func getSymbol() : async Text.Text {
        return symbol;
    };

    public shared (msg) func payOut() : async Text {
        Debug.print(debug_show (msg));
        if (balances.get(msg.caller) == null) {
            let amount = 10000;
            balances.put(msg.caller, amount);
            return "Success";
        } else {
            return "Already claimed";
        };
    };

    public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {
        // call payout first to ensure the caller has a balance
        let _ = await payOut();
        let fromBalance : Nat = switch (balances.get(msg.caller)) {
            case null 0;
            case (?result) result;
        };
        if (fromBalance < amount) {
            return "Insufficient balance";
        };
        let toBalance : Nat = switch (balances.get(to)) {
            case null 0;
            case (?result) result;
        };
        balances.put(msg.caller, fromBalance - amount);
        balances.put(to, toBalance + amount);
        return "Transfer successful";
    };

    system func preupgrade() {
        balanceEntries := Iter.toArray(balances.entries());
    };

    system func postupgrade() {
        balances := HashMap.fromIter<Principal, Nat>(balanceEntries.vals(), 1, Principal.equal, Principal.hash);
        if (balances.size() < 1) {
            balances.put(owner, totalSupply);
        };
    };
};
