Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B15631EF28
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhBRTDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:03:06 -0500
Received: from z11.mailgun.us ([104.130.96.11]:16376 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233353AbhBRR0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 12:26:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613669167; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=lTejp1S6cV1ZVxuGdWXuyk1yeMFJzL/m+zo/HkOyKLQ=; b=sZOkrd45FyWTC0mYpkvV7i5oe5CGT0BieV4zcIT5aRgsbSGmsZzWQq7kfiWQHXmdGVCEnZ/e
 0cDZRhxxlLhxnOYhrZlaaYha15x6+W5ptABN8ERK/WZvKMYsiIxwClm92tpf18crjwVelPuz
 cDrPdBBLTshfaMgC5SZcQFCLMZs=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 602ea30c3bd0a42cc9ef3ca7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 18 Feb 2021 17:25:32
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 622CFC43461; Thu, 18 Feb 2021 17:25:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5F0D2C433CA;
        Thu, 18 Feb 2021 17:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F0D2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, rientjes@google.com, vbabka@suse.cz,
        mhocko@suse.com, david@redhat.com, mgorman@techsingularity.net,
        linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, sudaraja@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH 1/1] mm: proof-of-concept for balancing node zones occupancy
Date:   Thu, 18 Feb 2021 22:54:32 +0530
Message-Id: <615153d1f2400df51e0592440868959ea90be13a.1613661472.git.charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613661472.git.charante@codeaurora.org>
References: <cover.1613661472.git.charante@codeaurora.org>
In-Reply-To: <cover.1613661472.git.charante@codeaurora.org>
References: <cover.1613661472.git.charante@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Proof-of-concept code for balancing the node zones occupancy
whose imbalance may be caused by the memory hotplug.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 include/linux/migrate.h |   8 +-
 include/linux/mm.h      |   3 +
 include/linux/mmzone.h  |   2 +
 kernel/sysctl.c         |  11 ++
 mm/compaction.c         |   4 +-
 mm/memory_hotplug.c     | 265 ++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 290 insertions(+), 3 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 4594838..b7dc259 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -53,6 +53,8 @@ extern int migrate_huge_page_move_mapping(struct address_space *mapping,
 				  struct page *newpage, struct page *page);
 extern int migrate_page_move_mapping(struct address_space *mapping,
 		struct page *newpage, struct page *page, int extra_count);
+extern void split_map_pages(struct list_head *list);
+extern unsigned long release_freepages(struct list_head *freelist);
 #else
 
 static inline void putback_movable_pages(struct list_head *l) {}
@@ -81,7 +83,11 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 {
 	return -ENOSYS;
 }
-
+static inline void split_map_pages(struct list_head *list) { }
+static inline unsigned long release_freepages(struct list_head *freelist)
+{
+	return 0;
+}
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecdf8a8..1014139 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2465,6 +2465,9 @@ extern int watermark_boost_factor;
 extern int watermark_scale_factor;
 extern bool arch_has_descending_max_zone_pfns(void);
 
+/* memory_hotplug.c */
+extern int balance_node_occupancy_pages;
+
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316..ce417c3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -977,6 +977,8 @@ int sysctl_min_slab_ratio_sysctl_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
 int numa_zonelist_order_handler(struct ctl_table *, int,
 		void *, size_t *, loff_t *);
+extern int sysctl_balance_node_occupancy_handler(struct ctl_table *tbl,
+		int write, void *buf, size_t *len, loff_t *pos);
 extern int percpu_pagelist_fraction;
 extern char numa_zonelist_order[];
 #define NUMA_ZONELIST_ORDER_LEN	16
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index c9fbdd8..4b95a90 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3140,6 +3140,17 @@ static struct ctl_table vm_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#ifdef CONFIG_MEMORY_HOTPLUG
+	{
+		.procname	= "balance_node_occupancy_pages",
+		.data		= &balance_node_occupancy_pages,
+		.maxlen		= sizeof(balance_node_occupancy_pages),
+		.mode		= 0200,
+		.proc_handler	= sysctl_balance_node_occupancy_handler,
+		.extra1		= SYSCTL_ZERO,
+	},
+
+#endif
 	{ }
 };
 
diff --git a/mm/compaction.c b/mm/compaction.c
index 190ccda..da3c015 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -68,7 +68,7 @@ static const unsigned int HPAGE_FRAG_CHECK_INTERVAL_MSEC = 500;
 #define COMPACTION_HPAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #endif
 
-static unsigned long release_freepages(struct list_head *freelist)
+unsigned long release_freepages(struct list_head *freelist)
 {
 	struct page *page, *next;
 	unsigned long high_pfn = 0;
@@ -84,7 +84,7 @@ static unsigned long release_freepages(struct list_head *freelist)
 	return high_pfn;
 }
 
-static void split_map_pages(struct list_head *list)
+void split_map_pages(struct list_head *list)
 {
 	unsigned int i, order, nr_pages;
 	struct page *page, *next;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9..2780c91 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -97,6 +97,271 @@ void mem_hotplug_done(void)
 
 u64 max_mem_size = U64_MAX;
 
+int balance_node_occupancy_pages;
+static atomic_t target_migrate_pages = ATOMIC_INIT(0);
+
+struct movable_zone_fill_control {
+	struct list_head freepages;
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	unsigned long nr_migrate_pages;
+	unsigned long nr_free_pages;
+	unsigned long limit;
+	int target;
+	struct zone *zone;
+};
+
+static void fill_movable_zone_fn(struct work_struct *work);
+static DECLARE_WORK(fill_movable_zone_work, fill_movable_zone_fn);
+static DEFINE_MUTEX(page_migrate_lock);
+
+static inline void reset_page_order(struct page *page)
+{
+	__ClearPageBuddy(page);
+	set_page_private(page, 0);
+}
+
+static int isolate_free_page(struct page *page, unsigned int order)
+{
+	struct zone *zone;
+
+	zone = page_zone(page);
+	list_del(&page->lru);
+	zone->free_area[order].nr_free--;
+	reset_page_order(page);
+
+	return 1UL << order;
+}
+
+static void isolate_free_pages(struct movable_zone_fill_control *fc)
+{
+	struct page *page;
+	unsigned long flags;
+	unsigned int order;
+	unsigned long start_pfn = fc->start_pfn;
+	unsigned long end_pfn = fc->end_pfn;
+
+	spin_lock_irqsave(&fc->zone->lock, flags);
+	for (; start_pfn < end_pfn; start_pfn++) {
+		unsigned long isolated;
+
+		if (!pfn_valid(start_pfn))
+			continue;
+
+		page = pfn_to_page(start_pfn);
+		if (!page)
+			continue;
+
+		if (PageCompound(page)) {
+			struct page *head = compound_head(page);
+			int skip;
+
+			skip = (1 << compound_order(head)) - (page - head);
+			start_pfn += skip - 1;
+			continue;
+		}
+
+		if (!PageBuddy(page))
+			continue;
+
+		order = page_private(page);
+		isolated = isolate_free_page(page, order);
+		set_page_private(page, order);
+		list_add_tail(&page->lru, &fc->freepages);
+		fc->nr_free_pages += isolated;
+		__mod_zone_page_state(fc->zone, NR_FREE_PAGES, -isolated);
+		start_pfn += isolated - 1;
+
+		/*
+		 * Make sure that the zone->lock is not held for long by
+		 * returning once we have SWAP_CLUSTER_MAX pages in the
+		 * free list for migration.
+		 */
+		if (fc->nr_free_pages >= SWAP_CLUSTER_MAX)
+			break;
+	}
+	fc->start_pfn = start_pfn + 1;
+	spin_unlock_irqrestore(&fc->zone->lock, flags);
+
+	split_map_pages(&fc->freepages);
+}
+
+static struct page *movable_page_alloc(struct page *page, unsigned long data)
+{
+	struct movable_zone_fill_control *fc;
+	struct page *freepage;
+
+	fc = (struct movable_zone_fill_control *)data;
+	if (list_empty(&fc->freepages)) {
+		isolate_free_pages(fc);
+		if (list_empty(&fc->freepages))
+			return NULL;
+	}
+
+	freepage = list_entry(fc->freepages.next, struct page, lru);
+	list_del(&freepage->lru);
+	fc->nr_free_pages--;
+
+	return freepage;
+}
+
+static void movable_page_free(struct page *page, unsigned long data)
+{
+	struct movable_zone_fill_control *fc;
+
+	fc = (struct movable_zone_fill_control *)data;
+	list_add(&page->lru, &fc->freepages);
+	fc->nr_free_pages++;
+}
+
+static unsigned long get_anon_movable_pages(
+			struct movable_zone_fill_control *fc,
+			unsigned long start_pfn,
+			unsigned long end_pfn, struct list_head *list)
+{
+	int found = 0, pfn, ret;
+	int limit = min_t(int, fc->target, (int)pageblock_nr_pages);
+
+	fc->nr_migrate_pages = 0;
+	for (pfn = start_pfn; pfn < end_pfn && found < limit; ++pfn) {
+		struct page *page = pfn_to_page(pfn);
+
+		if (!pfn_valid(pfn))
+			continue;
+
+		if (PageCompound(page)) {
+			struct page *head = compound_head(page);
+			int skip;
+
+			skip = (1 << compound_order(head)) - (page - head);
+			pfn += skip - 1;
+			continue;
+		}
+
+		if (PageBuddy(page)) {
+			unsigned long freepage_order;
+
+			freepage_order = READ_ONCE(page_private(page));
+			if (freepage_order > 0 && freepage_order < MAX_ORDER)
+				pfn += (1 << page_private(page)) - 1;
+			continue;
+		}
+
+		if (!PageLRU(page) || !PageAnon(page))
+			continue;
+
+		if (!get_page_unless_zero(page))
+			continue;
+
+		found++;
+		ret = isolate_lru_page(page);
+		if (!ret) {
+			list_add_tail(&page->lru, list);
+			inc_node_page_state(page, NR_ISOLATED_ANON +
+					page_is_file_lru(page));
+			++fc->nr_migrate_pages;
+		}
+
+		put_page(page);
+	}
+
+	return pfn;
+}
+
+static void prepare_fc(struct movable_zone_fill_control *fc)
+{
+	struct zone *zone;
+
+	zone = &(NODE_DATA(0)->node_zones[ZONE_MOVABLE]);
+	fc->zone = zone;
+	fc->start_pfn = zone->zone_start_pfn;
+	fc->end_pfn = zone_end_pfn(zone);
+	fc->limit = atomic64_read(&zone->managed_pages);
+	INIT_LIST_HEAD(&fc->freepages);
+}
+
+#define MIGRATE_TIMEOUT_SEC (20)
+static void fill_movable_zone_fn(struct work_struct *work)
+{
+	unsigned long start_pfn, end_pfn;
+	unsigned long movable_highmark;
+	struct zone *normal_zone = &(NODE_DATA(0)->node_zones[ZONE_NORMAL]);
+	struct zone *movable_zone = &(NODE_DATA(0)->node_zones[ZONE_MOVABLE]);
+	LIST_HEAD(source);
+	int ret, free;
+	struct movable_zone_fill_control fc = { {0} };
+	unsigned long timeout = MIGRATE_TIMEOUT_SEC * HZ, expire;
+
+	start_pfn = normal_zone->zone_start_pfn;
+	end_pfn = zone_end_pfn(normal_zone);
+	movable_highmark = high_wmark_pages(movable_zone);
+
+	lru_add_drain_all();
+	drain_all_pages(normal_zone);
+	if (!mutex_trylock(&page_migrate_lock))
+		return;
+	prepare_fc(&fc);
+	if (!fc.limit)
+		goto out;
+	expire = jiffies + timeout;
+restart:
+	fc.target = atomic_xchg(&target_migrate_pages, 0);
+	if (!fc.target)
+		goto out;
+repeat:
+	cond_resched();
+	if (time_after(jiffies, expire))
+		goto out;
+	free = zone_page_state(movable_zone, NR_FREE_PAGES);
+	if (free - fc.target <= movable_highmark)
+		fc.target = free - movable_highmark;
+	if (fc.target <= 0)
+		goto out;
+
+	start_pfn = get_anon_movable_pages(&fc, start_pfn, end_pfn, &source);
+	if (list_empty(&source) && start_pfn < end_pfn)
+		goto repeat;
+
+	ret = migrate_pages(&source, movable_page_alloc, movable_page_free,
+			(unsigned long) &fc,
+			MIGRATE_ASYNC, MR_MEMORY_HOTPLUG);
+	if (ret)
+		putback_movable_pages(&source);
+
+	fc.target -= fc.nr_migrate_pages;
+	if (ret == -ENOMEM || start_pfn >= end_pfn)
+		goto out;
+	else if (fc.target <= 0)
+		goto restart;
+
+	goto repeat;
+out:
+	mutex_unlock(&page_migrate_lock);
+	if (fc.nr_free_pages > 0)
+		release_freepages(&fc.freepages);
+}
+
+
+
+int sysctl_balance_node_occupancy_handler(struct ctl_table *table, int write,
+		void __user *buffer, size_t *length, loff_t *ppos)
+{
+	int rc;
+
+	rc = proc_dointvec_minmax(table, write, buffer, length, ppos);
+	if (rc)
+		return rc;
+
+	if (write) {
+		atomic_add(balance_node_occupancy_pages, &target_migrate_pages);
+
+		if (!work_pending(&fill_movable_zone_work))
+			queue_work(system_unbound_wq, &fill_movable_zone_work);
+	}
+
+	return 0;
+}
+
 /* add this memory to iomem resource */
 static struct resource *register_memory_resource(u64 start, u64 size,
 						 const char *resource_name)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

