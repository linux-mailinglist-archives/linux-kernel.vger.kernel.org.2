Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA61C400AF3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351313AbhIDKwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41878 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351147AbhIDKvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49E762004C;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ROWetETu9kRdMbomd37GMTie//m23OlCu21sQBbUl4=;
        b=F7GZaVepbAM+TaN/8QnZqT7ojUaN4DfohYbRx507liBEjAD1wSixZV9eXLtaM81OJydBZm
        sYcJ9XjHuhKELTC83QzlYZKcGjTzfT6xm4uJZQBXqzqIkQndemBGZSLBsF/+fW12MJCpUH
        YctcHZP6Lj9a5HsK4JbNvb71A7pOOmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ROWetETu9kRdMbomd37GMTie//m23OlCu21sQBbUl4=;
        b=kuRLw8aI69OvF3SzP26y7KcJja1NkUyfAkYPQm/+nGLBZ6X+3gzUiQsPcD6PuX4H9y7jTg
        3oLiEJab0FxLNOAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 226571348A;
        Sat,  4 Sep 2021 10:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CIjHB2ZPM2HoUQAAMHmgww
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
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 28/33] mm: slub: move flush_cpu_slab() invocations __free_slab() invocations out of IRQ context
Date:   Sat,  4 Sep 2021 12:49:58 +0200
Message-Id: <20210904105003.11688-29-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5641; i=vbabka@suse.cz; h=from:subject; bh=RFyIAg8pO6Wlp9YLx1y4SOJmK0WVFwSTEu0I5PRQaUA=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM09MEhT0P/nYHovK3rOS2tiLVpbZWYBqvRPytExV DFXvXWeJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPTAAKCRDgIcpz8YmpELBBCA CIg3yCkqtzzAiCk4qS8+LUevzu4nfcRtrkKZmnIQUCh+I3RX57jjVWwYQnY5NOvopa7fKibspPUJa9 hMyHTQPo/vy6zLHPaO9vhg3Rue44fJ7+27q0keWX+IqHfT5upseoQWJAAoHz3jQEjyGOAfNCjsoqZZ 3zu4V8oAJbmJkHLG0WPVRnNQRgXcqd/djNfErKW/eLSYaYw4ND43XwCuQE0E9muyfa7nKUP5k1BZrw RkWVZvnDF5pyTyHXOEWrrXGiZFlyDka/yEdzlSiY373w/IkItNb7aoSHhYah/41P2M44vh0Y4Bixql PTwawvjA2KgarHIfDRDq2xU4LqRCP9
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

flush_all() flushes a specific SLAB cache on each CPU (where the cache
is present). The deactivate_slab()/__free_slab() invocation happens
within IPI handler and is problematic for PREEMPT_RT.

The flush operation is not a frequent operation or a hot path. The
per-CPU flush operation can be moved to within a workqueue.

Because a workqueue handler, unlike IPI handler, does not disable irqs,
flush_slab() now has to disable them for working with the kmem_cache_cpu
fields. deactivate_slab() is safe to call with irqs enabled.

[vbabka@suse.cz: adapt to new SLUB changes]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c |  2 ++
 mm/slub.c        | 94 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 80 insertions(+), 16 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 1c673c323baf..ec2bb0beed75 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -502,6 +502,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	if (unlikely(!s))
 		return;
 
+	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
 	s->refcount--;
@@ -516,6 +517,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 	}
 out_unlock:
 	mutex_unlock(&slab_mutex);
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL(kmem_cache_destroy);
 
diff --git a/mm/slub.c b/mm/slub.c
index fa9a366d2d9c..b7f8b9d34e46 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2496,16 +2496,25 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
-	void *freelist = c->freelist;
-	struct page *page = c->page;
+	unsigned long flags;
+	struct page *page;
+	void *freelist;
+
+	local_irq_save(flags);
+
+	page = c->page;
+	freelist = c->freelist;
 
 	c->page = NULL;
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
 
-	deactivate_slab(s, page, freelist);
+	local_irq_restore(flags);
 
-	stat(s, CPUSLAB_FLUSH);
+	if (page) {
+		deactivate_slab(s, page, freelist);
+		stat(s, CPUSLAB_FLUSH);
+	}
 }
 
 static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
@@ -2526,15 +2535,27 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	unfreeze_partials_cpu(s, c);
 }
 
+struct slub_flush_work {
+	struct work_struct work;
+	struct kmem_cache *s;
+	bool skip;
+};
+
 /*
  * Flush cpu slab.
  *
- * Called from IPI handler with interrupts disabled.
+ * Called from CPU work handler with migration disabled.
  */
-static void flush_cpu_slab(void *d)
+static void flush_cpu_slab(struct work_struct *w)
 {
-	struct kmem_cache *s = d;
-	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
+	struct kmem_cache *s;
+	struct kmem_cache_cpu *c;
+	struct slub_flush_work *sfw;
+
+	sfw = container_of(w, struct slub_flush_work, work);
+
+	s = sfw->s;
+	c = this_cpu_ptr(s->cpu_slab);
 
 	if (c->page)
 		flush_slab(s, c);
@@ -2542,17 +2563,51 @@ static void flush_cpu_slab(void *d)
 	unfreeze_partials(s);
 }
 
-static bool has_cpu_slab(int cpu, void *info)
+static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 {
-	struct kmem_cache *s = info;
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	return c->page || slub_percpu_partial(c);
 }
 
+static DEFINE_MUTEX(flush_lock);
+static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
+
+static void flush_all_cpus_locked(struct kmem_cache *s)
+{
+	struct slub_flush_work *sfw;
+	unsigned int cpu;
+
+	lockdep_assert_cpus_held();
+	mutex_lock(&flush_lock);
+
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
+		if (!has_cpu_slab(cpu, s)) {
+			sfw->skip = true;
+			continue;
+		}
+		INIT_WORK(&sfw->work, flush_cpu_slab);
+		sfw->skip = false;
+		sfw->s = s;
+		schedule_work_on(cpu, &sfw->work);
+	}
+
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
+		if (sfw->skip)
+			continue;
+		flush_work(&sfw->work);
+	}
+
+	mutex_unlock(&flush_lock);
+}
+
 static void flush_all(struct kmem_cache *s)
 {
-	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
+	cpus_read_lock();
+	flush_all_cpus_locked(s);
+	cpus_read_unlock();
 }
 
 /*
@@ -4097,7 +4152,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
-	flush_all(s);
+	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
@@ -4373,7 +4428,7 @@ EXPORT_SYMBOL(kfree);
  * being allocated from last increasing the chance that the last objects
  * are freed in them.
  */
-int __kmem_cache_shrink(struct kmem_cache *s)
+static int __kmem_cache_do_shrink(struct kmem_cache *s)
 {
 	int node;
 	int i;
@@ -4385,7 +4440,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	unsigned long flags;
 	int ret = 0;
 
-	flush_all(s);
 	for_each_kmem_cache_node(s, node, n) {
 		INIT_LIST_HEAD(&discard);
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
@@ -4435,13 +4489,21 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	return ret;
 }
 
+int __kmem_cache_shrink(struct kmem_cache *s)
+{
+	flush_all(s);
+	return __kmem_cache_do_shrink(s);
+}
+
 static int slab_mem_going_offline_callback(void *arg)
 {
 	struct kmem_cache *s;
 
 	mutex_lock(&slab_mutex);
-	list_for_each_entry(s, &slab_caches, list)
-		__kmem_cache_shrink(s);
+	list_for_each_entry(s, &slab_caches, list) {
+		flush_all_cpus_locked(s);
+		__kmem_cache_do_shrink(s);
+	}
 	mutex_unlock(&slab_mutex);
 
 	return 0;
-- 
2.33.0

