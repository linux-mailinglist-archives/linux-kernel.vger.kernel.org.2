Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD741ACBA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240173AbhI1KP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240056AbhI1KPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:15:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6317961131;
        Tue, 28 Sep 2021 10:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632824050;
        bh=jPT23extS7U6noHN1SJAl9hzNfhvGqmZrrjilelIp+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rQehcW3jUepwlgxiKYKPj4K58IMqo/1AtnaQTP+h855aN7RTQEmSPfy3eezbLCl+/
         ldUGQ45A8PqlPoDAeb4CKPfW3kx3P+1LpCVEZqdABPgxTETYWtSJXnNY2usGegM8O+
         U9mSCqHzvpeZ1T4rBGJpLoWK291p6QY2y1a0zCJkPo99d4wtXzCKbVCYyMSJV4MAT1
         qjqKiXuabAOZU/bMVxRaJbzRKZkmc9+4va/yVHM7L1EplF9QMCNTnVPcKIEncldP6s
         x+/zB8sdArGR30+0kvYvsiujcfhuLg/8ic5JOaQ9qGmPOyfWASNmpm026M3NHkxk2f
         50y6Lz0eHeriw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mVA7k-000Thy-Db; Tue, 28 Sep 2021 12:14:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] scripts: get_abi.pl: use STDERR for search-string and show-hints
Date:   Tue, 28 Sep 2021 12:14:02 +0200
Message-Id: <51c6a39c82f73b441030c51bf905a1f382452a67.1632823172.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632823172.git.mchehab+huawei@kernel.org>
References: <cover.1632823172.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On undefined checks, use STDOUT only for the not found entries.

All other data (search-string and show-hints) is printed at
STDERR.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---

To mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH 0/3] at: https://lore.kernel.org/all/cover.1632823172.git.mchehab+huawei@kernel.org/

 scripts/get_abi.pl | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 4978163f5b16..a6c91f822363 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -728,9 +728,9 @@ sub check_undefined_symbols {
 		for (my $i = 0; $i < @names; $i++) {
 			if ($found_string && $hint) {
 				if (!$i) {
-					print "--> $names[$i]\n";
+					print STDERR "--> $names[$i]\n";
 				} else {
-					print "    $names[$i]\n";
+					print STDERR "    $names[$i]\n";
 				}
 			}
 			foreach my $re (@expr) {
@@ -760,17 +760,17 @@ sub check_undefined_symbols {
 		}
 		next if ($exact);
 
+		print "$file not found.\n" if (!$search_string || $found_string);
+
 		if ($hint && (!$search_string || $found_string)) {
 			my $what = $leaf{$leave}->{what};
 			$what =~ s/\xac/\n\t/g;
 			if ($leave ne "others") {
-				print "    more likely regexes:\n\t$what\n";
+				print STDERR "    more likely regexes:\n\t$what\n";
 			} else {
-				print "    tested regexes:\n\t$what\n";
+				print STDERR "    tested regexes:\n\t$what\n";
 			}
-			next;
 		}
-		print "$file not found.\n" if (!$search_string || $found_string);
 	}
 }
 
@@ -852,7 +852,7 @@ sub undefined_symbols {
 				}
 			}
 			if ($search_string && $added) {
-				print "What: $what\n" if ($what =~ m#$search_string#);
+				print STDERR "What: $what\n" if ($what =~ m#$search_string#);
 			}
 
 		}
-- 
2.31.1

