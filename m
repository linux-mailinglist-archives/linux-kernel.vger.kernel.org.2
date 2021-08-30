Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC383FB792
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhH3OL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:11:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14436 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbhH3OLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:11:18 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GysYw5Y6czbfj3;
        Mon, 30 Aug 2021 22:06:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 30
 Aug 2021 22:10:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 3/6] mm/page_alloc.c: remove obsolete comment in free_pcppages_bulk()
Date:   Mon, 30 Aug 2021 22:10:48 +0800
Message-ID: <20210830141051.64090-4-linmiaohe@huawei.com>
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

It's also confusing now. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d3983244f56f..b5edcfe112aa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1424,17 +1424,6 @@ static inline void prefetch_buddy(struct page *page)
 	prefetch(buddy);
 }
 
-/*
- * Frees a number of pages from the PCP lists
- * Assumes all pages on list are in same zone, and of same order.
- * count is the number of pages to free.
- *
- * If the zone was previously in an "all pages pinned" state then look to
- * see if this freeing clears that state.
- *
- * And clear the zone's pages_scanned counter, to hold off the "all pages are
- * pinned" detection logic.
- */
 static void free_pcppages_bulk(struct zone *zone, int count,
 					struct per_cpu_pages *pcp)
 {
-- 
2.23.0

