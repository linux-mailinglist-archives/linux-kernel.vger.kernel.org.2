Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C3408A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhIMLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:51:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9033 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239186AbhIMLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:51:11 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H7Prl6s6HzVsc6;
        Mon, 13 Sep 2021 19:48:55 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 13
 Sep 2021 19:49:53 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <jhubbard@nvidia.com>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/page_isolation: don't putback unisolated page
Date:   Mon, 13 Sep 2021 19:50:21 +0800
Message-ID: <20210913115021.27597-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
v1->v2:
  Add VM_WARN_ON to catch unexpected isolating failure.
---
 mm/page_isolation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f93cc63d8fa1..f67c4c70f17f 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -94,8 +94,13 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
 			buddy = page + (buddy_pfn - pfn);
 
 			if (!is_migrate_isolate_page(buddy)) {
-				__isolate_free_page(page, order);
-				isolated_page = true;
+				isolated_page = !!__isolate_free_page(page, order);
+				/*
+				 * Isolating a free page in an isolated pageblock
+				 * is expected to always work as watermarks don't
+				 * apply here.
+				 */
+				VM_WARN_ON(!isolated_page);
 			}
 		}
 	}
-- 
2.23.0

