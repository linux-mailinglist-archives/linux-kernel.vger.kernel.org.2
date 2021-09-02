Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041663FED91
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344289AbhIBMNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 08:13:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15381 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbhIBMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 08:13:24 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H0fpN5Hfmzbgbr;
        Thu,  2 Sep 2021 20:08:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 2 Sep
 2021 20:12:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 4/5] mm/page_alloc.c: use helper function zone_spans_pfn()
Date:   Thu, 2 Sep 2021 20:12:41 +0800
Message-ID: <20210902121242.41607-5-linmiaohe@huawei.com>
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

Use helper function zone_spans_pfn() to check whether pfn is within a
zone to simplify the code slightly.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f7fcbac2d091..9c09dcb24149 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1581,7 +1581,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
 		struct zone *zone = &pgdat->node_zones[zid];
 
-		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
+		if (zone_spans_pfn(zone, pfn))
 			break;
 	}
 	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
-- 
2.23.0

