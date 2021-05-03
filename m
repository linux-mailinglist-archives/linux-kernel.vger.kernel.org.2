Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A088037236B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhECXIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhECXHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBAB3613B4;
        Mon,  3 May 2021 23:06:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheT-009YAD-RV; Mon, 03 May 2021 19:06:57 -0400
Message-ID: <20210503230657.738348001@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        "John Warthog9 Hawley (VMware)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 5/7] ktest: Further consistency cleanups
References: <20210503230510.845068955@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>

This cleans up some additional whitespace pieces that to be more
consistent, as well as moving a curly brace around, and some 'or'
statements to match the rest of the file (usually or goes at the
end of the line vs. at the beginning)

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 85 +++++++++++++++---------------------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 633c715173ff..a3c6ad64c479 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -24,7 +24,7 @@ my %evals;
 
 #default opts
 my %default = (
-    "MAILER"			=> "sendmail",  # default mailer
+    "MAILER"			=> "sendmail",	# default mailer
     "EMAIL_ON_ERROR"		=> 1,
     "EMAIL_WHEN_FINISHED"	=> 1,
     "EMAIL_WHEN_CANCELED"	=> 0,
@@ -36,15 +36,15 @@ my %default = (
     "CLOSE_CONSOLE_SIGNAL"	=> "INT",
     "TIMEOUT"			=> 120,
     "TMP_DIR"			=> "/tmp/ktest/\${MACHINE}",
-    "SLEEP_TIME"		=> 60,	# sleep time between tests
+    "SLEEP_TIME"		=> 60,		# sleep time between tests
     "BUILD_NOCLEAN"		=> 0,
     "REBOOT_ON_ERROR"		=> 0,
     "POWEROFF_ON_ERROR"		=> 0,
     "REBOOT_ON_SUCCESS"		=> 1,
     "POWEROFF_ON_SUCCESS"	=> 0,
     "BUILD_OPTIONS"		=> "",
-    "BISECT_SLEEP_TIME"		=> 60,   # sleep time between bisects
-    "PATCHCHECK_SLEEP_TIME"	=> 60, # sleep time between patch checks
+    "BISECT_SLEEP_TIME"		=> 60,		# sleep time between bisects
+    "PATCHCHECK_SLEEP_TIME"	=> 60, 		# sleep time between patch checks
     "CLEAR_LOG"			=> 0,
     "BISECT_MANUAL"		=> 0,
     "BISECT_SKIP"		=> 1,
@@ -537,7 +537,7 @@ sub read_prompt {
     my $ans;
 
     for (;;) {
-	if ($cancel) {
+        if ($cancel) {
 	    print "$prompt [y/n/C] ";
 	} else {
 	    print "$prompt [Y/n] ";
@@ -863,7 +863,6 @@ sub value_defined {
 	defined($opt{$2});
 }
 
-my $d = 0;
 sub process_expression {
     my ($name, $val) = @_;
 
@@ -978,7 +977,6 @@ sub __read_config {
 	    $override = 0;
 
 	    if ($type eq "TEST_START") {
-
 		if ($num_tests_set) {
 		    die "$name: $.: Can not specify both NUM_TESTS and TEST_START\n";
 		}
@@ -1048,7 +1046,6 @@ sub __read_config {
 		$test_num = $old_test_num;
 		$repeat = $old_repeat;
 	    }
-
 	} elsif (/^\s*ELSE\b(.*)$/) {
 	    if (!$if) {
 		die "$name: $.: ELSE found with out matching IF section\n$_";
@@ -1471,7 +1468,6 @@ sub get_test_name() {
 }
 
 sub dodie {
-
     # avoid recursion
     return if ($in_die);
     $in_die = 1;
@@ -1481,10 +1477,8 @@ sub dodie {
     doprint "CRITICAL FAILURE... [TEST $i] ", @_, "\n";
 
     if ($reboot_on_error && !do_not_reboot) {
-
 	doprint "REBOOTING\n";
 	reboot_to_good;
-
     } elsif ($poweroff_on_error && defined($power_off)) {
 	doprint "POWERING OFF\n";
 	`$power_off`;
@@ -1519,8 +1513,9 @@ sub dodie {
 	    close O;
 	    close L;
 	}
+
 	send_email("KTEST: critical failure for test $i [$name]",
-	        "Your test started at $script_start_time has failed with:\n@_\n", $log_file);
+		"Your test started at $script_start_time has failed with:\n@_\n", $log_file);
     }
 
     if ($monitor_cnt) {
@@ -1915,8 +1910,8 @@ sub _get_grub_index {
     my ($command, $target, $skip) = @_;
 
     return if (defined($grub_number) && defined($last_grub_menu) &&
-	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
-	       $last_machine eq $machine);
+	$last_grub_menu eq $grub_menu && defined($last_machine) &&
+	$last_machine eq $machine);
 
     doprint "Find $reboot_type menu ... ";
     $grub_number = -1;
@@ -1924,8 +1919,8 @@ sub _get_grub_index {
     my $ssh_grub = $ssh_exec;
     $ssh_grub =~ s,\$SSH_COMMAND,$command,g;
 
-    open(IN, "$ssh_grub |")
-	or dodie "unable to execute $command";
+    open(IN, "$ssh_grub |") or
+	dodie "unable to execute $command";
 
     my $found = 0;
 
@@ -1979,8 +1974,7 @@ sub get_grub_index {
     _get_grub_index($command, $target, $skip);
 }
 
-sub wait_for_input
-{
+sub wait_for_input {
     my ($fp, $time) = @_;
     my $start_time;
     my $rin;
@@ -2096,7 +2090,6 @@ sub monitor {
     my $version_found = 0;
 
     while (!$done) {
-
 	if ($bug && defined($stop_after_failure) &&
 	    $stop_after_failure >= 0) {
 	    my $time = $stop_after_failure - (time - $failure_start);
@@ -2571,7 +2564,6 @@ sub build {
 	    run_command "mv $outputdir/config_temp $output_config" or
 		dodie "moving config_temp";
 	}
-
     } elsif (!$noclean) {
 	unlink "$output_config";
 	run_command "$make mrproper" or
@@ -2652,11 +2644,12 @@ sub success {
 
     print_times;
 
-    doprint "\n\n*******************************************\n";
-    doprint     "*******************************************\n";
-    doprint     "KTEST RESULT: TEST $i$name SUCCESS!!!!         **\n";
-    doprint     "*******************************************\n";
-    doprint     "*******************************************\n";
+    doprint "\n\n";
+    doprint "*******************************************\n";
+    doprint "*******************************************\n";
+    doprint "KTEST RESULT: TEST $i$name SUCCESS!!!!   **\n";
+    doprint "*******************************************\n";
+    doprint "*******************************************\n";
 
     if (defined($store_successes)) {
 	save_logs "success", $store_successes;
@@ -3034,7 +3027,6 @@ sub bisect {
     }
 
     if ($do_check) {
-
 	# get current HEAD
 	my $head = get_sha1("HEAD");
 
@@ -3074,13 +3066,11 @@ sub bisect {
 	run_command "git bisect replay $replay" or
 	    dodie "failed to run replay";
     } else {
-
 	run_command "git bisect good $good" or
 	    dodie "could not set bisect good to $good";
 
 	run_git_bisect "git bisect bad $bad" or
 	    dodie "could not set bisect bad to $bad";
-
     }
 
     if (defined($start)) {
@@ -3133,8 +3123,8 @@ sub assign_configs {
 
     doprint "Reading configs from $config\n";
 
-    open (IN, $config)
-	or dodie "Failed to read $config";
+    open (IN, $config) or
+	dodie "Failed to read $config";
 
     while (<IN>) {
 	chomp;
@@ -3287,10 +3277,11 @@ sub config_bisect {
 
     if (!defined($config_bisect_exec)) {
 	# First check the location that ktest.pl ran
-	my @locations = ( "$pwd/config-bisect.pl",
-			  "$dirname/config-bisect.pl",
-			  "$builddir/tools/testing/ktest/config-bisect.pl",
-			  undef );
+	my @locations = (
+		"$pwd/config-bisect.pl",
+		"$dirname/config-bisect.pl",
+		"$builddir/tools/testing/ktest/config-bisect.pl",
+		undef );
 	foreach my $loc (@locations) {
 	    doprint "loc = $loc\n";
 	    $config_bisect_exec = $loc;
@@ -3632,8 +3623,8 @@ sub read_kconfig {
 
 sub read_depends {
     # find out which arch this is by the kconfig file
-    open (IN, $output_config)
-	or dodie "Failed to read $output_config";
+    open (IN, $output_config) or
+	dodie "Failed to read $output_config";
     my $arch;
     while (<IN>) {
 	if (m,Linux/(\S+)\s+\S+\s+Kernel Configuration,) {
@@ -3708,7 +3699,6 @@ sub get_depends {
     my @configs;
 
     while ($dep =~ /[$valid]/) {
-
 	if ($dep =~ /^[^$valid]*([$valid]+)/) {
 	    my $conf = "CONFIG_" . $1;
 
@@ -3889,7 +3879,6 @@ sub make_min_config {
     my $take_two = 0;
 
     while (!$done) {
-
 	my $config;
 	my $found;
 
@@ -3900,7 +3889,7 @@ sub make_min_config {
 
 	# Sort keys by who is most dependent on
 	@test_configs = sort  { $depcount{chomp_config($b)} <=> $depcount{chomp_config($a)} }
-			  @test_configs ;
+	    @test_configs ;
 
 	# Put configs that did not modify the config at the end.
 	my $reset = 1;
@@ -3976,8 +3965,8 @@ sub make_min_config {
 
 	    # update new ignore configs
 	    if (defined($ignore_config)) {
-		open (OUT, ">$temp_config")
-		    or dodie "Can't write to $temp_config";
+		open (OUT, ">$temp_config") or
+		    dodie "Can't write to $temp_config";
 		foreach my $config (keys %save_configs) {
 		    print OUT "$save_configs{$config}\n";
 		}
@@ -4004,8 +3993,8 @@ sub make_min_config {
 	    }
 
 	    # Save off all the current mandatory configs
-	    open (OUT, ">$temp_config")
-		or dodie "Can't write to $temp_config";
+	    open (OUT, ">$temp_config") or
+		dodie "Can't write to $temp_config";
 	    foreach my $config (keys %keep_configs) {
 		print OUT "$keep_configs{$config}\n";
 	    }
@@ -4043,7 +4032,6 @@ sub make_warnings_file {
 
     open(IN, $buildlog) or dodie "Can't open $buildlog";
     while (<IN>) {
-
 	# Some compilers use UTF-8 extended for quotes
 	# for distcc heterogeneous systems, this causes issues
 	s/$utf8_quote/'/g;
@@ -4263,7 +4251,6 @@ sub do_send_mail {
 }
 
 sub send_email {
-
     if (defined($mailto)) {
 	if (!defined($mailer)) {
 	    doprint "No email sent: email or mailer not specified in config.\n";
@@ -4277,7 +4264,7 @@ sub cancel_test {
     if ($email_when_canceled) {
 	my $name = get_test_name;
 	send_email("KTEST: Your [$name] test was cancelled",
-	        "Your test started at $script_start_time was cancelled: sig int");
+	    "Your test started at $script_start_time was cancelled: sig int");
     }
     die "\nCaught Sig Int, test interrupted: $!\n"
 }
@@ -4332,7 +4319,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 	if ($email_when_started) {
 	    my $name = get_test_name;
 	    send_email("KTEST: Your [$name] test was started",
-	        "Your test was started on $script_start_time");
+		"Your test was started on $script_start_time");
 	}
     }
 
@@ -4411,7 +4398,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 	my $ret = run_command $pre_test;
 	if (!$ret && defined($pre_test_die) &&
 	    $pre_test_die) {
-	    dodie "failed to pre_test\n";
+		dodie "failed to pre_test\n";
 	}
     }
 
@@ -4509,7 +4496,7 @@ doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
     send_email("KTEST: Your test has finished!",
-	    "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
+	"$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
 }
 
 if (defined($opt{"LOG_FILE"})) {
-- 
2.30.1


