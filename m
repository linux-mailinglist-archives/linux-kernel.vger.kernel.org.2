Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB703A1305
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbhFILnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:43:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239162AbhFILlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:31 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 84B1D1FD69;
        Wed,  9 Jun 2021 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbfCejBm4aJ4eyiGJzBDybVMR3HougtHgUCP1fs72bo=;
        b=abQ+3zq7aibBT/g90YxFKE7rlf+NZ9S9FZTxwKAh2QuzmHAYSsa8uB5EK/eiHpxrHVrPxq
        pgjW2LElsW0P+47Y+kCK7ikqyJsPBOZvoJKHKcxqiVqsGrH2Qoat0SQPh+TJAnsFRSyH+B
        AjgejlpHfvZzB4AoT7DbzQM4CynrS/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbfCejBm4aJ4eyiGJzBDybVMR3HougtHgUCP1fs72bo=;
        b=bqh+vEXLGfW4VC1I3METAhg3INHSZVUllLrlgqb3HKqRkpcukg/2P3UhNoA4Ky7WoOrqok
        A7E8UUQ37dmjHKBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 55DBC11A98;
        Wed,  9 Jun 2021 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbfCejBm4aJ4eyiGJzBDybVMR3HougtHgUCP1fs72bo=;
        b=abQ+3zq7aibBT/g90YxFKE7rlf+NZ9S9FZTxwKAh2QuzmHAYSsa8uB5EK/eiHpxrHVrPxq
        pgjW2LElsW0P+47Y+kCK7ikqyJsPBOZvoJKHKcxqiVqsGrH2Qoat0SQPh+TJAnsFRSyH+B
        AjgejlpHfvZzB4AoT7DbzQM4CynrS/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbfCejBm4aJ4eyiGJzBDybVMR3HougtHgUCP1fs72bo=;
        b=bqh+vEXLGfW4VC1I3METAhg3INHSZVUllLrlgqb3HKqRkpcukg/2P3UhNoA4Ky7WoOrqok
        A7E8UUQ37dmjHKBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id QLR+FHaowGD6XgAALh3uQQ
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
Subject: [RFC v2 15/34] mm, slub: restore irqs around calling new_slab()
Date:   Wed,  9 Jun 2021 13:38:44 +0200
Message-Id: <20210609113903.1421-16-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index acb5e8f1d9da..f4ce372e3dd3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1749,9 +1749,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 
 	flags &= gfp_allowed_mask;
 
-	if (gfpflags_allow_blocking(flags))
-		local_irq_enable();
-
 	flags |= s->allocflags;
 
 	/*
@@ -1810,8 +1807,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->frozen = 1;
 
 out:
-	if (gfpflags_allow_blocking(flags))
-		local_irq_disable();
 	if (!page)
 		return NULL;
 
@@ -2739,16 +2734,17 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
2.31.1

