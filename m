Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429C740ACA7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 13:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhINLol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 07:44:41 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:16198 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbhINLok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 07:44:40 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H81fk0VFPz1DGwK;
        Tue, 14 Sep 2021 19:42:22 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Tue, 14
 Sep 2021 19:43:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v3] mm/page_isolation: fix potential missing call to unset_migratetype_isolate()
Date:   Tue, 14 Sep 2021 19:43:48 +0800
Message-ID: <20210914114348.15569-1-linmiaohe@huawei.com>
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

In start_isolate_page_range() undo path, pfn_to_online_page() just checks
the first pfn in a pageblock while __first_valid_page() will traverse the
pageblock until the first online pfn is found. So we may miss the call to
unset_migratetype_isolate() in undo path and pages will remain isolated
unexpectedly. Fix this by calling undo_isolate_page_range() and this will
also help to simplify the code further. Note we shouldn't ever trigger it
because MAX_ORDER-1 aligned pfn ranges shouldn't contain memory holes now.

Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
v1->v2:
  Simplify the code further per David Hildenbrand.
v2->v3:
  remove unneeded cc stable.
---
 mm/page_isolation.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index a95c2c6562d0..f93cc63d8fa1 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -183,7 +183,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     unsigned migratetype, int flags)
 {
 	unsigned long pfn;
-	unsigned long undo_pfn;
 	struct page *page;
 
 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
@@ -193,25 +192,12 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	     pfn < end_pfn;
 	     pfn += pageblock_nr_pages) {
 		page = __first_valid_page(pfn, pageblock_nr_pages);
-		if (page) {
-			if (set_migratetype_isolate(page, migratetype, flags)) {
-				undo_pfn = pfn;
-				goto undo;
-			}
+		if (page && set_migratetype_isolate(page, migratetype, flags)) {
+			undo_isolate_page_range(start_pfn, pfn, migratetype);
+			return -EBUSY;
 		}
 	}
 	return 0;
-undo:
-	for (pfn = start_pfn;
-	     pfn < undo_pfn;
-	     pfn += pageblock_nr_pages) {
-		struct page *page = pfn_to_online_page(pfn);
-		if (!page)
-			continue;
-		unset_migratetype_isolate(page, migratetype);
-	}
-
-	return -EBUSY;
 }
 
 /*
-- 
2.23.0

