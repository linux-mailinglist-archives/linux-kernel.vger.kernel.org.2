Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1533DA3E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbhG2NWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:22:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38500 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237350AbhG2NVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 027F7223D8;
        Thu, 29 Jul 2021 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wUXefGogUvby0u0ZYeK4JTU6bSiRmchnpXl1sp1MEY=;
        b=KXdbvxoFOOlXQtdQeSkLXYjVGt+sTeJZEypH6XHLEiFbPF0axiMz9xrmRlZD6yA88bud+I
        UC0S/1ssArfuegRDyTB1VL/017rcvechg2W1nNBKmb2/ImwUp3sEodhcYBNiNZoTwAnUdT
        glHhTNZ9Fv6YzvY1dEyE1zUzWRqWYNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4wUXefGogUvby0u0ZYeK4JTU6bSiRmchnpXl1sp1MEY=;
        b=XaoeZ5+6og1YBZsFd7SDOnCC3PzWMduJnk08NgzhATKIs9PmMG38dzCaWu+2iH+h1Enwpy
        UZQNSq+pgnzc8lDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3E9713AE9;
        Thu, 29 Jul 2021 13:21:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yPX+LmarAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:42 +0000
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
Subject: [PATCH v3 14/35] mm, slub: move disabling irqs closer to get_partial() in ___slab_alloc()
Date:   Thu, 29 Jul 2021 15:21:11 +0200
Message-Id: <20210729132132.19691-15-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index dd01af81dd77..187424ebf1d8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2676,11 +2676,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2721,6 +2716,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	if (!freelist) {
 		c->page = NULL;
+		local_irq_restore(flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2750,12 +2746,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2763,6 +2766,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2795,15 +2808,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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

