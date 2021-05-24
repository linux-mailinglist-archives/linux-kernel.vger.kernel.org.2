Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4438F662
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 01:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhEXXnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 19:43:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50692 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhEXXmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 19:42:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621899649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vn0q2MowqtMDKWpeLbHMppeC+VLuK7X9dSk7w+C8hww=;
        b=iRccDoB8mUyH/MVrd5v/64ILvNf/DpJlIU/v48EEFKkMgev39CghddEg4y9LsUrIKRu6XH
        Vzp+HqV2vRgi6kR9MyRvBnVXqwe3SF3zg1X7KD/CwwMKasbeyP0cOwNzlSNmKGOXMlQLc0
        S3F+aOYgdh8oUb6jL+yfcIwKGcKs4vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621899649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vn0q2MowqtMDKWpeLbHMppeC+VLuK7X9dSk7w+C8hww=;
        b=dV6m66/oQWOK1Ti2udRobMzvcSd+vTOLKwUtUfQqdMnsPYeYCo0YkMChbRCj06BF71IvKO
        PD8SG0esmzSymSDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 32B78AF45;
        Mon, 24 May 2021 23:40:49 +0000 (UTC)
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
Subject: [RFC 20/26] mm, slub: discard slabs in unfreeze_partials() without irqs disabled
Date:   Tue, 25 May 2021 01:39:40 +0200
Message-Id: <20210524233946.20352-21-vbabka@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524233946.20352-1-vbabka@suse.cz>
References: <20210524233946.20352-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need for disabled irqs when discarding slabs, so restore them before
discarding.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 446d2d5344c9..33c3faacf7b1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2360,6 +2360,8 @@ static void unfreeze_partials(struct kmem_cache *s,
 	if (n)
 		spin_unlock(&n->list_lock);
 
+	local_irq_restore(flags);
+
 	while (discard_page) {
 		page = discard_page;
 		discard_page = discard_page->next;
@@ -2369,7 +2371,6 @@ static void unfreeze_partials(struct kmem_cache *s,
 		stat(s, FREE_SLAB);
 	}
 
-	local_irq_restore(flags);
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 }
 
-- 
2.31.1

