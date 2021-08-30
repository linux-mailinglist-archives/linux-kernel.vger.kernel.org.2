Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942073FB795
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 16:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhH3OLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 10:11:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:18990 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbhH3OLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:11:20 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GysYx2zLdzbkgN;
        Mon, 30 Aug 2021 22:06:29 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 30
 Aug 2021 22:10:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 4/6] mm/page_alloc.c: use helper function zone_spans_pfn()
Date:   Mon, 30 Aug 2021 22:10:49 +0800
Message-ID: <20210830141051.64090-5-linmiaohe@huawei.com>
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

Use helper function zone_spans_pfn() to check whether pfn is within a
zone to simplify the code slightly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5edcfe112aa..7bb79e959ab4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1576,7 +1576,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
 		struct zone *zone = &pgdat->node_zones[zid];
 
-		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
+		if (zone_spans_pfn(zone, pfn))
 			break;
 	}
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
-- 
2.23.0

