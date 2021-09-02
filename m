Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14D13FED35
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 13:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343838AbhIBLze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 07:55:34 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9395 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbhIBLzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 07:55:23 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H0fPC6csnz8w8t;
        Thu,  2 Sep 2021 19:50:07 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 2 Sep
 2021 19:54:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2] mm/page_alloc.c: avoid accessing uninitialized pcp page migratetype
Date:   Thu, 2 Sep 2021 19:54:47 +0800
Message-ID: <20210902115447.57050-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it's not prepared to free unref page, the pcp page migratetype is
unset. Thus We will get rubbish from get_pcppage_migratetype() and
might list_del &page->lru again after it's already deleted from the
list leading to grumble about data corruption.

Fixes: df1acc856923 ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Cc: <stable@vger.kernel.org>
---
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9c09dcb24149..a3c6acafa478 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3420,8 +3420,10 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_to_pfn(page);
-		if (!free_unref_page_prepare(page, pfn, 0))
+		if (!free_unref_page_prepare(page, pfn, 0)) {
 			list_del(&page->lru);
+			continue;
+		}
 
 		/*
 		 * Free isolated pages directly to the allocator, see
-- 
2.23.0

