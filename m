Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7073A12F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbhFILmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbhFILla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DF76219E1;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8v4ryVEKUVoC+Nx8Pww9inYHYBKUn8XDFXC2DN/iVs=;
        b=hQJ14+UFclogDrfchxtALGrb5AN/Qu62FILb5FBbctbbzOVCNPpeX3lA+btq04MsEKTbtO
        sG2m+jjPz+/USgzwFSNzGa9m0j4QhVSYXXO3sluq4oDNEJXlrAWSG5bsU9Hqa+X6X8Tgja
        WbMpLZ6NAa3hMrVvCY6VHG96k7uwcq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8v4ryVEKUVoC+Nx8Pww9inYHYBKUn8XDFXC2DN/iVs=;
        b=PaMxdXxvO6Exmk8d3FptcxglUOrdFSfEbkRN4Jnc8ppEBjJ3TDmap479lfL7G7XqP/mIJL
        0Ri6gSjT6zL40BCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id E38DF118DD;
        Wed,  9 Jun 2021 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8v4ryVEKUVoC+Nx8Pww9inYHYBKUn8XDFXC2DN/iVs=;
        b=hQJ14+UFclogDrfchxtALGrb5AN/Qu62FILb5FBbctbbzOVCNPpeX3lA+btq04MsEKTbtO
        sG2m+jjPz+/USgzwFSNzGa9m0j4QhVSYXXO3sluq4oDNEJXlrAWSG5bsU9Hqa+X6X8Tgja
        WbMpLZ6NAa3hMrVvCY6VHG96k7uwcq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z8v4ryVEKUVoC+Nx8Pww9inYHYBKUn8XDFXC2DN/iVs=;
        b=PaMxdXxvO6Exmk8d3FptcxglUOrdFSfEbkRN4Jnc8ppEBjJ3TDmap479lfL7G7XqP/mIJL
        0Ri6gSjT6zL40BCg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id iHkcN3aowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:34 +0000
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
Subject: [RFC v2 18/34] mm, slub: stop disabling irqs around get_partial()
Date:   Wed,  9 Jun 2021 13:38:47 +0200
Message-Id: <20210609113903.1421-19-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function get_partial() does not need to have irqs disabled as a whole. It's
sufficient to convert spin_lock operations to their irq saving/restoring
versions.

As a result, it's now possible to reach the page allocator from the slab
allocator without disabling and re-enabling interrupts on the way.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 760080b58957..6f894d1e84d6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1950,11 +1950,12 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
  * Try to allocate a partial slab from a specific node.
  */
 static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-			      struct page **ret_page, gfp_t flags)
+			      struct page **ret_page, gfp_t gfpflags)
 {
 	struct page *page, *page2;
 	void *object = NULL;
 	unsigned int available = 0;
+	unsigned long flags;
 	int objects;
 
 	/*
@@ -1966,11 +1967,11 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 	if (!n || !n->nr_partial)
 		return NULL;
 
-	spin_lock(&n->list_lock);
+	spin_lock_irqsave(&n->list_lock, flags);
 	list_for_each_entry_safe(page, page2, &n->partial, slab_list) {
 		void *t;
 
-		if (!pfmemalloc_match(page, flags))
+		if (!pfmemalloc_match(page, gfpflags))
 			continue;
 
 		t = acquire_slab(s, n, page, object == NULL, &objects);
@@ -1991,7 +1992,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			break;
 
 	}
-	spin_unlock(&n->list_lock);
+	spin_unlock_irqrestore(&n->list_lock, flags);
 	return object;
 }
 
@@ -2706,8 +2707,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			local_irq_restore(flags);
 			goto reread_page;
 		}
-		if (unlikely(!slub_percpu_partial(c)))
+		if (unlikely(!slub_percpu_partial(c))) {
+			local_irq_restore(flags);
 			goto new_objects; /* stolen by an IRQ handler */
+		}
 
 		page = c->page = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, page);
@@ -2716,18 +2719,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
-	local_irq_save(flags);
-	if (unlikely(c->page)) {
-		local_irq_restore(flags);
-		goto reread_page;
-	}
-
 new_objects:
 
-	lockdep_assert_irqs_disabled();
-
 	freelist = get_partial(s, gfpflags, node, &page);
-	local_irq_restore(flags);
 	if (freelist)
 		goto check_new_page;
 
-- 
2.31.1

