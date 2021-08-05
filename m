Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5F3E17D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbhHEPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:24:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34096 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbhHEPUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1708223DE;
        Thu,  5 Aug 2021 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOXrWd8xXiPpj97LPVMpLwoNpZ8JIuzAy7sOYm8ZXA0=;
        b=axnmtkgNecVAlM/uNDsH01WEv/8Lw2a5Oenh/cj2/cDuRWH68+ID7iLEqU/9O5uaamyGkI
        Cme+TSHb38Rgp9quRs/XVRU1R2zLyFtxUJLCDD4B5B565pb/2lFDzxHb5gD73xFty1Mfpc
        fcyukvDd6a6dIyawdg7vfJd0tD6Dd7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176806;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nOXrWd8xXiPpj97LPVMpLwoNpZ8JIuzAy7sOYm8ZXA0=;
        b=lmA2U4ENLz6ozFCd/vD3YKwBUjayiZmFKnxrtJuJIDHDBVgylm+Hzcs7i/a1+zujVFqjL1
        kEIpbCv3CvohBMCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7A0513DAC;
        Thu,  5 Aug 2021 15:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EHP3L6YBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:06 +0000
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
Subject: [PATCH v4 15/35] mm, slub: restore irqs around calling new_slab()
Date:   Thu,  5 Aug 2021 17:19:40 +0200
Message-Id: <20210805152000.12817-16-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
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
index 868a782b6f62..9350ff5110a0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1792,9 +1792,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 	flags &= gfp_allowed_mask;
 
-	if (gfpflags_allow_blocking(flags))
-		local_irq_enable();
-
 	flags |= s->allocflags;
 
 	/*
@@ -1853,8 +1850,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->frozen = 1;
 
 out:
-	if (gfpflags_allow_blocking(flags))
-		local_irq_disable();
 	if (!page)
 		return NULL;
 
@@ -2782,16 +2777,17 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.32.0

