Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225D43F4CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhHWO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 10:59:46 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51620 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhHWO7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9505B21FD8;
        Mon, 23 Aug 2021 14:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXjHaSea/rcrLxRaQNMT+12HXxQCY7WQ5QbH5T0zz2A=;
        b=hMJwV1FHuqepDdcgLIFHSUtLVV8Cvbi8ofEzzNkQHxWal7DOoDm06BH99Ia33G9tOkpInr
        Dko5wf1DSNMhYNPFIoN1uXH1zErqKBvbajxcCcohis20IbDpAThaFA1DAztz+GVWX+6xCO
        rjlZb7rim7LLK8eZaOyHznsnfhP4e+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXjHaSea/rcrLxRaQNMT+12HXxQCY7WQ5QbH5T0zz2A=;
        b=mQPfgy06i5qAd+Ys4/oymlktzgRnez5g/EfpMKsiNwd4Pz4ZahHq011GJA9oAniOXfeNwV
        OIu71SuFAJ8yNVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B49A13BE1;
        Mon, 23 Aug 2021 14:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iNSsGZ63I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:38 +0000
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
Subject: [PATCH v5 05/35] mm, slub: remove redundant unfreeze_partials() from put_cpu_partial()
Date:   Mon, 23 Aug 2021 16:57:56 +0200
Message-Id: <20210823145826.3857-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
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
index fee093db2bfd..79e53303844c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2466,13 +2466,6 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
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
2.32.0

