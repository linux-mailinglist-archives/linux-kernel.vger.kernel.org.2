Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CD3A1302
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbhFILmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47100 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239163AbhFILlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C0CC1FD6B;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cqt0VXEchackCh9ETD6KPbwS56wP8+xgoNpRJiEk95Q=;
        b=gpYYQAKtd2Lwif+d4UZBHLgSL8vuuV+4zM4kQ1Ln6B6RZo4EnFEmpmcKrw2lXGLdfKpb+c
        SMseFmoRl3zVfWtFjvyKxgofvLyau2t+voqxPqCHPcoq+ZnWfH2T2fq6eGqW393QZmaov2
        1zwd7rQt7dwHJtDDfd34O/+c0FrWpXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cqt0VXEchackCh9ETD6KPbwS56wP8+xgoNpRJiEk95Q=;
        b=okCO1DzMKaLPjSNK2ZYSOvomn80slibDBV2mV+Y/ePmltdzlc1O1KSDFI5Ln4UV+YEhYzz
        EgVrDFJlomag1GBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 1E02811A98;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cqt0VXEchackCh9ETD6KPbwS56wP8+xgoNpRJiEk95Q=;
        b=gpYYQAKtd2Lwif+d4UZBHLgSL8vuuV+4zM4kQ1Ln6B6RZo4EnFEmpmcKrw2lXGLdfKpb+c
        SMseFmoRl3zVfWtFjvyKxgofvLyau2t+voqxPqCHPcoq+ZnWfH2T2fq6eGqW393QZmaov2
        1zwd7rQt7dwHJtDDfd34O/+c0FrWpXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cqt0VXEchackCh9ETD6KPbwS56wP8+xgoNpRJiEk95Q=;
        b=okCO1DzMKaLPjSNK2ZYSOvomn80slibDBV2mV+Y/ePmltdzlc1O1KSDFI5Ln4UV+YEhYzz
        EgVrDFJlomag1GBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id MMjdBneowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:35 +0000
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
Subject: [RFC v2 19/34] mm, slub: move reset of c->page and freelist out of deactivate_slab()
Date:   Wed,  9 Jun 2021 13:38:48 +0200
Message-Id: <20210609113903.1421-20-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deactivate_slab() removes the cpu slab by merging the cpu freelist with slab's
freelist and putting the slab on the proper node's list. It also sets the
respective kmem_cache_cpu pointers to NULL.

By extracting the kmem_cache_cpu operations from the function, we can make it
not dependent on disabled irqs.

Also if we return a single free pointer from ___slab_alloc, we no longer have
to assign kmem_cache_cpu.page before deactivation or care if somebody preempted
us and assigned a different page to our kmem_cache_cpu in the process.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6f894d1e84d6..8b0b975bfa36 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2149,10 +2149,13 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 }
 
 /*
- * Remove the cpu slab
+ * Finishes removing the cpu slab. Merges cpu's freelist with page's freelist,
+ * unfreezes the slabs and puts it on the proper list.
+ * Assumes the slab has been already safely taken away from kmem_cache_cpu
+ * by the caller.
  */
 static void deactivate_slab(struct kmem_cache *s, struct page *page,
-				void *freelist, struct kmem_cache_cpu *c)
+			    void *freelist)
 {
 	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
@@ -2281,9 +2284,6 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
-
-	c->page = NULL;
-	c->freelist = NULL;
 }
 
 /*
@@ -2408,10 +2408,16 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
-	stat(s, CPUSLAB_FLUSH);
-	deactivate_slab(s, c->page, c->freelist, c);
+	void *freelist = c->freelist;
+	struct page *page = c->page;
 
+	c->page = NULL;
+	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
+
+	deactivate_slab(s, page, freelist);
+
+	stat(s, CPUSLAB_FLUSH);
 }
 
 /*
@@ -2696,7 +2702,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		local_irq_restore(flags);
 		goto reread_page;
 	}
-	deactivate_slab(s, page, c->freelist, c);
+	freelist = c->freelist;
+	c->page = NULL;
+	c->freelist = NULL;
+	deactivate_slab(s, page, freelist);
 	local_irq_restore(flags);
 
 new_slab:
@@ -2775,11 +2784,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 return_single:
 
 	local_irq_save(flags);
-	if (unlikely(c->page))
-		flush_slab(s, c);
-	c->page = page;
-
-	deactivate_slab(s, page, get_freepointer(s, freelist), c);
+	deactivate_slab(s, page, get_freepointer(s, freelist));
 	local_irq_restore(flags);
 	return freelist;
 }
-- 
2.31.1

