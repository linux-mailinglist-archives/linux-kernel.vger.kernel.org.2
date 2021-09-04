Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B3D400AE0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351183AbhIDKv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:51:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59668 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351044AbhIDKvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 36DC322688;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iykri81EvFzwHykbB/4XmCR+cinYqJzxF99XZovGSx4=;
        b=hUtTyRkgZ+QVdhlOIsusancWsBmFEujS6DUTauNT4hSPFVm+NynK1h5oNhbVGRD0kcddCO
        GP3mZXqQB4ibeqxpNJPz+28YKJfO92+UuyMn0i7yKnzp0OGzu+hV7JUV4bpPpedqEe9kin
        +fsuE8G3loTDqFCrEkrlDy6jxVfSawA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Iykri81EvFzwHykbB/4XmCR+cinYqJzxF99XZovGSx4=;
        b=nU0vbvi6m57B8uPxUPw3tpGJKvoGgraMsCyoNfCvRibrvvPl1l8BBcn3i/Ryud3raORL7o
        lvoypSvHXCDncgCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C48513AC0;
        Sat,  4 Sep 2021 10:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SEo5AmJPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:10 +0000
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
Subject: [PATCH v6 05/33] mm, slub: remove redundant unfreeze_partials() from put_cpu_partial()
Date:   Sat,  4 Sep 2021 12:49:35 +0200
Message-Id: <20210904105003.11688-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1474; h=from:subject; bh=Dbt53Uprqci9Kr6cpXzRwSLm0CIzXov+H6Q0g0SydJE=; b=owGbwMvMwMH4QPFU8cfOlQKMp9WSGBKN/YXtc9xLGRW0RVeenC7c0VgZaz55RV/Mw6uv3XJUzR7r 3LPvZDRmYWDkYJAVU2Tp9Z7MuNL0scQ+j7gzMINYmUCmMHBxCsBE3B5xMMzx/tC7uGOmSUvHfR+vto rNET6bvfzyLls6/o2dMjsr02zO/VS1E7GV6YwujRqnbgb9D+L53dPwUFTQ5DXDaaVwZ27eaRO31GdP v1jneOHo04OyHtkfUrMupv+U7WNZzPfM5QlP4Bd5oU0xii16923Xm2XwxywVuXRHWfDqnlsBWnYT/z yef8XebXN0baaJa/rfp6VCjL6HJILztTdPjpgWonqhhCVHsvFf0E/RX+96n68+11EYYJ9lnR3z/85t H81lG5O0OmYp7C0Q2saeGnArjdNdPe0+y+KvU/d6+DwXzQxUc57yIS9rf1PH5riEIyI/TxQYz/70u+ DNrcZPvc+mnA1nYbwk1aH711UfAA==
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
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
2.33.0

