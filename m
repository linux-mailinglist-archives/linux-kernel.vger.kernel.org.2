Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0D3A12F5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbhFILmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54644 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbhFILl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B2A47219A0;
        Wed,  9 Jun 2021 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMRaEZFMqbqCquk4QWerCUuNLFI/dmGIIEo12matNCQ=;
        b=JixlPVZ/dhqgk2DKFXTb9/92CPbymu2U2qdnX76atqNlB3g4f5zRYLrlagVZykKDgTLiih
        vdtQ2g8HU6gvUexrcHtoj++v92tsyscySr+X6yT768ECqYJ9UoxdH2tvJvzE81A8ZjkZJl
        DiBFYN5o+iGwciHTh9oG8bqhimuctos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMRaEZFMqbqCquk4QWerCUuNLFI/dmGIIEo12matNCQ=;
        b=zfxQHLpAV+0vuOAM4N2A1QLCJuhr4WM5p+V9/v0tkidBV+a2F3kGHCnPj1z3qv/ypM1tUg
        uCtQ1DyLEASbacBw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 85851118DD;
        Wed,  9 Jun 2021 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMRaEZFMqbqCquk4QWerCUuNLFI/dmGIIEo12matNCQ=;
        b=JixlPVZ/dhqgk2DKFXTb9/92CPbymu2U2qdnX76atqNlB3g4f5zRYLrlagVZykKDgTLiih
        vdtQ2g8HU6gvUexrcHtoj++v92tsyscySr+X6yT768ECqYJ9UoxdH2tvJvzE81A8ZjkZJl
        DiBFYN5o+iGwciHTh9oG8bqhimuctos=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tMRaEZFMqbqCquk4QWerCUuNLFI/dmGIIEo12matNCQ=;
        b=zfxQHLpAV+0vuOAM4N2A1QLCJuhr4WM5p+V9/v0tkidBV+a2F3kGHCnPj1z3qv/ypM1tUg
        uCtQ1DyLEASbacBw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id gI0YIHaowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:34 +0000
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
Subject: [RFC v2 16/34] mm, slub: validate slab from partial list or page allocator before making it cpu slab
Date:   Wed,  9 Jun 2021 13:38:45 +0200
Message-Id: <20210609113903.1421-17-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we obtain a new slab page from node partial list or page allocator, we
assign it to kmem_cache_cpu, perform some checks, and if they fail, we undo
the assignment.

In order to allow doing the checks without irq disabled, restructure the code
so that the checks are done first, and kmem_cache_cpu.page assignment only
after they pass.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f4ce372e3dd3..378f1cb040b3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2729,10 +2729,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	lockdep_assert_irqs_disabled();
 
 	freelist = get_partial(s, gfpflags, node, &page);
-	if (freelist) {
-		c->page = page;
+	if (freelist)
 		goto check_new_page;
-	}
 
 	local_irq_restore(flags);
 	put_cpu_ptr(s->cpu_slab);
@@ -2745,9 +2743,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 	local_irq_save(flags);
-	if (c->page)
-		flush_slab(s, c);
-
 	/*
 	 * No other reference to the page yet so we can
 	 * muck around with it freely without cmpxchg
@@ -2756,14 +2751,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	page->freelist = NULL;
 
 	stat(s, ALLOC_SLAB);
-	c->page = page;
 
 check_new_page:
 
 	if (kmem_cache_debug(s)) {
 		if (!alloc_debug_processing(s, page, freelist, addr)) {
 			/* Slab failed checks. Next slab needed */
-			c->page = NULL;
 			local_irq_restore(flags);
 			goto new_slab;
 		} else {
@@ -2782,10 +2775,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 */
 		goto return_single;
 
+	if (unlikely(c->page))
+		flush_slab(s, c);
+	c->page = page;
+
 	goto load_freelist;
 
 return_single:
 
+	if (unlikely(c->page))
+		flush_slab(s, c);
+	c->page = page;
+
 	deactivate_slab(s, page, get_freepointer(s, freelist), c);
 	local_irq_restore(flags);
 	return freelist;
-- 
2.31.1

