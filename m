Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56FC38F666
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhEXXn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:50690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229955AbhEXXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aiQwK4df8tDnzTlsaSf3SJq73hoGcFgjjePzs7fO+U=;
        b=ey83G9BNV6qKtgSw0R0jNkLvTroUNyE3N7E1bKKIvmocpOJNRbQ+3dqZIX4xJAxj9p55wP
        1HlK4Y1EekunZyqm+A5faUE9WrbQ0jQb7Vd/WdBNoGp8qVmTe9UVmIDD4E8qkkQhPNF3zH
        2Um327Z92MR4aHvP7+ESzpaCA/dhkGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8aiQwK4df8tDnzTlsaSf3SJq73hoGcFgjjePzs7fO+U=;
        b=2jCoI7PPUmnPfzFHXtsYZhnP1YxE/pHHkdSBx2T/vLmC3QbJykdjwDG1FaFgAhu31yT2Q4
        ylL8iqaRR+c+4dDQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F103AF3E;
        Mon, 24 May 2021 23:40:49 +0000 (UTC)
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
Subject: [RFC 19/26] mm, slub: move irq control into unfreeze_partials()
Date:   Tue, 25 May 2021 01:39:39 +0200
Message-Id: <20210524233946.20352-20-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

unfreeze_partials() can be optimized so that it doesn't need irqs disabled for
the whole time. As the first step, move irq control into the function and
remove it from callers.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 01422c757f9b..446d2d5344c9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2304,9 +2304,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 /*
  * Unfreeze all the cpu partial slabs.
  *
- * This function must be called with interrupts disabled
- * for the cpu using c (or some other guarantee must be there
- * to guarantee no concurrent accesses).
+ * This function must be called with preemption or migration
+ * disabled with c local to the cpu.
  */
 static void unfreeze_partials(struct kmem_cache *s,
 		struct kmem_cache_cpu *c)
@@ -2314,6 +2313,9 @@ static void unfreeze_partials(struct kmem_cache *s,
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct page *page, *discard_page = NULL;
+	unsigned long flags;
+
+	local_irq_save(flags);
 
 	while ((page = slub_percpu_partial(c))) {
 		struct page new;
@@ -2366,6 +2368,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
+
+	local_irq_restore(flags);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
@@ -2393,14 +2397,11 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 			pobjects = oldpage->pobjects;
 			pages = oldpage->pages;
 			if (drain && pobjects > slub_cpu_partial(s)) {
-				unsigned long flags;
 				/*
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
-				local_irq_save(flags);
 				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
-				local_irq_restore(flags);
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
@@ -2417,13 +2418,9 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!= oldpage);
-	if (unlikely(!slub_cpu_partial(s))) {
-		unsigned long flags;
-
-		local_irq_save(flags);
+	if (unlikely(!slub_cpu_partial(s)))
 		unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
-		local_irq_restore(flags);
-	}
+
 	preempt_enable();
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
-- 
2.31.1

