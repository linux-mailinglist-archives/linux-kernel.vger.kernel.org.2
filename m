Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1EC34A4D3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCZJpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:45:31 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55137 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhCZJpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:45:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTNHunT_1616751900;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UTNHunT_1616751900)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Mar 2021 17:45:00 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH 4/4] mm/page_reporting: Fix possible user allocation failure
Date:   Fri, 26 Mar 2021 17:44:58 +0800
Message-Id: <1616751898-58393-5-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We encountered user memory allocation failure(OOM) on our
512MiB tiny instances, it didn't happen after turning off
the page reporting.

After some debugging, it turns out 32*4MB=128MB(order-10)
free pages were isolated during reporting window resulting
in no free available.

Actually this might also happen on large instances when
having a few free memory.

This patch introduces a rule to limit reporting capacity
according to current free memory, and reduce accordingly
for higher orders which could break this rule.

For example,
 100MiB free, sgl capacity for different orders are:
   order-9 : 32
   order-10: 16

Reported-by: Helin Guo <helinguo@linux.alibaba.com>
Tested-by: Helin Guo <helinguo@linux.alibaba.com>
Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/page_reporting.c | 89 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 17 deletions(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 6ffedb8..2ec0ec0 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -129,8 +129,8 @@ void __page_reporting_notify(void)
  */
 static int
 page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
-		     unsigned int order, unsigned int mt,
-		     struct scatterlist *sgl, unsigned int *offset)
+		     unsigned int order, unsigned int mt, struct scatterlist *sgl,
+		     const unsigned int capacity, unsigned int *offset)
 {
 	struct free_area *area = &zone->free_area[order];
 	struct list_head *list = &area->free_list[mt];
@@ -161,10 +161,10 @@ void __page_reporting_notify(void)
 	 * list processed. This should result in us reporting all pages on
 	 * an idle system in about 30 seconds.
 	 *
-	 * The division here should be cheap since PAGE_REPORTING_CAPACITY
-	 * should always be a power of 2.
+	 * The division here should be cheap since capacity should
+	 * always be a power of 2.
 	 */
-	budget = DIV_ROUND_UP(area->nr_free, PAGE_REPORTING_CAPACITY * 16);
+	budget = DIV_ROUND_UP(area->nr_free, capacity * 16);
 
 	/* loop through free list adding unreported pages to sg list */
 	list_for_each_entry_safe(page, next, list, lru) {
@@ -196,7 +196,7 @@ void __page_reporting_notify(void)
 			--(*offset);
 			sg_set_page(&sgl[*offset], page, page_len, 0);
 
-			nr_pages = (PAGE_REPORTING_CAPACITY - *offset) << order;
+			nr_pages = (capacity - *offset) << order;
 			if (zone->reported_pages + nr_pages >= threshold) {
 				err = 1;
 				break;
@@ -217,10 +217,10 @@ void __page_reporting_notify(void)
 		spin_unlock_irq(&zone->lock);
 
 		/* begin processing pages in local list */
-		err = prdev->report(prdev, sgl, PAGE_REPORTING_CAPACITY);
+		err = prdev->report(prdev, sgl, capacity);
 
 		/* reset offset since the full list was reported */
-		*offset = PAGE_REPORTING_CAPACITY;
+		*offset = capacity;
 
 		/* update budget to reflect call to report function */
 		budget--;
@@ -229,7 +229,7 @@ void __page_reporting_notify(void)
 		spin_lock_irq(&zone->lock);
 
 		/* flush reported pages from the sg list */
-		page_reporting_drain(prdev, sgl, zone, PAGE_REPORTING_CAPACITY, !err);
+		page_reporting_drain(prdev, sgl, zone, capacity, !err);
 
 		/*
 		 * Reset next to first entry, the old next isn't valid
@@ -251,12 +251,39 @@ void __page_reporting_notify(void)
 	return err;
 }
 
+/*
+ * For guest with little free memory, we should tune reporting capacity
+ * correctly to avoid reporting too much once, otherwise user allocation
+ * may fail and OOM during reporting window between __isolate_free_page()
+ * and page_reporting_drain().
+ *
+ * Calculate from which order we begin to reduce the scatterlist capacity,
+ * in order not to isolate too many pages to fail the user allocation.
+ */
+static unsigned int calculate_zone_order_threshold(struct zone *z)
+{
+	unsigned int order;
+	long pages_threshold;
+
+	pages_threshold = zone_page_state(z, NR_FREE_PAGES) - low_wmark_pages(z);
+	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+		if ((PAGE_REPORTING_CAPACITY << order) > pages_threshold)
+			break;
+	}
+
+	return order;
+}
+
 static int
 page_reporting_process_zone(struct page_reporting_dev_info *prdev,
 			    struct scatterlist *sgl, struct zone *zone)
 {
-	unsigned int order, mt, leftover, offset = PAGE_REPORTING_CAPACITY;
+	unsigned int order, mt, leftover, offset;
 	unsigned long watermark, threshold;
+	unsigned int capacity = PAGE_REPORTING_CAPACITY;
+	unsigned int capacity_curr;
+	struct scatterlist *sgl_curr;
+	unsigned int order_threshold;
 	int err = 0;
 
 	threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;
@@ -274,15 +301,28 @@ void __page_reporting_notify(void)
 	if (!zone_watermark_ok(zone, 0, watermark, 0, ALLOC_CMA))
 		return err;
 
+	sgl_curr = sgl;
+	capacity_curr = offset = capacity;
+	order_threshold = calculate_zone_order_threshold(zone);
 	/* Process each free list starting from lowest order/mt */
 	for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
+		/* try to reduce unexpected high order's reporting capacity */
+		if (order >= order_threshold) {
+			capacity_curr = capacity >> (order - order_threshold + 1);
+			if (capacity_curr == 0)
+				capacity_curr = 1;
+			sgl_curr = sgl + capacity - capacity_curr;
+			offset = capacity_curr;
+			sg_init_table(sgl_curr, capacity_curr);
+		}
+
 		for (mt = 0; mt < MIGRATE_TYPES; mt++) {
 			/* We do not pull pages from the isolate free list */
 			if (is_migrate_isolate(mt))
 				continue;
 
 			err = page_reporting_cycle(prdev, zone, order, mt,
-						   sgl, &offset);
+						   sgl_curr, capacity_curr, &offset);
 			/* Exceed threshold go to report leftover */
 			if (err > 0) {
 				err = 0;
@@ -292,18 +332,34 @@ void __page_reporting_notify(void)
 			if (err)
 				return err;
 		}
+
+		/* report the leftover pages for next orders with reduced capacity */
+		leftover = capacity_curr - offset;
+		if (leftover && order + 1 >= order_threshold) {
+			sgl_curr = &sgl_curr[offset];
+			err = prdev->report(prdev, sgl_curr, leftover);
+			offset = capacity_curr;
+
+			/* flush any remaining pages out from the last report */
+			spin_lock_irq(&zone->lock);
+			page_reporting_drain(prdev, sgl_curr, zone, leftover, !err);
+			spin_unlock_irq(&zone->lock);
+
+			if (err)
+				return err;
+		}
 	}
 
 leftover:
 	/* report the leftover pages before going idle */
-	leftover = PAGE_REPORTING_CAPACITY - offset;
+	leftover = capacity_curr - offset;
 	if (leftover) {
-		sgl = &sgl[offset];
-		err = prdev->report(prdev, sgl, leftover);
+		sgl_curr = &sgl_curr[offset];
+		err = prdev->report(prdev, sgl_curr, leftover);
 
 		/* flush any remaining pages out from the last report */
 		spin_lock_irq(&zone->lock);
-		page_reporting_drain(prdev, sgl, zone, leftover, !err);
+		page_reporting_drain(prdev, sgl_curr, zone, leftover, !err);
 		spin_unlock_irq(&zone->lock);
 	}
 
@@ -332,9 +388,8 @@ static void page_reporting_process(struct work_struct *work)
 	if (!sgl)
 		goto err_out;
 
-	sg_init_table(sgl, PAGE_REPORTING_CAPACITY);
-
 	for_each_zone(zone) {
+		sg_init_table(sgl, PAGE_REPORTING_CAPACITY);
 		err = page_reporting_process_zone(prdev, sgl, zone);
 		if (err)
 			break;
-- 
1.8.3.1

