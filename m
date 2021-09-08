Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F90403C05
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351986AbhIHPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349478AbhIHPAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8586B61164;
        Wed,  8 Sep 2021 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631113142;
        bh=+mlARGw01rxTwhUrmA0/0OaEj1ejKNUY2erm21yfPQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pB+GGKzS6cAo9nyLsR9y3tbPy8t+H/vKk+WtoUj8t+Q+pPHi3/V3tu/bZ9IhwC3BJ
         Liwf/jQmWHB8jk5BnR8rfCW3ypijxbsQfu7c3M2+rONUDTsYYpVo1buRCkqF0mk0Gl
         yOiW9I1QEXYUf/84/JaXJeCfyOD6HwovuMjkA4Ad8wWefL2I9jKcQoIVWduARUtxYu
         3OUUCRTYPJ44+qfLFdAhxoKMqPBlUdJkSBRlcLh8dQfyDlGmVHRwbzMaGOOBx9dq8y
         liytvfAZ3UmgTuazpQW//+8PaDRebzXVvr+pGG9L4GilA/nBXhvYRRXRflOjzGbwGO
         cl3GEoIXzvREw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mNz2S-006r3h-Jk; Wed, 08 Sep 2021 16:59:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] scripts: get_abi.pl: detect softlinks
Date:   Wed,  8 Sep 2021 16:58:49 +0200
Message-Id: <a14ae290b67778e633d974f0d515764e212041bc.1631112725.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631112725.git.mchehab+huawei@kernel.org>
References: <cover.1631112725.git.mchehab+huawei@kernel.org>
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
 scripts/get_abi.pl | 177 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 143 insertions(+), 34 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 31b2fdf1f318..7600e50b53bb 100755
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
@@ -539,62 +542,162 @@ sub skip_debugfs {
 }
 
 my %leaf;
+my %aliases;
+my @files;
 
 my $escape_symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x29\x2b-\x2d\x3a-\x40\x7b-\xff]) }x;
 sub parse_existing_sysfs {
 	my $file = $File::Find::name;
+	my $mode = (lstat($file))[2];
+	my $abs_file = abs_path($file);
 
-	my $mode = (stat($file))[2];
-	return if ($mode & S_IFDIR);
+	if (S_ISLNK($mode)) {
+		$aliases{$file} = $abs_file;
+		return;
+	}
 
-	my $leave = $file;
-	$leave =~ s,.*/,,;
+	return if (S_ISDIR($mode));
 
-	if (defined($leaf{$leave})) {
-		# FIXME: need to check if the path makes sense
-		my $what = $leaf{$leave};
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
+}
+
+sub undefined_symbols {
+	find({
+		wanted =>\&parse_existing_sysfs,
+		preprocess =>\&dont_parse_special_attributes,
+		no_chdir => 1
+	     }, $sysfs_prefix);
+
+	foreach my $what (sort keys %data) {
+		next if (!($what =~ m/^$sysfs_prefix/));
+
+		# Convert what into regular expressions
 
 		$what =~ s/,/ /g;
 
+		$what =~ s,/\.\.\./,/.*/,g;
+
+		# Temporarely change [0-9] type of patterns
+		$what =~ s/\[(\d+)\-(\d+)\]/\xf4$1-$2\xf5/g;
+
+		# Handle multiple option patterns
+		$what =~ s/[\{\<\[]([\w_]+)(?:[,|\s]+([\w_]+)){1,}[\}\>\]]/($1|$2)/g;
+
+		# Handle wildcards
 		$what =~ s/\<[^\>]+\>/.*/g;
 		$what =~ s/\{[^\}]+\}/.*/g;
 		$what =~ s/\[[^\]]+\]/.*/g;
-		$what =~ s,/\.\.\./,/.*/,g;
+
+		$what =~ s/[XYZ]/.*/g;
 		$what =~ s,/\*/,/.*/,g;
 
+		# Recover [0-9] type of patterns
+		$what =~ s/\xf4/[/g;
+		$what =~ s/\xf5/]/g;
+
+		# Remove duplicated spaces
 		$what =~ s/\s+/ /g;
 
+		my $leave = $what;
+		$leave =~ s,.*/,,;
+
+		next if ($leave =~ m/^\.\*/ || $leave eq "");
+
 		# Escape all other symbols
 		$what =~ s/$escape_symbols/\\$1/g;
+		$what =~ s/\\([\[\]\(\)\|])/$1/g;
+		$what =~ s/(\d+)\\(-\d+)/$1$2/g;
 
-		foreach my $i (split / /,$what) {
-			if ($file =~ m#^$i$#) {
-#				print "$file: $i: OK!\n";
-				return;
+		$leave =~ s/[\(\)]//g;
+
+		foreach my $l (split /\|/, $leave) {
+			if (defined($leaf{$l})) {
+				$leaf{$l} .= " " . $what;
+			} else {
+				$leaf{$l} = $what;
 			}
 		}
-
-		print "$file: $leave is defined at $what\n";
-
-		return;
-	}
-
-	print "$file not found.\n";
-}
-
-sub undefined_symbols {
-	foreach my $what (sort keys %data) {
-		my $leave = $what;
-		$leave =~ s,.*/,,;
-
-		if (defined($leaf{$leave})) {
-			$leaf{$leave} .= " " . $what;
-		} else {
-			$leaf{$leave} = $what;
-		}
 	}
 
-	find({wanted =>\&parse_existing_sysfs, preprocess =>\&skip_debugfs, no_chdir => 1}, $sysfs_prefix);
+	check_undefined_symbols;
 }
 
 # Ensure that the prefix will always end with a slash
@@ -644,7 +747,8 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 =head1 SYNOPSIS
 
 B<abi_book.pl> [--debug] [--enable-lineno] [--man] [--help]
-	       [--(no-)rst-source] [--dir=<dir>] <COMAND> [<ARGUMENT>]
+	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
+	       <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
 
@@ -686,6 +790,11 @@ Enable output of #define LINENO lines.
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

