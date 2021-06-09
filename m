Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC23A12F8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239212AbhFILm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:42:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbhFILla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:41:30 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B17E219E5;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epQKKcaNSs6oc8v4JtInuf1QdvJlAwnRMC1xTjWgeXI=;
        b=WO97LCf9vSIMTWJg/0ZzucZdzc/KUz0BS36mpkEr6IkncBpRRtXErcnJjbNRWwqvcSoK4a
        YRPFd1XsAFa46zoD6I2jXpss1OADAEXhNgqpZn3dqego9LkLzkcAexp6GkyMgMZRpCkb4g
        jJWjhtBNnoO6kXeDbX2Ldl+z4XFJTls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epQKKcaNSs6oc8v4JtInuf1QdvJlAwnRMC1xTjWgeXI=;
        b=yg5PRqXC80SpIoAHlB81o2BuIzmk+uejuwQLDb2xD9TU/xKj7uCw3rpzFLHbFm67QcSHAq
        93Be0I1JgmWfW8Aw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4DCB3118DD;
        Wed,  9 Jun 2021 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623238775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epQKKcaNSs6oc8v4JtInuf1QdvJlAwnRMC1xTjWgeXI=;
        b=WO97LCf9vSIMTWJg/0ZzucZdzc/KUz0BS36mpkEr6IkncBpRRtXErcnJjbNRWwqvcSoK4a
        YRPFd1XsAFa46zoD6I2jXpss1OADAEXhNgqpZn3dqego9LkLzkcAexp6GkyMgMZRpCkb4g
        jJWjhtBNnoO6kXeDbX2Ldl+z4XFJTls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623238775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epQKKcaNSs6oc8v4JtInuf1QdvJlAwnRMC1xTjWgeXI=;
        b=yg5PRqXC80SpIoAHlB81o2BuIzmk+uejuwQLDb2xD9TU/xKj7uCw3rpzFLHbFm67QcSHAq
        93Be0I1JgmWfW8Aw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id YM1+EneowGD6XgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 09 Jun 2021 11:39:35 +0000
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
Subject: [RFC v2 20/34] mm, slub: make locking in deactivate_slab() irq-safe
Date:   Wed,  9 Jun 2021 13:38:49 +0200
Message-Id: <20210609113903.1421-21-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609113903.1421-1-vbabka@suse.cz>
References: <20210609113903.1421-1-vbabka@suse.cz>
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
index 8b0b975bfa36..bba18146def6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2163,6 +2163,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	enum slab_modes l = M_NONE, m = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
+	unsigned long flags = 0;
 	struct page new;
 	struct page old;
 
@@ -2238,7 +2239,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * that acquire_slab() will see a slab page that
 			 * is frozen
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	} else {
 		m = M_FULL;
@@ -2249,7 +2250,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * slabs from diagnostic functions will not see
 			 * any frozen slabs.
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	}
 
@@ -2266,14 +2267,14 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
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
2.31.1

