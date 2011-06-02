#!/usr/bin/perl -w

use File::Basename;

my ($f)=$ARGV[0];

die("file [$f] not found") unless ( -f "$f" );
$table_name = "$1_md5" if ($f =~ m/(\w+)\.md5/);

$DDL=qq(create table $table_name (dir text, name text, md5 text));
print $DDL.";\n\n";
open FH, "$f" or die;
while(<FH>) {
    my ($md5, $complete_name) = (m/^(\S{32})\s+(.+)$/);
    my($filename, $directories, $suffix) = fileparse($complete_name);
    printf "insert into ${table_name} (dir, name, md5) values (\"%s\",\"%s\",\"%s\");\n", 
      $directories, $filename, $md5;
    
}
close (FH);


