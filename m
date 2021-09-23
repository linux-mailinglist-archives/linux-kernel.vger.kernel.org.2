Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3BB415FE8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbhIWNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241241AbhIWNbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:31:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C65696127A;
        Thu, 23 Sep 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632403814;
        bh=Iw2fDEKzMDejp/o4wtP5bv8wvrqWKI39WK/zq08eWqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFzexhLkHpDu74xDsNDoXkaj31xWvjihNAkUu1gw2Uw7hKzb5V2HOyVtBxHRpzvVd
         Vh3Nm/TZ2ljRDya45Hb4D6/fqED/GcRGWBM+pW4vuMmi5fjtDjhE7QnP9qiuLSO+T2
         aUc3UeR38oxhXi34754LWXB+Ry6pGczhKdy5OGBPKArGettUghcIhAtVYkSamVfMgs
         tHguDb1MrHXXtYwDfBrKFHPFnbhbugCLOSKe9NZVZ7n2BRFesJdMgC4vkvx63lXyZ3
         D3aBxl2gY6ncYFrbCGj4MkELWlkOof5Ih7+GlLNKalvnZSNAxGjMre22bIPvZsYXcp
         /0+wyVZzLGLeQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mTOnl-000neU-2Y; Thu, 23 Sep 2021 15:30:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/13] scripts: get_abi.pl: stop check loop earlier when regex is found
Date:   Thu, 23 Sep 2021 15:30:09 +0200
Message-Id: <333efdaa5ccfce1a0d540c266897947d7853b94f.1632402570.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1632402570.git.mchehab+huawei@kernel.org>
References: <cover.1632402570.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, there are two loops used to seek for a regex. Make
sure that both will be skip when a match is found.

While here, drop the unused $defined variable.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 42eb16eb78e9..d45e5ba56f9c 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -685,7 +685,6 @@ sub check_undefined_symbols {
 		my @names = @{$$file_ref{"__name"}};
 		my $file = $names[0];
 
-		my $defined = 0;
 		my $exact = 0;
 		my $found_string;
 
@@ -711,13 +710,11 @@ sub check_undefined_symbols {
 					last;
 				}
 			}
+			last if ($exact);
 		}
-
-		$defined++;
-
 		next if ($exact);
 
-		if ($hint && $defined && (!$search_string || $found_string)) {
+		if ($hint && (!$search_string || $found_string)) {
 			$what =~ s/\xac/\n\t/g;
 			if ($leave ne "others") {
 				print "    more likely regexes:\n\t$what\n";
-- 
2.31.1

