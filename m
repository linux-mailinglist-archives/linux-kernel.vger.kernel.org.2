Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD13E17D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242153AbhHEPYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:24:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34046 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbhHEPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 973AD223DD;
        Thu,  5 Aug 2021 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpSEnfFVipeLYsm5P4IZ48437eDIJVCmfiiW+1mKvCY=;
        b=crx31kreGLzmTCyMpzpenqoTiUtihEXS+TB9EIlN13eBZ9O4832HU2ARkE+g5XXoII7xv3
        Bwarc8I/5lAZcy7G0X8b2LqCdap1bOAkTYdPY7NJ4CyKembxkE/tuSc7jB5OX1/Eb4NaTc
        H2zIQbO5DpXqfimqqpqBXsU0MNoWk+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176806;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpSEnfFVipeLYsm5P4IZ48437eDIJVCmfiiW+1mKvCY=;
        b=eeQLEkGRoF2i2i29Lye4HDJvdzP955C3+cSMl9jG91ge1zgVnSu58A76ft2I1803HKOawb
        TrsO8ToKeQjXz0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6965E13DAC;
        Thu,  5 Aug 2021 15:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cGgYGaYBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:06 +0000
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
Subject: [PATCH v4 13/35] mm, slub: do initial checks in ___slab_alloc() with irqs enabled
Date:   Thu,  5 Aug 2021 17:19:38 +0200
Message-Id: <20210805152000.12817-14-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As another step of shortening irq disabled sections in ___slab_alloc(), delay
disabling irqs until we pass the initial checks if there is a cached percpu
slab and it's suitable for our allocation.

Now we have to recheck c->page after actually disabling irqs as an allocation
in irq handler might have replaced it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/slub.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index db03cb972c11..7eb06fe9d7a0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2665,8 +2665,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	stat(s, ALLOC_SLOWPATH);
 
-	local_irq_save(flags);
-	page = c->page;
+reread_page:
+
+	page = READ_ONCE(c->page);
 	if (!page) {
 		/*
 		 * if the node is not online or has no normal memory, just
@@ -2675,6 +2676,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		if (unlikely(node != NUMA_NO_NODE &&
 			     !node_isset(node, slab_nodes)))
 			node = NUMA_NO_NODE;
+		local_irq_save(flags);
+		if (unlikely(c->page)) {
+			local_irq_restore(flags);
+			goto reread_page;
+		}
 		goto new_slab;
 	}
 redo:
@@ -2689,8 +2695,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto redo;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
-			deactivate_slab(s, page, c->freelist, c);
-			goto new_slab;
+			goto deactivate_slab;
 		}
 	}
 
@@ -2699,12 +2704,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(page, gfpflags))) {
-		deactivate_slab(s, page, c->freelist, c);
-		goto new_slab;
-	}
+	if (unlikely(!pfmemalloc_match(page, gfpflags)))
+		goto deactivate_slab;
 
-	/* must check again c->freelist in case of cpu migration or IRQ */
+	/* must check again c->page in case IRQ handler changed it */
+	local_irq_save(flags);
+	if (unlikely(page != c->page)) {
+		local_irq_restore(flags);
+		goto reread_page;
+	}
 	freelist = c->freelist;
 	if (freelist)
 		goto load_freelist;
@@ -2720,6 +2728,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_REFILL);
 
 load_freelist:
+
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * freelist is pointing to the list of objects to be used.
 	 * page is pointing to the page from which the objects are obtained.
@@ -2731,11 +2742,23 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	local_irq_restore(flags);
 	return freelist;
 
+deactivate_slab:
+
+	local_irq_save(flags);
+	if (page != c->page) {
+		local_irq_restore(flags);
+		goto reread_page;
+	}
+	deactivate_slab(s, page, c->freelist, c);
+
 new_slab:
 
+	lockdep_assert_irqs_disabled();
+
 	if (slub_percpu_partial(c)) {
 		page = c->page = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
+		local_irq_restore(flags);
 		stat(s, CPU_PARTIAL_ALLOC);
 		goto redo;
 	}
-- 
2.32.0

