Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090F138F656
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbhEXXmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:42:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:50692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhEXXmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tig2eA8Wm758Dr7faUoCLnxKmtvXTVhcR/nltsYptMY=;
        b=W95lkie0++iNBRygHiOD8HtHFg83IEXp9u/DPb9Miui4K7XapaxeupuL7fH2VBfSdg8t5v
        I2qQUhzM4/8rAccH2IyX0yY0W3kDf/vn5UUgKqdYpxU+tY4mRY+tzj4Cbu8h8ChfBpKkrw
        1PJ8d3SsfweZ6KGIVsruk4Vja8dHSi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tig2eA8Wm758Dr7faUoCLnxKmtvXTVhcR/nltsYptMY=;
        b=brdgGJUHkP+/mQvGiqKV41bN1djB9U8c/rAZRGi8aj3Zb7ubEqc9ocplMt/1Gezwn6xMTx
        oLIqhkfL67UYGoCQ==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41C1CAF2F;
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
Subject: [RFC 06/26] mm, slub: dissolve new_slab_objects() into ___slab_alloc()
Date:   Tue, 25 May 2021 01:39:26 +0200
Message-Id: <20210524233946.20352-7-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patches will need more fine grained control over individual actions
in ___slab_alloc(), the only caller of new_slab_objects(), so dissolve it
there. This is a preparatory step with no functional change.

The only minor change is moving WARN_ON_ONCE() for using a constructor together
with __GFP_ZERO to new_slab() which makes it somewhat less frequent, but still
able to catch a misuse.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7973bcd42bc7..9d1d872f5ab9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1839,6 +1839,8 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
+	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
+
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
@@ -2571,36 +2573,6 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 #endif
 }
 
-static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
-			int node, struct kmem_cache_cpu **pc)
-{
-	void *freelist = NULL;
-	struct kmem_cache_cpu *c = *pc;
-	struct page *page;
-
-	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
-
-	page = new_slab(s, flags, node);
-	if (page) {
-		c = raw_cpu_ptr(s->cpu_slab);
-		if (c->page)
-			flush_slab(s, c);
-
-		/*
-		 * No other reference to the page yet so we can
-		 * muck around with it freely without cmpxchg
-		 */
-		freelist = page->freelist;
-		page->freelist = NULL;
-
-		stat(s, ALLOC_SLAB);
-		c->page = page;
-		*pc = c;
-	}
-
-	return freelist;
-}
-
 static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
 {
 	if (unlikely(PageSlabPfmemalloc(page)))
@@ -2747,13 +2719,27 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (freelist)
 		goto check_new_page;
 
-	freelist = new_slab_objects(s, gfpflags, node, &c);
+	page = new_slab(s, gfpflags, node);
 
-	if (unlikely(!freelist)) {
+	if (unlikely(!page)) {
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
 
+	c = raw_cpu_ptr(s->cpu_slab);
+	if (c->page)
+		flush_slab(s, c);
+
+	/*
+	 * No other reference to the page yet so we can
+	 * muck around with it freely without cmpxchg
+	 */
+	freelist = page->freelist;
+	page->freelist = NULL;
+
+	stat(s, ALLOC_SLAB);
+	c->page = page;
+
 check_new_page:
 	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
-- 
2.31.1

