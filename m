Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE8410510
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhIRIT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 04:19:58 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16277 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhIRIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 04:19:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HBNwv0strz8tDw;
        Sat, 18 Sep 2021 16:17:51 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 18 Sep 2021 16:18:29 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 18 Sep
 2021 16:18:29 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2] mm/vmstat: annotate data race for zone->free_area[order].nr_free
Date:   Sat, 18 Sep 2021 16:46:55 +0800
Message-ID: <20210918084655.2696522-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN reports a data-race on v5.10 which also exists on mainline:

==================================================================
BUG: KCSAN: data-race in extfrag_for_order+0x33/0x2d0

race at unknown origin, with read to 0xffff9ee9bfffab48 of 8 bytes by task 34 on cpu 1:
 extfrag_for_order+0x33/0x2d0
 kcompactd+0x5f0/0xce0
 kthread+0x1f9/0x220
 ret_from_fork+0x22/0x30

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 34 Comm: kcompactd0 Not tainted 5.10.0+ #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
==================================================================

Access to zone->free_area[order].nr_free in extfrag_for_order() and
frag_show_print() is lockless. That's intentional and the stats are
a rough estimate anyway. Annotate them with data_race().

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/vmstat.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 8ce2620344b2..8525849a48f0 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1070,8 +1070,13 @@ static void fill_contig_page_info(struct zone *zone,
 	for (order = 0; order < MAX_ORDER; order++) {
 		unsigned long blocks;
 
-		/* Count number of free blocks */
-		blocks = zone->free_area[order].nr_free;
+		/*
+		 * Count number of free blocks.
+		 *
+		 * Access to nr_free is lockless as nr_free is used only for
+		 * diagnostic purposes. Use data_race to avoid KCSAN warning.
+		 */
+		blocks = data_race(zone->free_area[order].nr_free);
 		info->free_blocks_total += blocks;
 
 		/* Count free base pages */
@@ -1445,7 +1450,11 @@ static void frag_show_print(struct seq_file *m, pg_data_t *pgdat,
 
 	seq_printf(m, "Node %d, zone %8s ", pgdat->node_id, zone->name);
 	for (order = 0; order < MAX_ORDER; ++order)
-		seq_printf(m, "%6lu ", zone->free_area[order].nr_free);
+		/*
+		 * Access to nr_free is lockless as nr_free is used only for
+		 * printing purposes. Use data_race to avoid KCSAN warning.
+		 */
+		seq_printf(m, "%6lu ", data_race(zone->free_area[order].nr_free));
 	seq_putc(m, '\n');
 }
 
-- 
2.18.0.huawei.25

