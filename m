Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15CA37236C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 01:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhECXIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 19:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhECXHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 19:07:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02AEA613BA;
        Mon,  3 May 2021 23:06:59 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1ldheU-009YAh-0N; Mon, 03 May 2021 19:06:58 -0400
Message-ID: <20210503230657.888167368@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 03 May 2021 19:05:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        "John Warthog9 Hawley (VMware)" <warthog9@eaglescrag.net>
Subject: [for-next][PATCH 6/7] ktest: Re-arrange the code blocks for better discoverability
References: <20210503230510.845068955@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "John 'Warthog9' Hawley (VMware)" <warthog9@eaglescrag.net>

Perl, as with most scripting languages, is fairly flexible in how /
where you can define things, and it will (for the most part) do what you
would expect it to do.  This however can lead to situations, like with
ktest, where things get muddled over time.

This pushes the variable definitions back up to the top, followed by
functions, with the main script executables down at the bottom, INSTEAD
of being somewhat mish-mashed together in certain places.  This mostly
has the advantage of making it more obvious where things are initially
defined, what functions are there, and ACTUALLY where the main script
starts executing, and should make this a little more approachable.

Signed-off-by: John 'Warthog9' Hawley (VMware) <warthog9@eaglescrag.net>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 296 ++++++++++++++++++-----------------
 1 file changed, 154 insertions(+), 142 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index a3c6ad64c479..09d1578f9d66 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -512,6 +512,69 @@ $config_help{"REBOOT_SCRIPT"} = << "EOF"
 EOF
     ;
 
+# used with process_expression()
+my $d = 0;
+
+# defined before get_test_name()
+my $in_die = 0;
+
+# defined before process_warning_line()
+my $check_build_re = ".*:.*(warning|error|Error):.*";
+my $utf8_quote = "\\x{e2}\\x{80}(\\x{98}|\\x{99})";
+
+# defined before child_finished()
+my $child_done;
+
+# config_ignore holds the configs that were set (or unset) for
+# a good config and we will ignore these configs for the rest
+# of a config bisect. These configs stay as they were.
+my %config_ignore;
+
+# config_set holds what all configs were set as.
+my %config_set;
+
+# config_off holds the set of configs that the bad config had disabled.
+# We need to record them and set them in the .config when running
+# olddefconfig, because olddefconfig keeps the defaults.
+my %config_off;
+
+# config_off_tmp holds a set of configs to turn off for now
+my @config_off_tmp;
+
+# config_list is the set of configs that are being tested
+my %config_list;
+my %null_config;
+
+my %dependency;
+
+# found above run_config_bisect()
+my $pass = 1;
+
+# found above add_dep()
+
+my %depends;
+my %depcount;
+my $iflevel = 0;
+my @ifdeps;
+
+# prevent recursion
+my %read_kconfigs;
+
+# found above test_this_config()
+my %min_configs;
+my %keep_configs;
+my %save_configs;
+my %processed_configs;
+my %nochange_config;
+
+#
+# These are first defined here, main function later on
+#
+sub run_command;
+sub start_monitor;
+sub end_monitor;
+sub wait_for_monitor;
+
 sub _logit {
     if (defined($opt{"LOG_FILE"})) {
 	print LOG @_;
@@ -1365,11 +1428,6 @@ sub eval_option {
     return $option;
 }
 
-sub run_command;
-sub start_monitor;
-sub end_monitor;
-sub wait_for_monitor;
-
 sub reboot {
     my ($time) = @_;
     my $powercycle = 0;
@@ -1454,8 +1512,6 @@ sub do_not_reboot {
 	($test_type eq "config_bisect" && $opt{"CONFIG_BISECT_TYPE[$i]"} eq "build");
 }
 
-my $in_die = 0;
-
 sub get_test_name() {
     my $name;
 
@@ -2342,9 +2398,6 @@ sub start_monitor_and_install {
     return monitor;
 }
 
-my $check_build_re = ".*:.*(warning|error|Error):.*";
-my $utf8_quote = "\\x{e2}\\x{80}(\\x{98}|\\x{99})";
-
 sub process_warning_line {
     my ($line) = @_;
 
@@ -2694,8 +2747,6 @@ sub child_run_test {
     exit $run_command_status;
 }
 
-my $child_done;
-
 sub child_finished {
     $child_done = 1;
 }
@@ -3096,28 +3147,6 @@ sub bisect {
     success $i;
 }
 
-# config_ignore holds the configs that were set (or unset) for
-# a good config and we will ignore these configs for the rest
-# of a config bisect. These configs stay as they were.
-my %config_ignore;
-
-# config_set holds what all configs were set as.
-my %config_set;
-
-# config_off holds the set of configs that the bad config had disabled.
-# We need to record them and set them in the .config when running
-# olddefconfig, because olddefconfig keeps the defaults.
-my %config_off;
-
-# config_off_tmp holds a set of configs to turn off for now
-my @config_off_tmp;
-
-# config_list is the set of configs that are being tested
-my %config_list;
-my %null_config;
-
-my %dependency;
-
 sub assign_configs {
     my ($hash, $config) = @_;
 
@@ -3212,8 +3241,6 @@ sub config_bisect_end {
     doprint "***************************************\n\n";
 }
 
-my $pass = 1;
-
 sub run_config_bisect {
     my ($good, $bad, $last_result) = @_;
     my $reset = "";
@@ -3505,14 +3532,6 @@ sub patchcheck {
     return 1;
 }
 
-my %depends;
-my %depcount;
-my $iflevel = 0;
-my @ifdeps;
-
-# prevent recursion
-my %read_kconfigs;
-
 sub add_dep {
     # $config depends on $dep
     my ($config, $dep) = @_;
@@ -3713,12 +3732,6 @@ sub get_depends {
     return @configs;
 }
 
-my %min_configs;
-my %keep_configs;
-my %save_configs;
-my %processed_configs;
-my %nochange_config;
-
 sub test_this_config {
     my ($config) = @_;
 
@@ -4047,98 +4060,6 @@ sub make_warnings_file {
     success $i;
 }
 
-$#ARGV < 1 or die "ktest.pl version: $VERSION\n   usage: ktest.pl [config-file]\n";
-
-if ($#ARGV == 0) {
-    $ktest_config = $ARGV[0];
-    if (! -f $ktest_config) {
-	print "$ktest_config does not exist.\n";
-	if (!read_yn "Create it?") {
-	    exit 0;
-	}
-    }
-}
-
-if (! -f $ktest_config) {
-    $newconfig = 1;
-    get_test_case;
-    open(OUT, ">$ktest_config") or die "Can not create $ktest_config";
-    print OUT << "EOF"
-# Generated by ktest.pl
-#
-
-# PWD is a ktest.pl variable that will result in the process working
-# directory that ktest.pl is executed in.
-
-# THIS_DIR is automatically assigned the PWD of the path that generated
-# the config file. It is best to use this variable when assigning other
-# directory paths within this directory. This allows you to easily
-# move the test cases to other locations or to other machines.
-#
-THIS_DIR := $variable{"PWD"}
-
-# Define each test with TEST_START
-# The config options below it will override the defaults
-TEST_START
-TEST_TYPE = $default{"TEST_TYPE"}
-
-DEFAULTS
-EOF
-;
-    close(OUT);
-}
-read_config $ktest_config;
-
-if (defined($opt{"LOG_FILE"})) {
-    $opt{"LOG_FILE"} = eval_option("LOG_FILE", $opt{"LOG_FILE"}, -1);
-}
-
-# Append any configs entered in manually to the config file.
-my @new_configs = keys %entered_configs;
-if ($#new_configs >= 0) {
-    print "\nAppending entered in configs to $ktest_config\n";
-    open(OUT, ">>$ktest_config") or die "Can not append to $ktest_config";
-    foreach my $config (@new_configs) {
-	print OUT "$config = $entered_configs{$config}\n";
-	$opt{$config} = process_variables($entered_configs{$config});
-    }
-}
-
-if (defined($opt{"LOG_FILE"})) {
-    if ($opt{"CLEAR_LOG"}) {
-	unlink $opt{"LOG_FILE"};
-    }
-    open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
-    LOG->autoflush(1);
-}
-
-doprint "\n\nSTARTING AUTOMATED TESTS\n\n";
-
-for (my $i = 0, my $repeat = 1; $i <= $opt{"NUM_TESTS"}; $i += $repeat) {
-
-    if (!$i) {
-	doprint "DEFAULT OPTIONS:\n";
-    } else {
-	doprint "\nTEST $i OPTIONS";
-	if (defined($repeat_tests{$i})) {
-	    $repeat = $repeat_tests{$i};
-	    doprint " ITERATE $repeat";
-	}
-	doprint "\n";
-    }
-
-    foreach my $option (sort keys %opt) {
-
-	if ($option =~ /\[(\d+)\]$/) {
-	    next if ($i != $1);
-	} else {
-	    next if ($i);
-	}
-
-	doprint "$option = $opt{$option}\n";
-    }
-}
-
 sub option_defined {
     my ($option) = @_;
 
@@ -4269,6 +4190,97 @@ sub cancel_test {
     die "\nCaught Sig Int, test interrupted: $!\n"
 }
 
+$#ARGV < 1 or die "ktest.pl version: $VERSION\n   usage: ktest.pl [config-file]\n";
+
+if ($#ARGV == 0) {
+    $ktest_config = $ARGV[0];
+    if (! -f $ktest_config) {
+	print "$ktest_config does not exist.\n";
+	if (!read_yn "Create it?") {
+	    exit 0;
+	}
+    }
+}
+
+if (! -f $ktest_config) {
+    $newconfig = 1;
+    get_test_case;
+    open(OUT, ">$ktest_config") or die "Can not create $ktest_config";
+    print OUT << "EOF"
+# Generated by ktest.pl
+#
+
+# PWD is a ktest.pl variable that will result in the process working
+# directory that ktest.pl is executed in.
+
+# THIS_DIR is automatically assigned the PWD of the path that generated
+# the config file. It is best to use this variable when assigning other
+# directory paths within this directory. This allows you to easily
+# move the test cases to other locations or to other machines.
+#
+THIS_DIR := $variable{"PWD"}
+
+# Define each test with TEST_START
+# The config options below it will override the defaults
+TEST_START
+TEST_TYPE = $default{"TEST_TYPE"}
+
+DEFAULTS
+EOF
+;
+    close(OUT);
+}
+read_config $ktest_config;
+
+if (defined($opt{"LOG_FILE"})) {
+    $opt{"LOG_FILE"} = eval_option("LOG_FILE", $opt{"LOG_FILE"}, -1);
+}
+
+# Append any configs entered in manually to the config file.
+my @new_configs = keys %entered_configs;
+if ($#new_configs >= 0) {
+    print "\nAppending entered in configs to $ktest_config\n";
+    open(OUT, ">>$ktest_config") or die "Can not append to $ktest_config";
+    foreach my $config (@new_configs) {
+	print OUT "$config = $entered_configs{$config}\n";
+	$opt{$config} = process_variables($entered_configs{$config});
+    }
+}
+
+if (defined($opt{"LOG_FILE"})) {
+    if ($opt{"CLEAR_LOG"}) {
+	unlink $opt{"LOG_FILE"};
+    }
+    open(LOG, ">> $opt{LOG_FILE}") or die "Can't write to $opt{LOG_FILE}";
+    LOG->autoflush(1);
+}
+
+doprint "\n\nSTARTING AUTOMATED TESTS\n\n";
+
+for (my $i = 0, my $repeat = 1; $i <= $opt{"NUM_TESTS"}; $i += $repeat) {
+
+    if (!$i) {
+	doprint "DEFAULT OPTIONS:\n";
+    } else {
+	doprint "\nTEST $i OPTIONS";
+	if (defined($repeat_tests{$i})) {
+	    $repeat = $repeat_tests{$i};
+	    doprint " ITERATE $repeat";
+	}
+	doprint "\n";
+    }
+
+    foreach my $option (sort keys %opt) {
+	if ($option =~ /\[(\d+)\]$/) {
+	    next if ($i != $1);
+	} else {
+	    next if ($i);
+	}
+
+	doprint "$option = $opt{$option}\n";
+    }
+}
+
 $SIG{INT} = qw(cancel_test);
 
 # First we need to do is the builds
-- 
2.30.1


