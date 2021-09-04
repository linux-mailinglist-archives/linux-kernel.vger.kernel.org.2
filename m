Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5A400AF0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351282AbhIDKwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41836 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351132AbhIDKvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 94D032004A;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abyIByKdr3jrMEwCHmXJJwxp+t8UFYqcqerjvpQAudQ=;
        b=hjDEJu706Z3zL4h7X+uuZhnXecjfG56QyJpoU5FCaLIjGdbwamSXZrVYFRyQaIJ/8K4Tz+
        1hu2EdrYA72mlE9c8ph/xVo1aRahhxV6u9o7N2Paoot4zQw0ud2BsuRVTw+g3sfebStera
        2LFFwiAXF0sdot1EXhe8+RRQ3dv5+CQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752613;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abyIByKdr3jrMEwCHmXJJwxp+t8UFYqcqerjvpQAudQ=;
        b=+Fl0ZzuMfbBqeubJ7vnCnLldMfadDslvnTFDX2HRKHLWCAj0EdRe47xWdr3YzRGtfSDw+Z
        40NvS4+/2VDkbACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E3B31348A;
        Sat,  4 Sep 2021 10:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wGRIGmVPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:13 +0000
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 24/33] mm, slub: separate detaching of partial list in unfreeze_partials() from unfreezing
Date:   Sat,  4 Sep 2021 12:49:54 +0200
Message-Id: <20210904105003.11688-25-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4726; h=from:subject; bh=m8KqMyogJ2MTsJFq0oIHrHMFniLHH3wuxsPb1iL4MZY=; b=owGbwMvMwMH4QPFU8cfOlQKMp9WSGBKN/Z02nszbcjqlQ2Qmg0XSLa3L249d+P9RuDJTqeXm5gv/ GITDOxmNWRgYORhkxRRZer0nM640fSyxzyPuDMwgViaQKQxcnAIwkZs7ORjW5yc65Gww05jEN4eznH uh4IcjSZu5ujYsSlTWM/K976QS06Pz9Jxq09cytaL9HFbOe11yfib97Frw9WzYnu4nOT7rbjopP2Ox kXsa7cwoY+8mfPtZnYyoXPZi7gs9Ku/LUr/4WYbJCscf25EjecMid86f8zNPXFFdvNDfqCbVW+iztG T4lDKXLNv4lT9mh5hczWS75fHfxvhUKvMxlxvR/ekMfd/CS100og4fXmPe+CMwrlTCYOVaNa4A3XdH e61k5ZpFHm/RevlEKy+m6FhaSMeGS4yxOYHr75nXs2wUsDri6fNaJbBK+Khc1U6df6+vlz6L/yYR96 bug1LgbeG5HrsdNyvWHMl9c0IJAA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unfreezing partial list can be split to two phases - detaching the list from
struct kmem_cache_cpu, and processing the list. The whole operation does not
need to be protected by disabled irqs. Restructure the code to separate the
detaching (with disabled irqs) and unfreezing (with irq disabling to be reduced
in the next patch).

Also, unfreeze_partials() can be called from another cpu on behalf of a cpu
that is being offlined, where disabling irqs on the local cpu has no sense, so
restructure the code as follows:

- __unfreeze_partials() is the bulk of unfreeze_partials() that processes the
  detached percpu partial list
- unfreeze_partials() detaches list from current cpu with irqs disabled and
  calls __unfreeze_partials()
- unfreeze_partials_cpu() is to be called for the offlined cpu so it needs no
  irq disabling, and is called from __flush_cpu_slab()
- flush_cpu_slab() is for the local cpu thus it needs to call
  unfreeze_partials(). So it can't simply call
  __flush_cpu_slab(smp_processor_id()) anymore and we have to open-code the
  proper calls.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 73 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b31e00eb9561..9b46d9b9c879 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2347,25 +2347,15 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	}
 }
 
-/*
- * Unfreeze all the cpu partial slabs.
- *
- * This function must be called with preemption or migration
- * disabled with c local to the cpu.
- */
-static void unfreeze_partials(struct kmem_cache *s,
-		struct kmem_cache_cpu *c)
-{
 #ifdef CONFIG_SLUB_CPU_PARTIAL
+static void __unfreeze_partials(struct kmem_cache *s, struct page *partial_page)
+{
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
-	struct page *page, *partial_page, *discard_page = NULL;
+	struct page *page, *discard_page = NULL;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
-	partial_page = slub_percpu_partial(c);
-	c->partial = NULL;
-
 	while (partial_page) {
 		struct page new;
 		struct page old;
@@ -2420,10 +2410,45 @@ static void unfreeze_partials(struct kmem_cache *s,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
+}
 
-#endif	/* CONFIG_SLUB_CPU_PARTIAL */
+/*
+ * Unfreeze all the cpu partial slabs.
+ */
+static void unfreeze_partials(struct kmem_cache *s)
+{
+	struct page *partial_page;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	partial_page = this_cpu_read(s->cpu_slab->partial);
+	this_cpu_write(s->cpu_slab->partial, NULL);
+	local_irq_restore(flags);
+
+	if (partial_page)
+		__unfreeze_partials(s, partial_page);
 }
 
+static void unfreeze_partials_cpu(struct kmem_cache *s,
+				  struct kmem_cache_cpu *c)
+{
+	struct page *partial_page;
+
+	partial_page = slub_percpu_partial(c);
+	c->partial = NULL;
+
+	if (partial_page)
+		__unfreeze_partials(s, partial_page);
+}
+
+#else	/* CONFIG_SLUB_CPU_PARTIAL */
+
+static inline void unfreeze_partials(struct kmem_cache *s) { }
+static inline void unfreeze_partials_cpu(struct kmem_cache *s,
+				  struct kmem_cache_cpu *c) { }
+
+#endif	/* CONFIG_SLUB_CPU_PARTIAL */
+
 /*
  * Put a page that was just frozen (in __slab_free|get_partial_node) into a
  * partial page slot if available.
@@ -2452,7 +2477,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 				 * partial array is full. Move the existing
 				 * set to the per node partial list.
 				 */
-				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
+				unfreeze_partials(s);
 				oldpage = NULL;
 				pobjects = 0;
 				pages = 0;
@@ -2487,11 +2512,6 @@ static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 	stat(s, CPUSLAB_FLUSH);
 }
 
-/*
- * Flush cpu slab.
- *
- * Called from IPI handler with interrupts disabled.
- */
 static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
@@ -2499,14 +2519,23 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	if (c->page)
 		flush_slab(s, c);
 
-	unfreeze_partials(s, c);
+	unfreeze_partials_cpu(s, c);
 }
 
+/*
+ * Flush cpu slab.
+ *
+ * Called from IPI handler with interrupts disabled.
+ */
 static void flush_cpu_slab(void *d)
 {
 	struct kmem_cache *s = d;
+	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
 
-	__flush_cpu_slab(s, smp_processor_id());
+	if (c->page)
+		flush_slab(s, c);
+
+	unfreeze_partials(s);
 }
 
 static bool has_cpu_slab(int cpu, void *info)
-- 
2.33.0

