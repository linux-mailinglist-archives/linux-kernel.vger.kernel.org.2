Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916F734A4CF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbhCZJpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:45:24 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:46080 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbhCZJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:45:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xlpang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UTNHunI_1616751899;
Received: from localhost(mailfrom:xlpang@linux.alibaba.com fp:SMTPD_---0UTNHunI_1616751899)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 26 Mar 2021 17:44:59 +0800
From:   Xunlei Pang <xlpang@linux.alibaba.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Xunlei Pang <xlpang@linux.alibaba.com>
Subject: [PATCH 2/4] mm/page_reporting: Introduce free page reporting factor
Date:   Fri, 26 Mar 2021 17:44:56 +0800
Message-Id: <1616751898-58393-3-git-send-email-xlpang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
References: <1616751898-58393-1-git-send-email-xlpang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new "/sys/kernel/mm/page_reporting/reporting_factor"
within [0, 100], and stop page reporting when it reaches
the configured threshold. Default is 100 which means no
limitation is imposed. Percentile is adopted to reflect
the fact that it reports on the per-zone basis.

We can control the total number of reporting pages via
this knob to avoid EPT violations which may affect the
performance of the business, imagine the guest memory
allocation burst or host long-tail memory reclaiming
really hurt.

This knob can help make customized control policies according
to VM priority, it is also useful for testing, gray-release, etc.

Signed-off-by: Xunlei Pang <xlpang@linux.alibaba.com>
---
 mm/page_reporting.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index ba195ea..86c6479 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -11,6 +11,8 @@
 #include "page_reporting.h"
 #include "internal.h"
 
+static int reporting_factor = 100;
+
 #define PAGE_REPORTING_DELAY	(2 * HZ)
 static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
 
@@ -134,6 +136,7 @@ void __page_reporting_notify(void)
 	struct list_head *list = &area->free_list[mt];
 	unsigned int page_len = PAGE_SIZE << order;
 	struct page *page, *next;
+	unsigned long threshold;
 	long budget;
 	int err = 0;
 
@@ -144,6 +147,7 @@ void __page_reporting_notify(void)
 	if (list_empty(list))
 		return err;
 
+	threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;
 	spin_lock_irq(&zone->lock);
 
 	/*
@@ -181,6 +185,8 @@ void __page_reporting_notify(void)
 
 		/* Attempt to pull page from list and place in scatterlist */
 		if (*offset) {
+			unsigned long nr_pages;
+
 			if (!__isolate_free_page(page, order)) {
 				next = page;
 				break;
@@ -190,6 +196,12 @@ void __page_reporting_notify(void)
 			--(*offset);
 			sg_set_page(&sgl[*offset], page, page_len, 0);
 
+			nr_pages = (PAGE_REPORTING_CAPACITY - *offset) << order;
+			if (zone->reported_pages + nr_pages >= threshold) {
+				err = 1;
+				break;
+			}
+
 			continue;
 		}
 
@@ -244,9 +256,13 @@ void __page_reporting_notify(void)
 			    struct scatterlist *sgl, struct zone *zone)
 {
 	unsigned int order, mt, leftover, offset = PAGE_REPORTING_CAPACITY;
-	unsigned long watermark;
+	unsigned long watermark, threshold;
 	int err = 0;
 
+	threshold = atomic_long_read(&zone->managed_pages) * reporting_factor / 100;
+	if (zone->reported_pages >= threshold)
+		return err;
+
 	/* Generate minimum watermark to be able to guarantee progress */
 	watermark = low_wmark_pages(zone) +
 		    (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
@@ -267,11 +283,18 @@ void __page_reporting_notify(void)
 
 			err = page_reporting_cycle(prdev, zone, order, mt,
 						   sgl, &offset);
+			/* Exceed threshold go to report leftover */
+			if (err > 0) {
+				err = 0;
+				goto leftover;
+			}
+
 			if (err)
 				return err;
 		}
 	}
 
+leftover:
 	/* report the leftover pages before going idle */
 	leftover = PAGE_REPORTING_CAPACITY - offset;
 	if (leftover) {
@@ -435,9 +458,44 @@ static ssize_t refault_kbytes_store(struct kobject *kobj,
 }
 REPORTING_ATTR(refault_kbytes);
 
+static ssize_t reporting_factor_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", reporting_factor);
+}
+
+static ssize_t reporting_factor_store(struct kobject *kobj,
+		struct kobj_attribute *attr,
+		const char *buf, size_t count)
+{
+	int new, old, err;
+	struct page *page;
+
+	err = kstrtoint(buf, 10, &new);
+	if (err || (new < 0 || new > 100))
+		return -EINVAL;
+
+	old = reporting_factor;
+	reporting_factor = new;
+
+	if (new <= old)
+		goto out;
+
+	/* Trigger reporting with new larger reporting_factor */
+	page = alloc_pages(__GFP_HIGHMEM | __GFP_NOWARN,
+			PAGE_REPORTING_MIN_ORDER);
+	if (page)
+		__free_pages(page, PAGE_REPORTING_MIN_ORDER);
+
+out:
+	return count;
+}
+REPORTING_ATTR(reporting_factor);
+
 static struct attribute *reporting_attrs[] = {
 	&reported_kbytes_attr.attr,
 	&refault_kbytes_attr.attr,
+	&reporting_factor_attr.attr,
 	NULL,
 };
 
-- 
1.8.3.1

