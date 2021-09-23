Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C639415FDA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241358AbhIWNcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232158AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ACF106124A;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=NRvFsF+aAKf4uML+UvJ3Rji2lhdemLTe2QssJCX460k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUbZmGXJm8Nkz7p6BoPCXha/yJqP6P1bMs534D2K7NI5SmrxBPk6wch5OTy26k5iN
         OMGB2qz/1Ov83Tpn6tkoWfXz5SUzA4muge1PWd5E6Q+1eD+gdKwG02mdzk2ZQTjzS3
         NBWh5wpIQh1LxTrFXiLiJfyxJDirKtixBqvjE8UbyMugJ0N4kpxLUshZz7O+qh8MUX
         WoLMlaCIopRX8gtlAcL659X5ifXjgo0iWr1OoSfuopAY7wHrckGXYM/EybaoKhMRPt
         3N1GM3VW8UFnnVzGkhxSzo/eedyy1XdETQhoyBPCqPJJNHSTzTkzldjnLNvIYkMKKC
         j2PCCd3zmAB2g==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnk-000ne6-Rd; Thu, 23 Sep 2021 15:30:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] scripts: get_abi.pl: don't skip what that ends with wildcards
Date:   Thu, 23 Sep 2021 15:30:03 +0200
Message-Id: <33fddc5055f9c8ceb1a726b8fd4916eec23ac954.1632402570.git.mchehab+huawei@kernel.org>
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
index 40f10175bb98..8f69acec4ae5 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -590,44 +590,47 @@ sub check_undefined_symbols {
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
@@ -638,7 +641,7 @@ sub check_undefined_symbols {
 		# is not easily parseable.
 		next if ($file =~ m#/parameters/#);
 
-		if ($hint && $defined) {
+		if ($hint && $defined && $leave ne "others") {
 			print "$leave at $path might be one of:$whats\n"  if (!$search_string || $found_string);
 			next;
 		}
@@ -700,7 +703,16 @@ sub undefined_symbols {
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

