
import ballerinax/mysql;
import ballerinax/mysql.driver as _;
import ballerina/http;

type Person record {
    string nic;
    string name;
};

// MySQL configuration parameters
configurable string host = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;

final mysql:Client mysqlEp = check new (host = host, user = username, database = database, password = password);

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    isolated resource function get persons(string nic) returns Person|error? {

        Person|error queryRowResponse = mysqlEp->queryRow(sqlQuery = `select * from persons where nic=${nic}`);
        return queryRowResponse;

    }
}