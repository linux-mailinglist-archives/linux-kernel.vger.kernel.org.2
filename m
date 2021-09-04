Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0C400AF8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351345AbhIDKw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:59 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59774 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351156AbhIDKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9A33C226A4;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XE/0hCI6rwhbtBvO72tFM9uB8CSt2ys92o/71rryZBk=;
        b=PtEz2UGr4Djb/xsCe93udugl73qIlWGhRmru3fTkwOzfjxXsTMSE9dfOgnLbsumuGaceU8
        Rx9RNASYFrR2DdVn7hGiWji2SmI5UrZO5/Ub+JXARcvtMNLgPQIhkTOVfQoJmuMQW5opyZ
        5CtkX8+EV2uCNNfrjM7UCKo+jtwvI/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XE/0hCI6rwhbtBvO72tFM9uB8CSt2ys92o/71rryZBk=;
        b=4Gn3x8j3aHoasAPGtOLxyw8Nvn8g/ckUosAMG4sekdf/7r111PtvOneBYJr4J4oL1XANwD
        qo4SS+NcYOR7VvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 73EB11348A;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qDOzG2ZPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:14 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 30/33] mm, slub: make slab_lock() disable irqs with PREEMPT_RT
Date:   Sat,  4 Sep 2021 12:50:00 +0200
Message-Id: <20210904105003.11688-31-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6010; h=from:subject; bh=Lsp+7O6TsrV/GHAU3Qyl7YtJA8GrGQ5Wdum3uta1hBo=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09Rfod8T/qm0pYZbEzcdze/OrZ1rCDVmIUGJ8Bq 4vMeBtqJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPUQAKCRDgIcpz8YmpEN7jB/ 9lNSRssamZZbTPJRVFPuvvKjtgQX7EpPSmiK+tR6QbL1ebwAVU98gXiGSMwBf37kvxnhs4QIMz5Gba kkmBPnMaQcc96CyXnGxTOCsFdiMWPzcceYRWi+CxZI9WGUAQpdCO2p5b5N8ZPjpAPTOuAZ12lJFIjV CPfFwTzVWyTVCyXxHYNGNpgTDBO/DUOCT6O1pU4yQyRXdIjYpwcgrD2gp62GVtEMafqZ2Me9pmsv3F WtGH/mIPlb9LeZ89qHr4x3AgNZIwZV29nuV9G3oRBOTWhvhPlaMAYPUw38ft9YBHa8apFKlqZUV+rr s5W7OE4CJvq+m03BLdOytU7DduL2i2
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to disable irqs around slab_lock() (a bit spinlock) to make it
irq-safe. Most calls to slab_lock() are nested under spin_lock_irqsave() which
doesn't disable irqs on PREEMPT_RT, so add explicit disabling with PREEMPT_RT.
The exception is cmpxchg_double_slab() which already disables irqs, so use a
__slab_[un]lock() variant without irq disable there.

slab_[un]lock() thus needs a flags pointer parameter, which is unused on !RT.
free_debug_processing() now has two flags variables, which looks odd, but only
one is actually used - the one used in spin_lock_irqsave() on !RT and the one
used in slab_lock() on RT.

As a result, __cmpxchg_double_slab() and cmpxchg_double_slab() become
effectively identical on RT, as both will disable irqs, which is necessary on
RT as most callers of this function also rely on irqsaving lock operations.
Thus, assert that irqs are already disabled in __cmpxchg_double_slab() only on
!RT and also change the VM_BUG_ON assertion to the more standard lockdep_assert
one.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 58 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 76e56ce55d21..a04c36e173c0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -359,25 +359,44 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 /*
  * Per slab locking using the pagelock
  */
-static __always_inline void slab_lock(struct page *page)
+static __always_inline void __slab_lock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	bit_spin_lock(PG_locked, &page->flags);
 }
 
-static __always_inline void slab_unlock(struct page *page)
+static __always_inline void __slab_unlock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	__bit_spin_unlock(PG_locked, &page->flags);
 }
 
-/* Interrupts must be disabled (for the fallback code to work right) */
+static __always_inline void slab_lock(struct page *page, unsigned long *flags)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(*flags);
+	__slab_lock(page);
+}
+
+static __always_inline void slab_unlock(struct page *page, unsigned long *flags)
+{
+	__slab_unlock(page);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(*flags);
+}
+
+/*
+ * Interrupts must be disabled (for the fallback code to work right), typically
+ * by an _irqsave() lock variant. Except on PREEMPT_RT where locks are different
+ * so we disable interrupts as part of slab_[un]lock().
+ */
 static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-	VM_BUG_ON(!irqs_disabled());
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		lockdep_assert_irqs_disabled();
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 	if (s->flags & __CMPXCHG_DOUBLE) {
@@ -388,15 +407,18 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
 	} else
 #endif
 	{
-		slab_lock(page);
+		/* init to 0 to prevent spurious warnings */
+		unsigned long flags = 0;
+
+		slab_lock(page, &flags);
 		if (page->freelist == freelist_old &&
 					page->counters == counters_old) {
 			page->freelist = freelist_new;
 			page->counters = counters_new;
-			slab_unlock(page);
+			slab_unlock(page, &flags);
 			return true;
 		}
-		slab_unlock(page);
+		slab_unlock(page, &flags);
 	}
 
 	cpu_relax();
@@ -427,16 +449,16 @@ static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		unsigned long flags;
 
 		local_irq_save(flags);
-		slab_lock(page);
+		__slab_lock(page);
 		if (page->freelist == freelist_old &&
 					page->counters == counters_old) {
 			page->freelist = freelist_new;
 			page->counters = counters_new;
-			slab_unlock(page);
+			__slab_unlock(page);
 			local_irq_restore(flags);
 			return true;
 		}
-		slab_unlock(page);
+		__slab_unlock(page);
 		local_irq_restore(flags);
 	}
 
@@ -1269,11 +1291,11 @@ static noinline int free_debug_processing(
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
 	void *object = head;
 	int cnt = 0;
-	unsigned long flags;
+	unsigned long flags, flags2;
 	int ret = 0;
 
 	spin_lock_irqsave(&n->list_lock, flags);
-	slab_lock(page);
+	slab_lock(page, &flags2);
 
 	if (s->flags & SLAB_CONSISTENCY_CHECKS) {
 		if (!check_slab(s, page))
@@ -1306,7 +1328,7 @@ static noinline int free_debug_processing(
 		slab_err(s, page, "Bulk freelist count(%d) invalid(%d)\n",
 			 bulk_cnt, cnt);
 
-	slab_unlock(page);
+	slab_unlock(page, &flags2);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	if (!ret)
 		slab_fix(s, "Object at 0x%p not freed", object);
@@ -4087,11 +4109,12 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 {
 #ifdef CONFIG_SLUB_DEBUG
 	void *addr = page_address(page);
+	unsigned long flags;
 	unsigned long *map;
 	void *p;
 
 	slab_err(s, page, text, s->name);
-	slab_lock(page);
+	slab_lock(page, &flags);
 
 	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
@@ -4102,7 +4125,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 		}
 	}
 	put_map(map);
-	slab_unlock(page);
+	slab_unlock(page, &flags);
 #endif
 }
 
@@ -4834,8 +4857,9 @@ static void validate_slab(struct kmem_cache *s, struct page *page,
 {
 	void *p;
 	void *addr = page_address(page);
+	unsigned long flags;
 
-	slab_lock(page);
+	slab_lock(page, &flags);
 
 	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
 		goto unlock;
@@ -4850,7 +4874,7 @@ static void validate_slab(struct kmem_cache *s, struct page *page,
 			break;
 	}
 unlock:
-	slab_unlock(page);
+	slab_unlock(page, &flags);
 }
 
 static int validate_slab_node(struct kmem_cache *s,
-- 
2.33.0

