Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFF5415FF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbhIWNc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241229AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C88826127B;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=sBGl69LRk9kTMahgKDyY3Ok7EDn1glCgjruLEgCUeZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI2HlsjvsNiHnL0ZF++aoQcQ1EcBE9yWuKrML0o07blPunAKsUXra7IZKsuqdRRsL
         ICtPkbd/pqW9MKyXCyRre/7P3dqA8Web6nMZpEMEf1mNFIwf/CdhAFqXRelvgjMKRV
         bbacsQmETeGJT4aVHArU7ZzC0/dpm3bO7ZwbWndkBV36MpI3hMLKNlnsIpwfQEjFnP
         oGw51O3XqE2DQKn25TK38r2gzXw4+uJWe9FUfitYNDt3gS6PXkh01cEX7BxJiWB1cH
         2am+BkBVVI784fl4+r5bnmHpVarUbHGyHynHks99uYjOVzdx/jFZnKGyZunXb6NE7+
         PfxBYzC1Oca7w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnl-000neY-3l; Thu, 23 Sep 2021 15:30:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] scripts: get_abi.pl: precompile what match regexes
Date:   Thu, 23 Sep 2021 15:30:10 +0200
Message-Id: <ec38468d86e807f1d6681c14c7ad4a731804adcb.1632402570.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632402570.git.mchehab+huawei@kernel.org>
References: <cover.1632402570.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to earn some time during matches, pre-compile regexes.

Before this patch:
	$ time ./scripts/get_abi.pl undefined |wc -l
	6970

	real	0m54,751s
	user	0m54,022s
	sys	0m0,592s

Afterwards:

	$ time ./scripts/get_abi.pl undefined |wc -l
	6970

	real	0m5,888s
	user	0m5,310s
	sys	0m0,562s

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index d45e5ba56f9c..f2b5efef9c30 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -25,6 +25,7 @@ my $search_string;
 my $dbg_what_parsing = 1;
 my $dbg_what_open = 2;
 my $dbg_dump_abi_structs = 4;
+my $dbg_undefined = 8;
 
 #
 # If true, assumes that the description is formatted with ReST
@@ -692,7 +693,8 @@ sub check_undefined_symbols {
 		if (!defined($leaf{$leave})) {
 			$leave = "others";
 		}
-		my $what = $leaf{$leave};
+		my @expr = @{$leaf{$leave}->{expr}};
+		die ("missing rules for $leave") if (!defined($leaf{$leave}));
 
 		my $path = $file;
 		$path =~ s,(.*/).*,$1,;
@@ -702,10 +704,17 @@ sub check_undefined_symbols {
 			$found_string = 1;
 		}
 
-		foreach my $a (@names) {
-			print "--> $a\n" if ($found_string && $hint);
-			foreach my $w (split /\xac/, $what) {
-				if ($a =~ m#^$w$#) {
+		for (my $i = 0; $i < @names; $i++) {
+			if ($found_string && $hint) {
+				if (!$i) {
+					print "--> $names[$i]\n";
+				} else {
+					print "    $names[$i]\n";
+				}
+			}
+			foreach my $re (@expr) {
+				print "$names[$i] =~ /^$re\$/\n" if ($debug && $dbg_undefined);
+				if ($names[$i] =~ $re) {
 					$exact = 1;
 					last;
 				}
@@ -715,6 +724,7 @@ sub check_undefined_symbols {
 		next if ($exact);
 
 		if ($hint && (!$search_string || $found_string)) {
+			my $what = $leaf{$leave}->{what};
 			$what =~ s/\xac/\n\t/g;
 			if ($leave ne "others") {
 				print "    more likely regexes:\n\t$what\n";
@@ -734,7 +744,7 @@ sub undefined_symbols {
 		no_chdir => 1
 	     }, $sysfs_prefix);
 
-	$leaf{"others"} = "";
+	$leaf{"others"}->{what} = "";
 
 	foreach my $w (sort keys %data) {
 		foreach my $what (split /\xac/,$w) {
@@ -792,14 +802,15 @@ sub undefined_symbols {
 			$what =~ s/sqrt(.*)/sqrt\(.*\)/;
 
 			my $leave = get_leave($what);
+
 			my $added = 0;
 			foreach my $l (split /\|/, $leave) {
 				if (defined($leaf{$l})) {
-					next if ($leaf{$l} =~ m/\b$what\b/);
-					$leaf{$l} .= "\xac" . $what;
+					next if ($leaf{$l}->{what} =~ m/\b$what\b/);
+					$leaf{$l}->{what} .= "\xac" . $what;
 					$added = 1;
 				} else {
-					$leaf{$l} = $what;
+					$leaf{$l}->{what} = $what;
 					$added = 1;
 				}
 			}
@@ -809,6 +820,15 @@ sub undefined_symbols {
 
 		}
 	}
+	# Compile regexes
+	foreach my $l (keys %leaf) {
+		my @expr;
+		foreach my $w(split /\xac/, $leaf{$l}->{what}) {
+			push @expr, qr /^$w$/;
+		}
+		$leaf{$l}->{expr} = \@expr;
+	}
+
 	# Take links into account
 	foreach my $link (keys %aliases) {
 		my $abs_file = $aliases{$link};
-- 
2.31.1

