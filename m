Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3835413708
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbhIUQPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:15:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36121 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234013AbhIUQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632240818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6mnRYMlCMcOKDKQfbrjGHyzvFIZ6fLhADshZ7k2vuLI=;
        b=fIEoRzDHZMIIQEt4fJlSba4m5VLWDQOEWKwJAUGmKecTiiM6YfMh0O1dhmZmBALAkIMzTh
        JONfAoDOCo+7gEIMMuFohLJAYU7PBjgG+OSUWH6iNj8VRVP2H5SNikiJJ9P/Agf2jb04ft
        f7JE6nHSgIqNX4NcH8GMihqwgIY+Ojo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-SaN19H4kP96d3I1k3TaDxQ-1; Tue, 21 Sep 2021 12:13:37 -0400
X-MC-Unique: SaN19H4kP96d3I1k3TaDxQ-1
Received: by mail-wr1-f69.google.com with SMTP id r7-20020a5d6947000000b0015e0f68a63bso9296728wrw.22
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6mnRYMlCMcOKDKQfbrjGHyzvFIZ6fLhADshZ7k2vuLI=;
        b=Osex7SYG10Rq2/tDUMFAx42G+mM4yqGseExygsSJqp5uf34KjD7JnplguCH5qfVkST
         5uFmRlsws/oXaIp5aRkYRjE+QfTm9S4B/wbAsV9Q+BmNolgyg3lgXs1EJ3Qgr6NQMUWN
         m+zWZ+UZZB6ciR3NBjiQBcbCSc2TQuUvUZm5XMBPlb4kVRFAw0q6TmuOVu7NvjbyiLbr
         m3JhMxiTSZRGFTiKw/PlSfeOLx5WRXyGO0yBNZlW9HzZYv5adn9dd6qgTSPAUfcui+ac
         Q6SPAbeNKNRc0hUbYhnU0P0MqJltCIUSmydO6xkhSbnvlYsah06Tq6DVgoVxwuYmB7xK
         LY2g==
X-Gm-Message-State: AOAM5306PNEeTizVwrFjnwdEGdk48qKsVesUyiAW3Z0ralPAEC+GTlWs
        6BdooDS3nwBbTEpGkObxfGhFnPi8tQH2RQv3HCOYdDIsLMA0FPjb6lJpJ95qi5hIetx/WjJgCmm
        OKmo3kwuBwoDjSI5BzNP/93nu
X-Received: by 2002:a1c:c918:: with SMTP id f24mr5518706wmb.61.1632240815846;
        Tue, 21 Sep 2021 09:13:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVoZ7kYejG472I/F9ywvyNwhKIXJJdZ5S1KHl3KZ2v+nsWpdgVQIW8uMFSa48gONQWppIi6Q==
X-Received: by 2002:a1c:c918:: with SMTP id f24mr5518680wmb.61.1632240815623;
        Tue, 21 Sep 2021 09:13:35 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id t1sm19786477wrz.39.2021.09.21.09.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 09:13:35 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, cl@linux.com, peterz@infradead.org,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, bigeasy@linutronix.de,
        anna-maria@linutronix.de, linux-rt-users@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH 2/6] mm/swap: Introduce alternative per-cpu LRU cache locking
Date:   Tue, 21 Sep 2021 18:13:20 +0200
Message-Id: <20210921161323.607817-3-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210921161323.607817-1-nsaenzju@redhat.com>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct lru_pvecs' and 'struct lru_rotate' per-CPU pagevecs are
protected using local locks. While performance savvy, this doesn't
allow for remote access to these structures. CPUs requiring system-wide
LRU cache drains get around this by scheduling drain work on all CPUs.
That said, some select setups like systems with NOHZ_FULL CPUs, aren't
well suited to this, as they can't handle interruptions of any sort.

To mitigate this, introduce an alternative locking scheme using
spinlocks that will permit remotely accessing these per-CPU pagevecs.
It's disabled by default, with no functional change to regular users,
and enabled through the 'remote_pcpu_cache_access' static key. Upcoming
patches will make use of this static key.

The naming of the static key is left vague on purpose as it is planned
to also enable a similar locking setup to access mm/page_alloc.c's
per-cpu page lists remotely.

This is based on previous work by Thomas Gleixner, Anna-Maria Gleixner,
and Sebastian Andrzej Siewior[1].

[1] https://patchwork.kernel.org/project/linux-mm/patch/20190424111208.24459-3-bigeasy@linutronix.de/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/internal.h |   2 +
 mm/swap.c     | 152 +++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 128 insertions(+), 26 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 18256e32a14c..5a2cef7cd394 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -32,6 +32,8 @@
 /* Do not use these with a slab allocator */
 #define GFP_SLAB_BUG_MASK (__GFP_DMA32|__GFP_HIGHMEM|~__GFP_BITS_MASK)
 
+extern struct static_key_false remote_pcpu_cache_access;
+
 void page_writeback_init(void);
 
 static inline void *folio_raw_mapping(struct folio *folio)
diff --git a/mm/swap.c b/mm/swap.c
index e7f9e4018ccf..bcf73bd563a6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -46,13 +46,27 @@
 /* How many pages do we try to swap or page in/out together? */
 int page_cluster;
 
+/*
+ * On some setups, like with nohz_full, CPUs might be too busy to handle
+ * per-cpu drain work, leading to unwarranted interruptions and hangs. This
+ * key, when enabled, allows for remote draining of these per-cpu caches/page
+ * lists at the cost of more constraining locking.
+ */
+__ro_after_init DEFINE_STATIC_KEY_FALSE(remote_pcpu_cache_access);
+
+struct lru_cache_locks {
+	local_lock_t local;
+	spinlock_t spin;
+};
+
 /* Protecting only lru_rotate.pvec which requires disabling interrupts */
 struct lru_rotate {
-	local_lock_t lock;
+	struct lru_cache_locks locks;
 	struct pagevec pvec;
 };
 static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
-	.lock = INIT_LOCAL_LOCK(lock),
+	.locks.local = INIT_LOCAL_LOCK(lru_rotate.locks.local),
+	.locks.spin = __SPIN_LOCK_UNLOCKED(lru_rotate.locks.spin),
 };
 
 /*
@@ -60,7 +74,7 @@ static DEFINE_PER_CPU(struct lru_rotate, lru_rotate) = {
  * by disabling preemption (and interrupts remain enabled).
  */
 struct lru_pvecs {
-	local_lock_t lock;
+	struct lru_cache_locks locks;
 	struct pagevec lru_add;
 	struct pagevec lru_deactivate_file;
 	struct pagevec lru_deactivate;
@@ -70,9 +84,94 @@ struct lru_pvecs {
 #endif
 };
 static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
-	.lock = INIT_LOCAL_LOCK(lock),
+	.locks.local = INIT_LOCAL_LOCK(lru_pvecs.locks.local),
+	.locks.spin = __SPIN_LOCK_UNLOCKED(lru_pvecs.locks.spin),
 };
 
+static inline void lru_cache_lock(struct lru_cache_locks *locks)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		/* Avoid migration between this_cpu_ptr() and spin_lock() */
+		migrate_disable();
+		spin_lock(this_cpu_ptr(&locks->spin));
+	} else {
+		local_lock(&locks->local);
+	}
+}
+
+static inline void lru_cache_lock_irqsave(struct lru_cache_locks *locks,
+					  unsigned long *flagsp)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		/* Avoid migration between this_cpu_ptr() and spin_lock_irqsave() */
+		migrate_disable();
+		spin_lock_irqsave(this_cpu_ptr(&locks->spin), *flagsp);
+	} else {
+		local_lock_irqsave(&locks->local, *flagsp);
+	}
+}
+
+/*
+ * The lru_cache_lock_cpu()/lru_cache_lock_irqsave_cpu() flavor of functions
+ * should only be used from remote CPUs when 'remote_pcpu_cache_access' is
+ * enabled or the target CPU is dead. Otherwise, it can still be called on the
+ * local CPU with migration disabled.
+ */
+static inline void lru_cache_lock_cpu(struct lru_cache_locks *locks, int cpu)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access))
+		spin_lock(per_cpu_ptr(&locks->spin, cpu));
+	else
+		local_lock(&locks->local);
+}
+
+static inline void lru_cache_lock_irqsave_cpu(struct lru_cache_locks *locks,
+					      unsigned long *flagsp, int cpu)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access))
+		spin_lock_irqsave(per_cpu_ptr(&locks->spin, cpu), *flagsp);
+	else
+		local_lock_irqsave(&locks->local, *flagsp);
+}
+
+static inline void lru_cache_unlock(struct lru_cache_locks *locks)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		spin_unlock(this_cpu_ptr(&locks->spin));
+		migrate_enable();
+	} else {
+		local_unlock(&locks->local);
+	}
+}
+
+static inline void lru_cache_unlock_irqrestore(struct lru_cache_locks *locks,
+					       unsigned long flags)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access)) {
+		spin_unlock_irqrestore(this_cpu_ptr(&locks->spin), flags);
+		migrate_enable();
+	} else {
+		local_unlock_irqrestore(&locks->local, flags);
+	}
+}
+
+static inline void lru_cache_unlock_cpu(struct lru_cache_locks *locks, int cpu)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access))
+		spin_unlock(per_cpu_ptr(&locks->spin, cpu));
+	else
+		local_unlock(&locks->local);
+}
+
+static inline void lru_cache_unlock_irqrestore_cpu(struct lru_cache_locks *locks,
+						   unsigned long flags, int cpu)
+{
+	if (static_branch_unlikely(&remote_pcpu_cache_access))
+		spin_unlock_irqrestore(per_cpu_ptr(&locks->spin, cpu), flags);
+	else
+		local_unlock_irqrestore(&locks->local, flags);
+}
+
 /*
  * This path almost never happens for VM activity - pages are normally
  * freed via pagevecs.  But it gets used by networking.
@@ -245,11 +344,11 @@ void folio_rotate_reclaimable(struct folio *folio)
 		unsigned long flags;
 
 		folio_get(folio);
-		local_lock_irqsave(&lru_rotate.lock, flags);
+		lru_cache_lock_irqsave(&lru_rotate.locks, &flags);
 		pvec = this_cpu_ptr(&lru_rotate.pvec);
 		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
-		local_unlock_irqrestore(&lru_rotate.lock, flags);
+		lru_cache_unlock_irqrestore(&lru_rotate.locks, flags);
 	}
 }
 
@@ -341,11 +440,11 @@ static void folio_activate(struct folio *folio)
 		struct pagevec *pvec;
 
 		folio_get(folio);
-		local_lock(&lru_pvecs.lock);
+		lru_cache_lock(&lru_pvecs.locks);
 		pvec = this_cpu_ptr(&lru_pvecs.activate_page);
 		if (pagevec_add_and_need_flush(pvec, &folio->page))
 			pagevec_lru_move_fn(pvec, __activate_page);
-		local_unlock(&lru_pvecs.lock);
+		lru_cache_unlock(&lru_pvecs.locks);
 	}
 }
 
@@ -372,7 +471,7 @@ static void __lru_cache_activate_folio(struct folio *folio)
 	struct pagevec *pvec;
 	int i;
 
-	local_lock(&lru_pvecs.lock);
+	lru_cache_lock(&lru_pvecs.locks);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
 
 	/*
@@ -394,7 +493,7 @@ static void __lru_cache_activate_folio(struct folio *folio)
 		}
 	}
 
-	local_unlock(&lru_pvecs.lock);
+	lru_cache_unlock(&lru_pvecs.locks);
 }
 
 /*
@@ -453,11 +552,11 @@ void folio_add_lru(struct folio *folio)
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
 	folio_get(folio);
-	local_lock(&lru_pvecs.lock);
+	lru_cache_lock(&lru_pvecs.locks);
 	pvec = this_cpu_ptr(&lru_pvecs.lru_add);
 	if (pagevec_add_and_need_flush(pvec, &folio->page))
 		__pagevec_lru_add(pvec);
-	local_unlock(&lru_pvecs.lock);
+	lru_cache_unlock(&lru_pvecs.locks);
 }
 EXPORT_SYMBOL(folio_add_lru);
 
@@ -592,8 +691,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec)
 
 /*
  * Drain pages out of the cpu's pagevecs.
- * Either "cpu" is the current CPU, and preemption has already been
- * disabled; or "cpu" is being hot-unplugged, and is already dead.
+ * Either "cpu" is the current CPU, and preemption has already been disabled,
+ * or we're remotely flushing pvecs with the 'remote_pcpu_cache_access' key
+ * enabled, or "cpu" is being hot-unplugged and is already dead.
  */
 void lru_add_drain_cpu(int cpu)
 {
@@ -608,9 +708,9 @@ void lru_add_drain_cpu(int cpu)
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
-		local_lock_irqsave(&lru_rotate.lock, flags);
+		lru_cache_lock_irqsave_cpu(&lru_rotate.locks, &flags, cpu);
 		pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
-		local_unlock_irqrestore(&lru_rotate.lock, flags);
+		lru_cache_unlock_irqrestore_cpu(&lru_rotate.locks, flags, cpu);
 	}
 
 	pvec = &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
@@ -649,12 +749,12 @@ void deactivate_file_page(struct page *page)
 	if (likely(get_page_unless_zero(page))) {
 		struct pagevec *pvec;
 
-		local_lock(&lru_pvecs.lock);
+		lru_cache_lock(&lru_pvecs.locks);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate_file);
 
 		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
-		local_unlock(&lru_pvecs.lock);
+		lru_cache_unlock(&lru_pvecs.locks);
 	}
 }
 
@@ -671,12 +771,12 @@ void deactivate_page(struct page *page)
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		struct pagevec *pvec;
 
-		local_lock(&lru_pvecs.lock);
+		lru_cache_lock(&lru_pvecs.locks);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_deactivate);
 		get_page(page);
 		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
-		local_unlock(&lru_pvecs.lock);
+		lru_cache_unlock(&lru_pvecs.locks);
 	}
 }
 
@@ -693,28 +793,28 @@ void mark_page_lazyfree(struct page *page)
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		struct pagevec *pvec;
 
-		local_lock(&lru_pvecs.lock);
+		lru_cache_lock(&lru_pvecs.locks);
 		pvec = this_cpu_ptr(&lru_pvecs.lru_lazyfree);
 		get_page(page);
 		if (pagevec_add_and_need_flush(pvec, page))
 			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
-		local_unlock(&lru_pvecs.lock);
+		lru_cache_unlock(&lru_pvecs.locks);
 	}
 }
 
 void lru_add_drain(void)
 {
-	local_lock(&lru_pvecs.lock);
+	lru_cache_lock(&lru_pvecs.locks);
 	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&lru_pvecs.lock);
+	lru_cache_unlock(&lru_pvecs.locks);
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
-	local_lock(&lru_pvecs.lock);
+	lru_cache_lock(&lru_pvecs.locks);
 	lru_add_drain_cpu(smp_processor_id());
 	drain_local_pages(zone);
-	local_unlock(&lru_pvecs.lock);
+	lru_cache_unlock(&lru_pvecs.locks);
 }
 
 #ifdef CONFIG_SMP
-- 
2.31.1

