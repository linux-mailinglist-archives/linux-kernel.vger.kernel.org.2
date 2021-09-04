Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943B2400AEC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351285AbhIDKwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351108AbhIDKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF6022685;
        Sat,  4 Sep 2021 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BpmeT6y9tW0E7A7tMHDfugGCZQ+kerTepO7ow0UTtMo=;
        b=oa+dZdnyZ3ESxNPuN6pSoiG7LV7vgkHEQCHQ6ysXEiTfH+OgXoqkp7T9Qh2F6991QL0mUK
        HDocmuVncKkFOlsrL6geqfhgddnjZ1WI9KlWEY9BbCBjpiWNkVpPggwq8sbOeYGPmJwBBM
        Lq2D3uAAzAuN3UYjDm980DytLgLa7Lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BpmeT6y9tW0E7A7tMHDfugGCZQ+kerTepO7ow0UTtMo=;
        b=GcE01FZIqNAhmjKaR6nu4cKDdAVYaBgBMNoIAcSua6qeEka1ZURwHGDwNx4Otb+zNHp+3w
        Uz91lJVLG9dNW6BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 641421348A;
        Sat,  4 Sep 2021 10:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6ATYF2NPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:11 +0000
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
Subject: [PATCH v6 12/33] mm, slub: do initial checks in ___slab_alloc() with irqs enabled
Date:   Sat,  4 Sep 2021 12:49:42 +0200
Message-Id: <20210904105003.11688-13-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4916; h=from:subject; bh=87FE9OnRJNS0hJN/F6onzd/dcCcpGvQurTw98yB4lQ4=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08layrbhE7BGZ9g7S//qCc3uINZLuKCPbVCTiBb NbCquwOJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPJQAKCRDgIcpz8YmpEOtMCA CDILOVEKEfYJTvmrsDTaROd13M9ONiFoLUR52lXtaDBErcc2QMW6FXzLUOi3iWQFHAp5LPWTrt9NgK Np+Z+F+IZyQ0aDPhIfCDPjYBH8r0Gph8m+BBUZDrRJX8736/lsoBgPfIHt0DX49bocb/CmP9Kt0llU O8R6uDo6ClD3vlQdN1gxiv59HizvJfocs69xESjAeFc3jGanCMiHCM9QumpGElzRv9CYDZi9F+ZUmn aO68evD/w6eOF3KPB7d77WiVDZ4f43c4IBAGBdMP4ga5srnUmSY5PdXtlme09hror8WfcN+yuASfLl jU9zyAzz6RFy2nLrjr/nln6gwftZiI
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As another step of shortening irq disabled sections in ___slab_alloc(), delay
disabling irqs until we pass the initial checks if there is a cached percpu
slab and it's suitable for our allocation.

Now we have to recheck c->page after actually disabling irqs as an allocation
in irq handler might have replaced it.

Because we call pfmemalloc_match() as one of the checks, we might hit
VM_BUG_ON_PAGE(!PageSlab(page)) in PageSlabPfmemalloc in case we get
interrupted and the page is freed. Thus introduce a pfmemalloc_match_unsafe()
variant that lacks the PageSlab check.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
---
 include/linux/page-flags.h |  9 +++++++
 mm/slub.c                  | 54 +++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 9 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 5922031ffab6..7fda4fb85bdc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -815,6 +815,15 @@ static inline int PageSlabPfmemalloc(struct page *page)
 	return PageActive(page);
 }
 
+/*
+ * A version of PageSlabPfmemalloc() for opportunistic checks where the page
+ * might have been freed under us and not be a PageSlab anymore.
+ */
+static inline int __PageSlabPfmemalloc(struct page *page)
+{
+	return PageActive(page);
+}
+
 static inline void SetPageSlabPfmemalloc(struct page *page)
 {
 	VM_BUG_ON_PAGE(!PageSlab(page), page);
diff --git a/mm/slub.c b/mm/slub.c
index dda05cc83eef..6295695d8515 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2620,6 +2620,19 @@ static inline bool pfmemalloc_match(struct page *page, gfp_t gfpflags)
 	return true;
 }
 
+/*
+ * A variant of pfmemalloc_match() that tests page flags without asserting
+ * PageSlab. Intended for opportunistic checks before taking a lock and
+ * rechecking that nobody else freed the page under us.
+ */
+static inline bool pfmemalloc_match_unsafe(struct page *page, gfp_t gfpflags)
+{
+	if (unlikely(__PageSlabPfmemalloc(page)))
+		return gfp_pfmemalloc_allowed(gfpflags);
+
+	return true;
+}
+
 /*
  * Check the page->freelist of a page and either transfer the freelist to the
  * per cpu freelist or deactivate the page.
@@ -2682,8 +2695,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	stat(s, ALLOC_SLOWPATH);
 
-	local_irq_save(flags);
-	page = c->page;
+reread_page:
+
+	page = READ_ONCE(c->page);
 	if (!page) {
 		/*
 		 * if the node is not online or has no normal memory, just
@@ -2692,6 +2706,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2706,8 +2725,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto redo;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
-			deactivate_slab(s, page, c->freelist, c);
-			goto new_slab;
+			goto deactivate_slab;
 		}
 	}
 
@@ -2716,12 +2734,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(page, gfpflags))) {
-		deactivate_slab(s, page, c->freelist, c);
-		goto new_slab;
-	}
+	if (unlikely(!pfmemalloc_match_unsafe(page, gfpflags)))
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
@@ -2737,6 +2758,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_REFILL);
 
 load_freelist:
+
+	lockdep_assert_irqs_disabled();
+
 	/*
 	 * freelist is pointing to the list of objects to be used.
 	 * page is pointing to the page from which the objects are obtained.
@@ -2748,11 +2772,23 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.33.0

