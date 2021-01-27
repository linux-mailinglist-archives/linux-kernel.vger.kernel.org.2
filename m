Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22F3305711
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhA0Jg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:36:57 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11202 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhA0JdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:33:14 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DQddF1rPzzl9cY;
        Wed, 27 Jan 2021 17:30:57 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Wed, 27 Jan 2021
 17:32:19 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/memory_hotplug: use helper function zone_end_pfn() to get end_pfn
Date:   Wed, 27 Jan 2021 04:32:11 -0500
Message-ID: <20210127093211.37714-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 108bcc96ef70 ("mm: add & use zone_end_pfn() and zone_spans_pfn()")
introduced the helper zone_end_pfn() to calculate the zone end pfn.  But
update_pgdat_span() forgot to use it. Use this helper and re-name local
variable zone_end_pfn to end_pfn to fix below compilation error:

mm/memory_hotplug.c: In function ‘update_pgdat_span’:
mm/memory_hotplug.c:448:32: error: called object ‘zone_end_pfn’ is not a
function or function pointer
   unsigned long zone_end_pfn = zone_end_pfn(zone);
                                ^~~~~~~~~~~~
mm/memory_hotplug.c:448:17: note: declared here
   unsigned long zone_end_pfn = zone_end_pfn(zone);
                 ^~~~~~~~~~~~

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory_hotplug.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 710e469fb3a1..0483db52b85f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -493,20 +493,19 @@ static void update_pgdat_span(struct pglist_data *pgdat)
 
 	for (zone = pgdat->node_zones;
 	     zone < pgdat->node_zones + MAX_NR_ZONES; zone++) {
-		unsigned long zone_end_pfn = zone->zone_start_pfn +
-					     zone->spanned_pages;
+		unsigned long end_pfn = zone_end_pfn(zone);
 
 		/* No need to lock the zones, they can't change. */
 		if (!zone->spanned_pages)
 			continue;
 		if (!node_end_pfn) {
 			node_start_pfn = zone->zone_start_pfn;
-			node_end_pfn = zone_end_pfn;
+			node_end_pfn = end_pfn;
 			continue;
 		}
 
-		if (zone_end_pfn > node_end_pfn)
-			node_end_pfn = zone_end_pfn;
+		if (end_pfn > node_end_pfn)
+			node_end_pfn = end_pfn;
 		if (zone->zone_start_pfn < node_start_pfn)
 			node_start_pfn = zone->zone_start_pfn;
 	}
-- 
2.19.1

