Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBD38F654
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhEXXmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50686 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhEXXmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnmATVE2cFsOM4l8AU+rjNgF4Z1lvhgPiSG7YMvlexg=;
        b=PCqD7jpSrVK8HyL9jdefa4okGaF8URkbUPTvS1m8iJQs7RkvR4E+TxDOi2E7QKvwcyiPjF
        LGLm8KZBbUk5f35DlF3O5sDbtsrLZjiDj1G2bl6e/MrSjlygqVsqqPQVscvZe/s31Ytep9
        U9Bm+17Du0r3VrUKiXi3IGXDLSfgotA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RnmATVE2cFsOM4l8AU+rjNgF4Z1lvhgPiSG7YMvlexg=;
        b=i59ySutqAGdk3OtHuYoc298S5w1Eyhuxp3sYi//yJVEvDMMCwPdidLLHIJPJtqeHfc9ydT
        kf9McfvjHHvRAmCg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27BA6AF23;
        Mon, 24 May 2021 23:40:48 +0000 (UTC)
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
Subject: [RFC 05/26] mm, slub: extract get_partial() from new_slab_objects()
Date:   Tue, 25 May 2021 01:39:25 +0200
Message-Id: <20210524233946.20352-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The later patches will need more fine grained control over individual actions
in ___slab_alloc(), the only caller of new_slab_objects(), so this is a first
preparatory step with no functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7b4cdc59b9ff..7973bcd42bc7 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2574,17 +2574,12 @@ slab_out_of_memory(struct kmem_cache *s, gfp_t gfpflags, int nid)
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
@@ -2748,6 +2743,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto redo;
 	}
 
+	freelist = get_partial(s, gfpflags, node, c);
+	if (freelist)
+		goto check_new_page;
+
 	freelist = new_slab_objects(s, gfpflags, node, &c);
 
 	if (unlikely(!freelist)) {
@@ -2755,6 +2754,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		return NULL;
 	}
 
+check_new_page:
 	page = c->page;
 	if (likely(!kmem_cache_debug(s) && pfmemalloc_match(page, gfpflags)))
 		goto load_freelist;
-- 
2.31.1

