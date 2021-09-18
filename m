Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC264105B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244470AbhIRJyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243710AbhIRJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:53:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E78461283;
        Sat, 18 Sep 2021 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631958742;
        bh=yR15p2TgWTxBiHKVm9ig5QEeA3S2VfkFPJa8dYUMMiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kgvQG6ai+2DNJ9BmZGI4cbXa8Js2LWL4tqsnEH6Zut8sexTaAiaxeVFLQbsz4mBOZ
         iHtChups52WOqqI4an1dKAq1IcIbHbzul1BB9VWivBuLv2+KeNiwaPqwFs3133EC3l
         h2mNX3jrYLJ5k0CdEqlO/ApSqRvP6Om/F+ygNmeuukgs7rHPBWXgB673lv+KRWd9LR
         KUfhg3IBofz1HnuxFsXJ4g+wJTdn+Gq9FEZYgmuRwvxAxK2gO6b2Z1+tGkO+urswKq
         qYKryqpDz5tEV5XlwcOg6L9vDo+kJ4FlrX1g2Pv3uTEj+sbodwa88NRR7qlNM8PY9a
         nb1xaH/3x3OnA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mRX1A-003b16-Nb; Sat, 18 Sep 2021 11:52:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] scripts: get_abi.pl: don't skip what that ends with wildcards
Date:   Sat, 18 Sep 2021 11:52:15 +0200
Message-Id: <79ba5139643355230e3bba136b20991cfc92020f.1631957565.git.mchehab+huawei@kernel.org>
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

The search algorithm used inside check_undefined_symbols
has an optimization: it seeks only whats that have the same
leave name. This helps not only to speedup the search, but
it also allows providing a hint about a partial match.

There's a drawback, however: when "what:" finishes with a
wildcard, the logic will skip the what, reporting it as
"not found".

Fix it by grouping the remaining cases altogether, and
disabing any hints for such cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 74 +++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index f5f2f664e336..fe83f295600c 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -589,44 +589,47 @@ sub check_undefined_symbols {
 			$found_string = 1;
 		}
 
+		if ($leave =~ /^\d+$/ || !defined($leaf{$leave})) {
+			$leave = "others";
+		}
+
 		print "--> $file\n" if ($found_string && $hint);
-		if (defined($leaf{$leave})) {
-			my $what = $leaf{$leave};
-			$whats .= " $what" if (!($whats =~ m/$what/));
+		my $what = $leaf{$leave};
+		$whats .= " $what" if (!($whats =~ m/$what/));
 
-			foreach my $w (split / /, $what) {
-				if ($file =~ m#^$w$#) {
-					$exact = 1;
-					last;
-				}
+		foreach my $w (split / /, $what) {
+			if ($file =~ m#^$w$#) {
+				$exact = 1;
+				last;
 			}
-			# Check for aliases
-			#
-			# TODO: this algorithm is O(w * n²). It can be
-			# improved in the future in order to handle it
-			# faster, by changing parse_existing_sysfs to
-			# store the sysfs inside a tree, at the expense
-			# on making the code less readable and/or using some
-			# additional perl library.
-			foreach my $a (keys %aliases) {
-				my $new = $aliases{$a};
-				my $len = length($new);
+		}
+		# Check for aliases
+		#
+		# TODO: this algorithm is O(w * n²). It can be
+		# improved in the future in order to handle it
+		# faster, by changing parse_existing_sysfs to
+		# store the sysfs inside a tree, at the expense
+		# on making the code less readable and/or using some
+		# additional perl library.
+		foreach my $a (keys %aliases) {
+			my $new = $aliases{$a};
+			my $len = length($new);
 
-				if (substr($file, 0, $len) eq $new) {
-					my $newf = $a . substr($file, $len);
+			if (substr($file, 0, $len) eq $new) {
+				my $newf = $a . substr($file, $len);
 
-					print "    $newf\n" if ($found_string && $hint);
-					foreach my $w (split / /, $what) {
-						if ($newf =~ m#^$w$#) {
-							$exact = 1;
-							last;
-						}
+				print "    $newf\n" if ($found_string && $hint);
+				foreach my $w (split / /, $what) {
+					if ($newf =~ m#^$w$#) {
+						$exact = 1;
+						last;
 					}
 				}
 			}
-
-			$defined++;
 		}
+
+		$defined++;
+
 		next if ($exact);
 
 		# Ignore some sysfs nodes
@@ -637,7 +640,7 @@ sub check_undefined_symbols {
 		# is not easily parseable.
 		next if ($file =~ m#/parameters/#);
 
-		if ($hint && $defined) {
+		if ($hint && $defined && $leave ne "others") {
 			print "$leave at $path might be one of:$whats\n"  if (!$search_string || $found_string);
 			next;
 		}
@@ -699,7 +702,16 @@ sub undefined_symbols {
 			my $leave = $what;
 			$leave =~ s,.*/,,;
 
-			next if ($leave =~ m/^\.\*/ || $leave eq "");
+			# $leave is used to improve search performance at
+			# check_undefined_symbols, as the algorithm there can seek
+			# for a small number of "what". It also allows giving a
+			# hint about a leave with the same name somewhere else.
+			# However, there are a few occurences where the leave is
+			# either a wildcard or a number. Just group such cases
+			# altogether.
+			if ($leave =~ m/^\.\*/ || $leave eq "" || $leave =~ /^\d+$/) {
+				$leave = "others" ;
+			}
 
 			# Escape all other symbols
 			$what =~ s/$escape_symbols/\\$1/g;
-- 
2.31.1

