import ballerina/http;

type StockBalance record {|
    readonly string productId;
    int quantity;
|};

service / on new http:Listener(8080) {

    private table<StockBalance> key(productId) stockBalances = table [];

    function init() {
        self.stockBalances.add({productId: "90090087", quantity: 11});
        self.stockBalances.add({productId: "90090088", quantity: 22});

    }

    resource function get inventory/[string productId]() returns StockBalance|http:NotFound {

        if !self.stockBalances.hasKey(productId) {
            return <http:NotFound>{};
        }
        return self.stockBalances.get(productId);
    }
}

