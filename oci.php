<?php

$HOST = '';
$SID = '';
$USERNAME = '';
$PASSWORD = '';

function connect($host, $sid, $u, $p)
{
    $dburl = "(DESCRIPTION =
     (ADDRESS = (PROTOCOL = TCP)(HOST = $host)(PORT = 1521))
     (CONNECT_DATA =
       (SERVER = DEDICATED)
       (SERVICE_NAME = $sid)
     )
     )";
    try {
        $connection = oci_connect($u, $p, $dburl);
        if ($connection) {
            echo "Connection successful to $sid at $host\n";
        } else {
            $error = oci_error();
            echo "Connection failed: " . $error['message'] . "\n";
        }
        return $connection;
    } catch (Exception $e) {
        die("Exception occurred: " . $e->getMessage());
    }
}

connect($HOST, $SID, $USERNAME, $PASSWORD
); // Call the function to establish a connection
