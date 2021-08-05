Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9333E17E5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbhHEPZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:25:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34046 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbhHEPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 907F2223EB;
        Thu,  5 Aug 2021 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=703pcAVh4yrZunpFNxfaazQZ9fpg17fwAncUDGsp8Eg=;
        b=trOYO7aTIl5urXKwt6myAZM9TCepNHSDvhIczvxmJ+MZIY54qe4UTDGPuh9ACJUGn296e2
        hm1D5iI/E2r7p+mn7dKRCdJETwz/vY19J0UnCAnMWHU4NF84HJrFs7c+1wYRpBZKVyahzN
        v/LcMIahUZzWPB0GsR/3enRcDxQnF9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=703pcAVh4yrZunpFNxfaazQZ9fpg17fwAncUDGsp8Eg=;
        b=RrssXubzh7yGM166nIrnmAz4Yw12Y6q7YHk0Vn0L6egrYurJGl+jhFDnWxEo/uoQMP4Hqo
        ADUflzn1gkIoqLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62CB113DA8;
        Thu,  5 Aug 2021 15:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QIOJF6oBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:10 +0000
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
Subject: [PATCH v4 34/35] mm, slub: use migrate_disable() on PREEMPT_RT
Date:   Thu,  5 Aug 2021 17:19:59 +0200
Message-Id: <20210805152000.12817-35-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently use preempt_disable() (directly or via get_cpu_ptr()) to stabilize
the pointer to kmem_cache_cpu. On PREEMPT_RT this would be incompatible with
the list_lock spinlock. We can use migrate_disable() instead, but that
increases overhead on !PREEMPT_RT as it's an unconditional function call.

In order to get the best available mechanism on both PREEMPT_RT and
!PREEMPT_RT, introduce private slub_get_cpu_ptr() and slub_put_cpu_ptr()
wrappers and use them.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c35ad273e3e9..690e762912b7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -118,6 +118,26 @@
  * 			the fast path and disables lockless freelists.
  */
 
+/*
+ * We could simply use migrate_disable()/enable() but as long as it's a
+ * function call even on !PREEMPT_RT, use inline preempt_disable() there.
+ */
+#ifndef CONFIG_PREEMPT_RT
+#define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
+#define slub_put_cpu_ptr(var)	put_cpu_ptr(var)
+#else
+#define slub_get_cpu_ptr(var)		\
+({					\
+	migrate_disable();		\
+	this_cpu_ptr(var);		\
+})
+#define slub_put_cpu_ptr(var)		\
+do {					\
+	(void)(var);			\
+	migrate_enable();		\
+} while (0)
+#endif
+
 #ifdef CONFIG_SLUB_DEBUG
 #ifdef CONFIG_SLUB_DEBUG_ON
 DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
@@ -2806,7 +2826,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (unlikely(!pfmemalloc_match(page, gfpflags)))
 		goto deactivate_slab;
 
-	/* must check again c->page in case IRQ handler changed it */
+	/* must check again c->page in case we got preempted and it changed */
 	local_irq_save(flags);
 	if (unlikely(page != c->page)) {
 		local_irq_restore(flags);
@@ -2865,7 +2885,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		}
 		if (unlikely(!slub_percpu_partial(c))) {
 			local_irq_restore(flags);
-			goto new_objects; /* stolen by an IRQ handler */
+			/* we were preempted and partial list got empty */
+			goto new_objects;
 		}
 
 		page = c->page = slub_percpu_partial(c);
@@ -2881,9 +2902,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (freelist)
 		goto check_new_page;
 
-	put_cpu_ptr(s->cpu_slab);
+	slub_put_cpu_ptr(s->cpu_slab);
 	page = new_slab(s, gfpflags, node);
-	c = get_cpu_ptr(s->cpu_slab);
+	c = slub_get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!page)) {
 		slab_out_of_memory(s, gfpflags, node);
@@ -2966,12 +2987,12 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * cpu before disabling preemption. Need to reload cpu area
 	 * pointer.
 	 */
-	c = get_cpu_ptr(s->cpu_slab);
+	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
 	p = ___slab_alloc(s, gfpflags, node, addr, c);
 #ifdef CONFIG_PREEMPT_COUNT
-	put_cpu_ptr(s->cpu_slab);
+	slub_put_cpu_ptr(s->cpu_slab);
 #endif
 	return p;
 }
@@ -3500,7 +3521,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * IRQs, which protects against PREEMPT and interrupts
 	 * handlers invoking normal fastpath.
 	 */
-	c = get_cpu_ptr(s->cpu_slab);
+	c = slub_get_cpu_ptr(s->cpu_slab);
 	local_irq_disable();
 
 	for (i = 0; i < size; i++) {
@@ -3546,7 +3567,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 	c->tid = next_tid(c->tid);
 	local_irq_enable();
-	put_cpu_ptr(s->cpu_slab);
+	slub_put_cpu_ptr(s->cpu_slab);
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
@@ -3556,7 +3577,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 				slab_want_init_on_alloc(flags, s));
 	return i;
 error:
-	put_cpu_ptr(s->cpu_slab);
+	slub_put_cpu_ptr(s->cpu_slab);
 	slab_post_alloc_hook(s, objcg, flags, i, p, false);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
-- 
2.32.0

