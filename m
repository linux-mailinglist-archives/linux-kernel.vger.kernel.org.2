Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9AD3FB794
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbhH3OLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:11:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15273 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbhH3OLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:11:20 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Gysf32rb7z88XN;
        Mon, 30 Aug 2021 22:10:03 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 30
 Aug 2021 22:10:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 5/6] mm/page_alloc.c: avoid accessing uninitialized pcp page migratetype
Date:   Mon, 30 Aug 2021 22:10:50 +0800
Message-ID: <20210830141051.64090-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210830141051.64090-1-linmiaohe@huawei.com>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
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

If it's not prepared to free unref page, the pcp page migratetype is
unset. Thus We will get rubbish from get_pcppage_migratetype() and
might list_del &page->lru again after it's already deleted from the
list leading to grumble about data corruption.

Fixes: 3dcbe270d8ec ("mm/page_alloc: avoid conflating IRQs disabled with zone->lock")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7bb79e959ab4..d87b7e6e9e6b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3415,8 +3415,10 @@ void free_unref_page_list(struct list_head *list)
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

