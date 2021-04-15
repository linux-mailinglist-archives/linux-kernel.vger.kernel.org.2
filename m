Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240CF36034A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhDOH2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhDOH2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:28:34 -0400
Received: from mail.ionic.de (ionic.de [IPv6:2001:41d0:a:588b:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54180C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:28:11 -0700 (PDT)
Authentication-Results: root24.eu; spf=softfail (domain owner 
   discourages use of this host) smtp.mailfrom=ionic.de 
   (client-ip=217.92.117.31; helo=home.ionic.de; 
   envelope-from=ionic@ionic.de; receiver=<UNKNOWN>)
Received: from apgunner.local.home.ionic.de (home.ionic.de [217.92.117.31])
        by mail.ionic.de (Postfix) with ESMTPSA id 6C5234F017FB;
        Thu, 15 Apr 2021 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ionic.de; s=default;
        t=1618471688; bh=R2uZiJIRuX6FIs5pqSQ5Y3vH/u2XradEjghB/i61lZ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/F7+oAUP4ueZemuKOZmgl9hopNtZw2voKpznSD0p6XEVLx/zVhmZRrlzcHBxn6qC
         sgxjESQgT0pssbh8nso+JsXhmf3ChYT8+hX84xcOlhV+n1/G3NyUKA8uTWiWXch5Bb
         pK0jflP/zjDyAeYEvRsF6AzyABWnBLmVWuTefn9M=
From:   Mihai Moldovan <ionic@ionic.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] kconfig: nconf: stop endless search loops
Date:   Thu, 15 Apr 2021 09:28:03 +0200
Message-Id: <20210415072803.16338-1-ionic@ionic.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210327120155.500-1-ionic@ionic.de>
References: <20210327120155.500-1-ionic@ionic.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the user selects the very first entry in a page and performs a
search-up operation, or selects the very last entry in a page and
performs a search-down operation that will not succeed (e.g., via
[/]asdfzzz[Up Arrow]), nconf will never terminate searching the page.

The reason is that in this case, the starting point will be set to -1
or n, which is then translated into (n - 1) (i.e., the last entry of
the page) or 0 (i.e., the first entry of the page) and finally the
search begins. This continues to work fine until the index reaches 0 or
(n - 1), at which point it will be decremented to -1 or incremented to
n, but not checked against the starting point right away. Instead, it's
wrapped around to the bottom or top again, after which the starting
point check occurs... and naturally fails.

My original implementation added another check for -1 before wrapping
the running index variable around, but Masahiro Yamada pointed out that
the actual issue is that the comparison point (starting point) exceeds
bounds (i.e., the [0,n-1] interval) in the first place and that,
instead, the starting point should be fixed.

This has the welcome side-effect of also fixing the case where the
starting point was n while searching down, which also lead to an
infinite loop.

OTOH, this code is now essentially all his work.

Amazingly, nobody seems to have been hit by this for 11 years - or at
the very least nobody bothered to debug and fix this.

Signed-off-by: Mihai Moldovan <ionic@ionic.de>
---
v2: swap constant in comparison to right side, as requested by
    Randy Dunlap <rdunlap@infradead.org>
v3: reimplement as suggested by Masahiro Yamada <masahiroy@kernel.org>,
    which has the side-effect of also fixing endless looping in the
    symmetric down-direction

 scripts/kconfig/nconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index e0f965529166..af814b39b876 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -504,8 +504,8 @@ static int get_mext_match(const char *match_str, match_f flag)
 	else if (flag == FIND_NEXT_MATCH_UP)
 		--match_start;
 
+	match_start = (match_start + items_num) % items_num;
 	index = match_start;
-	index = (index + items_num) % items_num;
 	while (true) {
 		char *str = k_menu_items[index].str;
 		if (strcasestr(str, match_str) != NULL)
-- 
2.30.1

