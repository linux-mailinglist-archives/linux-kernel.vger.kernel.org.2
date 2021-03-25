Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621B8348E31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhCYKjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhCYKid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:38:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0C3C61A31;
        Thu, 25 Mar 2021 10:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616668713;
        bh=W1br4FiINJpmQzfAdkQ99FX4HJL1iHQ/nWSUR1z579w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a8o1L8uogdvmmkegsgg7Ody4iUrHHuLScWbsz/vhTxjcbnWaLLD/0CRyC14BQdc28
         XjMR343aNwBGUNXZC2ZeWNWbf6iSOSgx+Z+FRWi1gsnaGfs0beCSO6pLsqgR+baq2y
         kGYOBhWtL4q7M0kxKgS70hdmAnVT4yV/9Wd577YmH0VOZTpd1T4MpK/LYMXIIodB6q
         aV9dEcVpD5ubL7X8fpfVOHNLg3qH1dEh6gFRNxFLxxbCe50fuJ8zZHg5NZeb/yQz5A
         z3Xt6C966wNPwKCPU1OZ4MEANqAt/arUTeYiyqGtnWKAq2iO5pLMkZhSx6n/JogNHI
         0y3bUeDup7a1Q==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1lPNNl-001AvW-7o; Thu, 25 Mar 2021 11:38:29 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] get_abi.pl: fix xref boundaries
Date:   Thu, 25 Mar 2021 11:38:24 +0100
Message-Id: <79a14d2518499b76931b5f29c50979987108152d.1616668017.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616668017.git.mchehab+huawei@kernel.org>
References: <cover.1616668017.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some issues with the regex that seeks for What:
cross references: basically, it is mis-identifying the start
and the end boundaries of the regex, which causes :ref: to
be inseerted for the wrong symbols at the wrong places.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 3c82cd188368..e87028257d1c 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -281,8 +281,11 @@ sub create_labels {
 # Outputs the book on ReST format
 #
 
-# \b doesn't work well with paths. So, we need to define something else
-my $bondary = qr { (?<![\w\/\`\{])(?=[\w\/\`\{])|(?<=[\w\/\`\{])(?![\w\/\`\{]) }x;
+# \b doesn't work well with paths. So, we need to define something else:
+# Boundaries are punct characters, spaces and end-of-line
+my $start = qr {(^|\s|\() }x;
+my $bondary = qr { ([,.:;\)\s]|\z) }x;
+my $xref_match = qr { $start(\/sys\/[^,.:;\)\s]+)$bondary }x;
 my $symbols = qr { ([\x01-\x08\x0e-\x1f\x21-\x2f\x3a-\x40\x7b-\xff]) }x;
 
 sub output_rest {
@@ -390,16 +393,18 @@ sub output_rest {
 					$desc =~ s,\bDocumentation/ABI/$f\b,:ref:`$xref`,g;
 				}
 
-				@matches = $desc =~ m,$bondary(/sys/[^\s\.\,\;\:\*\s\`\'\(\)]+)$bondary,;
+				# Seek for cross reference symbols like /sys/...
+				@matches = $desc =~ m/$xref_match/g;
 
 				foreach my $s (@matches) {
+					next if (!($s =~ m,/,));
 					if (defined($data{$s}) && defined($data{$s}->{label})) {
 						my $xref = $s;
 
 						$xref =~ s/$symbols/\\$1/g;
 						$xref = ":ref:`$xref <" . $data{$s}->{label} . ">`";
 
-						$desc =~ s,$bondary$s$bondary,$xref,g;
+						$desc =~ s,$start$s$bondary,$1$xref$2,g;
 					}
 				}
 
-- 
2.30.2

