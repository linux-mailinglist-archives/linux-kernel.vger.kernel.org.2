Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FE74105BC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbhIRJyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243766AbhIRJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:53:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83C226126A;
        Sat, 18 Sep 2021 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631958742;
        bh=ZzbcajCc/vY/EAA1aXzS0mSoQf6nMjJxhjPNNoN0I3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0+6sYbQqN/AH4gq38qXZsELsEnUR1dOmmdtSutb22swZmL70uRA77BeTROC0gcuz
         1QkrFmNZL1Y4fBq1qKC7EclbPV5FrS1+UgITbsVtKSh7GvFG3+E80c5GFrLgSymM1m
         K5bNUCukR8dRB6QZEebhCV5Slikh8urfQMLx9MPzVWze/wEBI7mKoVc+Sn8m2VQTT7
         I0BDaccLegsifEBQhfKG0SptoN202qEAujxIhXhi+aa5HxSVT8I3S8KKVCh/KWAkzE
         I9JfRvbL8yDkwUK+kOWfKRo0GFHr3UVMc+yGXmpQvsBLASw2A54Teb7MbfM43NDntT
         GpdqBKd+OE6yg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mRX1A-003b0y-L2; Sat, 18 Sep 2021 11:52:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] scripts: get_abi.pl: detect softlinks
Date:   Sat, 18 Sep 2021 11:52:13 +0200
Message-Id: <77c49f7d158d88e17f18d40652b75cdde9e179eb.1631957565.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631957565.git.mchehab+huawei@kernel.org>
References: <cover.1631957565.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The way sysfs works is that the same leave may be present under
/sys/devices, /sys/bus and /sys/class, etc, linked via soft
symlinks.

To make it harder to parse, the ABI definition usually refers
only to one of those locations.

So, improve the logic in order to retrieve the symlinks.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 207 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 165 insertions(+), 42 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 78364c4c4967..b0ca4f4e56f2 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -8,8 +8,10 @@ use Pod::Usage;
 use Getopt::Long;
 use File::Find;
 use Fcntl ':mode';
+use Cwd 'abs_path';
 
 my $help = 0;
+my $hint = 0;
 my $man = 0;
 my $debug = 0;
 my $enable_lineno = 0;
@@ -28,6 +30,7 @@ GetOptions(
 	"rst-source!" => \$description_is_rst,
 	"dir=s" => \$prefix,
 	'help|?' => \$help,
+	"show-hints" => \$hint,
 	man => \$man
 ) or pod2usage(2);
 
@@ -526,7 +529,7 @@ sub search_symbols {
 }
 
 # Exclude /sys/kernel/debug and /sys/kernel/tracing from the search path
-sub skip_debugfs {
+sub dont_parse_special_attributes {
 	if (($File::Find::dir =~ m,^/sys/kernel,)) {
 		return grep {!/(debug|tracing)/ } @_;
 	}
@@ -539,64 +542,178 @@ sub skip_debugfs {
 }
 
 my %leaf;
+my %aliases;
+my @files;
 
-my $escape_symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x29\x2b-\x2d\x3a-\x40\x7b-\xff]) }x;
+my $escape_symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x29\x2b-\x2d\x3a-\x40\x7b-\xfe]) }x;
 sub parse_existing_sysfs {
 	my $file = $File::Find::name;
+	my $mode = (lstat($file))[2];
+	my $abs_file = abs_path($file);
 
-	my $mode = (stat($file))[2];
-	return if ($mode & S_IFDIR);
-
-	my $leave = $file;
-	$leave =~ s,.*/,,;
-
-	if (defined($leaf{$leave})) {
-		# FIXME: need to check if the path makes sense
-		my $what = $leaf{$leave};
-
-		$what =~ s/,/ /g;
-
-		$what =~ s/\<[^\>]+\>/.*/g;
-		$what =~ s/\{[^\}]+\}/.*/g;
-		$what =~ s/\[[^\]]+\]/.*/g;
-		$what =~ s,/\.\.\./,/.*/,g;
-		$what =~ s,/\*/,/.*/,g;
-
-		$what =~ s/\s+/ /g;
-
-		# Escape all other symbols
-		$what =~ s/$escape_symbols/\\$1/g;
-
-		foreach my $i (split / /,$what) {
-			if ($file =~ m#^$i$#) {
-#				print "$file: $i: OK!\n";
-				return;
-			}
-		}
-
-		print "$file: $leave is defined at $what\n";
-
+	if (S_ISLNK($mode)) {
+		$aliases{$file} = $abs_file;
 		return;
 	}
 
-	print "$file not found.\n";
+	return if (S_ISDIR($mode));
+
+	# Trivial: file is defined exactly the same way at ABI What:
+	return if (defined($data{$file}));
+	return if (defined($data{$abs_file}));
+
+	push @files, $abs_file;
+}
+
+sub check_undefined_symbols {
+	foreach my $file (sort @files) {
+
+		# sysfs-module is special, as its definitions are inside
+		# a text. For now, just ignore them.
+		next if ($file =~ m#^/sys/module/#);
+
+		# Ignore cgroup and firmware
+		next if ($file =~ m#^/sys/(fs/cgroup|firmware)/#);
+
+		my $defined = 0;
+		my $exact = 0;
+		my $whats = "";
+
+		my $leave = $file;
+		$leave =~ s,.*/,,;
+
+		my $path = $file;
+		$path =~ s,(.*/).*,$1,;
+
+		if (defined($leaf{$leave})) {
+			my $what = $leaf{$leave};
+			$whats .= " $what" if (!($whats =~ m/$what/));
+
+			foreach my $w (split / /, $what) {
+				if ($file =~ m#^$w$#) {
+					$exact = 1;
+					last;
+				}
+			}
+			# Check for aliases
+			#
+			# TODO: this algorithm is O(w * n²). It can be
+			# improved in the future in order to handle it
+			# faster, by changing parse_existing_sysfs to
+			# store the sysfs inside a tree, at the expense
+			# on making the code less readable and/or using some
+			# additional perl library.
+			foreach my $a (keys %aliases) {
+				my $new = $aliases{$a};
+				my $len = length($new);
+
+				if (substr($file, 0, $len) eq $new) {
+					my $newf = $a . substr($file, $len);
+
+					foreach my $w (split / /, $what) {
+						if ($newf =~ m#^$w$#) {
+							$exact = 1;
+							last;
+						}
+					}
+				}
+			}
+
+			$defined++;
+		}
+		next if ($exact);
+
+		# Ignore some sysfs nodes
+		next if ($file =~ m#/(sections|notes)/#);
+
+		# Would need to check at
+		# Documentation/admin-guide/kernel-parameters.txt, but this
+		# is not easily parseable.
+		next if ($file =~ m#/parameters/#);
+
+		if ($hint && $defined) {
+			print "$leave at $path might be one of:$whats\n";
+			next;
+		}
+		print "$file not found.\n";
+	}
 }
 
 sub undefined_symbols {
+	find({
+		wanted =>\&parse_existing_sysfs,
+		preprocess =>\&dont_parse_special_attributes,
+		no_chdir => 1
+	     }, $sysfs_prefix);
+
 	foreach my $w (sort keys %data) {
 		foreach my $what (split /\xac /,$w) {
+			next if (!($what =~ m/^$sysfs_prefix/));
+
+			# Convert what into regular expressions
+
+			$what =~ s,/\.\.\./,/*/,g;
+			$what =~ s,\*,.*,g;
+
+			# Temporarily change [0-9]+ type of patterns
+			$what =~ s/\[0\-9\]\+/\xff/g;
+
+			# Temporarily change [\d+-\d+] type of patterns
+			$what =~ s/\[0\-\d+\]/\xff/g;
+			$what =~ s/\[(\d+)\]/\xf4$1\xf5/g;
+
+			# Temporarily change [0-9] type of patterns
+			$what =~ s/\[(\d)\-(\d)\]/\xf4$1-$2\xf5/g;
+
+			# Handle multiple option patterns
+			$what =~ s/[\{\<\[]([\w_]+)(?:[,|]+([\w_]+)){1,}[\}\>\]]/($1|$2)/g;
+
+			# Handle wildcards
+			$what =~ s/\<[^\>]+\>/.*/g;
+			$what =~ s/\{[^\}]+\}/.*/g;
+			$what =~ s/\[[^\]]+\]/.*/g;
+
+			$what =~ s/[XYZ]/.*/g;
+
+			# Recover [0-9] type of patterns
+			$what =~ s/\xf4/[/g;
+			$what =~ s/\xf5/]/g;
+
+			# Remove duplicated spaces
+			$what =~ s/\s+/ /g;
+
+			# Special case: this ABI has a parenthesis on it
+			$what =~ s/sqrt\(x^2\+y^2\+z^2\)/sqrt\(x^2\+y^2\+z^2\)/;
+
+			# Special case: drop comparition as in:
+			#	What: foo = <something>
+			# (this happens on a few IIO definitions)
+			$what =~ s,\s*\=.*$,,;
+
 			my $leave = $what;
 			$leave =~ s,.*/,,;
 
-			if (defined($leaf{$leave})) {
-				$leaf{$leave} .= " " . $what;
-			} else {
-				$leaf{$leave} = $what;
+			next if ($leave =~ m/^\.\*/ || $leave eq "");
+
+			# Escape all other symbols
+			$what =~ s/$escape_symbols/\\$1/g;
+			$what =~ s/\\\\/\\/g;
+			$what =~ s/\\([\[\]\(\)\|])/$1/g;
+			$what =~ s/(\d+)\\(-\d+)/$1$2/g;
+
+			$leave =~ s/[\(\)]//g;
+
+			foreach my $l (split /\|/, $leave) {
+				if (defined($leaf{$l})) {
+					next if ($leaf{$l} =~ m/$what/);
+					$leaf{$l} .= " " . $what;
+				} else {
+					$leaf{$l} = $what;
+				}
 			}
 		}
 	}
-
-	find({wanted =>\&parse_existing_sysfs, preprocess =>\&skip_debugfs, no_chdir => 1}, $sysfs_prefix);
+	check_undefined_symbols;
 }
 
 # Ensure that the prefix will always end with a slash
@@ -646,7 +763,8 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 =head1 SYNOPSIS
 
 B<abi_book.pl> [--debug] [--enable-lineno] [--man] [--help]
-	       [--(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
+	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
+	       <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -688,6 +806,11 @@ Enable output of #define LINENO lines.
 Put the script in verbose mode, useful for debugging. Can be called multiple
 times, to increase verbosity.
 
+=item B<--show-hints>
+
+Show hints about possible definitions for the missing ABI symbols.
+Used only when B<undefined>.
+
 =item B<--help>
 
 Prints a brief help message and exits.
-- 
2.31.1

