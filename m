Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F374105B3
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244190AbhIRJxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243470AbhIRJxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 865A56127A;
        Sat, 18 Sep 2021 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631958742;
        bh=b4hM6zi20fiL9ExtFZn7NAAY6ZXN4cw11mSm3k3j41Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BsVjxuGoVtW40W5cJrExs4WhR98wP9r3o3Cu8cNGY+8voAOXCBFdO6OpxntDpdXwi
         fzerR1WQXbXIzqGMy4sI61rhUokInmWqg6Lnol4VCDHqFY1mn08viSymGfdJqWf3N2
         LSBjlKoIbrUWTArFpt6FDO8st6uUww0h62H5cidhRPWFr0RqumDn2Sw8s1OmhDzOtA
         P8Kqvugyx7WpuH+EfGpBU6f6j9WecxdyCj6PVjmJvRrXwvFOQDVQlfzjpybaMQZHxS
         94+Rh2+X4XPJneIHg9PO+wGCbuM/SRvwsB1vZJQsZ+YvIAAdt+bHFBaz2IdRU+fgOT
         g4uJT/TUIVXlw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mRX1A-003b12-MQ; Sat, 18 Sep 2021 11:52:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] scripts: get_abi.pl: add an option to filter undefined results
Date:   Sat, 18 Sep 2021 11:52:14 +0200
Message-Id: <7b56c10195bb5e5dfd8b5838a3db8d361231d884.1631957565.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631957565.git.mchehab+huawei@kernel.org>
References: <cover.1631957565.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The output of this script can be too big. Add an option to
filter out results, in order to help finding issues at the
ABI files.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index b0ca4f4e56f2..f5f2f664e336 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -18,6 +18,7 @@ my $enable_lineno = 0;
 my $show_warnings = 1;
 my $prefix="Documentation/ABI";
 my $sysfs_prefix="/sys";
+my $search_string;
 
 #
 # If true, assumes that the description is formatted with ReST
@@ -31,6 +32,7 @@ GetOptions(
 	"dir=s" => \$prefix,
 	'help|?' => \$help,
 	"show-hints" => \$hint,
+	"search-string=s" => \$search_string,
 	man => \$man
 ) or pod2usage(2);
 
@@ -568,16 +570,13 @@ sub parse_existing_sysfs {
 sub check_undefined_symbols {
 	foreach my $file (sort @files) {
 
-		# sysfs-module is special, as its definitions are inside
-		# a text. For now, just ignore them.
-		next if ($file =~ m#^/sys/module/#);
-
 		# Ignore cgroup and firmware
 		next if ($file =~ m#^/sys/(fs/cgroup|firmware)/#);
 
 		my $defined = 0;
 		my $exact = 0;
 		my $whats = "";
+		my $found_string;
 
 		my $leave = $file;
 		$leave =~ s,.*/,,;
@@ -585,6 +584,12 @@ sub check_undefined_symbols {
 		my $path = $file;
 		$path =~ s,(.*/).*,$1,;
 
+		if ($search_string) {
+			next if (!($file =~ m#$search_string#));
+			$found_string = 1;
+		}
+
+		print "--> $file\n" if ($found_string && $hint);
 		if (defined($leaf{$leave})) {
 			my $what = $leaf{$leave};
 			$whats .= " $what" if (!($whats =~ m/$what/));
@@ -610,6 +615,7 @@ sub check_undefined_symbols {
 				if (substr($file, 0, $len) eq $new) {
 					my $newf = $a . substr($file, $len);
 
+					print "    $newf\n" if ($found_string && $hint);
 					foreach my $w (split / /, $what) {
 						if ($newf =~ m#^$w$#) {
 							$exact = 1;
@@ -632,10 +638,10 @@ sub check_undefined_symbols {
 		next if ($file =~ m#/parameters/#);
 
 		if ($hint && $defined) {
-			print "$leave at $path might be one of:$whats\n";
+			print "$leave at $path might be one of:$whats\n"  if (!$search_string || $found_string);
 			next;
 		}
-		print "$file not found.\n";
+		print "$file not found.\n" if (!$search_string || $found_string);
 	}
 }
 
@@ -701,16 +707,29 @@ sub undefined_symbols {
 			$what =~ s/\\([\[\]\(\)\|])/$1/g;
 			$what =~ s/(\d+)\\(-\d+)/$1$2/g;
 
+			$what =~ s/\xff/\\d+/g;
+
+
+			# Special case: IIO ABI which a parenthesis.
+			$what =~ s/sqrt(.*)/sqrt\(.*\)/;
+
 			$leave =~ s/[\(\)]//g;
 
+			my $added = 0;
 			foreach my $l (split /\|/, $leave) {
 				if (defined($leaf{$l})) {
 					next if ($leaf{$l} =~ m/$what/);
 					$leaf{$l} .= " " . $what;
+					$added = 1;
 				} else {
 					$leaf{$l} = $what;
+					$added = 1;
 				}
 			}
+			if ($search_string && $added) {
+				print "What: $what\n" if ($what =~ m#$search_string#);
+			}
+
 		}
 	}
 	check_undefined_symbols;
@@ -764,6 +783,7 @@ abi_book.pl - parse the Linux ABI files and produce a ReST book.
 
 B<abi_book.pl> [--debug] [--enable-lineno] [--man] [--help]
 	       [--(no-)rst-source] [--dir=<dir>] [--show-hints]
+	       [--search-string <regex>]
 	       <COMAND> [<ARGUMENT>]
 
 Where <COMMAND> can be:
@@ -811,6 +831,11 @@ times, to increase verbosity.
 Show hints about possible definitions for the missing ABI symbols.
 Used only when B<undefined>.
 
+=item B<--search-string> [regex string]
+
+Show only occurences that match a search string.
+Used only when B<undefined>.
+
 =item B<--help>
 
 Prints a brief help message and exits.
-- 
2.31.1

