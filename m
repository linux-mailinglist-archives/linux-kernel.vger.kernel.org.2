Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC0B3F4CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhHWPBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60742 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhHWO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9AEC120009;
        Mon, 23 Aug 2021 14:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AndxTRuNtCFJKZWJMxgoEcJJk99rnnvBQrqH6rnWB7o=;
        b=W4YDIvNUF5jbGDP3cMILfjoDYthpotjbv22c+HvwXEDwPqZWBOcE8zRhrhEd3jlHMk7HBW
        JOOcY/bQ1hdjB2a5zptPHaDZnGUwHQ1aO+wTnKseaB6BCYZFoZnbK3mqEKfE/uvG7UeRr4
        g4hjDmHzvvtZmZKOCrO5mKcE1VEAFpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AndxTRuNtCFJKZWJMxgoEcJJk99rnnvBQrqH6rnWB7o=;
        b=y7ufV/XEL1xXBMSF5DL2OdlacQZQc5AH4/eGKyi32oIKavgOzoFGqqFYXC7qg8qz9TLK2c
        KVGqDzZmUEvTWABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72E6413BE0;
        Mon, 23 Aug 2021 14:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eDGLG6K3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:42 +0000
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
Subject: [PATCH v5 28/35] mm, slab: make flush_slab() possible to call with irqs enabled
Date:   Mon, 23 Aug 2021 16:58:19 +0200
Message-Id: <20210823145826.3857-29-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently flush_slab() is always called with disabled IRQs if it's needed, but
the following patches will change that, so add a parameter to control IRQ
disabling within the function, which only protects the kmem_cache_cpu
manipulation and not the call to deactivate_slab() which doesn't need it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ddcaddc5e801..bb7e05543738 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2480,16 +2480,28 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
+static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			      bool lock)
 {
-	void *freelist = c->freelist;
-	struct page *page = c->page;
+	unsigned long flags;
+	void *freelist;
+	struct page *page;
+
+	if (lock)
+		local_irq_save(flags);
+
+	freelist = c->freelist;
+	page = c->page;
 
 	c->page = NULL;
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
 
-	deactivate_slab(s, page, freelist);
+	if (lock)
+		local_irq_restore(flags);
+
+	if (page)
+		deactivate_slab(s, page, freelist);
 
 	stat(s, CPUSLAB_FLUSH);
 }
@@ -2499,7 +2511,7 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	if (c->page)
-		flush_slab(s, c);
+		flush_slab(s, c, false);
 
 	unfreeze_partials_cpu(s, c);
 }
@@ -2515,7 +2527,7 @@ static void flush_cpu_slab(void *d)
 	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
 
 	if (c->page)
-		flush_slab(s, c);
+		flush_slab(s, c, false);
 
 	unfreeze_partials(s);
 }
-- 
2.32.0

