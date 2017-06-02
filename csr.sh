echo "Please enter your project name"
read pname
openssl req -new -newkey rsa:2048 -nodes -keyout $pname.key -out $pname.csr
