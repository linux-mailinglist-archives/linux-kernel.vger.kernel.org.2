Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF493DA3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbhG2NWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:22:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38420 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237501AbhG2NVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C18CC223D9;
        Thu, 29 Jul 2021 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9katWnfmArnWvO9KXk/+VitaeXhhHIpd56N9sWxuL/U=;
        b=wCfKe5GRnTGR+i24GtCLu6jaIMaHrASpz7ZCOvwSQIUkneJFvYQIE3TTLn43EIolGJvN5S
        /RKVlcUYkO8ARXza4bT8E70+IfAGlqu6R3bHo4Ok0hD5OgqQO3lCoCyuOrdwSXZN0XKcP7
        Fd1HwL2b9bSaHWcTckYMDZ4priEPKUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564903;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9katWnfmArnWvO9KXk/+VitaeXhhHIpd56N9sWxuL/U=;
        b=NOX1Ne1QXDUU5PiUQg5G5yCOojtPqjyy144ByTkn5JgOkcKciXAH2KrfS5hZ3jk6+2dNCv
        kgbLUXEY1COH9oCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94FBE13AE9;
        Thu, 29 Jul 2021 13:21:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8KzVI2erAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:43 +0000
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
Subject: [PATCH v3 18/35] mm, slub: stop disabling irqs around get_partial()
Date:   Thu, 29 Jul 2021 15:21:15 +0200
Message-Id: <20210729132132.19691-19-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
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
index fe0594b60e93..50a4add8983d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1993,11 +1993,12 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags);
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
@@ -2009,11 +2010,11 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
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
@@ -2034,7 +2035,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			break;
 
 	}
-	spin_unlock(&n->list_lock);
+	spin_unlock_irqrestore(&n->list_lock, flags);
 	return object;
 }
 
@@ -2749,8 +2750,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2759,18 +2762,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.32.0

