Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519353E17EB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbhHEPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:25:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34220 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbhHEPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B57D223E6;
        Thu,  5 Aug 2021 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIdcFtE8RY52cb60LfRZfBd4IzlUEE7xiTzo3NifrlM=;
        b=CE8KYpFlp71DrEpf5l+Xq1oWOuoBm7K4rV1LQIHKTZqUYm7hEqhVLoS2uQX47WoZ1GRC98
        6xmPB1UolrHaWhyS5lSYCqncwsRo5XL9KFGpTRTJQx+IzsGu7JQcxsLGmB0RBqh8QdqIOw
        8PqXqMk3lSljp43o5AuHbi6056NR7v4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176809;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIdcFtE8RY52cb60LfRZfBd4IzlUEE7xiTzo3NifrlM=;
        b=omZRhwN1CBAyABvi1yTlH7aI7Amr7RxOivKuYEWXWIiepp/C+X7Np9cbnPo/7/5MgFULJQ
        Gly5ZDdMiMC1w2DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FCFD13DA8;
        Thu,  5 Aug 2021 15:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KEgID6kBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:09 +0000
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
Subject: [PATCH v4 28/35] mm, slab: make flush_slab() possible to call with irqs enabled
Date:   Thu,  5 Aug 2021 17:19:53 +0200
Message-Id: <20210805152000.12817-29-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
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
index c10f2c9b9352..dceb289cb052 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2477,16 +2477,28 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
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
@@ -2496,7 +2508,7 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
 	if (c->page)
-		flush_slab(s, c);
+		flush_slab(s, c, false);
 
 	unfreeze_partials_cpu(s, c);
 }
@@ -2512,7 +2524,7 @@ static void flush_cpu_slab(void *d)
 	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
 
 	if (c->page)
-		flush_slab(s, c);
+		flush_slab(s, c, false);
 
 	unfreeze_partials(s);
 }
-- 
2.32.0

