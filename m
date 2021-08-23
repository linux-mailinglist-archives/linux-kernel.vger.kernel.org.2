Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C6D3F4CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhHWPAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:00:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51766 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhHWO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1BE6121FE6;
        Mon, 23 Aug 2021 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QyECwTCvzCUitO+ZNBoSYuyIQpyTGNLpMFm4Xk/n4gQ=;
        b=kCJ7zk9Q5mg/QDo6HusRYFbITcVG+Cvg+qdhsLhkME1OWY5zlcld+n/JIFRsaq7j//3QuK
        orQNpcqI17JVtzbN07/Pwg7iUauJIHTSKhG1XMj/RlJMW3l4GvAoKiDkKigyK0ZQHZboZX
        yBJDL+hdNUBF7uqAjiY0QhIBKQlKWqU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QyECwTCvzCUitO+ZNBoSYuyIQpyTGNLpMFm4Xk/n4gQ=;
        b=I+0oJx5Z9Djzzz5dME4NLkXj8GFAzkz83y14SqSq9iAZIQRQoNCRzK1GW5X86TjEfx4uWv
        vdc31KPNEUh/x1AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD7EB13BE1;
        Mon, 23 Aug 2021 14:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YPiiMZ+3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:39 +0000
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
Subject: [PATCH v5 13/35] mm, slub: do initial checks in ___slab_alloc() with irqs enabled
Date:   Mon, 23 Aug 2021 16:58:04 +0200
Message-Id: <20210823145826.3857-14-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As another step of shortening irq disabled sections in ___slab_alloc(), delay
disabling irqs until we pass the initial checks if there is a cached percpu
slab and it's suitable for our allocation.

Now we have to recheck c->page after actually disabling irqs as an allocation
in irq handler might have replaced it.

Because we call pfmemalloc_match() as one of the checks, we might hit
VM_BUG_ON_PAGE(!PageSlab(page)) in PageSlabPfmemalloc in case we get
interrupted and the page is freed. Thus introduce a pfmemalloc_match_unsafe()
variant that lacks the PageSlab check.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/page-flags.h |  9 +++++++
 mm/slub.c                  | 54 +++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6..7fda4fb85bdc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -815,6 +815,15 @@ static inline int PageSlabPfmemalloc(struct page *page)
 	return PageActive(page);
 }
 
+/*
+ * A version of PageSlabPfmemalloc() for opportunistic checks where the page
+ * might have been freed under us and not be a PageSlab anymore.
+ */
+static inline int __PageSlabPfmemalloc(struct page *page)
+{
+	return PageActive(page);
+}
+
 static inline void SetPageSlabPfmemalloc(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageSlab(page), page);
diff --git a/mm/slub.c b/mm/slub.c
index 31f946e03823..fcc38638c645 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2606,6 +2606,19 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
 	return true;
 }
 
+/*
+ * A variant of pfmemalloc_match() that tests page flags without asserting
+ * PageSlab. Intended for opportunistic checks before taking a lock and
+ * rechecking that nobody else freed the page under us.
+ */
+static inline bool pfmemalloc_match_unsafe(struct page *page, gfp_t gfpflags)
+{
+	if (unlikely(__PageSlabPfmemalloc(page)))
+		return gfp_pfmemalloc_allowed(gfpflags);
+
+	return true;
+}
+
 /*
  * Check the page->freelist of a page and either transfer the freelist to the
  * per cpu freelist or deactivate the page.
@@ -2668,8 +2681,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	stat(s, ALLOC_SLOWPATH);
 
-	local_irq_save(flags);
-	page = c->page;
+reread_page:
+
+	page = READ_ONCE(c->page);
 	if (!page) {
 		/*
 		 * if the node is not online or has no normal memory, just
@@ -2678,6 +2692,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		if (unlikely(node != NUMA_NO_NODE &&
 			     !node_isset(node, slab_nodes)))
 			node = NUMA_NO_NODE;
+		local_irq_save(flags);
+		if (unlikely(c->page)) {
+			local_irq_restore(flags);
+			goto reread_page;
+		}
 		goto new_slab;
 	}
 redo:
@@ -2692,8 +2711,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto redo;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
-			deactivate_slab(s, page, c->freelist, c);
-			goto new_slab;
+			goto deactivate_slab;
 		}
 	}
 
@@ -2702,12 +2720,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(page, gfpflags))) {
-		deactivate_slab(s, page, c->freelist, c);
-		goto new_slab;
-	}
+	if (unlikely(!pfmemalloc_match_unsafe(page, gfpflags)))
+		goto deactivate_slab;
 
-	/* must check again c->freelist in case of cpu migration or IRQ */
+	/* must check again c->page in case IRQ handler changed it */
+	local_irq_save(flags);
+	if (unlikely(page != c->page)) {
+		local_irq_restore(flags);
+		goto reread_page;
+	}
 	freelist = c->freelist;
 	if (freelist)
 		goto load_freelist;
@@ -2723,6 +2744,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_REFILL);
 
 load_freelist:
+
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * freelist is pointing to the list of objects to be used.
 	 * page is pointing to the page from which the objects are obtained.
@@ -2734,11 +2758,23 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	local_irq_restore(flags);
 	return freelist;
 
+deactivate_slab:
+
+	local_irq_save(flags);
+	if (page != c->page) {
+		local_irq_restore(flags);
+		goto reread_page;
+	}
+	deactivate_slab(s, page, c->freelist, c);
+
 new_slab:
 
+	lockdep_assert_irqs_disabled();
+
 	if (slub_percpu_partial(c)) {
 		page = c->page = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
+		local_irq_restore(flags);
 		stat(s, CPU_PARTIAL_ALLOC);
 		goto redo;
 	}
-- 
2.32.0

