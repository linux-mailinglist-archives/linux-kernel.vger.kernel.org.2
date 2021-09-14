Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44CB40B1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhINOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:47:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234687AbhINOrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:47:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3FEA5603E8;
        Tue, 14 Sep 2021 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631630763;
        bh=ejNvSj9uRUsXDwVYudWmYyvoJFx2tE0z1Ceg/xs2cgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LU48xNjgrSytBMFhBnv69SHStUqA49vI63TJFFXqsbi+/KDfLuARn8GdbcUpX0/+h
         SC/LeAnpq9p/K5Xv83Nz+XEqHeougcaFiYWQCfeGhIonHKazG/nNxZ4TPSab+7F8hh
         HhMplKeIc/euGDFpQ4FuWhWTX3YGruZGlNEP14jLvUEpBOdmMcKkxOfHw0zJHRjdIs
         hAKtQ4CFB/VHCSr5dZ/hpeNRLKKQTMBg2XaypfTZC6CArzMdtqwsH4/RgQgZVG/qgu
         uuI0YnoslPsje3ZLy54OHKtzl+e1VRzauGbJaPXJz+z4gupjYpK54BL+aIMe6KjF8B
         1EXyJ9HYrReZg==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mQ9hB-000KzM-Gm; Tue, 14 Sep 2021 16:46:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] scripts: get_abi.pl: don't skip what that ends with wildcards
Date:   Tue, 14 Sep 2021 16:45:58 +0200
Message-Id: <4d625ec358c3fa0dfaf4bfa276b9330407bb8389.1631629987.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631629987.git.mchehab+huawei@kernel.org>
References: <cover.1631629987.git.mchehab+huawei@kernel.org>
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
index 4f31d2e34dd0..e001b6612ac7 100755
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

