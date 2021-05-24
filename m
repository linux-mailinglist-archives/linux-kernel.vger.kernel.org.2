Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A974138F651
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhEXXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:42:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEXXmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVHhxBz5PMne0XZT3zO+ovDd4dDVDxEhwNUCfCb/aKc=;
        b=qoI9jq/pgA4tT5xbBvqsBbzL1uW1cfejSksYK4wZUN4NHWRg6f/5iWed6armkEXjfF7Hbz
        U1eykhAOl4Fd1aY2Ew+cgkHPxjVzz3nB4gYoT+sCs3AM8vSJM5rOav8fEYsxcagmPy1Va7
        mK0Uq0T2tY8JS2UoaasFzCBRNnM92e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVHhxBz5PMne0XZT3zO+ovDd4dDVDxEhwNUCfCb/aKc=;
        b=DrPHqBVEIWTBP0i/LR5+v/LlPzI0dlXCommjortvhrcSAZt45B+ATF6MEEC7Fgpts5xDBJ
        NaPiLnxvyWJp+PDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E714CAF1E;
        Mon, 24 May 2021 23:40:47 +0000 (UTC)
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
Subject: [RFC 04/26] mm, slub: simplify kmem_cache_cpu and tid setup
Date:   Tue, 25 May 2021 01:39:24 +0200
Message-Id: <20210524233946.20352-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In slab_alloc_node() and do_slab_free() fastpaths we need to guarantee that
our kmem_cache_cpu pointer is from the same cpu as the tid value. Currently
that's done by reading the tid first using this_cpu_read(), then the
kmem_cache_cpu pointer and verifying we read the same tid using the pointer and
plain READ_ONCE().

This can be simplified to just fetching kmem_cache_cpu pointer and then reading
tid using the pointer. That guarantees they are from the same cpu. We don't
need to read the tid using this_cpu_read() because the value will be validated
by this_cpu_cmpxchg_double(), making sure we are on the correct cpu and the
freelist didn't change by anyone preempting us since reading the tid.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 83ad64c1d9da..7b4cdc59b9ff 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2840,15 +2840,14 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	 * reading from one cpu area. That does not matter as long
 	 * as we end up on the original cpu again when doing the cmpxchg.
 	 *
-	 * We should guarantee that tid and kmem_cache are retrieved on
-	 * the same cpu. It could be different if CONFIG_PREEMPTION so we need
-	 * to check if it is matched or not.
+	 * We must guarantee that tid and kmem_cache_cpu are retrieved on the
+	 * same cpu. We read first the kmem_cache_cpu pointer and use it to read
+	 * the tid. If we are preempted and switched to another cpu between the
+	 * two reads, it's OK as the two are still associated with the same cpu
+	 * and cmpxchg later will validate the cpu.
 	 */
-	do {
-		tid = this_cpu_read(s->cpu_slab->tid);
-		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
-		 unlikely(tid != READ_ONCE(c->tid)));
+	c = raw_cpu_ptr(s->cpu_slab);
+	tid = READ_ONCE(c->tid);
 
 	/*
 	 * Irqless object alloc/free algorithm used here depends on sequence
@@ -3122,11 +3121,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	 * data is retrieved via this pointer. If we are on the same cpu
 	 * during the cmpxchg then the free will succeed.
 	 */
-	do {
-		tid = this_cpu_read(s->cpu_slab->tid);
-		c = raw_cpu_ptr(s->cpu_slab);
-	} while (IS_ENABLED(CONFIG_PREEMPTION) &&
-		 unlikely(tid != READ_ONCE(c->tid)));
+	c = raw_cpu_ptr(s->cpu_slab);
+	tid = READ_ONCE(c->tid);
 
 	/* Same with comment on barrier() in slab_alloc_node() */
 	barrier();
-- 
2.31.1

