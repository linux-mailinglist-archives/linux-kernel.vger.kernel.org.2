Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEE3400AE7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351240AbhIDKvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59716 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351095AbhIDKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B34E32268D;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0qikWkeWrWzeED3jQTDQNevpFBtSnM3fTB8vQvz2Ng=;
        b=IHrJpQNESpzGQFm3XV+gP2eNFlArZfrNTPGxNeg8SR3+q/hWjsFLvOAY2KOKyL4RJISJYP
        Oc7SaVNwVIDm+jj9840T8dLhjtk3VnkEcxCfOmytmlK0vwXrYNgzhpJNGXJsDP4zag1MBJ
        pIbMdhN5/EQGsTS4uKEVg+fI+yB9eMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0qikWkeWrWzeED3jQTDQNevpFBtSnM3fTB8vQvz2Ng=;
        b=w29ULsKvpJde3plaG1P0u9sT24zWMJKjm2jvbWmVVHupjV1skDj3PIqynNiPA2nsRrQkXe
        1oAEd4/9SEM0hDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B2091348A;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iF5mIWJPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:10 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v6 08/33] mm, slub: return slab page from get_partial() and set c->page afterwards
Date:   Sat,  4 Sep 2021 12:49:38 +0200
Message-Id: <20210904105003.11688-9-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; h=from:subject; bh=AIR1iH8XFLOAYQjmDmu0Ek9yTm3TVAGwBM2CAzKF+/8=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08bZtDzow5yNQ+VfrFLi41AgJLLMSXU5mHiI11N SgotFb6JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPGwAKCRDgIcpz8YmpECUaB/ 4scoK1vp9QisXLrOXIKDqXgmbxh1D4PixriGDYOnZhUr4gUuUMra+T/KqfYrkzVIXyQl5K1f7StPPU /M6G73I04xf0mrnnCtsIcb0xUCMBRwmgp7rU8hbs8UTtPW05S7lElY51LrAq7TKD5EKbzvF1OWIh6J KpuKKC+E9ydVPzaE3f9kUUwyPPGHAJVIIYSv2Hq48/ijwOofyg7H8RA1U1jwfbBbFC1q0VuiYrEX2i qsUXpNBdMC1vh691aIyFw1mbUf9gTuYT7aZ/fwoNEDP/eCU7wKS2uZXc7JI7qd0vYhv5PhfUQMq66y 4MUm5xMxoet8MymaOokbUR0lDvt+6Q
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index 0c645b0e96d9..e9d582eee7d7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2017,7 +2017,7 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-				struct kmem_cache_cpu *c, gfp_t flags)
+			      struct page **ret_page, gfp_t flags)
 {
 	struct page *page, *page2;
 	void *object = NULL;
@@ -2046,7 +2046,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 
 		available += objects;
 		if (!object) {
-			c->page = page;
+			*ret_page = page;
 			stat(s, ALLOC_FROM_PARTIAL);
 			object = t;
 		} else {
@@ -2066,7 +2066,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
  * Get a page from somewhere. Search in increasing NUMA distances.
  */
 static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
-		struct kmem_cache_cpu *c)
+			     struct page **ret_page)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
@@ -2108,7 +2108,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
 
 			if (n && cpuset_zone_allowed(zone, flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, c, flags);
+				object = get_partial_node(s, n, ret_page, flags);
 				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
@@ -2130,7 +2130,7 @@ static void *get_any_partial(struct kmem_cache *s, gfp_t flags,
  * Get a partial page, lock it and return it.
  */
 static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
-		struct kmem_cache_cpu *c)
+			 struct page **ret_page)
 {
 	void *object;
 	int searchnode = node;
@@ -2138,11 +2138,11 @@ static void *get_partial(struct kmem_cache *s, gfp_t flags, int node,
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
@@ -2754,9 +2754,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
 
@@ -2780,7 +2782,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	c->page = page;
 
 check_new_page:
-	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
 		goto load_freelist;
 
-- 
2.33.0

