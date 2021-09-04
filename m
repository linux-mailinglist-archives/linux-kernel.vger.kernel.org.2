Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C721E400AE6
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351099AbhIDKvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59794 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351114AbhIDKvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DFD7E22692;
        Sat,  4 Sep 2021 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEymnrLAdycXLEBJApfPxYhDTw/EX4tPQinZrfLSvMA=;
        b=KcHB/EXBFjURXxI41CCrdnf4JhSmejTHMLIQI1fX4tUFapjyyEaALL9MOUxIERLA8fKdb3
        kOKTMBhOQuzAoAKNNY+WEYcuc6FTqfTBcUVnCxGAxBbQlzFVvlMET+HBvR2OZJMAdQsJUv
        XI5eRDMWpEqFsiyKt34PtgWtBrLtY28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TEymnrLAdycXLEBJApfPxYhDTw/EX4tPQinZrfLSvMA=;
        b=1W6Gb548jEJMcou17aXUN21HKYV/BUF3FTm/WRGZTFgAGJuGUe9koedIjSqwuNroh+RcPj
        itC96Nrinos/HQBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9D131348A;
        Sat,  4 Sep 2021 10:50:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gFK/LGNPM2HoUQAAMHmgww
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
Subject: [PATCH v6 14/33] mm, slub: restore irqs around calling new_slab()
Date:   Sat,  4 Sep 2021 12:49:44 +0200
Message-Id: <20210904105003.11688-15-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; h=from:subject; bh=hiYjFkgYOx65xN3plTEUgZd4l4T9CUvQgDc0ydDV7Pk=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM08qPCuji38EcARo3dHO386xZVezBABOz2fE1v3y 115Zjr+JATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPKgAKCRDgIcpz8YmpEMKoB/ 9sDfd09t4xNZ1XmBY3XofDM6R2Ho8xiWQdZ7Gl25JQA+CqyiGeQqqoFngN8YzHUcAOPPWuUy08zQ2f p++YMY/CuOYmcgjz9Urzd44qN7n3IQlHzTKPQlwR7et0iaABWwnYEHE7doFIu42rV7FnGhLO2PpQW0 +yW4uiXmZKwfnMnN2eu9rRclbW2r7LC9tF2PN9D7xUYd4I+3G7fUKmCEROuN2IW13FRpD3dYf6WAmK MK935Q6ShVEWtdRuJb2jXKZV1eiTAaWpWdkUZkd0wq5a7Ppe1ESHqA91DfCd5wYeCkmpbmqOiq+/9G 2GoPJHlKnlw0d7jZRgE1l4daFf0309
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allocate_slab() currently re-enables irqs before calling to the page allocator.
It depends on gfpflags_allow_blocking() to determine if it's safe to do so.
Now we can instead simply restore irq before calling it through new_slab().
The other caller early_kmem_cache_node_alloc() is unaffected by this.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4d1f3e4a5951..7798ba1c614f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1809,9 +1809,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 	flags &= gfp_allowed_mask;
 
-	if (gfpflags_allow_blocking(flags))
-		local_irq_enable();
-
 	flags |= s->allocflags;
 
 	/*
@@ -1870,8 +1867,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->frozen = 1;
 
 out:
-	if (gfpflags_allow_blocking(flags))
-		local_irq_disable();
 	if (!page)
 		return NULL;
 
@@ -2812,16 +2807,17 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto check_new_page;
 	}
 
+	local_irq_restore(flags);
 	put_cpu_ptr(s->cpu_slab);
 	page = new_slab(s, gfpflags, node);
 	c = get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!page)) {
-		local_irq_restore(flags);
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
 
+	local_irq_save(flags);
 	if (c->page)
 		flush_slab(s, c);
 
-- 
2.33.0

