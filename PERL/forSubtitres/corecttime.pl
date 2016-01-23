#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: corecttime.pl
#
#        USAGE: ./corecttime.pl  
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
#      CREATED: 23.01.2016 13:11:35
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use utf8;

my ($TIMEADD) = 8;

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


sub addTime
{
    my ($time) =  @_;

    my ($hours, $minuts, $other) = split(/:/, $time);

    my($seconds, $miliseconds) = split(/,/, $other);

    $seconds += $TIMEADD;

    if($seconds > 59)
    {
        $minuts += $TIMEADD;
        $seconds = 0;
    }

    if($minuts > 59)
    {
        $hours += $TIMEADD;
        $minuts = 0;
    }

    $hours = "0$hours" if($hours>1 && $hours<10);
    $minuts = "0$minuts" if($minuts<10);
    $seconds = "0$seconds" if($seconds<10);

    $time = "$hours:$minuts:$seconds,$miliseconds";

    #print $time, "\n";

    return $time;
}



sub main
{
    my($body)  = openfile('en.srt');
    #00:00:09,200 --> 00:00:11,668
   
    $$body=~s/(\d+:\d+:\d+,\d+)\s+-->\s+(\d+:\d+:\d+,\d+)/addTime($1). " --> " . addTime($2)/ge;
    
    print $$body;
}





main();
