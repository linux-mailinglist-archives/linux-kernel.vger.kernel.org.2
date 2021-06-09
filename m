Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35083A1307
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239329AbhFILnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:43:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239177AbhFILlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 58E50219ED;
        Wed,  9 Jun 2021 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfMFwj7ppgCWhaxJh1K1eYLeFIE8J8e6h1Q7xkpTECo=;
        b=0PD5fXKpoeabe6dUZOIO/Z/5nY6DrOvynM1KuMFVcTyoJfmZ8VGXgpLmhe4uBjV11+D5em
        4Hxy+e67kwQOxuAoWYePnfUFacJgkkdyG+VJPEIh0ekY5MhFCNIPa6MajEgBPjam6iOh6S
        n3okn6meKDgqv213Jv6q0qEvxYG3nFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfMFwj7ppgCWhaxJh1K1eYLeFIE8J8e6h1Q7xkpTECo=;
        b=aCiRQyu4/Yyi+HLIruMVy41bQEpCaA8+Fqp5qjFR1SOVLyXuGg55cZl3duhSMQMD/KUMJx
        ORaRnRU599yma8AA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 274CC11A98;
        Wed,  9 Jun 2021 11:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfMFwj7ppgCWhaxJh1K1eYLeFIE8J8e6h1Q7xkpTECo=;
        b=0PD5fXKpoeabe6dUZOIO/Z/5nY6DrOvynM1KuMFVcTyoJfmZ8VGXgpLmhe4uBjV11+D5em
        4Hxy+e67kwQOxuAoWYePnfUFacJgkkdyG+VJPEIh0ekY5MhFCNIPa6MajEgBPjam6iOh6S
        n3okn6meKDgqv213Jv6q0qEvxYG3nFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238777;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfMFwj7ppgCWhaxJh1K1eYLeFIE8J8e6h1Q7xkpTECo=;
        b=aCiRQyu4/Yyi+HLIruMVy41bQEpCaA8+Fqp5qjFR1SOVLyXuGg55cZl3duhSMQMD/KUMJx
        ORaRnRU599yma8AA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id KJweCXmowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:37 +0000
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
Subject: [RFC v2 29/34] mm: slub: Move flush_cpu_slab() invocations __free_slab() invocations out of IRQ context
Date:   Wed,  9 Jun 2021 13:38:58 +0200
Message-Id: <20210609113903.1421-30-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index 5c70fc17e9be..6e747e0d7dcd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2474,33 +2474,73 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
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
+	cpus_read_lock();
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
+	cpus_read_unlock();
 }
 
 /*
-- 
2.31.1

