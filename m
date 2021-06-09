Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EB63A12EF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239236AbhFILlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46826 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbhFILl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:28 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AEEC61FD5E;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je5OLYb88ZghiDt2tfqoGBAzw5mIHL6ZuL1ieKZAWls=;
        b=SP7R3Wdq+ca70GBPjuBb5lOmMYbVxAmtP/2BMfEnst17ZsSwG1e6u3JFIDQ4Jd76B3lJ9n
        6c4Sq/RhqmA0sjuYKrOOt9lr3vohntoTLh3FMT/hcjBJLV/JamglaPGSlnGxD29E2EReyE
        eLX3CbnpmrTD5XGXo0Ethhfyz6shU30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je5OLYb88ZghiDt2tfqoGBAzw5mIHL6ZuL1ieKZAWls=;
        b=Fkqzad5/LFNHgBBJdrbJ+r7Y7W6sT9R9QS2oZCag5ntHmNxFpWdJ6ZeYV3M+1WwBwU3c2a
        ooqF1TGx9uDvWBAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 7CCD6118DD;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je5OLYb88ZghiDt2tfqoGBAzw5mIHL6ZuL1ieKZAWls=;
        b=SP7R3Wdq+ca70GBPjuBb5lOmMYbVxAmtP/2BMfEnst17ZsSwG1e6u3JFIDQ4Jd76B3lJ9n
        6c4Sq/RhqmA0sjuYKrOOt9lr3vohntoTLh3FMT/hcjBJLV/JamglaPGSlnGxD29E2EReyE
        eLX3CbnpmrTD5XGXo0Ethhfyz6shU30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=je5OLYb88ZghiDt2tfqoGBAzw5mIHL6ZuL1ieKZAWls=;
        b=Fkqzad5/LFNHgBBJdrbJ+r7Y7W6sT9R9QS2oZCag5ntHmNxFpWdJ6ZeYV3M+1WwBwU3c2a
        ooqF1TGx9uDvWBAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id kCH+HXSowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:32 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC v2 06/34] mm, slub: unify cmpxchg_double_slab() and __cmpxchg_double_slab()
Date:   Wed,  9 Jun 2021 13:38:35 +0200
Message-Id: <20210609113903.1421-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions differ only in irq disabling in the slow path. We can create a
common function with an extra bool parameter to control the irq disabling.
As the functions are inline and the parameter compile-time constant, there
will be no runtime overhead due to this change.

Also change the DEBUG_VM based irqs disable assert to the more standard
lockdep_assert based one.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 62 +++++++++++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f740598696b4..76af5065baeb 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -365,13 +365,13 @@ static __always_inline void slab_unlock(struct page *page)
 	__bit_spin_unlock(PG_locked, &page->flags);
 }
 
-/* Interrupts must be disabled (for the fallback code to work right) */
-static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
+static inline bool ___cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
-		const char *n)
+		const char *n, bool disable_irqs)
 {
-	VM_BUG_ON(!irqs_disabled());
+	if (!disable_irqs)
+		lockdep_assert_irqs_disabled();
 #if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
     defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
 	if (s->flags & __CMPXCHG_DOUBLE) {
@@ -382,15 +382,23 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
 	} else
 #endif
 	{
+		unsigned long flags;
+
+		if (disable_irqs)
+			local_irq_save(flags);
 		slab_lock(page);
 		if (page->freelist == freelist_old &&
 					page->counters == counters_old) {
 			page->freelist = freelist_new;
 			page->counters = counters_new;
 			slab_unlock(page);
+			if (disable_irqs)
+				local_irq_restore(flags);
 			return true;
 		}
 		slab_unlock(page);
+		if (disable_irqs)
+			local_irq_restore(flags);
 	}
 
 	cpu_relax();
@@ -403,45 +411,23 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
 	return false;
 }
 
-static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
+/* Interrupts must be disabled (for the fallback code to work right) */
+static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
 		void *freelist_old, unsigned long counters_old,
 		void *freelist_new, unsigned long counters_new,
 		const char *n)
 {
-#if defined(CONFIG_HAVE_CMPXCHG_DOUBLE) && \
-    defined(CONFIG_HAVE_ALIGNED_STRUCT_PAGE)
-	if (s->flags & __CMPXCHG_DOUBLE) {
-		if (cmpxchg_double(&page->freelist, &page->counters,
-				   freelist_old, counters_old,
-				   freelist_new, counters_new))
-			return true;
-	} else
-#endif
-	{
-		unsigned long flags;
-
-		local_irq_save(flags);
-		slab_lock(page);
-		if (page->freelist == freelist_old &&
-					page->counters == counters_old) {
-			page->freelist = freelist_new;
-			page->counters = counters_new;
-			slab_unlock(page);
-			local_irq_restore(flags);
-			return true;
-		}
-		slab_unlock(page);
-		local_irq_restore(flags);
-	}
-
-	cpu_relax();
-	stat(s, CMPXCHG_DOUBLE_FAIL);
-
-#ifdef SLUB_DEBUG_CMPXCHG
-	pr_info("%s %s: cmpxchg double redo ", n, s->name);
-#endif
+	return ___cmpxchg_double_slab(s, page, freelist_old, counters_old,
+				      freelist_new, counters_new, n, false);
+}
 
-	return false;
+static inline bool cmpxchg_double_slab(struct kmem_cache *s, struct page *page,
+		void *freelist_old, unsigned long counters_old,
+		void *freelist_new, unsigned long counters_new,
+		const char *n)
+{
+	return ___cmpxchg_double_slab(s, page, freelist_old, counters_old,
+				      freelist_new, counters_new, n, true);
 }
 
 #ifdef CONFIG_SLUB_DEBUG
-- 
2.31.1

