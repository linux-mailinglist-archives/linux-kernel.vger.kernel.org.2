Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF2238F65D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbhEXXnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhEXXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qht04eLTeiQoPJTWYPrj6z5gpgRHPGm0FIq/WeQ3lBM=;
        b=XryzIbvvRUKjf+49llvhqljrzlS0Nf1A+8iC9SUsvKQuWKiXdUgS/+fbGK7bF3r1ZjbqQF
        +u5IXaXwxVVjzsxwjx13rpcg779YBCfCUe3sNQr7UqO0VwKefICYXiDAY947wsOX1PQlYb
        yq4V5s8/6g05ojGKrcoElSAQR1lSaZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qht04eLTeiQoPJTWYPrj6z5gpgRHPGm0FIq/WeQ3lBM=;
        b=QFYAEJOl6kF8s0PkNLANoeSb8/JJn0BS5eqCPDT3gDLGDKyl+LywqhXlq8Jq1rdQclPZ/N
        LPEpRGxdWQTIl+CA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52FEAAF31;
        Mon, 24 May 2021 23:40:48 +0000 (UTC)
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
Subject: [RFC 11/26] mm, slub: move disabling irqs closer to get_partial() in ___slab_alloc()
Date:   Tue, 25 May 2021 01:39:31 +0200
Message-Id: <20210524233946.20352-12-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue reducing the irq disabled scope. Check for per-cpu partial slabs with
first with irqs enabled and then recheck with irqs disabled before grabbing
the slab page. Mostly preparatory for the following patches.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e243a991b15b..16f3cbb81627 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2653,11 +2653,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		if (unlikely(node != NUMA_NO_NODE &&
 			     !node_isset(node, slab_nodes)))
 			node = NUMA_NO_NODE;
-		local_irq_save(flags);
-		if (unlikely(c->page)) {
-			local_irq_restore(flags);
-			goto reread_page;
-		}
 		goto new_slab;
 	}
 redo:
@@ -2698,6 +2693,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	if (!freelist) {
 		c->page = NULL;
+		local_irq_restore(flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2723,10 +2719,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto reread_page;
 	}
 	deactivate_slab(s, page, c->freelist, c);
+	local_irq_restore(flags);
 
 new_slab:
 
 	if (slub_percpu_partial(c)) {
+		local_irq_save(flags);
+		if (unlikely(c->page)) {
+			local_irq_restore(flags);
+			goto reread_page;
+		}
+		if (unlikely(!slub_percpu_partial(c))) /* stolen by IRQ? */
+			goto new_objects;
+
 		page = c->page = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
 		local_irq_restore(flags);
@@ -2734,6 +2739,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
+	local_irq_save(flags);
+	if (unlikely(c->page)) {
+		local_irq_restore(flags);
+		goto reread_page;
+	}
+
+new_objects:
+
 	freelist = get_partial(s, gfpflags, node, &page);
 	if (freelist) {
 		c->page = page;
@@ -2767,15 +2780,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 check_new_page:
 
 	if (kmem_cache_debug(s)) {
-		if (!alloc_debug_processing(s, page, freelist, addr))
+		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
+			c->page = NULL;
+			local_irq_restore(flags);
 			goto new_slab;
-		else
+		} else {
 			/*
 			 * For debug case, we don't load freelist so that all
 			 * allocations go through alloc_debug_processing()
 			 */
 			goto return_single;
+		}
 	}
 
 	if (unlikely(!pfmemalloc_match(page, gfpflags)))
-- 
2.31.1

