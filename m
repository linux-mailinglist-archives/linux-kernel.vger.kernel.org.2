Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABFF400AEF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhIDKwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41860 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351118AbhIDKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6735120047;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFMhySTaq6YX9S5AT4glg+2GS+e5+3dtX0MMjEGbNOM=;
        b=n0Y9nH5xLlkxKZ00bWqf712wPmz8x6ZxBjC/kHB3BcLOcaiTY+xxU0JdlI6b4xCDc2p6qj
        XOo+AOpDqvEj5KwqtFdOO2LShOxjBrB8dbqnRhxC5mMn7UoT8ecgmyDiYDYx51DI0f5wQc
        b0AdbPqVhkKbd0nPW+8jQkSgRN9p244=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFMhySTaq6YX9S5AT4glg+2GS+e5+3dtX0MMjEGbNOM=;
        b=ae2g3hL7b+RjqspV0GH3negCxho2reP8CJ+JgxKm+cw2zoefwjaMHQG2gx1YAgitHWNQ/t
        GWIrO1xMy+ZLfQAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40C3213A2C;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kIgyD2RPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:12 +0000
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
Subject: [PATCH v6 17/33] mm, slub: stop disabling irqs around get_partial()
Date:   Sat,  4 Sep 2021 12:49:47 +0200
Message-Id: <20210904105003.11688-18-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602; h=from:subject; bh=52j8sujcm4of7FmRbqiBJPbkJ2aBJYGWEd6QWSsF+6M=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08xYuBbSPdDE/wxVSZTpEmavIss5mEc8JObjR3R M7rXrymJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPMQAKCRDgIcpz8YmpEFTBCA CsSfzb6YngNCvKefgnDZLDHJpecUw7rQNdmr1HYt+eSgrcaJuN2lSFUyHb8A9W2fhGmhlQNiLAKoT6 v/TkHgbfK1wAIvIw0nnVcMkVDrGR7FUUjXA9QkSKtrK2XZ0PeVaogK40lgsnNe5Gdvgq1GrfkzAoQl cYSRjqUbLuyVIFxHK745kJOHGH8sr0fOezWsmavQ89FGR7eYFuG+PdRy0zNb0f6EkrZwZ9cxNSG3Tr p9IrCrZ+BFi6L+SG5ivQ6xC71xf/Pt7P9EzFueSzwAGRI4zfDIo4+ziGwI/tL2CS6yHHOZHyJ7BbGx UTNOfHXnX4naeuVB5YOJ5Y+HdCmqVE
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index b5788040d92e..8433e50d2c8e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2010,11 +2010,12 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
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
@@ -2026,11 +2027,11 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
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
@@ -2051,7 +2052,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			break;
 
 	}
-	spin_unlock(&n->list_lock);
+	spin_unlock_irqrestore(&n->list_lock, flags);
 	return object;
 }
 
@@ -2779,8 +2780,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2789,18 +2792,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.33.0

