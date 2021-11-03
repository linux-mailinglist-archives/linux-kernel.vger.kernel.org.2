Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E20444697
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 18:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhKCRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 13:08:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233105AbhKCRID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 13:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635959126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6hqjk3k1qOe1hlsoywI2rtd9aMmXRpPZ4qPXicNcNI=;
        b=VY0OuJPGLazG31Vo+D/66Yyq4l0i9ykhVo9UlAHQTaPu2FGhd5h6RbKodUnPRTbsyuOqBQ
        eA44zKnw6Ay9xkeAw+NSH5EKBgtYHwmiBkBJhsE4xhW1x2AJ+cM01Zyjv0nZhiJwZWjNyv
        dZOw6gkAIxrv9FAPKTiOyKUaSoQj0S0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-1anW_U2OMIeVJeKNGpP7IQ-1; Wed, 03 Nov 2021 13:05:21 -0400
X-MC-Unique: 1anW_U2OMIeVJeKNGpP7IQ-1
Received: by mail-wm1-f71.google.com with SMTP id o18-20020a05600c511200b00332fa17a02eso1365248wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 10:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6hqjk3k1qOe1hlsoywI2rtd9aMmXRpPZ4qPXicNcNI=;
        b=GLfzaGgE4D0M/8iHUt92vz3svl08+GS3kY0pEpvlvhkKDQCv8lD6oexmni6ptgKo1J
         U2igx1tTp7At4/eg9n9FwufXnFrsSJ6jQUY3JJpEgFLcvzCEAQijqVL3ntkFE9CrrCmk
         tfCPdNQmxYWNLyr6CwqRsZh5cPDQgs09NLKBpK2qT8hO10I5mR+HseLZhqReA9q/DjdB
         y98ZbAqez2fk5GfMuKkhkfxrq092/g4ofLzsDDhcEtFuX6ngFi+5PDfHSbfCfgqk/25P
         dY4z6WfMT6JmWA6/8vsf12VihfgoUa3jNAjFXnYydU7Tbx11VctaepPUU4ASNAxnBAGg
         yg0Q==
X-Gm-Message-State: AOAM533YJ3MtTbLMw0XCtzXV9xwThhb3lgO+2jy8BX97VVCCUCIn540t
        RrbmDOE1mulH2NKD0wjpAGjtpFOS1/f+nUhtEb5chW/sRvFEPX1ZwcSSBPRrNCqUutUM3ylhpfX
        EvelTrDanKzrkhJRukPtycdRr
X-Received: by 2002:adf:fc88:: with SMTP id g8mr28007982wrr.334.1635959120480;
        Wed, 03 Nov 2021 10:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/GN+uyyTaWBah9VkZ3ed2+0wkDjTtHrEFLj3fSAJzY+sm3o2ftXmvEq8M9d48axCCrj02dw==
X-Received: by 2002:adf:fc88:: with SMTP id g8mr28007937wrr.334.1635959120235;
        Wed, 03 Nov 2021 10:05:20 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h22sm2900610wmq.14.2021.11.03.10.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:05:19 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v2 2/3] mm/page_alloc: Convert per-cpu lists' local locks to per-cpu spin locks
Date:   Wed,  3 Nov 2021 18:05:11 +0100
Message-Id: <20211103170512.2745765-3-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103170512.2745765-1-nsaenzju@redhat.com>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_alloc's per-cpu page lists are currently protected by local locks.
This forces any remote operation dependent on draining them to schedule
drain work on all CPUs. This doesn't play well with NOHZ_FULL CPUs,
which can't be bothered to run housekeeping tasks.

As a first step to mitigate this, convert the current locking scheme to
per-cpu spinlocks. The conversion also moves the actual lock into
'struct per_cpu_pages' which is nicer code, but also essential in order
to couple access to the lock and lists. One side effect of this is a
more complex free_unref_page_list(), as the patch tries to maintain
previous function optimizations[1]. Other than that the conversion
itself is mostly trivial.

The performance difference between local locks and uncontended per-cpu
spinlocks (which they happen to be during normal operation) is pretty
small.

On an Intel Xeon E5-2640 (x86_64) with with 32GB of memory (mean
variation vs. vanilla runs, higher is worse):
   - netperf: -0.5% to 0.5% (no difference)
   - hackbench: -0.3% to 0.7% (almost no difference)
   - mmtests/sparsetruncate-tiny: -0.1% to 0.6%

On a Cavium ThunderX2 (arm64) with 64GB of memory:
   - netperf 1.0% to 1.7%
   - hackbench 0.8% to 1.5%
   - mmtests/sparsetruncate-tiny 1.6% to 2.1%

arm64 is a bit more sensitive to the change. Probably due to the effect
of the spinlock's memory barriers.

Note that the aim9 test suite was also run (through
mmtests/pagealloc-performance) but the test's own variance distorts the
results too much.

[1] See:
      - 9cca35d42eb61 ("mm, page_alloc: enable/disable IRQs once when
	freeing a list of pages ")
      - c24ad77d962c3 ("mm/page_alloc.c: avoid excessive IRQ disabled
	times in free_unref_page_list()")

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/mmzone.h |  1 +
 mm/page_alloc.c        | 87 ++++++++++++++++++++++--------------------
 2 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..83c51036c756 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -376,6 +376,7 @@ struct per_cpu_pages {
 
 	/* Lists of pages, one per migrate type stored on the pcp-lists */
 	struct list_head lists[NR_PCP_LISTS];
+	spinlock_t lock;
 };
 
 struct per_cpu_zonestat {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ef03dfb8f95..b332d5cc40f1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -122,13 +122,6 @@ typedef int __bitwise fpi_t;
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
 
-struct pagesets {
-	local_lock_t lock;
-};
-static DEFINE_PER_CPU(struct pagesets, pagesets) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
-
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -1505,8 +1498,8 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	pcp->count -= nr_freed;
 
 	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
+	 * spin_lock_irqsave(&pcp->lock) held so equivalent to
+	 * spin_lock_irqsave().
 	 */
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
@@ -3011,8 +3004,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	int i, allocated = 0;
 
 	/*
-	 * local_lock_irq held so equivalent to spin_lock_irqsave for
-	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
+	 * spin_lock_irqsave(&pcp->lock) held so equivalent to
+	 * spin_lock_irqsave().
 	 */
 	spin_lock(&zone->lock);
 	for (i = 0; i < count; ++i) {
@@ -3066,12 +3059,12 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 	unsigned long flags;
 	int to_drain, batch;
 
-	local_lock_irqsave(&pagesets.lock, flags);
+	spin_lock_irqsave(&pcp->lock, flags);
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0)
 		free_pcppages_bulk(zone, to_drain, pcp);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
 }
 #endif
 
@@ -3087,13 +3080,11 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 	unsigned long flags;
 	struct per_cpu_pages *pcp;
 
-	local_lock_irqsave(&pagesets.lock, flags);
-
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+	spin_lock_irqsave(&pcp->lock, flags);
 	if (pcp->count)
 		free_pcppages_bulk(zone, pcp->count, pcp);
-
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
 }
 
 /*
@@ -3355,16 +3346,14 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
-static void free_unref_page_commit(struct page *page, int migratetype,
-				   unsigned int order)
+static void free_unref_page_commit(struct page *page, struct per_cpu_pages *pcp,
+				   int migratetype, unsigned int order)
 {
 	struct zone *zone = page_zone(page);
-	struct per_cpu_pages *pcp;
 	int high;
 	int pindex;
 
 	__count_vm_event(PGFREE);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pindex = order_to_pindex(migratetype, order);
 	list_add(&page->lru, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
@@ -3383,6 +3372,7 @@ void free_unref_page(struct page *page, unsigned int order)
 {
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
+	struct per_cpu_pages *pcp;
 	int migratetype;
 
 	if (!free_unref_page_prepare(page, pfn, order))
@@ -3404,9 +3394,10 @@ void free_unref_page(struct page *page, unsigned int order)
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, migratetype, order);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	pcp = this_cpu_ptr(page_zone(page)->per_cpu_pageset);
+	spin_lock_irqsave(&pcp->lock, flags);
+	free_unref_page_commit(page, pcp, migratetype, order);
+	spin_unlock_irqrestore(&pcp->lock, flags);
 }
 
 /*
@@ -3415,6 +3406,7 @@ void free_unref_page(struct page *page, unsigned int order)
 void free_unref_page_list(struct list_head *list)
 {
 	struct page *page, *next;
+	spinlock_t *lock = NULL;
 	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
@@ -3422,6 +3414,7 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		unsigned long pfn = page_to_pfn(page);
+
 		if (!free_unref_page_prepare(page, pfn, 0)) {
 			list_del(&page->lru);
 			continue;
@@ -3439,8 +3432,22 @@ void free_unref_page_list(struct list_head *list)
 		}
 	}
 
-	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
+		struct per_cpu_pages *pcp = this_cpu_ptr(page_zone(page)->per_cpu_pageset);
+
+		/*
+		 * As an optimization, release the previously held lock only if
+		 * the page belongs to a different zone. But also, guard
+		 * against excessive IRQ disabled times when we get a large
+		 * list of pages to free.
+		 */
+		if (++batch_count == SWAP_CLUSTER_MAX ||
+		    (lock != &pcp->lock && lock)) {
+			spin_unlock_irqrestore(lock, flags);
+			batch_count = 0;
+			lock = NULL;
+		}
+
 		/*
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
@@ -3450,19 +3457,17 @@ void free_unref_page_list(struct list_head *list)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, migratetype, 0);
 
-		/*
-		 * Guard against excessive IRQ disabled times when we get
-		 * a large list of pages to free.
-		 */
-		if (++batch_count == SWAP_CLUSTER_MAX) {
-			local_unlock_irqrestore(&pagesets.lock, flags);
-			batch_count = 0;
-			local_lock_irqsave(&pagesets.lock, flags);
+		if (!lock) {
+			spin_lock_irqsave(&pcp->lock, flags);
+			lock = &pcp->lock;
 		}
+
+		free_unref_page_commit(page, pcp, migratetype, 0);
 	}
-	local_unlock_irqrestore(&pagesets.lock, flags);
+
+	if (lock)
+		spin_unlock_irqrestore(lock, flags);
 }
 
 /*
@@ -3636,18 +3641,17 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	struct page *page;
 	unsigned long flags;
 
-	local_lock_irqsave(&pagesets.lock, flags);
-
 	/*
 	 * On allocation, reduce the number of pages that are batch freed.
 	 * See nr_pcp_free() where free_factor is increased for subsequent
 	 * frees.
 	 */
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	spin_lock_irqsave(&pcp->lock, flags);
 	pcp->free_factor >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
 	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone, 1);
@@ -5265,8 +5269,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		goto failed;
 
 	/* Attempt the batch allocation */
-	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
+	spin_lock_irqsave(&pcp->lock, flags);
 	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 
 	while (nr_populated < nr_pages) {
@@ -5295,7 +5299,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
@@ -5304,7 +5308,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed_irq:
-	local_unlock_irqrestore(&pagesets.lock, flags);
+	spin_unlock_irqrestore(&pcp->lock, flags);
 
 failed:
 	page = __alloc_pages(gfp, 0, preferred_nid, nodemask);
@@ -6947,6 +6951,7 @@ void __meminit setup_zone_pageset(struct zone *zone)
 		struct per_cpu_zonestat *pzstats;
 
 		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
+		spin_lock_init(&pcp->lock);
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 		per_cpu_pages_init(pcp, pzstats);
 	}
-- 
2.33.1

