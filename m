Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3EE41ACB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhI1KPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:15:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240055AbhI1KPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6522861157;
        Tue, 28 Sep 2021 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632824050;
        bh=El3DLDbmJPhb2L3ESpYvmqf7mQvL2dzD7LJPa5jKNW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iRigGRFppwOCvspYwoh0pMWtmNMKPyNJbPfMwdYsDIMChuh8qR9Tz60OfdOJGENUu
         kj49twzYKfAbXNlSfK5a/6Qv8AmAJHqeDtvxpLtYPJ51KAihQI9BcM4O5hL4s3JDpv
         Mqub18Jh8ZBvns7LFC07ti0c/kiAVNqzagzJmqsLB7m+J6tdB358bp4o6fnb2T/wia
         o4kRFAGhE290qwIu5smrdvN7v5kk9ExADxqU59rwn31IIIsse6ZkaKbSYRJ/Nw5X0j
         wp1InQnNUtehT73BDmsCxgxgm2ZOmj9ANR8oeiCJaNbN4PqYNMXUURofpTkansqpKQ
         gbP9EwH32FXqQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVA7k-000Ti2-Ey; Tue, 28 Sep 2021 12:14:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] scripts: get_abi.pl: show progress
Date:   Tue, 28 Sep 2021 12:14:03 +0200
Message-Id: <4e581dcbec21ad8a60fff883498018f96f13dd1c.1632823172.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632823172.git.mchehab+huawei@kernel.org>
References: <cover.1632823172.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As parsing the sysfs entries can take a long time, add
progress information.

The progress logic will update the stats on every second,
or on 1% steps of the progress.

When STDERR is a console, it will use a single line, using
a VT-100 command to erase the line before rewriting it.
Otherwise, it will put one message on a separate line.
That would help to identify what parts of sysfs checking
that it is taking more time to process.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1632823172.git.mchehab+huawei@kernel.org/

 scripts/get_abi.pl | 163 ++++++++++++++++++++++++++++++---------------
 1 file changed, 108 insertions(+), 55 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index a6c91f822363..841d889747c0 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -9,6 +9,7 @@ use utf8;
 use Pod::Usage qw(pod2usage);
 use Getopt::Long;
 use File::Find;
+use IO::Handle;
 use Fcntl ':mode';
 use Cwd 'abs_path';
 use Data::Dumper;
@@ -702,87 +703,137 @@ sub get_leave($)
 	return $leave;
 }
 
-sub check_undefined_symbols {
-	foreach my $file_ref (sort @files) {
-		my @names = @{$$file_ref{"__name"}};
-		my $file = $names[0];
+my @not_found;
 
-		my $exact = 0;
-		my $found_string;
+sub check_file($$)
+{
+	my $file_ref = shift;
+	my $names_ref = shift;
+	my @names = @{$names_ref};
+	my $file = $names[0];
 
-		my $leave = get_leave($file);
-		if (!defined($leaf{$leave})) {
-			$leave = "others";
+	my $found_string;
+
+	my $leave = get_leave($file);
+	if (!defined($leaf{$leave})) {
+		$leave = "others";
+	}
+	my @expr = @{$leaf{$leave}->{expr}};
+	die ("\rmissing rules for $leave") if (!defined($leaf{$leave}));
+
+	my $path = $file;
+	$path =~ s,(.*/).*,$1,;
+
+	if ($search_string) {
+		return if (!($file =~ m#$search_string#));
+		$found_string = 1;
+	}
+
+	for (my $i = 0; $i < @names; $i++) {
+		if ($found_string && $hint) {
+			if (!$i) {
+				print STDERR "--> $names[$i]\n";
+			} else {
+				print STDERR "    $names[$i]\n";
+			}
+		}
+		foreach my $re (@expr) {
+			print STDERR "$names[$i] =~ /^$re\$/\n" if ($debug && $dbg_undefined);
+			if ($names[$i] =~ $re) {
+				return;
+			}
 		}
+	}
+
+	if ($leave ne "others") {
 		my @expr = @{$leaf{$leave}->{expr}};
-		die ("missing rules for $leave") if (!defined($leaf{$leave}));
-
-		my $path = $file;
-		$path =~ s,(.*/).*,$1,;
-
-		if ($search_string) {
-			next if (!($file =~ m#$search_string#));
-			$found_string = 1;
-		}
-
 		for (my $i = 0; $i < @names; $i++) {
-			if ($found_string && $hint) {
-				if (!$i) {
-					print STDERR "--> $names[$i]\n";
-				} else {
-					print STDERR "    $names[$i]\n";
-				}
-			}
 			foreach my $re (@expr) {
-				print "$names[$i] =~ /^$re\$/\n" if ($debug && $dbg_undefined);
+				print STDERR "$names[$i] =~ /^$re\$/\n" if ($debug && $dbg_undefined);
 				if ($names[$i] =~ $re) {
-					$exact = 1;
-					last;
+					return;
 				}
 			}
-			last if ($exact);
 		}
-		next if ($exact);
+	}
 
+	push @not_found, $file if (!$search_string || $found_string);
+
+	if ($hint && (!$search_string || $found_string)) {
+		my $what = $leaf{$leave}->{what};
+		$what =~ s/\xac/\n\t/g;
 		if ($leave ne "others") {
-			my @expr = @{$leaf{$leave}->{expr}};
-			for (my $i = 0; $i < @names; $i++) {
-				foreach my $re (@expr) {
-					print "$names[$i] =~ /^$re\$/\n" if ($debug && $dbg_undefined);
-					if ($names[$i] =~ $re) {
-						$exact = 1;
-						last;
-					}
-				}
-				last if ($exact);
-			}
-			last if ($exact);
+			print STDERR "\r    more likely regexes:\n\t$what\n";
+		} else {
+			print STDERR "\r    tested regexes:\n\t$what\n";
 		}
-		next if ($exact);
-
-		print "$file not found.\n" if (!$search_string || $found_string);
-
-		if ($hint && (!$search_string || $found_string)) {
-			my $what = $leaf{$leave}->{what};
-			$what =~ s/\xac/\n\t/g;
-			if ($leave ne "others") {
-				print STDERR "    more likely regexes:\n\t$what\n";
-			} else {
-				print STDERR "    tested regexes:\n\t$what\n";
-			}
+	}
+}
+
+sub check_undefined_symbols {
+	my $num_files = scalar @files;
+	my $next_i = 0;
+	my $start_time = times;
+
+	my $last_time = $start_time;
+
+	# When either debug or hint is enabled, there's no sense showing
+	# progress, as the progress will be overriden.
+	if ($hint || ($debug && $dbg_undefined)) {
+		$next_i = $num_files;
+	}
+
+	my $is_console;
+	$is_console = 1 if (-t STDERR);
+
+	for (my $i = 0; $i < $num_files; $i++) {
+		my $file_ref = $files[$i];
+		my @names = @{$$file_ref{"__name"}};
+
+		check_file($file_ref, \@names);
+
+		my $cur_time = times;
+
+		if ($i == $next_i || $cur_time > $last_time + 1) {
+			my $percent = $i * 100 / $num_files;
+
+			my $tm = $cur_time - $start_time;
+			my $time = sprintf "%d:%02d", int($tm), 60 * ($tm - int($tm));
+
+			printf STDERR "\33[2K\r", if ($is_console);
+			printf STDERR "%s: processing sysfs files... %i%%: $names[0]", $time, $percent;
+			printf STDERR "\n", if (!$is_console);
+			STDERR->flush();
+
+			$next_i = int (($percent + 1) * $num_files / 100);
+			$last_time = $cur_time;
 		}
 	}
+
+	my $cur_time = times;
+	my $tm = $cur_time - $start_time;
+	my $time = sprintf "%d:%02d", int($tm), 60 * ($tm - int($tm));
+
+	printf STDERR "\33[2K\r", if ($is_console);
+	printf STDERR "%s: processing sysfs files... done\n", $time;
+
+	foreach my $file (@not_found) {
+		print "$file not found.\n";
+	}
 }
 
 sub undefined_symbols {
+	print STDERR "Reading $sysfs_prefix directory contents...";
 	find({
 		wanted =>\&parse_existing_sysfs,
 		preprocess =>\&dont_parse_special_attributes,
 		no_chdir => 1
 	     }, $sysfs_prefix);
+	print STDERR "done.\n";
 
 	$leaf{"others"}->{what} = "";
 
+	print STDERR "Converting ABI What fields into regexes...";
 	foreach my $w (sort keys %data) {
 		foreach my $what (split /\xac/,$w) {
 			next if (!($what =~ m/^$sysfs_prefix/));
@@ -871,6 +922,8 @@ sub undefined_symbols {
 		my $abs_file = $aliases{$link};
 		graph_add_link($abs_file, $link);
 	}
+	print STDERR "done.\n";
+
 	check_undefined_symbols;
 }
 
-- 
2.31.1

