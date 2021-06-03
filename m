Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6938E399C83
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhFCI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:28:29 -0400
Received: from m12-13.163.com ([220.181.12.13]:33982 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhFCI21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:28:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=v8hdr
        MCBGacUEfiNlWE57cjpHLpNbsXqVFC3i2ws2ac=; b=qOhzDo5CcHt7J//MJRaTT
        5P7G5FgS4OP/k9pGu/YFbn/wThrtYI7OGkUu/KfdQgPpiZ1HhdwavKNfYLQ+xIgi
        s56RJ3f32Tj9msR9WnrhIomyhF+XJ+cEAYE/X2JCntYc3rs4UprA9Rq/x/bt8m84
        gYWiK9kMS3lTvxIcmqy3MY=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp9 (Coremail) with SMTP id DcCowABnbKD9kbhg_RscEQ--.16583S2;
        Thu, 03 Jun 2021 16:25:34 +0800 (CST)
From:   13145886936@163.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] mm: opt the use of space and tabs
Date:   Thu,  3 Jun 2021 01:25:26 -0700
Message-Id: <20210603082526.5753-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowABnbKD9kbhg_RscEQ--.16583S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxArW3KF47WF4kKF13JFyrWFg_yoW5CFW3pr
        WfGw1DWrWSqwsI9a97JF4ku343Aw1xKayxJrW2yr1rZ3Wagr1Yvr93KFy7ur1Yyr97Aa4a
        va1avF18Aw45ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bbCzNUUUUU=
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/1tbiXB6mg1Xlz1amnwAAs3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Revised the use of space and tabs.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 mm/memory.c     | 2 +-
 mm/page_alloc.c | 2 +-
 mm/vmscan.c     | 2 +-
 mm/vmstat.c     | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index f85c2c322a23..aec804080ad9 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1683,7 +1683,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		unsigned long size)
 {
 	if (address < vma->vm_start || address + size > vma->vm_end ||
-	    		!(vma->vm_flags & VM_PFNMAP))
+			!(vma->vm_flags & VM_PFNMAP))
 		return;
 
 	zap_page_range_single(vma, address, size, NULL);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4c468aa596aa..de1ab8073cc6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8908,7 +8908,7 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
  * need to be freed with free_contig_range().
  */
 int alloc_contig_range(unsigned long start, unsigned long end,
-		       unsigned migratetype, gfp_t gfp_mask)
+			unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
 	unsigned int order;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 60a19fd6ea3f..939bf138478a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4303,7 +4303,7 @@ static int __init kswapd_init(void)
 
 	swap_setup();
 	for_each_node_state(nid, N_MEMORY)
- 		kswapd_run(nid);
+		kswapd_run(nid);
 	return 0;
 }
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166..23504a605c7c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -200,7 +200,7 @@ int calculate_normal_threshold(struct zone *zone)
 	 * The threshold scales with the number of processors and the amount
 	 * of memory per zone. More memory means that we can defer updates for
 	 * longer, more processors could lead to more contention.
- 	 * fls() is used to have a cheap way of logarithmic scaling.
+	 * fls() is used to have a cheap way of logarithmic scaling.
 	 *
 	 * Some sample thresholds:
 	 *
@@ -439,7 +439,7 @@ void __dec_zone_state(struct zone *zone, enum zone_stat_item item)
 
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
-	if (unlikely(v < - t)) {
+	if (unlikely(v < -t)) {
 		s8 overstep = t >> 1;
 
 		zone_page_state_add(v - overstep, zone, item);
@@ -457,7 +457,7 @@ void __dec_node_state(struct pglist_data *pgdat, enum node_stat_item item)
 
 	v = __this_cpu_dec_return(*p);
 	t = __this_cpu_read(pcp->stat_threshold);
-	if (unlikely(v < - t)) {
+	if (unlikely(v < -t)) {
 		s8 overstep = t >> 1;
 
 		node_page_state_add(v - overstep, pgdat, item);
@@ -1063,7 +1063,7 @@ static int __fragmentation_index(unsigned int order, struct contig_page_info *in
 	 * 0 => allocation would fail due to lack of memory
 	 * 1 => allocation would fail due to fragmentation
 	 */
-	return 1000 - div_u64( (1000+(div_u64(info->free_pages * 1000ULL, requested))), info->free_blocks_total);
+	return 1000 - div_u64((1000+(div_u64(info->free_pages * 1000ULL, requested))), info->free_blocks_total);
 }
 
 /*
-- 
2.25.1


