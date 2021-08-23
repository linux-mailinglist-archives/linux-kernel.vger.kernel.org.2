Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9173F4CE1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhHWPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60454 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhHWO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CCBB2000C;
        Mon, 23 Aug 2021 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrtE2HucLxSOYjsQdGKegLbZEvI7SFTw8W15rOdcGSI=;
        b=F49VEMgYVXc/FcjRoOICDD7kiC9ZPxkwM4CvNed6+en9xrQvV7p/p2NyDdoQrNxl5wz93H
        SFDJsknyfyp90zgdf7QYhIdGHzj8qqfDKs4hT9QtuLSyKpr1Ay3a6BYxsz+PyJ6Rc88u52
        j/BXdCpUNxm2B/5SZUJtWVGK++RWNTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vrtE2HucLxSOYjsQdGKegLbZEvI7SFTw8W15rOdcGSI=;
        b=KYw96IjVS/8kl0iVsVreQeyJ4S9/SAcmdqmtkN7Qgt6brgb2gE5jLvVGWMk+fuiIaZ3TDg
        hQSTREcR7j0F/MCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6E3B13BE1;
        Mon, 23 Aug 2021 14:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GOjWN6C3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:40 +0000
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
Subject: [PATCH v5 19/35] mm, slub: move reset of c->page and freelist out of deactivate_slab()
Date:   Mon, 23 Aug 2021 16:58:10 +0200
Message-Id: <20210823145826.3857-20-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
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
index ad2c58a31af5..ef36c94f27e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2195,10 +2195,13 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
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
@@ -2327,9 +2330,6 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
-
-	c->page = NULL;
-	c->freelist = NULL;
 }
 
 /*
@@ -2454,10 +2454,16 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
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
@@ -2755,7 +2761,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -2834,11 +2843,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.32.0

