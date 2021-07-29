Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E284D3DA3F7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237728AbhG2NXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:23:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbhG2NVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D92B0223E0;
        Thu, 29 Jul 2021 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZ/sz9DDZ8M0Vfi6nYCImhy5kj0wJxMVWRF79KcwjWk=;
        b=V2IwvAMQafwBMr/2XGH0yPJbdInAPR7n9UJMtW56m+/vi9RHxN/zVDSRg/EfQ6gfj0BRk+
        iUSdm9bTUtxLFLQeStU8SOQ48MAibu+PVh5kyOSTbfAeqf0hJ1Mqg3zlVC35aVmsTQz+bV
        2OffAIQYcK51dGKnssErGi6HSx5kGOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564905;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MZ/sz9DDZ8M0Vfi6nYCImhy5kj0wJxMVWRF79KcwjWk=;
        b=um8EusyuXCCmwaUzVO1jwdTbE4TJIa5T21HzDXQsgiyvSbqwNKfecIn0c3tgBc4Tzv6cYU
        z+X0b6bt+Vm8AyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC7D213AF4;
        Thu, 29 Jul 2021 13:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0BN/KWmrAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:45 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
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
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3 29/35] mm: slub: Move flush_cpu_slab() invocations __free_slab() invocations out of IRQ context
Date:   Thu, 29 Jul 2021 15:21:26 +0200
Message-Id: <20210729132132.19691-30-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
 mm/slub.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 9fbc5396f3e1..dbb74dbe1c1e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2513,33 +2513,73 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
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
 static void flush_all(struct kmem_cache *s)
 {
-	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
+	struct slub_flush_work *sfw;
+	unsigned int cpu;
+
+	mutex_lock(&flush_lock);
+	cpus_read_lock();
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
+	cpus_read_unlock();
+	mutex_unlock(&flush_lock);
 }
 
 /*
-- 
2.32.0

