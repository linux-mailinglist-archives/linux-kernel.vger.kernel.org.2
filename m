Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F03DA7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 17:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbhG2Pmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 11:42:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59642 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhG2Pmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:42:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 74B7120050;
        Thu, 29 Jul 2021 15:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627573351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vW/7+Ky9BhBdG500p9Fw+Cif69i2uqG3unSQSiElBl0=;
        b=f0A/boqjK82oxiRxTKsKR4j5qmwGJ/tuvccWVa4m0PfDSi2RIRMJSniZr8DEtXGpbUuyxC
        3vzmpTM/pRJBXdiMfa3ukbIFdo4F7xQ0ujGbO2meflJ3TI18hxhmvwD7HDlkNS1hC+LiTp
        M6X+3I5EuyEmbtkXU1we0+/Cx+Q3vfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627573351;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vW/7+Ky9BhBdG500p9Fw+Cif69i2uqG3unSQSiElBl0=;
        b=rGIW6DXQCJD5G/mQih2yI2JrDAFlLdjbSfTHHAjaxjljiZcxNQlRjVbwQgVfSif89XoBId
        6p+F+NYPX+W9N6Aw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 4B515136BF;
        Thu, 29 Jul 2021 15:42:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id nRC8EWfMAmHQMgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 15:42:31 +0000
Subject: Re: [PATCH v3 33/35] mm, slub: protect put_cpu_partial() with
 disabled irqs instead of cmpxchg
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210729132132.19691-1-vbabka@suse.cz>
 <20210729132132.19691-34-vbabka@suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2dc3789d-59f7-7a2d-3466-a0bf9f0d3025@suse.cz>
Date:   Thu, 29 Jul 2021 17:42:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729132132.19691-34-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/29/21 3:21 PM, Vlastimil Babka wrote:
> Reported-by: Jann Horn <jannh@google.com>
> Suggested-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Screwed up with the cleanups resulting in memory leak spotted by Sebastian,
fixed version below, thanks.

----8<----
From 180d8ff44285eadc0f309e98afbb61132db34f1c Mon Sep 17 00:00:00 2001
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 28 Jul 2021 12:26:27 +0200
Subject: [PATCH v3 33/35] mm, slub: protect put_cpu_partial() with disabled
 irqs instead of cmpxchg

Jann Horn reported [1] the following theoretically possible race:

  task A: put_cpu_partial() calls preempt_disable()
  task A: oldpage = this_cpu_read(s->cpu_slab->partial)
  interrupt: kfree() reaches unfreeze_partials() and discards the page
  task B (on another CPU): reallocates page as page cache
  task A: reads page->pages and page->pobjects, which are actually
  halves of the pointer page->lru.prev
  task B (on another CPU): frees page
  interrupt: allocates page as SLUB page and places it on the percpu partial list
  task A: this_cpu_cmpxchg() succeeds

  which would cause page->pages and page->pobjects to end up containing
  halves of pointers that would then influence when put_cpu_partial()
  happens and show up in root-only sysfs files. Maybe that's acceptable,
  I don't know. But there should probably at least be a comment for now
  to point out that we're reading union fields of a page that might be
  in a completely different state.

Additionally, the this_cpu_cmpxchg() approach in put_cpu_partial() is only safe
against s->cpu_slab->partial manipulation in ___slab_alloc() if the latter
disables irqs, otherwise a __slab_free() in an irq handler could call
put_cpu_partial() in the middle of ___slab_alloc() manipulating ->partial
and corrupt it. This becomes an issue on RT after a local_lock is introduced
in later patch. The fix means taking the local_lock also in put_cpu_partial()
on RT.

After debugging this issue, Mike Galbraith suggested [2] that to avoid
different locking schemes on RT and !RT, we can just protect put_cpu_partial()
with disabled irqs (to be converted to local_lock_irqsave() later) everywhere.
This should be acceptable as it's not a fast path, and moving the actual
partial unfreezing outside of the irq disabled section makes it short, and with
the retry loop gone the code can be also simplified. In addition, the race
reported by Jann should no longer be possible.

[1] https://lore.kernel.org/lkml/CAG48ez1mvUuXwg0YPH5ANzhQLpbphqk-ZS+jbRz+H66fvm4FcA@mail.gmail.com/
[2] https://lore.kernel.org/linux-rt-users/e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de/

Reported-by: Jann Horn <jannh@google.com>
Suggested-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 81 ++++++++++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 37 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4f7218797603..e33a83e07c15 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2002,7 +2002,12 @@ static inline void *acquire_slab(struct kmem_cache *s,
 	return freelist;
 }
 
+#ifdef CONFIG_SLUB_CPU_PARTIAL
 static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain);
+#else
+static inline void put_cpu_partial(struct kmem_cache *s, struct page *page,
+				   int drain) { }
+#endif
 static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
 
 /*
@@ -2436,14 +2441,6 @@ static void unfreeze_partials_cpu(struct kmem_cache *s,
 		__unfreeze_partials(s, partial_page);
 }
 
-#else	/* CONFIG_SLUB_CPU_PARTIAL */
-
-static inline void unfreeze_partials(struct kmem_cache *s) { }
-static inline void unfreeze_partials_cpu(struct kmem_cache *s,
-				  struct kmem_cache_cpu *c) { }
-
-#endif	/* CONFIG_SLUB_CPU_PARTIAL */
-
 /*
  * Put a page that was just frozen (in __slab_free|get_partial_node) into a
  * partial page slot if available.
@@ -2453,46 +2450,56 @@ static inline void unfreeze_partials_cpu(struct kmem_cache *s,
  */
 static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 {
-#ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct page *oldpage;
-	int pages;
-	int pobjects;
+	struct page *page_to_unfreeze = NULL;
+	unsigned long flags;
+	int pages = 0;
+	int pobjects = 0;
 
-	preempt_disable();
-	do {
-		pages = 0;
-		pobjects = 0;
-		oldpage = this_cpu_read(s->cpu_slab->partial);
+	local_irq_save(flags);
+
+	oldpage = this_cpu_read(s->cpu_slab->partial);
 
-		if (oldpage) {
+	if (oldpage) {
+		if (drain && oldpage->pobjects > slub_cpu_partial(s)) {
+			/*
+			 * Partial array is full. Move the existing set to the
+			 * per node partial list. Postpone the actual unfreezing
+			 * outside of the critical section.
+			 */
+			page_to_unfreeze = oldpage;
+			oldpage = NULL;
+		} else {
 			pobjects = oldpage->pobjects;
 			pages = oldpage->pages;
-			if (drain && pobjects > slub_cpu_partial(s)) {
-				/*
-				 * partial array is full. Move the existing
-				 * set to the per node partial list.
-				 */
-				unfreeze_partials(s);
-				oldpage = NULL;
-				pobjects = 0;
-				pages = 0;
-				stat(s, CPU_PARTIAL_DRAIN);
-			}
 		}
+	}
 
-		pages++;
-		pobjects += page->objects - page->inuse;
+	pages++;
+	pobjects += page->objects - page->inuse;
 
-		page->pages = pages;
-		page->pobjects = pobjects;
-		page->next = oldpage;
+	page->pages = pages;
+	page->pobjects = pobjects;
+	page->next = oldpage;
 
-	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
-								!= oldpage);
-	preempt_enable();
-#endif	/* CONFIG_SLUB_CPU_PARTIAL */
+	this_cpu_write(s->cpu_slab->partial, page);
+
+	local_irq_restore(flags);
+
+	if (page_to_unfreeze) {
+		__unfreeze_partials(s, page_to_unfreeze);
+		stat(s, CPU_PARTIAL_DRAIN);
+	}
 }
 
+#else	/* CONFIG_SLUB_CPU_PARTIAL */
+
+static inline void unfreeze_partials(struct kmem_cache *s) { }
+static inline void unfreeze_partials_cpu(struct kmem_cache *s,
+				  struct kmem_cache_cpu *c) { }
+
+#endif	/* CONFIG_SLUB_CPU_PARTIAL */
+
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
 			      bool lock)
 {
-- 
2.32.0

