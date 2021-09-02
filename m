Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F374C3FED8F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344258AbhIBMN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:13:29 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15284 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbhIBMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:13:24 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H0ftS0N7wz8BJ8;
        Thu,  2 Sep 2021 20:12:00 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 2 Sep
 2021 20:12:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 1/5] mm/page_alloc.c: remove meaningless VM_BUG_ON() in pindex_to_order()
Date:   Thu, 2 Sep 2021 20:12:38 +0800
Message-ID: <20210902121242.41607-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210902121242.41607-1-linmiaohe@huawei.com>
References: <20210902121242.41607-1-linmiaohe@huawei.com>
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

It's meaningless to VM_BUG_ON() order != pageblock_order just after
setting order to pageblock_order. Remove it.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 91edb930b8ab..dbb3338d9287 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -677,10 +677,8 @@ static inline int pindex_to_order(unsigned int pindex)
 	int order = pindex / MIGRATE_PCPTYPES;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	if (order > PAGE_ALLOC_COSTLY_ORDER) {
+	if (order > PAGE_ALLOC_COSTLY_ORDER)
 		order = pageblock_order;
-		VM_BUG_ON(order != pageblock_order);
-	}
 #else
 	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
 #endif
-- 
2.23.0

