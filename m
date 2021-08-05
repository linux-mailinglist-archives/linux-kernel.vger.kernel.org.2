Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5795D3E17E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbhHEPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:25:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59580 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbhHEPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 019FC2024A;
        Thu,  5 Aug 2021 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VuSTUdo1E4NEd1uMmMdg59v4d3wQ4sTkX2zHUGf1rD0=;
        b=kVKn/PL8GY6zmfu9MY/qj8KKwzwB9ytlJ79Vee4dLguAqFd8ZHldLBfbCNDWH/Dq2MDWCd
        Dr5tqA5HTZhZ9tJxsV86anm94iGpH8oVbVckDuTJa81HGmxxD7xhGhnd4uzB8eMGGWLtEM
        q6cRzVJloaw1Gqe3WCFcoOnRuKvt8DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VuSTUdo1E4NEd1uMmMdg59v4d3wQ4sTkX2zHUGf1rD0=;
        b=WXqqc4slNSKB//zou/jPfSCwVMskWD1gXdI8hj8n9apV3+ts8vL7DfyL3i+TGXwmLwIxuh
        FzChVQ7d4xtBWsCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C6FCF13DAC;
        Thu,  5 Aug 2021 15:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aJT2L6kBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:09 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v4 31/35] mm, slub: optionally save/restore irqs in slab_[un]lock()/
Date:   Thu,  5 Aug 2021 17:19:56 +0200
Message-Id: <20210805152000.12817-32-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PREEMPT_RT we will need to disable irqs for this bit spinlock. As a
preparation, add a flags parameter, and an internal version that takes
additional bool parameter to control irq saving/restoring (the flags
parameter is compile-time unused if the bool is a constant false).

Convert ___cmpxchg_double_slab(), which also comes with the same bool
parameter, to use the internal version.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 52 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9cb58d884c58..9208020f72d5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -359,16 +359,33 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 /*
  * Per slab locking using the pagelock
  */
-static __always_inline void slab_lock(struct page *page)
+static __always_inline void
+__slab_lock(struct page *page, unsigned long *flags, bool disable_irqs)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
+	if (disable_irqs)
+		local_irq_save(*flags);
 	bit_spin_lock(PG_locked, &page->flags);
 }
 
-static __always_inline void slab_unlock(struct page *page)
+static __always_inline void
+__slab_unlock(struct page *page, unsigned long *flags, bool disable_irqs)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	__bit_spin_unlock(PG_locked, &page->flags);
+	if (disable_irqs)
+		local_irq_restore(*flags);
+}
+
+static __always_inline void
+slab_lock(struct page *page, unsigned long *flags)
+{
+	__slab_lock(page, flags, false);
+}
+
+static __always_inline void slab_unlock(struct page *page, unsigned long *flags)
+{
+	__slab_unlock(page, flags, false);
 }
 
 static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
@@ -388,23 +405,18 @@ static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *pag
 	} else
 #endif
 	{
-		unsigned long flags;
+		/* init to 0 to prevent spurious warnings */
+		unsigned long flags = 0;
 
-		if (disable_irqs)
-			local_irq_save(flags);
-		slab_lock(page);
+		__slab_lock(page, &flags, disable_irqs);
 		if (page->freelist == freelist_old &&
 					page->counters == counters_old) {
 			page->freelist = freelist_new;
 			page->counters = counters_new;
-			slab_unlock(page);
-			if (disable_irqs)
-				local_irq_restore(flags);
+			__slab_unlock(page, &flags, disable_irqs);
 			return true;
 		}
-		slab_unlock(page);
-		if (disable_irqs)
-			local_irq_restore(flags);
+		__slab_unlock(page, &flags, disable_irqs);
 	}
 
 	cpu_relax();
@@ -1255,11 +1267,11 @@ static noinline int free_debug_processing(
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
@@ -1292,7 +1304,7 @@ static noinline int free_debug_processing(
 		slab_err(s, page, "Bulk freelist count(%d) invalid(%d)\n",
 			 bulk_cnt, cnt);
 
-	slab_unlock(page);
+	slab_unlock(page, &flags2);
 	spin_unlock_irqrestore(&n->list_lock, flags);
 	if (!ret)
 		slab_fix(s, "Object at 0x%p not freed", object);
@@ -4048,9 +4060,10 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 	void *addr = page_address(page);
 	unsigned long *map;
 	void *p;
+	unsigned long flags;
 
 	slab_err(s, page, text, s->name);
-	slab_lock(page);
+	slab_lock(page, &flags);
 
 	map = get_map(s, page);
 	for_each_object(p, s, addr, page->objects) {
@@ -4061,7 +4074,7 @@ static void list_slab_objects(struct kmem_cache *s, struct page *page,
 		}
 	}
 	put_map(map);
-	slab_unlock(page);
+	slab_unlock(page, &flags);
 #endif
 }
 
@@ -4786,8 +4799,9 @@ static void validate_slab(struct kmem_cache *s, struct page *page,
 {
 	void *p;
 	void *addr = page_address(page);
+	unsigned long flags;
 
-	slab_lock(page);
+	slab_lock(page, &flags);
 
 	if (!check_slab(s, page) || !on_freelist(s, page, NULL))
 		goto unlock;
@@ -4802,7 +4816,7 @@ static void validate_slab(struct kmem_cache *s, struct page *page,
 			break;
 	}
 unlock:
-	slab_unlock(page);
+	slab_unlock(page, &flags);
 }
 
 static int validate_slab_node(struct kmem_cache *s,
-- 
2.32.0

