Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E21400AE8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351235AbhIDKwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59774 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351110AbhIDKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B757122691;
        Sat,  4 Sep 2021 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeP3y1r57GihuVpPrXb/4+oTDnqjGJYOBqRgC4z0qxk=;
        b=OYzEHuMAt862dmgxmu7nTeSkbNQQ6h7WKAwJk3zLGQDIdl6Tm2aYPijjG5rNKYUHs0jfdo
        ILYli5tNUo4Tdhc4HZqdEvzY1o7s1xmbkVDrUWELAbFR8tISOrZBb9ywAkBF01HKJlJuoY
        WZfyg9jYM6b6nx9/6l1wyg9hvXZCWmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GeP3y1r57GihuVpPrXb/4+oTDnqjGJYOBqRgC4z0qxk=;
        b=yJ2xTjx5TFg3TkZ+YtjFF6w/Ct8WXnYBewCvJxf6QtMbJ3xhl20PB0iUKARZfRWAtHVm0v
        vZfLppE6GtrcxnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E24013A2C;
        Sat,  4 Sep 2021 10:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qAMUImNPM2HoUQAAMHmgww
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
Subject: [PATCH v6 13/33] mm, slub: move disabling irqs closer to get_partial() in ___slab_alloc()
Date:   Sat,  4 Sep 2021 12:49:43 +0200
Message-Id: <20210904105003.11688-14-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2724; h=from:subject; bh=6/2Q0TW+Pawcgtmp309Wzzvc5MR3xNVTm4xAJlaknaI=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08od0TXtQnY9rR3B/9gzF+fRHWGoGSYMpwD4kiC 5dSHTamJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPKAAKCRDgIcpz8YmpEI6yCA C3f/QquTpEwCji1R3sb2SJp7soYR+YYU69SR6du3GOCUHms36D+UjHzU6Ng//p49xItGUZXOLaANZD FRrWt02HvKe0ZSewoAevuag0/jcvf705wfcM3HVojDL68Jf0aJe41QLqoEj30z3pUr1gLLWodHEWcw sk+V6QYa8oqU5Cc8IWtpSynmWGLPL91vPJrVZHX6PxvabXZvIR21rJLokfKe3j0g5LFGoK06p+C+s5 g/pmSNfQcOTQkbAX90DNdue7XUurfnRkKgQ5+YWz4BOn2G4L7m+95PWo1ZXQ5BJpjONvB138lrZfA9 Oh8FikVVhoKQGqLpt2uhaftt5+KIY4
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
index 6295695d8515..4d1f3e4a5951 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2706,11 +2706,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2751,6 +2746,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	if (!freelist) {
 		c->page = NULL;
+		local_irq_restore(flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -2780,12 +2776,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2793,6 +2796,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2825,15 +2838,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.33.0

