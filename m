Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912193F4CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhHWO7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:59:48 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51654 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhHWO7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C0DAD21FDD;
        Mon, 23 Aug 2021 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2nN2T/V3zUIbnghA57kedbOnA9ySW3XWYu+UKizZX9k=;
        b=QOeKfhHvX0ZYf53c1THOpRPiCCsp0QA8h3O5t+6HOjByGYgsNQHFqjye2OLzWF2Gx46LHz
        zY8N0hS5w31X3Vf25rNt00AKZQH6cPcK5qVK6krkpSd0ZWa1S1IQYEzNbsHzMzRLrpXsiK
        K7UfO+KRMkkvAcHAbCRN1ujTaiLWQv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2nN2T/V3zUIbnghA57kedbOnA9ySW3XWYu+UKizZX9k=;
        b=JpChCY5qn0KXHLZ7sYFJYwaIcr8s507wz44m81fxlO3bPgOL8iAmSxYGhQWU+1ULnB9FH0
        h/EhqjRTU/mRJ4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 962BF13BE0;
        Mon, 23 Aug 2021 14:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6G8QJJ63I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:38 +0000
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
Subject: [PATCH v5 06/35] mm, slub: unify cmpxchg_double_slab() and __cmpxchg_double_slab()
Date:   Mon, 23 Aug 2021 16:57:57 +0200
Message-Id: <20210823145826.3857-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
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
Acked-by: Christoph Lameter <cl@linux.com>
---
 mm/slub.c | 62 +++++++++++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 38 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 79e53303844c..e1c4e934c620 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -371,13 +371,13 @@ static __always_inline void slab_unlock(struct page *page)
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
@@ -388,15 +388,23 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
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
@@ -409,45 +417,23 @@ static inline bool __cmpxchg_double_slab(struct kmem_cache *s, struct page *page
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
2.32.0

