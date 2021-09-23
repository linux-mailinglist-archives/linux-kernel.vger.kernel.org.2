Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC41415FE3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbhIWNcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241269AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B824861250;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=g6jMhYZdW8r4BEff5vAQV8Hisuf6YMZysZmKUl1NTe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNuge+CLbkfOOeHOxEi1dalzeoP6Kl8M3NfT8S2ire6Gywb6VxnJvzqSCh7ACwP+4
         iAMRtzfyElpueXB2IUJ2h+7oQSqJx1FHNbUQdxfTB2gH80gLZEvhgTsnNpyqC+hpiB
         16Yzd7dMx2QByxSaDJOv0pwFTRCpq4E3ksB4QnuMK+dUXOmLyNQXXwzuVlwdztFJeg
         Ho7phqflpEskZG8dY1mLuCnR4s3Lha0dTU5BM7eAQI8PPDxWBvqGFeE9t0kNZ1gUfE
         8xf2ylXc4P/rxdwASSXczjYvT1FdebYNbJNpenca5lg3vA48/BVY38m04nQVta1saL
         Tilhqt3lcHdQg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnk-000neE-Tv; Thu, 23 Sep 2021 15:30:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] scripts: get_abi.pl: add a graph to speedup the undefined algorithm
Date:   Thu, 23 Sep 2021 15:30:05 +0200
Message-Id: <d074a28c6cf91f6451ea957a0141601c744d973c.1632402570.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632402570.git.mchehab+huawei@kernel.org>
References: <cover.1632402570.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Searching for symlinks is an expensive operation with the current
logic, as it is at the order of O(n^3). In practice, running the
check spends 2-3 minutes to check all symbols.

Fix it by storing the directory tree into a graph, and using
a Breadth First Search (BFS) to find the links for each sysfs node.

With such improvement, it can now report issues with ~11 seconds
on my machine.

It comes with a price, though: there are more symbols reported
as undefined after this change. I suspect it is due to some
sysfs circular loops that are dropped by BFS. Despite such
increase, it seems that the reports are now more coherent.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 189 ++++++++++++++++++++++++++++++---------------
 1 file changed, 127 insertions(+), 62 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 41a49ae31c25..9eb8a033d363 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -547,6 +547,73 @@ sub dont_parse_special_attributes {
 my %leaf;
 my %aliases;
 my @files;
+my %root;
+
+sub graph_add_file {
+	my $file = shift;
+	my $type = shift;
+
+	my $dir = $file;
+	$dir =~ s,^(.*/).*,$1,;
+	$file =~ s,.*/,,;
+
+	my $name;
+	my $file_ref = \%root;
+	foreach my $edge(split "/", $dir) {
+		$name .= "$edge/";
+		if (!defined ${$file_ref}{$edge}) {
+			${$file_ref}{$edge} = { };
+		}
+		$file_ref = \%{$$file_ref{$edge}};
+		${$file_ref}{"__name"} = [ $name ];
+	}
+	$name .= "$file";
+	${$file_ref}{$file} = {
+		"__name" => [ $name ]
+	};
+
+	return \%{$$file_ref{$file}};
+}
+
+sub graph_add_link {
+	my $file = shift;
+	my $link = shift;
+
+	# Traverse graph to find the reference
+	my $file_ref = \%root;
+	foreach my $edge(split "/", $file) {
+		$file_ref = \%{$$file_ref{$edge}} || die "Missing node!";
+	}
+
+	# do a BFS
+
+	my @queue;
+	my %seen;
+	my $base_name;
+	my $st;
+
+	push @queue, $file_ref;
+	$seen{$start}++;
+
+	while (@queue) {
+		my $v = shift @queue;
+		my @child = keys(%{$v});
+
+		foreach my $c(@child) {
+			next if $seen{$$v{$c}};
+			next if ($c eq "__name");
+
+			# Add new name
+			my $name = @{$$v{$c}{"__name"}}[0];
+			if ($name =~ s#^$file/#$link/#) {
+				push @{$$v{$c}{"__name"}}, $name;
+			}
+			# Add child to the queue and mark as seen
+			push @queue, $$v{$c};
+			$seen{$c}++;
+		}
+	}
+}
 
 my $escape_symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x29\x2b-\x2d\x3a-\x40\x7b-\xfe]) }x;
 sub parse_existing_sysfs {
@@ -569,19 +636,50 @@ sub parse_existing_sysfs {
 	return if (defined($data{$file}));
 	return if (defined($data{$abs_file}));
 
-	push @files, $abs_file;
+	push @files, graph_add_file($abs_file, "file");
+}
+
+sub get_leave($)
+{
+	my $what = shift;
+	my $leave;
+
+	my $l = $what;
+	my $stop = 1;
+
+	$leave = $l;
+	$leave =~ s,/$,,;
+	$leave =~ s,.*/,,;
+	$leave =~ s/[\(\)]//g;
+
+	# $leave is used to improve search performance at
+	# check_undefined_symbols, as the algorithm there can seek
+	# for a small number of "what". It also allows giving a
+	# hint about a leave with the same name somewhere else.
+	# However, there are a few occurences where the leave is
+	# either a wildcard or a number. Just group such cases
+	# altogether.
+	if ($leave =~ m/^\.\*/ || $leave eq "" || $leave =~ /^\d+$/) {
+		$leave = "others";
+	}
+
+	return $leave;
 }
 
 sub check_undefined_symbols {
-	foreach my $file (sort @files) {
+	foreach my $file_ref (sort @files) {
+		my @names = @{$$file_ref{"__name"}};
+		my $file = $names[0];
 
 		my $defined = 0;
 		my $exact = 0;
-		my $whats = "";
 		my $found_string;
 
-		my $leave = $file;
-		$leave =~ s,.*/,,;
+		my $leave = get_leave($file);
+		if (!defined($leaf{$leave})) {
+			$leave = "others";
+		}
+		my $what = $leaf{$leave};
 
 		my $path = $file;
 		$path =~ s,(.*/).*,$1,;
@@ -591,41 +689,12 @@ sub check_undefined_symbols {
 			$found_string = 1;
 		}
 
-		if ($leave =~ /^\d+$/ || !defined($leaf{$leave})) {
-			$leave = "others";
-		}
-
-		print "--> $file\n" if ($found_string && $hint);
-		my $what = $leaf{$leave};
-		$whats .= " $what" if (!($whats =~ m/$what/));
-
-		foreach my $w (split / /, $what) {
-			if ($file =~ m#^$w$#) {
-				$exact = 1;
-				last;
-			}
-		}
-		# Check for aliases
-		#
-		# TODO: this algorithm is O(w * n²). It can be
-		# improved in the future in order to handle it
-		# faster, by changing parse_existing_sysfs to
-		# store the sysfs inside a tree, at the expense
-		# on making the code less readable and/or using some
-		# additional perl library.
-		foreach my $a (keys %aliases) {
-			my $new = $aliases{$a};
-			my $len = length($new);
-
-			if (substr($file, 0, $len) eq $new) {
-				my $newf = $a . substr($file, $len);
-
-				print "    $newf\n" if ($found_string && $hint);
-				foreach my $w (split / /, $what) {
-					if ($newf =~ m#^$w$#) {
-						$exact = 1;
-						last;
-					}
+		foreach my $a (@names) {
+			print "--> $a\n" if ($found_string && $hint);
+			foreach my $w (split /\xac/, $what) {
+				if ($a =~ m#^$w$#) {
+					$exact = 1;
+					last;
 				}
 			}
 		}
@@ -642,8 +711,13 @@ sub check_undefined_symbols {
 		# is not easily parseable.
 		next if ($file =~ m#/parameters/#);
 
-		if ($hint && $defined && $leave ne "others") {
-			print "$leave at $path might be one of:$whats\n"  if (!$search_string || $found_string);
+		if ($hint && $defined && (!$search_string || $found_string)) {
+			$what =~ s/\xac/\n\t/g;
+			if ($leave ne "others") {
+				print "    more likely regexes:\n\t$what\n";
+			} else {
+				print "    tested regexes:\n\t$what\n";
+			}
 			next;
 		}
 		print "$file not found.\n" if (!$search_string || $found_string);
@@ -657,8 +731,10 @@ sub undefined_symbols {
 		no_chdir => 1
 	     }, $sysfs_prefix);
 
+	$leaf{"others"} = "";
+
 	foreach my $w (sort keys %data) {
-		foreach my $what (split /\xac /,$w) {
+		foreach my $what (split /\xac/,$w) {
 			next if (!($what =~ m/^$sysfs_prefix/));
 
 			# Convert what into regular expressions
@@ -701,20 +777,6 @@ sub undefined_symbols {
 			# (this happens on a few IIO definitions)
 			$what =~ s,\s*\=.*$,,;
 
-			my $leave = $what;
-			$leave =~ s,.*/,,;
-
-			# $leave is used to improve search performance at
-			# check_undefined_symbols, as the algorithm there can seek
-			# for a small number of "what". It also allows giving a
-			# hint about a leave with the same name somewhere else.
-			# However, there are a few occurences where the leave is
-			# either a wildcard or a number. Just group such cases
-			# altogether.
-			if ($leave =~ m/^\.\*/ || $leave eq "" || $leave =~ /^\d+$/) {
-				$leave = "others" ;
-			}
-
 			# Escape all other symbols
 			$what =~ s/$escape_symbols/\\$1/g;
 			$what =~ s/\\\\/\\/g;
@@ -723,17 +785,15 @@ sub undefined_symbols {
 
 			$what =~ s/\xff/\\d+/g;
 
-
 			# Special case: IIO ABI which a parenthesis.
 			$what =~ s/sqrt(.*)/sqrt\(.*\)/;
 
-			$leave =~ s/[\(\)]//g;
-
+			my $leave = get_leave($what);
 			my $added = 0;
 			foreach my $l (split /\|/, $leave) {
 				if (defined($leaf{$l})) {
-					next if ($leaf{$l} =~ m/$what/);
-					$leaf{$l} .= " " . $what;
+					next if ($leaf{$l} =~ m/\b$what\b/);
+					$leaf{$l} .= "\xac" . $what;
 					$added = 1;
 				} else {
 					$leaf{$l} = $what;
@@ -746,6 +806,11 @@ sub undefined_symbols {
 
 		}
 	}
+	# Take links into account
+	foreach my $link (keys %aliases) {
+		my $abs_file = $aliases{$link};
+		graph_add_link($abs_file, $link);
+	}
 	check_undefined_symbols;
 }
 
-- 
2.31.1

