Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CCE3DA3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbhG2NWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:22:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56744 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbhG2NVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C1D4F2003A;
        Thu, 29 Jul 2021 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+pHGWgb9q86Ral/p62A5fF1hFYGmqdwUQaJyTjgr+M=;
        b=cqJhLF6KxgwgBpNtKDKe6a6RNHQ5yNRsfxQ7TvnFiCBYwvAZu81YahhxRaDzLerF5Btu/F
        5Yv9cC5nSlOWfpyQvwo8FLGDUgCc1V98klMXYbM2qc7ctN4LZi17oAZMQZkHc5VIvABPRI
        lv68KkXHB4SM3/K+Uv6s5HJIsgsfXRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/+pHGWgb9q86Ral/p62A5fF1hFYGmqdwUQaJyTjgr+M=;
        b=c5VoH3O49S3UrNjAq1702oK3dN78iLn1gzTl+kiW6xV9S1z7cIBa9o5T5uViPjB50h2Q+e
        EvEyxjuqaB/oMgBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9587A13AE9;
        Thu, 29 Jul 2021 13:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UMziI2WrAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:41 +0000
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
Subject: [PATCH v3 08/35] mm, slub: dissolve new_slab_objects() into ___slab_alloc()
Date:   Thu, 29 Jul 2021 15:21:05 +0200
Message-Id: <20210729132132.19691-9-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index 09fa967519c5..7ccd03d553bc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1868,6 +1868,8 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags = kmalloc_fix_flags(flags);
 
+	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
+
 	return allocate_slab(s,
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
@@ -2593,36 +2595,6 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
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
@@ -2769,13 +2741,27 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.32.0

