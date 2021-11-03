Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4036E443C22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 05:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhKCENA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 00:13:00 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:27167 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKCEM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 00:12:59 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HkYDP0GZgzTgDM;
        Wed,  3 Nov 2021 12:08:53 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (7.185.36.10) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 12:10:21 +0800
Received: from [10.174.176.231] (10.174.176.231) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 12:10:20 +0800
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH v3] mm: emit the "free" trace report before freeing memory in
 kmem_cache_free()
To:     <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
CC:     <jhubbard@nvidia.com>, <songmuchun@bytedance.com>,
        <willy@infradead.org>, Tang Yizhou <tangyizhou@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>, <wuxu.wu@huawei.com>,
        <hewenliang4@huawei.com>
Message-ID: <374eb75d-7404-8721-4e1e-65b0e5b17279@huawei.com>
Date:   Wed, 3 Nov 2021 12:10:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the memory is freed, it can be immediately allocated by other
CPUs, before the "free" trace report has been emitted. This causes
inaccurate traces.

For example, if the following sequence of events occurs:

    CPU 0                 CPU 1

  (1) alloc xxxxxx
  (2) free  xxxxxx
                         (3) alloc xxxxxx
                         (4) free  xxxxxx

Then they will be inaccurately reported via tracing, so that they appear
to have happened in this order:

    CPU 0                 CPU 1

  (1) alloc xxxxxx
                         (2) alloc xxxxxx
  (3) free  xxxxxx
                         (4) free  xxxxxx

This makes it look like CPU 1 somehow managed to allocate memory that
CPU 0 still had allocated for itself.

In order to avoid this, emit the "free xxxxxx" tracing report just
before the actual call to free the memory, instead of just after it.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
v2 -> v3:
 - Fix the typo "mmemory" to "memory"
 - Add "Reviewed-by"
 - Fix the same problem in slab/slob

v1 -> v2:
 - Modify the description
 - Add "Reviewed-by"

 mm/slab.c | 3 +--
 mm/slob.c | 3 +--
 mm/slub.c | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index da132a9ae6f8..ca4822f6b2b6 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -3733,14 +3733,13 @@ void kmem_cache_free(struct kmem_cache *cachep, void *objp)
 	if (!cachep)
 		return;

+	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
 	local_irq_save(flags);
 	debug_check_no_locks_freed(objp, cachep->object_size);
 	if (!(cachep->flags & SLAB_DEBUG_OBJECTS))
 		debug_check_no_obj_freed(objp, cachep->object_size);
 	__cache_free(cachep, objp, _RET_IP_);
 	local_irq_restore(flags);
-
-	trace_kmem_cache_free(_RET_IP_, objp, cachep->name);
 }
 EXPORT_SYMBOL(kmem_cache_free);

diff --git a/mm/slob.c b/mm/slob.c
index 74d3f6e60666..03deee1e6a94 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -666,6 +666,7 @@ static void kmem_rcu_free(struct rcu_head *head)
 void kmem_cache_free(struct kmem_cache *c, void *b)
 {
 	kmemleak_free_recursive(b, c->flags);
+	trace_kmem_cache_free(_RET_IP_, b, c->name);
 	if (unlikely(c->flags & SLAB_TYPESAFE_BY_RCU)) {
 		struct slob_rcu *slob_rcu;
 		slob_rcu = b + (c->size - sizeof(struct slob_rcu));
@@ -674,8 +675,6 @@ void kmem_cache_free(struct kmem_cache *c, void *b)
 	} else {
 		__kmem_cache_free(b, c->size);
 	}
-
-	trace_kmem_cache_free(_RET_IP_, b, c->name);
 }
 EXPORT_SYMBOL(kmem_cache_free);

diff --git a/mm/slub.c b/mm/slub.c
index 432145d7b4ec..427e62034c3f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3526,8 +3526,8 @@ void kmem_cache_free(struct kmem_cache *s, void *x)
 	s = cache_from_obj(s, x);
 	if (!s)
 		return;
-	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
 	trace_kmem_cache_free(_RET_IP_, x, s->name);
+	slab_free(s, virt_to_head_page(x), x, NULL, 1, _RET_IP_);
 }
 EXPORT_SYMBOL(kmem_cache_free);

-- 
2.27.0
