Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DC238F65E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhEXXnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:50834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229926AbhEXXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGGhQXqylEVkhGCKs15bdMyTfUKJS20cQoY/lph/3m8=;
        b=qHeeEQdp+l8oDi/GxEUNr+OTPlCFxJqYKw0Ld1SGleywFtPjGcmkAu0J+PCCnCYm2IqrjR
        Hhrk/fxiSDKmaaWerViK4RB+XBOJt6wH3ukfyKO8ABMR5Xqp2ZpO35BwMLp2ORVW8rH9Wa
        93i745gCo8quEaMRQuJqCxRSR2WOzao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SGGhQXqylEVkhGCKs15bdMyTfUKJS20cQoY/lph/3m8=;
        b=Q/9QWO+pniucpKTJDZzw+89IFzM1M0qlXWLpeRR9NabOwiKr/NFXn6QGJuwVLwSum5wmda
        be6VckW9tHJWk2DA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68FDAAF35;
        Mon, 24 May 2021 23:40:48 +0000 (UTC)
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
Subject: [RFC 13/26] mm, slub: validate partial and newly allocated slabs before loading them
Date:   Tue, 25 May 2021 01:39:33 +0200
Message-Id: <20210524233946.20352-14-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we obtain a new slab page from node partial list or page allocator, we
assign it to kmem_cache_cpu, perform some checks, and if they fail, we undo
the assignment.

In order to allow doing the checks without irq disabled, restructure the code
so that checks go first, and kmem_cache_cpu assignment only afterwards.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 47a3438d6a35..78d7eb5be951 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2743,10 +2743,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 new_objects:
 
 	freelist = get_partial(s, gfpflags, node, &page);
-	if (freelist) {
-		c->page = page;
+	if (freelist)
 		goto check_new_page;
-	}
 
 	local_irq_restore(flags);
 	migrate_enable();
@@ -2760,9 +2758,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 	local_irq_save(flags);
-	if (c->page)
-		flush_slab(s, c);
-
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2771,14 +2766,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	page->freelist = NULL;
 
 	stat(s, ALLOC_SLAB);
-	c->page = page;
 
 check_new_page:
 
 	if (kmem_cache_debug(s)) {
 		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
-			c->page = NULL;
 			local_irq_restore(flags);
 			goto new_slab;
 		} else {
@@ -2797,10 +2790,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	if (unlikely(c->page))
+		flush_slab(s, c);
+	c->page = page;
+
 	goto load_freelist;
 
 return_single:
 
+	if (unlikely(c->page))
+		flush_slab(s, c);
+	c->page = page;
+
 	deactivate_slab(s, page, get_freepointer(s, freelist), c);
 	local_irq_restore(flags);
 	return freelist;
-- 
2.31.1

