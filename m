Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EBD3F4CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhHWPBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhHWO7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFB4D21FF7;
        Mon, 23 Aug 2021 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNHpFI9YeegQ7Tr0mlUdnFpfRtuVDo5qh+/Of6eaUa4=;
        b=NnTavDNbI4Azg6zy+qc13P+LRw3mN0vxMExWmThlLJCl4kpTK43XlzxPSteUXbU9/xE3wG
        DgetUyqHPMl8Pl3bFR4p55KcLkPmWZsQCR1sLoKGkHSvQvinY9R5ryC+XqUlnqC1ls3rwN
        lchsRULYeUyVxNbelEW3vUiC2DrQDhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNHpFI9YeegQ7Tr0mlUdnFpfRtuVDo5qh+/Of6eaUa4=;
        b=boZOzaqYnsU20KZW32qh3fuG1Xcy8cEdcH25QA3QPNUoJl3JOnLGYdzH0UW4v29PksIgiO
        rbmUUDuRTO+vFZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B16813BE1;
        Mon, 23 Aug 2021 14:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CH9TJaK3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:42 +0000
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
Subject: [PATCH v5 29/35] mm: slub: Move flush_cpu_slab() invocations __free_slab() invocations out of IRQ context
Date:   Mon, 23 Aug 2021 16:58:20 +0200
Message-Id: <20210823145826.3857-30-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
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

[vbabka@suse.cz: adapt to new SLUB changes]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab_common.c |  2 ++
 mm/slub.c        | 79 ++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 68 insertions(+), 13 deletions(-)

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
index bb7e05543738..29d71ae20c90 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2516,33 +2516,79 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
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
-		flush_slab(s, c, false);
+		flush_slab(s, c, true);
 
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
@@ -4087,7 +4133,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	int node;
 	struct kmem_cache_node *n;
 
-	flush_all(s);
+	flush_all_cpus_locked(s);
 	/* Attempt to free all objects */
 	for_each_kmem_cache_node(s, node, n) {
 		free_partial(s, n);
@@ -4363,7 +4409,7 @@ EXPORT_SYMBOL(kfree);
  * being allocated from last increasing the chance that the last objects
  * are freed in them.
  */
-int __kmem_cache_shrink(struct kmem_cache *s)
+static int __kmem_cache_do_shrink(struct kmem_cache *s)
 {
 	int node;
 	int i;
@@ -4375,7 +4421,6 @@ int __kmem_cache_shrink(struct kmem_cache *s)
 	unsigned long flags;
 	int ret = 0;
 
-	flush_all(s);
 	for_each_kmem_cache_node(s, node, n) {
 		INIT_LIST_HEAD(&discard);
 		for (i = 0; i < SHRINK_PROMOTE_MAX; i++)
@@ -4425,13 +4470,21 @@ int __kmem_cache_shrink(struct kmem_cache *s)
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
2.32.0

