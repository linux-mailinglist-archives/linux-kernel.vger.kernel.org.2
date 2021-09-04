Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702A8400A98
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350916AbhIDJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 05:21:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9402 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbhIDJV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 05:21:27 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H1ptb6RjNz8xT0;
        Sat,  4 Sep 2021 17:16:07 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Sat, 4 Sep
 2021 17:20:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mhocko@suse.com>, <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] mm/page_isolation: fix potential missing call to unset_migratetype_isolate()
Date:   Sat, 4 Sep 2021 17:20:53 +0800
Message-ID: <20210904092053.33037-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
also help to remove some duplicated codes.

Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_isolation.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 471e3a13b541..9bb562d5d194 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -202,14 +202,7 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	}
 	return 0;
 undo:
-	for (pfn = start_pfn;
-	     pfn < undo_pfn;
-	     pfn += pageblock_nr_pages) {
-		struct page *page = pfn_to_online_page(pfn);
-		if (!page)
-			continue;
-		unset_migratetype_isolate(page, migratetype);
-	}
+	undo_isolate_page_range(start_pfn, undo_pfn, migratetype);
 
 	return -EBUSY;
 }
-- 
2.23.0

