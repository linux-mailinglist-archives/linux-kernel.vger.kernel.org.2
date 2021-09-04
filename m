Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63871400A95
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbhIDJTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 05:19:17 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15385 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhIDJTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 05:19:16 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H1prR15G3zbdVl;
        Sat,  4 Sep 2021 17:14:15 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Sat, 4 Sep
 2021 17:18:12 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/page_isolation: don't putback unisolated page
Date:   Sat, 4 Sep 2021 17:18:39 +0800
Message-ID: <20210904091839.20270-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If __isolate_free_page() failed, due to zone watermark check, the page is
still on the free list. But this page will be put back to free list again
via __putback_isolated_page() now. This may trigger page->flags checks in
__free_one_page() if PageReported is set. Or we will corrupt the free list
because list_add() will be called for pages already on another list.

Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_isolation.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 9bb562d5d194..7d70d772525c 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -93,10 +93,8 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 			buddy_pfn = __find_buddy_pfn(pfn, order);
 			buddy = page + (buddy_pfn - pfn);
 
-			if (!is_migrate_isolate_page(buddy)) {
-				__isolate_free_page(page, order);
-				isolated_page = true;
-			}
+			if (!is_migrate_isolate_page(buddy))
+				isolated_page = !!__isolate_free_page(page, order);
 		}
 	}
 
-- 
2.23.0

