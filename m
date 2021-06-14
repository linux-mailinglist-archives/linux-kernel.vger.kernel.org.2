Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8BC3A6434
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbhFNLVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 07:21:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59164 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235185AbhFNLJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 07:09:18 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A889421976;
        Mon, 14 Jun 2021 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623668834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5mfqtWi1SWh7XqBauc489hxPzpEgPr8+VSbUtgr/fc=;
        b=ubc7v5HUMVBdCmBjizOvGgbVgnb/M4vLsZ2WsBfCilr3ccAvZSiSPRheuXAGHpuEPmMNkt
        iinUYAOU6ykYA5Q1V/JVrg8ib3A2667EjNQT3FsxKK6ElPosQMtQ//oY3KqNIOGttxq54w
        EInNP6Tcdgdg4e68n5sQ6gwRCc240nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623668834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5mfqtWi1SWh7XqBauc489hxPzpEgPr8+VSbUtgr/fc=;
        b=20JgQTItE5fW94MmKJmExmm6tq2IRQPsEJQJOLaLyrNT0L/PVJYhQtINN5BMfoCYFOHoV0
        jg0yuvcr515sPCCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 82C74118DD;
        Mon, 14 Jun 2021 11:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623668834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5mfqtWi1SWh7XqBauc489hxPzpEgPr8+VSbUtgr/fc=;
        b=ubc7v5HUMVBdCmBjizOvGgbVgnb/M4vLsZ2WsBfCilr3ccAvZSiSPRheuXAGHpuEPmMNkt
        iinUYAOU6ykYA5Q1V/JVrg8ib3A2667EjNQT3FsxKK6ElPosQMtQ//oY3KqNIOGttxq54w
        EInNP6Tcdgdg4e68n5sQ6gwRCc240nk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623668834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5mfqtWi1SWh7XqBauc489hxPzpEgPr8+VSbUtgr/fc=;
        b=20JgQTItE5fW94MmKJmExmm6tq2IRQPsEJQJOLaLyrNT0L/PVJYhQtINN5BMfoCYFOHoV0
        jg0yuvcr515sPCCQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id bopqH2I4x2ASBgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Mon, 14 Jun 2021 11:07:14 +0000
Subject: Re: [RFC v2 33/34] mm, slub: use migrate_disable() on PREEMPT_RT
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
        Jann Horn <jannh@google.com>
References: <20210609113903.1421-1-vbabka@suse.cz>
 <20210609113903.1421-34-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c553c26f-1f9c-e5ab-b71b-b2b5eeb59ad2@suse.cz>
Date:   Mon, 14 Jun 2021 13:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210609113903.1421-34-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/21 1:39 PM, Vlastimil Babka wrote:
> We currently use preempt_disable() (directly or via get_cpu_ptr()) to stabilize
> the pointer to kmem_cache_cpu. On PREEMPT_RT this would be incompatible with
> the list_lock spinlock. We can use migrate_disable() instead, but that
> increases overhead on !PREEMPT_RT as it's an unconditional function call even
> though it's ultimately a migrate_disable() there.
> 
> In order to get the best available mechanism on both PREEMPT_RT and
> !PREEMPT_RT, introduce private slub_get_cpu_ptr() and slub_put_cpu_ptr()
> wrappers and use them.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slub.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 12e966f07f19..caa206213e72 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -115,6 +115,26 @@
>   * 			the fast path and disables lockless freelists.
>   */
>  
> +/*
> + * We could simply use migrate_disable()/enable() but as long as it's a
> + * function call even on !PREEMPT_RT, use inline preempt_disable() there.
> + */
> +#ifdef CONFIG_PREEMPT_RT
> +#define slub_get_cpu_ptr(var)	get_cpu_ptr(var)
> +#define slub_put_cpu_ptr(var)	put_cpu_ptr(var)

After Mel's report and bisect pointing to this patch, I realized I got the
#ifdef wrong and it should be #ifnded

Fixed patch follows:

----8<----
From e79e166414b8c22e3bcf73a9383bafe802fa64d2 Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 21 May 2021 14:03:23 +0200
Subject: [PATCH] mm, slub: use migrate_disable() on PREEMPT_RT

We currently use preempt_disable() (directly or via get_cpu_ptr()) to stabilize
the pointer to kmem_cache_cpu. On PREEMPT_RT this would be incompatible with
the list_lock spinlock. We can use migrate_disable() instead, but that
increases overhead on !PREEMPT_RT as it's an unconditional function call even
though it's ultimately a migrate_disable() there.

In order to get the best available mechanism on both PREEMPT_RT and
!PREEMPT_RT, introduce private slub_get_cpu_ptr() and slub_put_cpu_ptr()
wrappers and use them.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 12e966f07f19..f0359b0c8154 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -115,6 +115,26 @@
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
@@ -2419,7 +2439,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	int pages;
 	int pobjects;
 
-	preempt_disable();
+	slub_get_cpu_ptr(s->cpu_slab);
 	do {
 		pages = 0;
 		pobjects = 0;
@@ -2450,7 +2470,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!= oldpage);
-	preempt_enable();
+	slub_put_cpu_ptr(s->cpu_slab);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
@@ -2759,7 +2779,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (unlikely(!pfmemalloc_match(page, gfpflags)))
 		goto deactivate_slab;
 
-	/* must check again c->page in case IRQ handler changed it */
+	/* must check again c->page in case we got preempted and it changed */
 	local_irq_save(flags);
 	if (unlikely(page != c->page)) {
 		local_irq_restore(flags);
@@ -2818,7 +2838,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		}
 		if (unlikely(!slub_percpu_partial(c))) {
 			local_irq_restore(flags);
-			goto new_objects; /* stolen by an IRQ handler */
+			/* we were preempted and partial list got empty */
+			goto new_objects;
 		}
 
 		page = c->page = slub_percpu_partial(c);
@@ -2834,9 +2855,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (freelist)
 		goto check_new_page;
 
-	put_cpu_ptr(s->cpu_slab);
+	slub_put_cpu_ptr(s->cpu_slab);
 	page = new_slab(s, gfpflags, node);
-	c = get_cpu_ptr(s->cpu_slab);
+	c = slub_get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!page)) {
 		slab_out_of_memory(s, gfpflags, node);
@@ -2919,12 +2940,12 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * cpu before disabling preemption. Need to reload cpu area
 	 * pointer.
 	 */
-	c = get_cpu_ptr(s->cpu_slab);
+	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
 
 	p = ___slab_alloc(s, gfpflags, node, addr, c);
 #ifdef CONFIG_PREEMPTION
-	put_cpu_ptr(s->cpu_slab);
+	slub_put_cpu_ptr(s->cpu_slab);
 #endif
 	return p;
 }
@@ -3445,7 +3466,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	 * IRQs, which protects against PREEMPT and interrupts
 	 * handlers invoking normal fastpath.
 	 */
-	c = get_cpu_ptr(s->cpu_slab);
+	c = slub_get_cpu_ptr(s->cpu_slab);
 	local_irq_disable();
 
 	for (i = 0; i < size; i++) {
@@ -3491,7 +3512,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	}
 	c->tid = next_tid(c->tid);
 	local_irq_enable();
-	put_cpu_ptr(s->cpu_slab);
+	slub_put_cpu_ptr(s->cpu_slab);
 
 	/*
 	 * memcg and kmem_cache debug support and memory initialization.
-- 
2.32.0

