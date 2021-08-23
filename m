Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7E3F4CD1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhHWPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbhHWO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 44FAF21FE7;
        Mon, 23 Aug 2021 14:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlD+HFKDvoGmzmIfB5vhsjKXZI7TboyZCmd1kySgHJ4=;
        b=wNH6elKfAqzm7fSbtcRez315EjxwkixqppRpIdhVCjqFbmhCFc3DQ6Vz+LT5mR9VrJ+5vO
        O9/0NxEyBMp8Q9al0XdRGixVUcsewb5STb/1E9mvWelty3uLvwrKFjm1QGlTotdHoyrbGb
        IXwQaqrcejvPxUOUYi5Iu+pXeE9dndU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlD+HFKDvoGmzmIfB5vhsjKXZI7TboyZCmd1kySgHJ4=;
        b=G5APiNFs57iA14prtqHk5HvVaSsacYMJlB07r6nvVsDYLBXLj41VR4cbEDz0VagmIxhbdD
        iLmlrSUoLldbHABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C03813BE0;
        Mon, 23 Aug 2021 14:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qGhDBqC3I2EFQQAAMHmgww
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
Subject: [PATCH v5 14/35] mm, slub: move disabling irqs closer to get_partial() in ___slab_alloc()
Date:   Mon, 23 Aug 2021 16:58:05 +0200
Message-Id: <20210823145826.3857-15-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue reducing the irq disabled scope. Check for per-cpu partial slabs with
first with irqs enabled and then recheck with irqs disabled before grabbing
the slab page. Mostly preparatory for the following patches.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index fcc38638c645..a437730d7ae2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2692,11 +2692,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		if (unlikely(node != NUMA_NO_NODE &&
 			     !node_isset(node, slab_nodes)))
 			node = NUMA_NO_NODE;
-		local_irq_save(flags);
-		if (unlikely(c->page)) {
-			local_irq_restore(flags);
-			goto reread_page;
-		}
 		goto new_slab;
 	}
 redo:
@@ -2737,6 +2732,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	if (!freelist) {
 		c->page = NULL;
+		local_irq_restore(flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2766,12 +2762,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto reread_page;
 	}
 	deactivate_slab(s, page, c->freelist, c);
+	local_irq_restore(flags);
 
 new_slab:
 
-	lockdep_assert_irqs_disabled();
-
 	if (slub_percpu_partial(c)) {
+		local_irq_save(flags);
+		if (unlikely(c->page)) {
+			local_irq_restore(flags);
+			goto reread_page;
+		}
+		if (unlikely(!slub_percpu_partial(c)))
+			goto new_objects; /* stolen by an IRQ handler */
+
 		page = c->page = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
 		local_irq_restore(flags);
@@ -2779,6 +2782,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
+	local_irq_save(flags);
+	if (unlikely(c->page)) {
+		local_irq_restore(flags);
+		goto reread_page;
+	}
+
+new_objects:
+
+	lockdep_assert_irqs_disabled();
+
 	freelist = get_partial(s, gfpflags, node, &page);
 	if (freelist) {
 		c->page = page;
@@ -2811,15 +2824,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 check_new_page:
 
 	if (kmem_cache_debug(s)) {
-		if (!alloc_debug_processing(s, page, freelist, addr))
+		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
+			c->page = NULL;
+			local_irq_restore(flags);
 			goto new_slab;
-		else
+		} else {
 			/*
 			 * For debug case, we don't load freelist so that all
 			 * allocations go through alloc_debug_processing()
 			 */
 			goto return_single;
+		}
 	}
 
 	if (unlikely(!pfmemalloc_match(page, gfpflags)))
-- 
2.32.0

