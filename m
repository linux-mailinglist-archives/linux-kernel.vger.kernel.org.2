Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B8A3F4CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 17:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhHWPBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 11:01:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60482 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhHWO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:59:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4AD0F20008;
        Mon, 23 Aug 2021 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629730721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIw1VlS+yjt3d7a9qpfJxscOym6tjt6rE1MC5A8rBPI=;
        b=1r+qEomoT+ks43jNrxisIPwd0yb7s1ubLqjAzQ0E3z4yyiTa6CIGCE/tWxA9TsBcllteHF
        RWF5YGaHMJxVzLnwE6gZtvhgujFTI+PAsYzXBQe1/5csLpS97uqANp70Ad46MCWYgPlblP
        oD2f+X57+8ubxOcjIB256FpCNrgAqoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629730721;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIw1VlS+yjt3d7a9qpfJxscOym6tjt6rE1MC5A8rBPI=;
        b=tVb8H+92nFnhsWRMMDYQ35nU9pRXfcuVXHbPwtPBu7GgiOBE9VSfVpqIWxxmn19LlAknKo
        vqKdiNXZxvwOyUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2073013BE0;
        Mon, 23 Aug 2021 14:58:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gGjPBqG3I2EFQQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 23 Aug 2021 14:58:41 +0000
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
Subject: [PATCH v5 20/35] mm, slub: make locking in deactivate_slab() irq-safe
Date:   Mon, 23 Aug 2021 16:58:11 +0200
Message-Id: <20210823145826.3857-21-vbabka@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823145826.3857-1-vbabka@suse.cz>
References: <20210823145826.3857-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dectivate_slab() now no longer touches the kmem_cache_cpu structure, so it will
be possible to call it with irqs enabled. Just convert the spin_lock calls to
their irq saving/restoring variants to make it irq-safe.

Note we now have to use cmpxchg_double_slab() for irq-safe slab_lock(), because
in some situations we don't take the list_lock, which would disable irqs.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index ef36c94f27e2..00a96e9030e5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2209,6 +2209,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	enum slab_modes l = M_NONE, m = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
+	unsigned long flags = 0;
 	struct page new;
 	struct page old;
 
@@ -2284,7 +2285,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * that acquire_slab() will see a slab page that
 			 * is frozen
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	} else {
 		m = M_FULL;
@@ -2295,7 +2296,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * slabs from diagnostic functions will not see
 			 * any frozen slabs.
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	}
 
@@ -2312,14 +2313,14 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	}
 
 	l = m;
-	if (!__cmpxchg_double_slab(s, page,
+	if (!cmpxchg_double_slab(s, page,
 				old.freelist, old.counters,
 				new.freelist, new.counters,
 				"unfreezing slab"))
 		goto redo;
 
 	if (lock)
-		spin_unlock(&n->list_lock);
+		spin_unlock_irqrestore(&n->list_lock, flags);
 
 	if (m == M_PARTIAL)
 		stat(s, tail);
-- 
2.32.0

