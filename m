Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3536C70E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbhD0NdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:33:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17066 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbhD0NdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:33:15 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FV2gZ3Y1Yz19Lf0;
        Tue, 27 Apr 2021 21:30:02 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 27 Apr 2021
 21:32:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 2/5] mm/huge_memory.c: use page->deferred_list
Date:   Tue, 27 Apr 2021 21:32:11 +0800
Message-ID: <20210427133214.2270207-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210427133214.2270207-1-linmiaohe@huawei.com>
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can represent the location of ->deferred_list instead of
->mapping + ->index, make use of it to improve readability.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..76ca1eb2a223 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2868,7 +2868,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	/* Take pin on all head pages to avoid freeing them under us */
 	list_for_each_safe(pos, next, &ds_queue->split_queue) {
-		page = list_entry((void *)pos, struct page, mapping);
+		page = list_entry((void *)pos, struct page, deferred_list);
 		page = compound_head(page);
 		if (get_page_unless_zero(page)) {
 			list_move(page_deferred_list(page), &list);
@@ -2883,7 +2883,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 
 	list_for_each_safe(pos, next, &list) {
-		page = list_entry((void *)pos, struct page, mapping);
+		page = list_entry((void *)pos, struct page, deferred_list);
 		if (!trylock_page(page))
 			goto next;
 		/* split_huge_page() removes page from list on success */
-- 
2.23.0

