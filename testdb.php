<?php
# test database
$dbname = 'phpbb';
$dbuser = 'phpbb';
$dbpass = 'geheim2';
$dbhost = 'container1';

$link = mysqli_connect($dbhost, $dbuser, $dbpass) or die("Unable to Connect to '$dbhost'");
mysqli_select_db($link, $dbname) or die("Could not open the db '$dbname'");

$sql = "SELECT COUNT(*) as tablecount FROM information_schema.tables WHERE table_schema = '$dbname' ";
$result = mysqli_query($link, $sql);
$value = mysqli_fetch_array($result);
 
$tblCnt = is_array($value) ? $value[0] : 0;
echo "There are $tblCnt phpBB tables<br />\n";

?>