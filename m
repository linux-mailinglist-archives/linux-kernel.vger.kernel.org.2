Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F00D3A12F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhFILmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46966 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbhFILl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E7121FD62;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxG0sTKG3HDQvTVC+wgypTAYjlpWe1E+zR9CMgBlKVE=;
        b=VgaBv0jv8ekGLTGkPcWtSbBkK43e1mKqGkYzPFDwmnaQICdiJz28h5LXVJ/Z8epVWA2xxk
        3kCpd0oPsN6tLFiWd841pTIPXwPtECiyX9oSrEJHb88boahSQCiiMRQbC+RERHzAyOCw0F
        vdlM7+8myOV7dhM+cf+dskR830UQQ6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxG0sTKG3HDQvTVC+wgypTAYjlpWe1E+zR9CMgBlKVE=;
        b=siZMeoMpA+713vHHCpAmN4iXON34m+uYDBrbCgJ2wjCc+KWDxs0r8wr3P/59DWT3a9JDCe
        87KmRma2rVo19WBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 2010D11A98;
        Wed,  9 Jun 2021 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxG0sTKG3HDQvTVC+wgypTAYjlpWe1E+zR9CMgBlKVE=;
        b=VgaBv0jv8ekGLTGkPcWtSbBkK43e1mKqGkYzPFDwmnaQICdiJz28h5LXVJ/Z8epVWA2xxk
        3kCpd0oPsN6tLFiWd841pTIPXwPtECiyX9oSrEJHb88boahSQCiiMRQbC+RERHzAyOCw0F
        vdlM7+8myOV7dhM+cf+dskR830UQQ6U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238773;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxG0sTKG3HDQvTVC+wgypTAYjlpWe1E+zR9CMgBlKVE=;
        b=siZMeoMpA+713vHHCpAmN4iXON34m+uYDBrbCgJ2wjCc+KWDxs0r8wr3P/59DWT3a9JDCe
        87KmRma2rVo19WBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id QOlbB3WowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:33 +0000
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
Subject: [RFC v2 09/34] mm, slub: return slab page from get_partial() and set c->page afterwards
Date:   Wed,  9 Jun 2021 13:38:38 +0200
Message-Id: <20210609113903.1421-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index 87f652bf8e4d..ca7cfc7706cc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1957,7 +1957,7 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-				struct kmem_cache_cpu *c, gfp_t flags)
+			      struct page **ret_page, gfp_t flags)
 {
 	struct page *page, *page2;
 	void *object = NULL;
@@ -1986,7 +1986,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 
 		available += objects;
 		if (!object) {
-			c->page = page;
+			*ret_page = page;
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
@@ -2006,7 +2006,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
  * Get a page from somewhere. Search in increasing NUMA distances.
  */
 static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
-		struct kmem_cache_cpu *c)
+			     struct page **ret_page)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
@@ -2048,7 +2048,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 			if (n && cpuset_zone_allowed(zone, flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, c, flags);
+				object = get_partial_node(s, n, ret_page, flags);
 				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
@@ -2070,7 +2070,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
  * Get a partial page, lock it and return it.
  */
 static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
-		struct kmem_cache_cpu *c)
+			 struct page **ret_page)
 {
 	void *object;
 	int searchnode = node;
@@ -2078,11 +2078,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
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
@@ -2694,9 +2694,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
 
@@ -2720,7 +2722,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c->page = page;
 
 check_new_page:
-	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
 		goto load_freelist;
 
-- 
2.31.1

