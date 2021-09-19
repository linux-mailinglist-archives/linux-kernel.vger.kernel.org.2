Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE06410C67
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 18:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhISQoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 12:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhISQoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 12:44:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB370C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:42:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c1so11050022pfp.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzC2O/s8ikNUmX8UKae7CAywgcUoWNrsJ166hFxSJ/M=;
        b=I+yJHIPqGUy8zAQJ77F4USO8jOPYezfBkwEhMcMaZQPUe38apE3IEuXRG2Ydi2M2c4
         0tn2Ap98xzqwIoXg9VglLUcixiv7mmkNWUVD4sWGeS/5pjex6PfpgH5ke26KTVGdwAj3
         ftvlaBGYFnbOZ0cgDh2OS6a3dPIOD7BG2mX1LJjtbyD4KCQmnX6uP/teHV8dg7vWTPwX
         NKY9weCveoXJokyNnFShS7nbdheQ4vysvkFONBFIdh3Lt5EVSlSgUjrZmXKDHh/zmtj6
         PJ/6cHZHOmx3BeiXW+oKcAMUIQk6HrrQtzMkSzCWI0jbPOdBnQ6dhB76Sphss7INZC+H
         IX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gzC2O/s8ikNUmX8UKae7CAywgcUoWNrsJ166hFxSJ/M=;
        b=zq+rofpUvGQVBsgEcolAmlYxYjB1P4YXtfrjvarx2ACFlQoH7plnDeaEU4mkk/9q8q
         PB51lBZupjuyv5PvQqT3Jpyk7iFJpyauUA4J79UxyH8tMdAovihAWeYC1iRLcrwJLx6E
         ERinbE/M4mZgMAJ5Q3WkJS1N021oCG+iYHDwIcJcstgc3dC9SQex52vpg/Y+pReE/gPs
         GjvAGMJ0Tq25f6IXGQcevBKE2zSAgOV6gRS1krlxd62dwKABDV3kQVXt8rUBAuqFnZic
         tegKpw6IUKw1c6jQzn8tK999Mj/2jpgoOUEmN8wKWlsSeTZFT5Zi8P5p36CsAwf2XSIy
         aPgw==
X-Gm-Message-State: AOAM531wwWmXWQW2AEWa1gi3r2QM+xBZnxacDjADo43l8raeX514AQhu
        Dmiicyf40Ep7ikzDsWDEeNg=
X-Google-Smtp-Source: ABdhPJx2j39d4jPqCtptbwq7+Uy8CyHhbLA2PDrOOIiILccGIY2j8CZJuXNQhEiQ2iKYPM/qgH7tCQ==
X-Received: by 2002:a62:1ad6:0:b0:440:3aef:46b7 with SMTP id a205-20020a621ad6000000b004403aef46b7mr20816934pfa.86.1632069771294;
        Sun, 19 Sep 2021 09:42:51 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id c23sm11080069pjr.20.2021.09.19.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 09:42:50 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     42.hyeyoo@gmail.com
Cc:     Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH] Introducing lockless cache built on top of slab allocator
Date:   Sun, 19 Sep 2021 16:42:39 +0000
Message-Id: <20210919164239.49905-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is just simple proof of concept, and not ready for submission yet.
There can be wrong code (like wrong gfp flags, or wrong error handling,
etc) it is just simple proof of concept. I want comment from you.

Recently block layer implemented percpu, lockless cache
on the top of slab allocator. It can be used for IO polling,
because IO polling disables interrupt.

Link: https://lwn.net/Articles/868070/
Link: https://www.spinics.net/lists/linux-block/msg71964.html

it gained some IOPS increase after this.
(Note that Jens used SLUB on performance measurement)

this is generalization of what have been done in block layer,
built on top of slab allocator.

lockless cache uses simple queuing to be more cache friendly.
and when the percpu freelist gets too big, it returns some
objects back to slab allocator.

it seems lockless cache can be used network layer's IO Polling (NAPI) too.

Any ideas/opinions on this?
---
 include/linux/lockless_cache.h |  31 ++++++++
 init/main.c                    |   2 +
 mm/Makefile                    |   2 +-
 mm/lockless_cache.c            | 132 +++++++++++++++++++++++++++++++++
 4 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/lockless_cache.h
 create mode 100644 mm/lockless_cache.c

diff --git a/include/linux/lockless_cache.h b/include/linux/lockless_cache.h
new file mode 100644
index 000000000000..e64b85e869f3
--- /dev/null
+++ b/include/linux/lockless_cache.h
@@ -0,0 +1,31 @@
+#include <linux/gfp.h>
+
+struct object_list {
+	void *object;
+	struct list_head list;
+};
+
+struct freelist {
+	struct object_list *head;
+	int size;
+};
+
+struct lockless_cache {
+	struct kmem_cache *cache;
+	struct freelist __percpu *freelist;
+
+	int total_size;
+	unsigned int max; /* maximum size for each percpu freelist */
+	unsigned int slack; /* number of objects returning to slab when freelist is too big (> max) */
+};
+
+void lockless_cache_init(void);
+struct lockless_cache
+*lockless_cache_create(const char *name, unsigned int size, unsigned int align,
+		slab_flags_t flags, void (*ctor)(void *), unsigned int max,
+		unsigned int slack);
+
+void lockless_cache_destroy(struct lockless_cache *cache);
+void *lockless_cache_alloc(struct lockless_cache *cache, gfp_t flags);
+void lockless_cache_free(struct lockless_cache *cache, void *object);
+
diff --git a/init/main.c b/init/main.c
index 3f7216934441..c18d6421cb65 100644
--- a/init/main.c
+++ b/init/main.c
@@ -79,6 +79,7 @@
 #include <linux/async.h>
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
+#include <linux/lockless_cache.h>
 #include <linux/perf_event.h>
 #include <linux/ptrace.h>
 #include <linux/pti.h>
@@ -848,6 +849,7 @@ static void __init mm_init(void)
 	/* page_owner must be initialized after buddy is ready */
 	page_ext_init_flatmem_late();
 	kmem_cache_init();
+	lockless_cache_init();
 	kmemleak_init();
 	pgtable_init();
 	debug_objects_mem_init();
diff --git a/mm/Makefile b/mm/Makefile
index fc60a40ce954..d6c3a89ed548 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o vmacache.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o lockless_cache.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/lockless_cache.c b/mm/lockless_cache.c
new file mode 100644
index 000000000000..05b8cdb672ff
--- /dev/null
+++ b/mm/lockless_cache.c
@@ -0,0 +1,132 @@
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/list.h>
+#include <linux/percpu-defs.h>
+#include <linux/lockless_cache.h>
+
+#ifdef CONFIG_SLUB
+#include <linux/slub_def.h>
+#elif CONFIG_SLAB
+#include <linux/slab_def.h>
+#else
+#include <linux/slob_def.h>
+#endif
+
+static struct kmem_cache *global_lockless_cache;
+static struct kmem_cache *global_list_cache;
+
+/*
+ * What should to do if initialization fails?
+ */
+void lockless_cache_init(void)
+{
+	global_lockless_cache = kmem_cache_create("global_lockless_cache", sizeof(struct lockless_cache),
+			sizeof(struct lockless_cache), 0, NULL);
+
+	global_list_cache = kmem_cache_create("global_list_cache", sizeof(struct object_list),
+			sizeof(struct object_list), 0, NULL);
+
+}
+EXPORT_SYMBOL(lockless_cache_init);
+
+struct lockless_cache
+*lockless_cache_create(const char *name, unsigned int size, unsigned int align,
+		slab_flags_t flags, void (*ctor)(void *), unsigned int max, unsigned int slack)
+{
+	int cpu;
+	struct lockless_cache *cache;
+
+	cache = kmem_cache_alloc(global_lockless_cache, GFP_KERNEL || __GFP_ZERO);
+	if (!cache)
+		return NULL;
+
+	cache->cache = kmem_cache_create(name, size, align, 0, ctor);
+	if (!cache->cache)
+		goto destroy_cache;
+
+	cache->freelist = alloc_percpu(struct freelist);
+	if (!cache->freelist)
+		goto destroy_cache;
+
+	cache->max = max;
+	cache->slack = slack;
+	cache->total_size = 0;
+
+	for_each_possible_cpu(cpu) {
+		struct freelist *freelist;
+		freelist = per_cpu_ptr(cache->freelist, cpu);
+		INIT_LIST_HEAD(&freelist->head->list);
+		freelist->size = 0;
+	}
+
+	return cache;
+
+destroy_cache:
+
+	lockless_cache_destroy(cache);
+	return cache;
+}
+EXPORT_SYMBOL(lockless_cache_create);
+
+void lockless_cache_destroy(struct lockless_cache *cache)
+{
+	int cpu;
+	struct object_list *elem;
+
+	for_each_possible_cpu(cpu) {
+		free_percpu(cache->freelist);
+		list_for_each_entry(elem, &cache->freelist->head->list, list) {
+			lockless_cache_free(cache, elem->object);
+			kmem_cache_free(global_list_cache, elem);
+		}
+	}
+
+	kmem_cache_destroy(cache->cache);
+}
+EXPORT_SYMBOL(lockless_cache_destroy);
+
+void *lockless_cache_alloc(struct lockless_cache *cache, gfp_t flags)
+{
+	struct freelist *freelist;
+	struct object_list *elem;
+
+	freelist = this_cpu_ptr(cache->freelist);
+
+	if (list_empty(&freelist->head->list)) {
+		elem = freelist->head;
+		list_del(&freelist->head->list);
+		cache->total_size--;
+		freelist->size--;
+		cache->cache->ctor(elem->object);
+	} else {
+		elem = kmem_cache_alloc(global_list_cache, flags);
+	}
+
+	return elem->object;
+}
+EXPORT_SYMBOL(lockless_cache_alloc);
+
+void lockless_cache_free(struct lockless_cache *cache, void *object)
+{
+	struct freelist *freelist;
+	struct object_list *elem;
+
+	elem = container_of(&object, struct object_list, object);
+	freelist = this_cpu_ptr(cache->freelist);
+	list_add(&freelist->head->list, &elem->list);
+	cache->total_size++;
+	freelist->size++;
+
+	/* return back to slab allocator */
+	if (freelist->size > cache->max) {
+		elem = list_last_entry(&freelist->head->list, struct object_list, list);
+		list_del(&elem->list);
+
+		kmem_cache_free(cache->cache, elem->object);
+		kmem_cache_free(global_list_cache, elem);
+		cache->total_size--;
+		freelist->size--;
+	}
+}
+EXPORT_SYMBOL(lockless_cache_free);
-- 
2.27.0

