Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E637D38F65C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhEXXnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:50772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229912AbhEXXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wIqmut6t8AzrJp5XwcHQFB5G4zyTOR84945gujQUwo=;
        b=X9HiedB3RPuZ2Fj9nF2C2yav1BNtZ6tyO7y7rylvOOQUzVy1tjN1Z0xqgFmrfdfdoDDwAF
        8eoK+62jwaZPoT/8FU/q/9LIWHPP6S/WLyVZeGJOFb5n/qvKZYvMxAcwvHI7qNsxrw9XTT
        Ml0TM2dotE+VQj0x/NcJTX+JieCwp/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wIqmut6t8AzrJp5XwcHQFB5G4zyTOR84945gujQUwo=;
        b=jzQcsSJmXTbNfl1tEZm2Hzxs86mGoqet3FxRiXmlKK/XUcWocXnpzrkkK75kiQW7hdnjqN
        t8GrV7OPJ/wDwUCA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5D6E9AF33;
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
Subject: [RFC 14/26] mm, slub: check new pages with restored irqs
Date:   Tue, 25 May 2021 01:39:34 +0200
Message-Id: <20210524233946.20352-15-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on top of the previous patch, re-enable irqs before checking new
pages. alloc_debug_processing() is now called with enabled irqs so we need to
remove VM_BUG_ON(!irqs_disabled()); in check_slab() - there doesn't seem to be
a need for it anyway.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 78d7eb5be951..e092387b5932 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -968,8 +968,6 @@ static int check_slab(struct kmem_cache *s, struct page *page)
 {
 	int maxobj;
 
-	VM_BUG_ON(!irqs_disabled());
-
 	if (!PageSlab(page)) {
 		slab_err(s, page, "Not a valid slab page");
 		return 0;
@@ -2743,10 +2741,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 new_objects:
 
 	freelist = get_partial(s, gfpflags, node, &page);
+	local_irq_restore(flags);
 	if (freelist)
 		goto check_new_page;
 
-	local_irq_restore(flags);
 	migrate_enable();
 	page = new_slab(s, gfpflags, node);
 	migrate_disable();
@@ -2757,7 +2755,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
-	local_irq_save(flags);
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2772,7 +2769,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (kmem_cache_debug(s)) {
 		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
-			local_irq_restore(flags);
 			goto new_slab;
 		} else {
 			/*
@@ -2790,6 +2786,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
@@ -2798,6 +2795,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 return_single:
 
+	local_irq_save(flags);
 	if (unlikely(c->page))
 		flush_slab(s, c);
 	c->page = page;
-- 
2.31.1

