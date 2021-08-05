Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB68F3E17C5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbhHEPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:21:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33952 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbhHEPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:20:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0E35F2230A;
        Thu,  5 Aug 2021 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628176805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIPKR8wh8GFRHbfvvx5orNH+gLTr2c1nG0HwbhXdS6A=;
        b=DvCOyy4GzvizAhEwlIXRLWZCMdbBVtzM4sk1g4NaGd4tscBFxNkGm+w6UB04uT8vlI23Ge
        mv59U+UdiXuFAMsGkXWh+f8nSmDJqaBrYv5N6H3SWYym3TIFVEtPNyFuuwBx2Cu/2IVANT
        4RvD3v56UTXSaZ0RT5mfrf0sB5FuZSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628176805;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIPKR8wh8GFRHbfvvx5orNH+gLTr2c1nG0HwbhXdS6A=;
        b=WX1iiBydl+rNMfqXvA19XSJO16aeAa7HCq/TymHD85ixlvmCYPOt/kwo88bdZtlW6CH/+h
        rSHNPUigkQBgH6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D4E0D13DAC;
        Thu,  5 Aug 2021 15:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QJVbM6QBDGFDdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 05 Aug 2021 15:20:04 +0000
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
Subject: [PATCH v4 05/35] mm, slub: remove redundant unfreeze_partials() from put_cpu_partial()
Date:   Thu,  5 Aug 2021 17:19:30 +0200
Message-Id: <20210805152000.12817-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
References: <20210805152000.12817-1-vbabka@suse.cz>
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
index 4ac4ad021fca..812345fdf13c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2463,13 +2463,6 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
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

