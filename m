Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74333DA3DD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbhG2NWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:22:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38376 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237453AbhG2NVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:21:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 940F1223D1;
        Thu, 29 Jul 2021 13:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627564901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7rwb3IAzM4bniGMFK16TTs3xhsRaSA8A92Uokxj+Uk=;
        b=kNNmOfJrRBJWZs26WD5Btju+nQs11uHJt1jp2ltZc3DjWwuldDCA/8hAeaiceP+LqsXmAR
        sdPGuzFhiD4yNxqngD7jG1C0pplL8P8MzVJNPA/s91c06KBzhQva7EFN0EhL3DdNbvh/Np
        FXnzAXHEJ0yXI1KoiqKUqoEicwuLsa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627564901;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7rwb3IAzM4bniGMFK16TTs3xhsRaSA8A92Uokxj+Uk=;
        b=lR7fQB4KEKFyDfNYzCjyeCNXmCgcZUpjVebk1GhzQY2uGIZFNVqHm0ePiQ7t/KHYbjLTsX
        VwooQV5fsjMPkiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6982113AF4;
        Thu, 29 Jul 2021 13:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gCkpGWWrAmF9AwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 13:21:41 +0000
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
Subject: [PATCH v3 07/35] mm, slub: extract get_partial() from new_slab_objects()
Date:   Thu, 29 Jul 2021 15:21:04 +0200
Message-Id: <20210729132132.19691-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729132132.19691-1-vbabka@suse.cz>
References: <20210729132132.19691-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patches will need more fine grained control over individual actions
in ___slab_alloc(), the only caller of new_slab_objects(), so this is a first
preparatory step with no functional change.

This adds a goto label that appears unnecessary at this point, but will be
useful for later changes.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Christoph Lameter <cl@linux.com>
---
 mm/slub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5673bdbfc23d..09fa967519c5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2596,17 +2596,12 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
 static inline void *new_slab_objects(struct kmem_cache *s, gfp_t flags,
 			int node, struct kmem_cache_cpu **pc)
 {
-	void *freelist;
+	void *freelist = NULL;
 	struct kmem_cache_cpu *c = *pc;
 	struct page *page;
 
 	WARN_ON_ONCE(s->ctor && (flags & __GFP_ZERO));
 
-	freelist = get_partial(s, flags, node, c);
-
-	if (freelist)
-		return freelist;
-
 	page = new_slab(s, flags, node);
 	if (page) {
 		c = raw_cpu_ptr(s->cpu_slab);
@@ -2770,6 +2765,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
+	freelist = get_partial(s, gfpflags, node, c);
+	if (freelist)
+		goto check_new_page;
+
 	freelist = new_slab_objects(s, gfpflags, node, &c);
 
 	if (unlikely(!freelist)) {
@@ -2777,6 +2776,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
+check_new_page:
 	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
 		goto load_freelist;
-- 
2.32.0

