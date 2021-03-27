Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B9A34B702
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 13:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhC0MHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 08:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhC0MHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 08:07:10 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 27 Mar 2021 05:07:10 PDT
Received: from mail.ionic.de (ionic.de [IPv6:2001:41d0:a:588b:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D266C0613B1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Mar 2021 05:07:09 -0700 (PDT)
Authentication-Results: root24.eu; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=ionic.de 
   (client-ip=217.92.117.31; helo=home.ionic.de; 
   envelope-from=ionic@ionic.de; receiver=<UNKNOWN>)
Received: from apgunner.local.home.ionic.de (home.ionic.de [217.92.117.31])
        by mail.ionic.de (Postfix) with ESMTPSA id 617A84F0046D;
        Sat, 27 Mar 2021 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
        t=1616846524; bh=UDJiICivjlIFip4eTmVwvTpv10gRaEyo1mLgK8dTWlg=;
        h=From:To:Cc:Subject:Date:From;
        b=Mog68HLYQ/eTXZ8VpnxG7iiXRv9Dc/67VuQ3EDcHXVCMezWofCxybt0Y5LkNXX/B6
         zqIWylPhRwR7PKH8Q2gxmz//P6qoHF5D5JBwQpTYd2B4E77T5suMueUz2I1AxFI4WC
         cQxyFKUbDCX4/5RALi5ll39WIh8rBLF/5o0OYXSU=
From:   Mihai Moldovan <ionic@ionic.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: nconf: stop endless search-up loops
Date:   Sat, 27 Mar 2021 13:01:55 +0100
Message-Id: <20210327120155.500-1-ionic@ionic.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user selects the very first entry in a page and performs a
search-up operation (e.g., via [/][a][Up Arrow]), nconf will never
terminate searching the page.

The reason is that in this case, the starting point will be set to -1,
which is then translated into (n - 1) (i.e., the last entry of the
page) and finally the search begins. This continues to work fine until
the index reaches 0, at which point it will be decremented to -1, but
not checked against the starting point right away. Instead, it's
wrapped around to the bottom again, after which the starting point
check occurs... and naturally fails.

We can easily avoid it by checking against the starting point directly
if the current index is -1 (which should be safe, since it's the only
magic value that can occur) and terminate the matching function.

Amazingly, nobody seems to have been hit by this for 11 years - or at
the very least nobody bothered to debug and fix this.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
---
 scripts/kconfig/nconf.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index e0f965529166..92a5403d8afa 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -515,6 +515,15 @@ static int get_mext_match(const char *match_str, match_f flag)
 			--index;
 		else
 			++index;
+		/*
+		 * It's fine for index to become negative - think of an
+		 * initial value for match_start of 0 with a match direction
+		 * of up, eventually making it -1.
+		 *
+		 * Handle this as a special case.
+		 */
+		if ((-1 == index) && (index == match_start))
+			return -1;
 		index = (index + items_num) % items_num;
 		if (index == match_start)
 			return -1;
-- 
2.30.1

