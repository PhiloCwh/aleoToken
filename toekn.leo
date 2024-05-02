// Define the structure of your token
struct Token {
    // Define the properties of the token
    pub const NAME: &str = "ExampleToken";
    pub const SYMBOL: &str = "EXT";
    pub const DECIMALS: u8 = 18;
    pub const INITIAL_SUPPLY: u64 = 1_000_000;

    // Balances of each account stored in a map
    balances: Map<Address, u64>,
    // Total supply of the token
    total_supply: u64,
}

// Implement the functionality for your token
impl Token {
    // Initialize a new token with the initial supply
    pub fn new() -> Self {
        let mut balances = Map::new();
        balances.insert(aleo::input(), Self::INITIAL_SUPPLY);
        Self {
            balances,
            total_supply: Self::INITIAL_SUPPLY,
        }
    }

    // Function to transfer tokens between accounts
    pub fn transfer(&mut self, to: Address, amount: u64) -> bool {
        let sender = aleo::input();
        let sender_balance = self.balances.get(&sender).unwrap_or_default();

        // Check if the sender has enough balance
        if sender_balance < amount {
            return false;
        }

        // Update balances
        let to_balance = self.balances.get(&to).unwrap_or_default();
        self.balances.insert(sender, sender_balance - amount);
        self.balances.insert(to, to_balance + amount);

        true
    }

    // Get the balance of a given account
    pub fn balance_of(&self, account: Address) -> u64 {
        self.balances.get(&account).unwrap_or_default()
    }
}
