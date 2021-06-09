Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF4A3A12E8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239156AbhFILl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:41:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46800 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbhFILl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:27 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7C1571FD58;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JmSnpyHqca5PLmH1BHqymRQUyP4QdjzJkGjzwDILP8=;
        b=RJCMgcjXUe7ROekNc9knNZ3EovAV5bzgtjaRIZ52W6GxVogbwC36wO3UdMhVOohqu9CDr/
        mT19g+aZtuBYkD29fLKOUzc9lca6x4UBRSpC3+Xu/MZreTJLiJdxpK4JQo2Di9H85ngtam
        FuCcTosNSujvBrbU0FWZwuXQyvjED6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JmSnpyHqca5PLmH1BHqymRQUyP4QdjzJkGjzwDILP8=;
        b=bcbC7k8pol07TGi2Zq6kgTNF6P2X5P72t6Y5S5tDOI2PqAHl7iE1wo2HwFsauNM7dOdkpu
        cI0/YVvVKf6m+eDA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4E48311A98;
        Wed,  9 Jun 2021 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JmSnpyHqca5PLmH1BHqymRQUyP4QdjzJkGjzwDILP8=;
        b=RJCMgcjXUe7ROekNc9knNZ3EovAV5bzgtjaRIZ52W6GxVogbwC36wO3UdMhVOohqu9CDr/
        mT19g+aZtuBYkD29fLKOUzc9lca6x4UBRSpC3+Xu/MZreTJLiJdxpK4JQo2Di9H85ngtam
        FuCcTosNSujvBrbU0FWZwuXQyvjED6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JmSnpyHqca5PLmH1BHqymRQUyP4QdjzJkGjzwDILP8=;
        b=bcbC7k8pol07TGi2Zq6kgTNF6P2X5P72t6Y5S5tDOI2PqAHl7iE1wo2HwFsauNM7dOdkpu
        cI0/YVvVKf6m+eDA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id uI2iEnSowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:32 +0000
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
Subject: [RFC v2 05/34] mm, slub: remove redundant unfreeze_partials() from put_cpu_partial()
Date:   Wed,  9 Jun 2021 13:38:34 +0200
Message-Id: <20210609113903.1421-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d6e0b7fa1186 ("slub: make dead caches discard free slabs immediately")
introduced cpu partial flushing for kmemcg caches, based on setting the target
cpu_partial to 0 and adding a flushing check in put_cpu_partial().
This code that sets cpu_partial to 0 was later moved by c9fc586403e7 ("slab:
introduce __kmemcg_cache_deactivate()") and ultimately removed by 9855609bde03
("mm: memcg/slab: use a single set of kmem_caches for all accounted
allocations"). However the check and flush in put_cpu_partial() was never
removed, although it's effectively a dead code. So this patch removes it.

Note that d6e0b7fa1186 also added preempt_disable()/enable() to
unfreeze_partials() which could be thus also considered unnecessary. But
further patches will rely on it, so keep it.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2953f6e43cae..f740598696b4 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2420,13 +2420,6 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 	} while (this_cpu_cmpxchg(s->cpu_slab->partial, oldpage, page)
 								!= oldpage);
-	if (unlikely(!slub_cpu_partial(s))) {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
-		local_irq_restore(flags);
-	}
 	preempt_enable();
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
-- 
2.31.1

