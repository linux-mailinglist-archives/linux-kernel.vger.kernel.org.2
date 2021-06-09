Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB233A12F1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238747AbhFILlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46884 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239144AbhFILl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:28 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1E8681FD61;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP6gY1FO49owhq4IXmCsqEM0wX1JIeYz2iR8RuLeKzs=;
        b=V8FHGEI4P8WxPddKk/LZH2BMfi9s9m7qRpZAJLGT2feGyXEA8FTdsmKjBZNWadQxLFQUiT
        V/ZP0clOdhvk/IjoVdzJ44DcjpMaZtZ+xJ7azBjv5jXg7BrzfVICwpeKmOLDeBRoxMDMsK
        Mrv3WVt6qvFCdN3M7N25U/n6Qzu6NiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP6gY1FO49owhq4IXmCsqEM0wX1JIeYz2iR8RuLeKzs=;
        b=gRRa2lgyuO6eUIZ/b/bgZn4ZAf2Jx9qQ7KZvvitRhlT7Qi+oCsDSg6bDJ1kQOHQyvVw8c3
        t5cKvFrVti1+r6Dg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E2588118DD;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP6gY1FO49owhq4IXmCsqEM0wX1JIeYz2iR8RuLeKzs=;
        b=V8FHGEI4P8WxPddKk/LZH2BMfi9s9m7qRpZAJLGT2feGyXEA8FTdsmKjBZNWadQxLFQUiT
        V/ZP0clOdhvk/IjoVdzJ44DcjpMaZtZ+xJ7azBjv5jXg7BrzfVICwpeKmOLDeBRoxMDMsK
        Mrv3WVt6qvFCdN3M7N25U/n6Qzu6NiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP6gY1FO49owhq4IXmCsqEM0wX1JIeYz2iR8RuLeKzs=;
        b=gRRa2lgyuO6eUIZ/b/bgZn4ZAf2Jx9qQ7KZvvitRhlT7Qi+oCsDSg6bDJ1kQOHQyvVw8c3
        t5cKvFrVti1+r6Dg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 4EvANnSowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:32 +0000
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
Subject: [RFC v2 08/34] mm, slub: dissolve new_slab_objects() into ___slab_alloc()
Date:   Wed,  9 Jun 2021 13:38:37 +0200
Message-Id: <20210609113903.1421-9-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patches will need more fine grained control over individual actions
in ___slab_alloc(), the only caller of new_slab_objects(), so dissolve it
there. This is a preparatory step with no functional change.

The only minor change is moving WARN_ON_ONCE() for using a constructor together
with __GFP_ZERO to new_slab(), which makes it somewhat less frequent, but still
able to catch a development change introducing a systematic misuse.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 38256e87dde8..87f652bf8e4d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1825,6 +1825,8 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
+	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
+
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
@@ -2550,36 +2552,6 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
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
@@ -2726,13 +2698,27 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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

