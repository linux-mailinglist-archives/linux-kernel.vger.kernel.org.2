Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E420E38F661
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhEXXnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhEXXmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5p0PizEV3N3GiwLue+53YpFP9i8rF0CXirWwfnsCP4=;
        b=DXFOK/s7RsNQOHek7IKrH62rhnjIs5Q0JQVDdO9HiVjkSKvaNFf15g+kVOQ1TFiiCVW4r/
        OMA7BorHY+9fpcwHQaI4V8YSsBFCgrmWtoKI86Sd9hRnK8aU5E5gV0Y6crsxNkIdVWW/t1
        B56V2enMULhFxr7dGGbuB319smJpw64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899648;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5p0PizEV3N3GiwLue+53YpFP9i8rF0CXirWwfnsCP4=;
        b=eWIjO2wgep5ZYKjyLU6z8Cx8pWnq/Msaaw8quKQ4oUxAa0hByJjR4PtNC2/3jpcfx1G4oe
        gPzGGJVEnTqWo8Cw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE29FAF39;
        Mon, 24 May 2021 23:40:48 +0000 (UTC)
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
Subject: [RFC 17/26] mm, slub: make locking in deactivate_slab() irq-safe
Date:   Tue, 25 May 2021 01:39:37 +0200
Message-Id: <20210524233946.20352-18-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dectivate_slab() now no longer touches the kmem_cache_cpu structure, so it will
be possible to call it with irqs enabled. Just convert the spin_lock calls to
their irq saving/restoring variants to make it irq-safe. Additionally we now
have to use cmpxchg_double_slab() for irq-safe slab_lock().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index cf855cd09802..0f58859165bf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2177,6 +2177,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	enum slab_modes l = M_NONE, m = M_NONE;
 	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
+	unsigned long flags = 0;
 	struct page new;
 	struct page old;
 
@@ -2252,7 +2253,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * that acquire_slab() will see a slab page that
 			 * is frozen
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	} else {
 		m = M_FULL;
@@ -2263,7 +2264,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 			 * slabs from diagnostic functions will not see
 			 * any frozen slabs.
 			 */
-			spin_lock(&n->list_lock);
+			spin_lock_irqsave(&n->list_lock, flags);
 		}
 	}
 
@@ -2280,14 +2281,14 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
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

