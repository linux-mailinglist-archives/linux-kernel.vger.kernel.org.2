Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD01A400AED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 13:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351260AbhIDKwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 06:52:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59728 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351117AbhIDKvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 06:51:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F9FC22697;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1630752612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTWAKLmBnHJEgugHxPsV+ggOQdSrusqVnBL855yHn3I=;
        b=1HGOkwfyFpcDdYMO8NjN2Fi3dMfcB17e7lyImGrJ5QsOO4leNlqsHRasgP/9rpEPx66I6h
        /2c8ZjAruFxBYfafYxJQqRUIL9IAK3eek5dzt7uTWbJOS2SdGh4GEX/D6e5e86VF+MmtrL
        H9OS/ZZ86M8h4ZRrYrF+ymfx5Eff/mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1630752612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yTWAKLmBnHJEgugHxPsV+ggOQdSrusqVnBL855yHn3I=;
        b=TU0mBrUkncQzJoN314ZySq7FYgDvlkqpFe/o0Pi42udw0z54b+wA5HaCAcg5COtHvPSHcS
        Zm7aplipNIozHmCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AC4A1348A;
        Sat,  4 Sep 2021 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uPpRGWRPM2HoUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sat, 04 Sep 2021 10:50:12 +0000
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
Subject: [PATCH v6 18/33] mm, slub: move reset of c->page and freelist out of deactivate_slab()
Date:   Sat,  4 Sep 2021 12:49:48 +0200
Message-Id: <20210904105003.11688-19-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904105003.11688-1-vbabka@suse.cz>
References: <20210904105003.11688-1-vbabka@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2896; h=from:subject; bh=hjcH8xMrLWaUffLKkEsh3qXRSMtqDyM/+LlY5fXXiwM=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhM080e7i5aYvInkeI/gf6l7U8JqibXV+TakTvRvtD y7ZFzluJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYTNPNAAKCRDgIcpz8YmpEEFTB/ 0dw+e6VDTWgaK/zibVxnkLiIchrFDfWJDwS1E5sCIV4GY+GPTcznsFL8vrdpxdMUPxZzFs0BAwMzxC fZg5xNYlD9RhbP9GFoDnFyUdHSLo8FUeNOiQapDMgzQbGSNlmhdQKSEoiTPK9cvqPqroA9I35ygvjC m17znfL1YsKq3jJgUwsvYYech8/O+ANDRio75kXnyjybRb5RadKqsiXthB4F7gdsXzZKvjPoZ3NJQk a6KEjkA3csZfKZbrZy99wXdYKu+/HBsebzfyz4xlrtH51REnbZIKkeiuhEf1qy4iS1FyBM/QQB/1dR 1e8b/YEWds2pmibNEsK+MyYrxLHm+1
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

deactivate_slab() removes the cpu slab by merging the cpu freelist with slab's
freelist and putting the slab on the proper node's list. It also sets the
respective kmem_cache_cpu pointers to NULL.

By extracting the kmem_cache_cpu operations from the function, we can make it
not dependent on disabled irqs.

Also if we return a single free pointer from ___slab_alloc, we no longer have
to assign kmem_cache_cpu.page before deactivation or care if somebody preempted
us and assigned a different page to our kmem_cache_cpu in the process.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 8433e50d2c8e..cea7a2ad9e3e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2209,10 +2209,13 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 }
 
 /*
- * Remove the cpu slab
+ * Finishes removing the cpu slab. Merges cpu's freelist with page's freelist,
+ * unfreezes the slabs and puts it on the proper list.
+ * Assumes the slab has been already safely taken away from kmem_cache_cpu
+ * by the caller.
  */
 static void deactivate_slab(struct kmem_cache *s, struct page *page,
-				void *freelist, struct kmem_cache_cpu *c)
+			    void *freelist)
 {
 	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
@@ -2341,9 +2344,6 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 		discard_slab(s, page);
 		stat(s, FREE_SLAB);
 	}
-
-	c->page = NULL;
-	c->freelist = NULL;
 }
 
 /*
@@ -2468,10 +2468,16 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
-	stat(s, CPUSLAB_FLUSH);
-	deactivate_slab(s, c->page, c->freelist, c);
+	void *freelist = c->freelist;
+	struct page *page = c->page;
 
+	c->page = NULL;
+	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
+
+	deactivate_slab(s, page, freelist);
+
+	stat(s, CPUSLAB_FLUSH);
 }
 
 /*
@@ -2769,7 +2775,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		local_irq_restore(flags);
 		goto reread_page;
 	}
-	deactivate_slab(s, page, c->freelist, c);
+	freelist = c->freelist;
+	c->page = NULL;
+	c->freelist = NULL;
+	deactivate_slab(s, page, freelist);
 	local_irq_restore(flags);
 
 new_slab:
@@ -2848,11 +2857,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 return_single:
 
 	local_irq_save(flags);
-	if (unlikely(c->page))
-		flush_slab(s, c);
-	c->page = page;
-
-	deactivate_slab(s, page, get_freepointer(s, freelist), c);
+	deactivate_slab(s, page, get_freepointer(s, freelist));
 	local_irq_restore(flags);
 	return freelist;
 }
-- 
2.33.0

