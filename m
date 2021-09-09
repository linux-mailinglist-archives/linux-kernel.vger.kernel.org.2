Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9B40425A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348765AbhIIAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbhIIAnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:43:00 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F695C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 17:41:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1631148106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=94smKPWchJmt0EJiRX/rpG0azVUWj24jfiMTAEmZ7PA=;
        b=qqgHCMtmuJKnvaVyMJolFE5kNnZdm/KHwvgvyk7UC/yqCMiZiq8amUqfSwj5nZ2SUccpXr
        F/rEQTqeGyuZWX78WQG+kbjbdzXr7FNA6tWKEvitRW9uZwTRusmv/NszQXcTs5zAty2wox
        Lf49g9HZKDU1Xb/8tLZYVb4dt5hMosU=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm, hwpoison: add is_free_buddy_page() in HWPoisonHandlable()
Date:   Thu,  9 Sep 2021 09:41:31 +0900
Message-Id: <20210909004131.163221-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: naoya.horiguchi@linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

commit fcc00621d88b ("mm/hwpoison: retry with shake_page() for
unhandlable pages") changes the return value of __get_hwpoison_page() to
retry for transiently unhandlable cases.  However, __get_hwpoison_page()
currently fails to properly judge buddy pages as handlable, so hard/soft
offline for buddy pages always fail as "unhandlable page".  This is
totally regrettable.

So let's add is_free_buddy_page() in HWPoisonHandlable(), so that
__get_hwpoison_page() returns different return values between buddy
pages and unhandlable pages as intended.

Fixes: fcc00621d88b ("mm/hwpoison: retry with shake_page() for unhandlable pages")
Cc: <stable@vger.kernel.org>
Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git v5.14-rc7-mmotm-2021-08-23-16-42/mm/memory-failure.c v5.14-rc7-mmotm-2021-08-23-16-42_patched/mm/memory-failure.c
index 60df8fcd0444..3416c55be810 100644
--- v5.14-rc7-mmotm-2021-08-23-16-42/mm/memory-failure.c
+++ v5.14-rc7-mmotm-2021-08-23-16-42_patched/mm/memory-failure.c
@@ -1126,7 +1126,7 @@ static int page_action(struct page_state *ps, struct page *p,
  */
 static inline bool HWPoisonHandlable(struct page *page)
 {
-	return PageLRU(page) || __PageMovable(page);
+	return PageLRU(page) || __PageMovable(page) || is_free_buddy_page(page);
 }
 
 static int __get_hwpoison_page(struct page *page)
-- 
2.25.1

