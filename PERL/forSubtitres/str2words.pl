#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: str2words.pl
#
#        USAGE: ./str2words.pl  
#
#  DESCRIPTION: 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 12.09.2016 14:52:31
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;
use Data::Dumper;


sub openfile
{
    my ($file_name) = @_;
    my ($file_handle, $body);

    # открыть для чтения файл по имени, взятом из $file_name
    open($file_handle, "<$file_name") or  die("Ошибка открытия файла $file_name: $!\n"); 

    while(<$file_handle> )
    {
        $body .= $_;
    } 

    close($file_handle) or die("Ошибка при закрытии файла: $!\n");

    return \$body;
}


sub searchWords
{
	my ($body) = @_;
	my (%arr, @arr) = ();
	
	$$body=~s/([a-zA-Z]{2,}\'[a-z]+|[a-zA-Z]{3,})/$arr{lc($1)}++/ge;

	#print Dumper \%arr;
	

	foreach my $key(sort { $arr{$a} <=> $arr{$b} } keys %arr)
	{
		#print "$key: $arr{$key}\n";
		unshift @arr , $key;	
	}	
	
	for (@arr)
	{
		print $_, "\n";
	}

	#print @arr, "\n";
	return 1;
}


sub main 
{
	my ($t) = openfile 'test.txt';
	
	searchWords ($t);
	#print Dumper $t;
}

main;
