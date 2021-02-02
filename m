Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782BD30B938
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhBBIGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:06:40 -0500
Received: from pv50p00im-ztbu10021601.me.com ([17.58.6.57]:35231 "EHLO
        pv50p00im-ztbu10021601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231509AbhBBIGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:06:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1612253129;
        bh=8NEp9zklRJUsl/PGNITMgJ3PKhwgHZVdrYPjebI/fgY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=V3ZNeYbWrC+4zHwFHy4bq0cnl1W3OOtHu+4/7o1t9oWtur2KXT19mlh3VZVC/pcYl
         XW0kKii9CHlYepHFS2esV/G5q3Xwgh6IpS2w+x6bxRSqc11zn9a9ztfa/roOgjv+/E
         S7J5sai+D+icLeGoVxRSKQFR5QPFWALfTVR8kgxiWATr56rc3lqsx1IAQqDKPbBzAy
         19UQ/LCa7L7KWimufwLS60lzJHK6FWFFyOVV+rkzfM6iBCeqvq8Ok8BGh94OhRVcAh
         RfCsBPRB2PGpI1bklaxg7mlenJodvYhWmsh6U0RzUHgFx2lFL6VXTOiOqK50hnJhgP
         isn2nVReQOeOg==
Received: from localhost.localdomain (unknown [119.3.119.19])
        by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id 3E0BD6E034F;
        Tue,  2 Feb 2021 08:05:25 +0000 (UTC)
From:   Abel Wu <abel.w@icloud.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     hewenliang4@huawei.com, wuyun.wu@huawei.com,
        Abel Wu <abel.w@icloud.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/slub: embed __slab_alloc to its caller
Date:   Tue,  2 Feb 2021 03:05:14 -0500
Message-Id: <20210202080515.2689-1-abel.w@icloud.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_04:2021-01-29,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2102020055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since slab_alloc_node() is the only caller of __slab_alloc(), embed
__slab_alloc() to its caller to save function call overhead. This
will also expand the caller's code block size a bit, but hackbench
tests on both host and guest didn't show a difference w/ or w/o
this patch.

Also rename ___slab_alloc() to __slab_alloc().

Signed-off-by: Abel Wu <abel.w@icloud.com>
---
 mm/slub.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 7ecbbbe5bc0c..0f69d2d0471a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2654,10 +2654,9 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
  * we need to allocate a new slab. This is the slowest path since it involves
  * a call to the page allocator and the setup of a new slab.
  *
- * Version of __slab_alloc to use when we know that interrupts are
- * already disabled (which is the case for bulk allocation).
+ * Must be called with interrupts disabled.
  */
-static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
+static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			  unsigned long addr, struct kmem_cache_cpu *c)
 {
 	void *freelist;
@@ -2758,31 +2757,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	return freelist;
 }
 
-/*
- * Another one that disabled interrupt and compensates for possible
- * cpu changes by refetching the per cpu area pointer.
- */
-static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c)
-{
-	void *p;
-	unsigned long flags;
-
-	local_irq_save(flags);
-#ifdef CONFIG_PREEMPTION
-	/*
-	 * We may have been preempted and rescheduled on a different
-	 * cpu before disabling interrupts. Need to reload cpu area
-	 * pointer.
-	 */
-	c = this_cpu_ptr(s->cpu_slab);
-#endif
-
-	p = ___slab_alloc(s, gfpflags, node, addr, c);
-	local_irq_restore(flags);
-	return p;
-}
-
 /*
  * If the object has been wiped upon free, make sure it's fully initialized by
  * zeroing out freelist pointer.
@@ -2854,7 +2828,19 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
 	object = c->freelist;
 	page = c->page;
 	if (unlikely(!object || !page || !node_match(page, node))) {
+		unsigned long flags;
+
+		local_irq_save(flags);
+#ifdef CONFIG_PREEMPTION
+		/*
+		 * We may have been preempted and rescheduled on a different
+		 * cpu before disabling interrupts. Need to reload cpu area
+		 * pointer.
+		 */
+		c = this_cpu_ptr(s->cpu_slab);
+#endif
 		object = __slab_alloc(s, gfpflags, node, addr, c);
+		local_irq_restore(flags);
 	} else {
 		void *next_object = get_freepointer_safe(s, object);
 
@@ -3299,7 +3285,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * We may have removed an object from c->freelist using
 			 * the fastpath in the previous iteration; in that case,
 			 * c->tid has not been bumped yet.
-			 * Since ___slab_alloc() may reenable interrupts while
+			 * Since __slab_alloc() may reenable interrupts while
 			 * allocating memory, we should bump c->tid now.
 			 */
 			c->tid = next_tid(c->tid);
@@ -3308,7 +3294,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			 * Invoking slow path likely have side-effect
 			 * of re-populating per CPU c->freelist
 			 */
-			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
+			p[i] = __slab_alloc(s, flags, NUMA_NO_NODE,
 					    _RET_IP_, c);
 			if (unlikely(!p[i]))
 				goto error;
-- 
2.27.0

