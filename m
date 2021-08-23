Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CD33F4CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhHWPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51840 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhHWO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 973C921FEA;
        Mon, 23 Aug 2021 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xli1ta2rWXTvirL38W0uAjurVB0A8z+tU+gP3KFvM38=;
        b=Z5Y7ffV/ZPLjJbeqSQ2ztRiZmqaxrX6payOKhlInV4dDrOdgw1NhgKUtqY+gCiOQjpo/v0
        KzMocb/E7M5mqjNdzs78a7g5ogEzJvZ+Ty0ouQSSeDch6u+YtnIAWK64mL9JMMlounX65a
        Q2NugmdYHB8BrMUC3PSSbsebqTGjS5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xli1ta2rWXTvirL38W0uAjurVB0A8z+tU+gP3KFvM38=;
        b=A/hzIJnMerGuqRhp2LFmnessL8RgWHXhr7oDYdBGr/tSVnNFghGR2upvXyeLouBLXPMAPv
        bqYV9KpgnyiCBBBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E5F413BE0;
        Mon, 23 Aug 2021 14:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +B5gGqC3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:40 +0000
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
Subject: [PATCH v5 16/35] mm, slub: validate slab from partial list or page allocator before making it cpu slab
Date:   Mon, 23 Aug 2021 16:58:07 +0200
Message-Id: <20210823145826.3857-17-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we obtain a new slab page from node partial list or page allocator, we
assign it to kmem_cache_cpu, perform some checks, and if they fail, we undo
the assignment.

In order to allow doing the checks without irq disabled, restructure the code
so that the checks are done first, and kmem_cache_cpu.page assignment only
after they pass.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8b240eb10a1d..fddfb0629b8e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2788,10 +2788,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	lockdep_assert_irqs_disabled();
 
 	freelist = get_partial(s, gfpflags, node, &page);
-	if (freelist) {
-		c->page = page;
+	if (freelist)
 		goto check_new_page;
-	}
 
 	local_irq_restore(flags);
 	put_cpu_ptr(s->cpu_slab);
@@ -2804,9 +2802,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 	local_irq_save(flags);
-	if (c->page)
-		flush_slab(s, c);
-
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2815,14 +2810,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2841,10 +2834,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.32.0

