Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526D637236A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhECXH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:07:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhECXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F57461283;
        Mon,  3 May 2021 23:06:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheT-009Y9h-Mg; Mon, 03 May 2021 19:06:57 -0400
Message-ID: <20210503230657.558388496@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        "John Warthog9 Hawley (VMware)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 4/7] ktest: Fixing indentation to match expected pattern
References: <20210503230510.845068955@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>

This is a followup to "ktest: Adding editor hints to improve
consistency" to actually adjust the existing indentation to match
the, now, expected pattern (first column 4 spaces, 2nd tab, 3rd
tab + 4 spaces, etc).  This should, at least help, keep things
consistent going forward now.

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 186 +++++++++++++++++------------------
 1 file changed, 92 insertions(+), 94 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 14a753b86445..633c715173ff 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -760,7 +760,7 @@ sub process_variables {
     # remove the space added in the beginning
     $retval =~ s/ //;
 
-    return "$retval"
+    return "$retval";
 }
 
 sub set_value {
@@ -1095,7 +1095,7 @@ sub __read_config {
 		    }
 		}
 	    }
-		
+
 	    if ( ! -r $file ) {
 		die "$name: $.: Can't read file $file\n$_";
 	    }
@@ -1186,13 +1186,13 @@ sub __read_config {
 }
 
 sub get_test_case {
-	print "What test case would you like to run?\n";
-	print " (build, install or boot)\n";
-	print " Other tests are available but require editing ktest.conf\n";
-	print " (see tools/testing/ktest/sample.conf)\n";
-	my $ans = <STDIN>;
-	chomp $ans;
-	$default{"TEST_TYPE"} = $ans;
+    print "What test case would you like to run?\n";
+    print " (build, install or boot)\n";
+    print " Other tests are available but require editing ktest.conf\n";
+    print " (see tools/testing/ktest/sample.conf)\n";
+    my $ans = <STDIN>;
+    chomp $ans;
+    $default{"TEST_TYPE"} = $ans;
 }
 
 sub read_config {
@@ -1519,13 +1519,13 @@ sub dodie {
 	    close O;
 	    close L;
 	}
-        send_email("KTEST: critical failure for test $i [$name]",
-                "Your test started at $script_start_time has failed with:\n@_\n", $log_file);
+	send_email("KTEST: critical failure for test $i [$name]",
+	        "Your test started at $script_start_time has failed with:\n@_\n", $log_file);
     }
 
     if ($monitor_cnt) {
-	    # restore terminal settings
-	    system("stty $stty_orig");
+	# restore terminal settings
+	system("stty $stty_orig");
     }
 
     if (defined($post_test)) {
@@ -1709,81 +1709,81 @@ sub wait_for_monitor {
 }
 
 sub save_logs {
-	my ($result, $basedir) = @_;
-	my @t = localtime;
-	my $date = sprintf "%04d%02d%02d%02d%02d%02d",
-		1900+$t[5],$t[4],$t[3],$t[2],$t[1],$t[0];
+    my ($result, $basedir) = @_;
+    my @t = localtime;
+    my $date = sprintf "%04d%02d%02d%02d%02d%02d",
+	1900+$t[5],$t[4],$t[3],$t[2],$t[1],$t[0];
 
-	my $type = $build_type;
-	if ($type =~ /useconfig/) {
-	    $type = "useconfig";
-	}
+    my $type = $build_type;
+    if ($type =~ /useconfig/) {
+	$type = "useconfig";
+    }
 
-	my $dir = "$machine-$test_type-$type-$result-$date";
+    my $dir = "$machine-$test_type-$type-$result-$date";
 
-	$dir = "$basedir/$dir";
+    $dir = "$basedir/$dir";
 
-	if (!-d $dir) {
-	    mkpath($dir) or
-		dodie "can't create $dir";
-	}
+    if (!-d $dir) {
+	mkpath($dir) or
+	    dodie "can't create $dir";
+    }
 
-	my %files = (
-		"config" => $output_config,
-		"buildlog" => $buildlog,
-		"dmesg" => $dmesg,
-		"testlog" => $testlog,
-	);
+    my %files = (
+	"config" => $output_config,
+	"buildlog" => $buildlog,
+	"dmesg" => $dmesg,
+	"testlog" => $testlog,
+    );
 
-	while (my ($name, $source) = each(%files)) {
-		if (-f "$source") {
-			cp "$source", "$dir/$name" or
-				dodie "failed to copy $source";
-		}
+    while (my ($name, $source) = each(%files)) {
+	if (-f "$source") {
+	    cp "$source", "$dir/$name" or
+		dodie "failed to copy $source";
 	}
+    }
 
-	doprint "*** Saved info to $dir ***\n";
+    doprint "*** Saved info to $dir ***\n";
 }
 
 sub fail {
 
-	if ($die_on_failure) {
-		dodie @_;
-	}
+    if ($die_on_failure) {
+	dodie @_;
+    }
 
-	doprint "FAILED\n";
+    doprint "FAILED\n";
 
-	my $i = $iteration;
+    my $i = $iteration;
 
-	# no need to reboot for just building.
-	if (!do_not_reboot) {
-	    doprint "REBOOTING\n";
-	    reboot_to_good $sleep_time;
-	}
+    # no need to reboot for just building.
+    if (!do_not_reboot) {
+	doprint "REBOOTING\n";
+	reboot_to_good $sleep_time;
+    }
 
-	my $name = "";
+    my $name = "";
 
-	if (defined($test_name)) {
-	    $name = " ($test_name)";
-	}
+    if (defined($test_name)) {
+	$name = " ($test_name)";
+    }
 
-	print_times;
+    print_times;
 
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
-	doprint "KTEST RESULT: TEST $i$name Failed: ", @_, "\n";
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
-	doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "KTEST RESULT: TEST $i$name Failed: ", @_, "\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
+    doprint "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n";
 
-	if (defined($store_failures)) {
-	    save_logs "fail", $store_failures;
-        }
+    if (defined($store_failures)) {
+	save_logs "fail", $store_failures;
+    }
 
-	if (defined($post_test)) {
-		run_command $post_test;
-	}
+    if (defined($post_test)) {
+	run_command $post_test;
+    }
 
-	return 1;
+    return 1;
 }
 
 sub run_command {
@@ -1969,9 +1969,9 @@ sub get_grub_index {
 	$target = '^menuentry.*' . $grub_menu_qt;
 	$skip = '^menuentry\s|^submenu\s';
     } elsif ($reboot_type eq "grub2bls") {
-        $command = $grub_bls_get;
-        $target = '^title=.*' . $grub_menu_qt;
-        $skip = '^title=';
+	$command = $grub_bls_get;
+	$target = '^title=.*' . $grub_menu_qt;
+	$skip = '^title=';
     } else {
 	return;
     }
@@ -2394,7 +2394,7 @@ sub check_buildlog {
 	while (<IN>) {
 	    if (/$check_build_re/) {
 		my $warning = process_warning_line $_;
-		
+
 		$warnings_list{$warning} = 1;
 	    }
 	}
@@ -2659,7 +2659,7 @@ sub success {
     doprint     "*******************************************\n";
 
     if (defined($store_successes)) {
-        save_logs "success", $store_successes;
+	save_logs "success", $store_successes;
     }
 
     if ($i != $opt{"NUM_TESTS"} && !do_not_reboot) {
@@ -3246,13 +3246,13 @@ sub run_config_bisect {
 
     $ret = run_config_bisect_test $config_bisect_type;
     if ($ret) {
-        doprint "NEW GOOD CONFIG ($pass)\n";
+	doprint "NEW GOOD CONFIG ($pass)\n";
 	system("cp $output_config $tmpdir/good_config.tmp.$pass");
 	$pass++;
 	# Return 3 for good config
 	return 3;
     } else {
-        doprint "NEW BAD CONFIG ($pass)\n";
+	doprint "NEW BAD CONFIG ($pass)\n";
 	system("cp $output_config $tmpdir/bad_config.tmp.$pass");
 	$pass++;
 	# Return 4 for bad config
@@ -3371,7 +3371,7 @@ sub config_bisect {
     } while ($ret == 3 || $ret == 4);
 
     if ($ret == 2) {
-        config_bisect_end "$good_config.tmp", "$bad_config.tmp";
+	config_bisect_end "$good_config.tmp", "$bad_config.tmp";
     }
 
     return $ret if ($ret < 0);
@@ -3551,7 +3551,6 @@ sub read_kconfig {
     my $cont = 0;
     my $line;
 
-
     if (! -f $kconfig) {
 	doprint "file $kconfig does not exist, skipping\n";
 	return;
@@ -3660,7 +3659,7 @@ sub read_depends {
 
     if (! -f $kconfig && $arch =~ /\d$/) {
 	my $orig = $arch;
- 	# some subarchs have numbers, truncate them
+	# some subarchs have numbers, truncate them
 	$arch =~ s/\d*$//;
 	$kconfig = "$builddir/arch/$arch/Kconfig";
 	if (! -f $kconfig) {
@@ -3855,7 +3854,7 @@ sub make_min_config {
     foreach my $config (@config_keys) {
 	my $kconfig = chomp_config $config;
 	if (!defined $depcount{$kconfig}) {
-		$depcount{$kconfig} = 0;
+	    $depcount{$kconfig} = 0;
 	}
     }
 
@@ -3957,13 +3956,13 @@ sub make_min_config {
 	my $failed = 0;
 	build "oldconfig" or $failed = 1;
 	if (!$failed) {
-		start_monitor_and_install or $failed = 1;
+	    start_monitor_and_install or $failed = 1;
 
-		if ($type eq "test" && !$failed) {
-		    do_run_test or $failed = 1;
-		}
+	    if ($type eq "test" && !$failed) {
+		do_run_test or $failed = 1;
+	    }
 
-		end_monitor;
+	    end_monitor;
 	}
 
 	$in_bisect = 0;
@@ -4277,8 +4276,8 @@ sub send_email {
 sub cancel_test {
     if ($email_when_canceled) {
 	my $name = get_test_name;
-        send_email("KTEST: Your [$name] test was cancelled",
-                "Your test started at $script_start_time was cancelled: sig int");
+	send_email("KTEST: Your [$name] test was cancelled",
+	        "Your test started at $script_start_time was cancelled: sig int");
     }
     die "\nCaught Sig Int, test interrupted: $!\n"
 }
@@ -4326,15 +4325,15 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     # The first test may override the PRE_KTEST option
     if ($i == 1) {
-        if (defined($pre_ktest)) {
-            doprint "\n";
-            run_command $pre_ktest;
-        }
-        if ($email_when_started) {
+	if (defined($pre_ktest)) {
+	    doprint "\n";
+	    run_command $pre_ktest;
+	}
+	if ($email_when_started) {
 	    my $name = get_test_name;
-            send_email("KTEST: Your [$name] test was started",
-                "Your test was started on $script_start_time");
-        }
+	    send_email("KTEST: Your [$name] test was started",
+	        "Your test was started on $script_start_time");
+	}
     }
 
     # Any test can override the POST_KTEST option
@@ -4506,12 +4505,11 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
     run_command $switch_to_good;
 }
 
-
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
     send_email("KTEST: Your test has finished!",
-            "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
+	    "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
 }
 
 if (defined($opt{"LOG_FILE"})) {
-- 
2.30.1


