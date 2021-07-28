Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91D3D8A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 11:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhG1JOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 05:14:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7760 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhG1JOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 05:14:18 -0400
Received: from dggeme766-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GZSW64hVszYd7v;
        Wed, 28 Jul 2021 17:08:18 +0800 (CST)
Received: from huawei.com (10.175.104.82) by dggeme766-chm.china.huawei.com
 (10.3.19.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 28
 Jul 2021 17:14:13 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <hannes@cmpxchg.org>, <shakeelb@google.com>,
        <ast@kernel.org>, <wangkefeng.wang@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/memcg: fix NULL pointer dereference in memcg_slab_free_hook()
Date:   Wed, 28 Jul 2021 17:13:48 +0800
Message-ID: <20210728091348.272714-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme766-chm.china.huawei.com (10.3.19.112)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I use kfree_rcu() to free a large memory allocated by
kmalloc_node(), the following dump occurs.

BUG: kernel NULL pointer dereference, address: 0000000000000020
[...]
Oops: 0000 [#1] SMP
[...]
Workqueue: events kfree_rcu_work
RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
[...]
Call Trace:
 kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
 kfree_bulk include/linux/slab.h:413 [inline]
 kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
 process_one_work+0x207/0x530 kernel/workqueue.c:2276
 worker_thread+0x320/0x610 kernel/workqueue.c:2422
 kthread+0x13d/0x160 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

When kmalloc_node() a large memory, page is allocated, not slab,
so when freeing memory via kfree_rcu(), this large memory should not
be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
is used for slab.

So in this case, there is no need to do anything with this large
page in memcg_slab_free_hook(), just skip it.

Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 mm/slab.h | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 67e06637ff2e..247d3f9c21f7 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -339,15 +339,20 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
 			continue;
 
 		page = virt_to_head_page(p[i]);
+		if (!s_orig) {
+			if (unlikely(!PageSlab(page))) {
+				BUG_ON(!PageCompound(page));
+				continue;
+			}
+			s = page->slab_cache;
+		} else {
+			s = s_orig;
+		}
+
 		objcgs = page_objcgs(page);
 		if (!objcgs)
 			continue;
 
-		if (!s_orig)
-			s = page->slab_cache;
-		else
-			s = s_orig;
-
 		off = obj_to_index(s, page, p[i]);
 		objcg = objcgs[off];
 		if (!objcg)
-- 
2.17.1

