Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D48400AF7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351385AbhIDKw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:57 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41820 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351155AbhIDKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C6A9A2004D;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Te8uYZ+g/t5qV0JLK8bHqgnx8DlM11R3kWw0y9ycTYk=;
        b=Eog5RGIEBmiGtxy2P3+3MSTtgxCgQStcrugqfiFiypaEvd0b9XdSWM3S4ySuUYUVrCdcU+
        C2pNlVF5hJMKLa70q0ntg+ft/rjakJ+8o0cGH6uavGXvEzuwazya8ZISF/1qd84tYsQQN9
        HHf4CROzq+l4cDTeUeHtYXc0wjpgVZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Te8uYZ+g/t5qV0JLK8bHqgnx8DlM11R3kWw0y9ycTYk=;
        b=pvYWWCkmXgbqA2bc8CFKOVuvf5Js4aRrCxP+yA118ltsbGMT9iWtTzcKTXf/Ey0zTkj0rB
        Q85gRLv26/oimVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B3E013A2C;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yOhRJWZPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:14 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: [PATCH v6 31/33] mm, slub: protect put_cpu_partial() with disabled irqs instead of cmpxchg
Date:   Sat,  4 Sep 2021 12:50:01 +0200
Message-Id: <20210904105003.11688-32-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5765; h=from:subject; bh=/N0hY/77wJBPZBZTaB+a9p8PuHcB/NcxRaWhRHbIrQ4=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09Uixe2VzO1GuJZUUveNarHJ3kclwnILIlpYVFB RvlCsaSJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPVAAKCRDgIcpz8YmpEL4qCA CrzDz59cnFzMMhZ/AbWUoDpt5CyxFJ2l111x2IRb4QnzMGy8x4R4QqeS5DKKK6+J2+UQaNU0Lx5e4+ Ft+Oz/y8EWGgbKP/w+GAjsOqN41XAZl6WEidJq4+pCgR1bbADZxe1y2OKpJQD8UpSYEVpRaYNcJ3La XD0g6UER9zHbHI/8mdE1WBMuz4dqDj9YW3s4YhzojEcTuTxX9aHppzHblibdVy8OlRn7xrvz3+SDTL huDP+gfk+3L6zYGOEz6kx56Wm9L6ddOdKIou0VB0K3ynBZEgltMQa2D2H/8Pffa3/lQ54Z18houW0E BIn0U5s9Iz92i5pYdBSTEzOh1FbOQb
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index a04c36e173c0..f4b33d2fddc1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2025,7 +2025,12 @@ static inline void *acquire_slab(struct kmem_cache *s,
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
@@ -2459,14 +2464,6 @@ static void unfreeze_partials_cpu(struct kmem_cache *s,
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
@@ -2476,46 +2473,56 @@ static inline void unfreeze_partials_cpu(struct kmem_cache *s,
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
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
 	unsigned long flags;
-- 
2.33.0

