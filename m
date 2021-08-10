Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DD63E17E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242306AbhHEPZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:25:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34012 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242009AbhHEPUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60597223EA;
        Thu,  5 Aug 2021 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86hWrvq9VzboJf/e/QEFd73JA4qBH9jYWEpfNvZWORw=;
        b=YNvOuVxrTXepid8/3jCzvTfxwQ68cPvuWBEqn0k4e5USka4cDSTIAm/P8J/weqwPI+/MUX
        tLaRCnKxA7YoL84JTnOmoET+kBzBOcUYrrY1ES5NQ/x6gJ/xZqbFfnBz8n8+dxir8YI/n/
        2QPjhj6zkkKJNiRG81IMU3lhQBUJOB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=86hWrvq9VzboJf/e/QEFd73JA4qBH9jYWEpfNvZWORw=;
        b=kC/DLyP4DPZil6WC8jfDmamPD3EAJGgaVAB+ktaWsUnlOwYz1yHKz7ci2mTc/BYfBDAK/t
        9aY0Uhxw/iUuF6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 303C013DAC;
        Thu,  5 Aug 2021 15:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJkoC6oBDGFDdQAAMHmgww
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
Subject: [PATCH v4 33/35] mm, slub: protect put_cpu_partial() with disabled irqs instead of cmpxchg
Date:   Thu,  5 Aug 2021 17:19:58 +0200
Message-Id: <20210805152000.12817-34-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 252421ff1d5f..c35ad273e3e9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2003,7 +2003,12 @@ static inline void *acquire_slab(struct kmem_cache *s,
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
@@ -2437,14 +2442,6 @@ static void unfreeze_partials_cpu(struct kmem_cache *s,
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
@@ -2454,46 +2451,56 @@ static inline void unfreeze_partials_cpu(struct kmem_cache *s,
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

