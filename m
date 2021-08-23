Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3717F3F4CCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhHWPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:00:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51722 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhHWO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4C3C521FDF;
        Mon, 23 Aug 2021 14:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qzhN0nTFVePV3BDkl6e4gnhqvz+P514h2el6LnbADE=;
        b=BRVIRlcmiFxjzvAPg95Qfsn8dsD8GbPfOv9QpTaaMh4BPLIsrP+5AD6FhTgiOxmLTwKc1O
        gZxzkTaIhF7xWaQ/nCiXSJtqrXRNI0Cvxklf/zdlvJssuxhhYPpK6+BrK1aKcU2xshEFcv
        7ttyOiTvfqAszyR1rUK7/zcYqBU+X1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730719;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+qzhN0nTFVePV3BDkl6e4gnhqvz+P514h2el6LnbADE=;
        b=Osm2ncgZBaljHyTSul+PMuVmw/QccW96gSxQmncaeJDUXtozric5S4ve5wx00JobWMFiW/
        uzpRX/TgaI1cfLDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 248E013BE1;
        Mon, 23 Aug 2021 14:58:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oPxkCJ+3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:39 +0000
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
Subject: [PATCH v5 09/35] mm, slub: return slab page from get_partial() and set c->page afterwards
Date:   Mon, 23 Aug 2021 16:58:00 +0200
Message-Id: <20210823145826.3857-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_partial() finds a suitable page on a partial list, acquires
and returns its freelist and assigns the page pointer to kmem_cache_cpu.
In later patch we will need more control over the kmem_cache_cpu.page
assignment, so instead of passing a kmem_cache_cpu pointer, pass a pointer to a
pointer to a page that get_partial() can fill and the caller can assign the
kmem_cache_cpu.page pointer. No functional change as all of this still happens
with disabled IRQs.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c8f5b2ca1ad6..fd9f5481b422 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2003,7 +2003,7 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-				struct kmem_cache_cpu *c, gfp_t flags)
+			      struct page **ret_page, gfp_t flags)
 {
 	struct page *page, *page2;
 	void *object = NULL;
@@ -2032,7 +2032,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 
 		available += objects;
 		if (!object) {
-			c->page = page;
+			*ret_page = page;
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
@@ -2052,7 +2052,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
  * Get a page from somewhere. Search in increasing NUMA distances.
  */
 static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
-		struct kmem_cache_cpu *c)
+			     struct page **ret_page)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
@@ -2094,7 +2094,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 			if (n && cpuset_zone_allowed(zone, flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, c, flags);
+				object = get_partial_node(s, n, ret_page, flags);
 				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
@@ -2116,7 +2116,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
  * Get a partial page, lock it and return it.
  */
 static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
-		struct kmem_cache_cpu *c)
+			 struct page **ret_page)
 {
 	void *object;
 	int searchnode = node;
@@ -2124,11 +2124,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
 	if (node == NUMA_NO_NODE)
 		searchnode = numa_mem_id();
 
-	object = get_partial_node(s, get_node(s, searchnode), c, flags);
+	object = get_partial_node(s, get_node(s, searchnode), ret_page, flags);
 	if (object || node != NUMA_NO_NODE)
 		return object;
 
-	return get_any_partial(s, flags, c);
+	return get_any_partial(s, flags, ret_page);
 }
 
 #ifdef CONFIG_PREEMPTION
@@ -2740,9 +2740,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
-	freelist = get_partial(s, gfpflags, node, c);
-	if (freelist)
+	freelist = get_partial(s, gfpflags, node, &page);
+	if (freelist) {
+		c->page = page;
 		goto check_new_page;
+	}
 
 	page = new_slab(s, gfpflags, node);
 
@@ -2766,7 +2768,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c->page = page;
 
 check_new_page:
-	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
 		goto load_freelist;
 
-- 
2.32.0

