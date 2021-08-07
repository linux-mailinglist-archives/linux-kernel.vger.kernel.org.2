Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8833E36DB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 20:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbhHGSy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 14:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhHGSy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 14:54:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA1CC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 11:54:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so18842145pjn.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 11:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rm4/7jSzHLLsc9lmyznESEs/xkSBx28RrSkjaCAY92U=;
        b=saMYz0KfGIHm7D5XGiiNmqjKh8N2aifY34sH/TZI/b4+1YDpdywx6eDyPsng49ppxL
         2BGTGPGAat8HwnjlpeALgstG3U2mrolRFBXeWqKazRXpMhDerYLpZwcgkv0tN72iAMn+
         3SoE/576wPoQ7oslurqNA7XKMORQNKcgFgpO/+MQYag3L3O60MvvnjKJw9X8em1CPBqM
         bvj80H+35ucdgN9mbFc8X7qExHsrdHhz/Zjl88GffGTauPCFw5yN5j+x+P9EWCGVu9sH
         1b0tQWzqIuQmD7hjdZhZnHHG/Nn45Zp7TGfSzF+TXVG+Ux4Xy1gt3N+FUnGZjNEdrnlb
         TRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rm4/7jSzHLLsc9lmyznESEs/xkSBx28RrSkjaCAY92U=;
        b=kwmsTyBTEQ3QlXdCULotPFZj4tIU+4+vmaHmd+QlqcyDM2Up5tn+2tzKSZVabdsRYf
         ie7pZgdcEsEyOcR6bYem/Vz6McuY9sZhI6Ui5ZgFgcxfG/8WH7ZtC928E6/6gK3PPEBn
         a6eSlgrglXsn+eG1OyYYaLJES4NTlIvpocUSLNLqe0jVSXYQz0K7cz5qQLGwRYQoU+tg
         jJlnur8NYEuWqxqSeDfZI+aqaLCIAm2dVMabsf0mrZyFzWzhrD9P0Jxsf7NVHvmWA0Wp
         4HOhvyI8JHjVkf9rC4u8YNCqMpuoxBpOhEHirAGoAY1OY3DFpcdn+fsmAoYBxaJhZU0P
         kjBg==
X-Gm-Message-State: AOAM532QH5ii1xnjX0ei1/0nPJ7vUvNTIOHN2tV5E4rvfZojBMQzYlk+
        3zCTg3cDOj8lqa3CUsnErTrwwA==
X-Google-Smtp-Source: ABdhPJwiQONosdd8AcRsJj8bv81+HQzQb6NLM5QRAdh4wpALr97Qhf+VamHNl2S5kDjo2OEUugQZMw==
X-Received: by 2002:a17:90b:1e51:: with SMTP id pi17mr26942018pjb.155.1628362479760;
        Sat, 07 Aug 2021 11:54:39 -0700 (PDT)
Received: from T490.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id m6sm2418851pjv.40.2021.08.07.11.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 11:54:39 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        wuqiang.matt@bytedance.com
Cc:     mattwu@163.com
Subject: [PATCH 1/2] scalable lock-less object pool implementation
Date:   Sun,  8 Aug 2021 02:54:16 +0800
Message-Id: <20210807185417.9209-2-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210807185417.9209-1-wuqiang.matt@bytedance.com>
References: <20210807185417.9209-1-wuqiang.matt@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The object pool is a scalable high performance queue for objects allocation
and reclamation, such as kretprobe instances. Leveraging per-cpu lockless
queue to mitigate hot spots of memory contention, it could deliver almost
linear scalability.

The object pool are best suited for the following cases:
1) memory allocation or reclamation is prohibited or too expensive
2) the objects are allocated/used/reclaimed very frequently

It's basd on cameron's CAS-based lock-free freelist:
https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/freelist.h | 521 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 492 insertions(+), 29 deletions(-)

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
index fc1842b96469..740a14606ad5 100644
--- a/include/linux/freelist.h
+++ b/include/linux/freelist.h
@@ -2,32 +2,375 @@
 #ifndef FREELIST_H
 #define FREELIST_H
 
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/atomic.h>
 
 /*
- * Copyright: cameron@moodycamel.com
+ * freelist: a lock-less version of object pool implementation
  *
- * A simple CAS-based lock-free free list. Not the fastest thing in the world
- * under heavy contention, but simple and correct (assuming nodes are never
- * freed until after the free list is destroyed), and fairly speedy under low
- * contention.
+ * Copyright: cameron@moodycamel.com, wuqiang.matt@bytedance.com
  *
- * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
+ * The object pool is a scalable implementaion of high performance queue
+ * for objects allocation and reclamation, such as kretprobe instances.
+ *
+ * It's basd on cameron's CAS-based lock-free freelist:
+ * https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
+ *
+ * With leveraging per-cpu lockless queue to mitigate hot spots of memory
+ * contention, it could deliver near-linear scalability for high parallel
+ * loads. The object pool are best suited for the following cases:
+ * 1) memory allocation or reclamation is prohibited or too expensive
+ * 2) the objects are allocated/used/reclaimed very frequently
+ *
+ * Before using, you must be aware of it's limitations:
+ * 1) Memory of all objects won't be freed until pool is de-allocated
+ * 2) Order and fairness are not guaranteed. So some threads might stay
+ *    hungry much longer than other competitors
+ *
+ * Objects could be pre-allocated during initialization or filled later
+ * with user's buffer or private allocations. Mixing different objects
+ * of self-managed/batched/manually-added is NOT recommended, though
+ * it's supported. For mixed case, the caller should take care of the
+ * releasing of objects or user pool.
+ *
+ * Typical use cases:
+ *
+ * 1) self-managed objects
+ *
+ * obj_init():
+ *    static int obj_init(void *context, struct freelist_node *obj)
+ *    {
+ *		struct my_node *node;
+ *		node = container_of(obj, struct my_node, obj);
+ * 		do_init_node(context, node);
+ * 		return 0;
+ *    }
+ *
+ * main():
+ *    freelist_init(&fh, num_possible_cpus() * 4, 16, GFP_KERNEL, context, obj_init);
+ *    <object pool initialized>
+ *
+ *    obj = freelist_pop(&fh);
+ *    do_something_with(obj);
+ *    freelist_push(obj, &fh);
+ *
+ *    <object pool to be destroyed>
+ *    freelist_fini(&fh, NULL, NULL);
+ *
+ * 2) batced with user's buffer
+ *
+ * obj_init():
+ *    static int obj_init(void *context, struct freelist_node *obj)
+ *    {
+ *		struct my_node *node;
+ *		node = container_of(obj, struct my_node, obj);
+ * 		do_init_node(context, node);
+ * 		return 0;
+ *    }
+ *
+ * free_buf():
+ *    static int free_buf(void *context, void *obj, int user, int element)
+ *    {
+ * 		if (obj && user && !element)
+ * 			kfree(obj);
+ *    }
+ *
+ * main():
+ *    freelist_init(&fh, num_possible_cpus() * 4, 0, GFP_KERNEL, 0, 0);
+ *    buffer = kmalloc(size, ...);
+ *    freelist_populate(&fh, buffer, size, 16, context, obj_init);
+ *    <object pool initialized>
+ *
+ *    obj = freelist_pop(&fh);
+ *    do_something_with(obj);
+ *    freelist_push(obj, &fh);
+ *
+ *    <object pool to be destroyed>
+ *    freelist_fini(&fh, context, free_buf);
+ *
+ * 3) manually added with user objects
+ *
+ *  free_obj():
+ *    static int free_obj(void *context, void *obj, int user, int element)
+ *    {
+ *		struct my_node *node;
+ *              node = container_of(obj, struct my_node, obj);
+ * 		if (obj && user && element)
+ * 			kfree(node);
+ *    }
+ *
+ * main():
+ *    freelist_init(&fh, num_possible_cpus() * 4, 0, 0, GFP_KERNEL, 0, 0);
+ *    for () {
+ *      node = kmalloc(objsz, ...);
+ *      do_init_node(node);
+ *      freelist_add_scattered(&node.obj, oh);
+ *    }
+ *    <object pool initialized>
+ *
+ *    obj = freelist_pop(&fh);
+ *    do_something_with(obj);
+ *    freelist_push(obj, &fh);
+ *
+ *    <object pool to be destroyed>
+ *    freelist_fini(&fh, context, free_obj);
  */
 
+/*
+ * common componment of every node
+ */
 struct freelist_node {
-	atomic_t		refs;
-	struct freelist_node	*next;
+	struct freelist_node   *next;
+	atomic_t                refs;
+};
+
+#define REFS_ON_FREELIST 0x80000000
+#define REFS_MASK	 0x7FFFFFFF
+
+/*
+ * freelist_slot: per-cpu singly linked list
+ *
+ * All pre-allocated objects are next to freelist_slot. Objects and
+ * freelist_slot are to be allocated from the memory pool local node.
+ */
+struct freelist_slot {
+	struct freelist_node   *fs_head;	/* head of percpu list */
 };
+#define SLOT_OBJS(s) ((void *)(s) + sizeof(struct freelist_slot))
 
+/*
+ * freelist_head: object pooling metadata
+ */
 struct freelist_head {
-	struct freelist_node	*head;
+	uint32_t                fh_objsz;	/* object & element size */
+	uint32_t                fh_nobjs;	/* total objs in freelist */
+	uint32_t                fh_ncpus;	/* num of possible cpus */
+	uint32_t                fh_in_slot:1;	/* objs alloced with slots */
+	uint32_t                fh_vmalloc:1;	/* alloc from vmalloc zone */
+	gfp_t                   fh_gfp;		/* k/vmalloc gfp flags */
+	uint32_t                fh_sz_pool;	/* user pool size in byes */
+	void                   *fh_pool;	/* user managed memory pool */
+	struct freelist_slot  **fh_slots;	/* array of percpu slots */
+	uint32_t               *fh_sz_slots;	/* size in bytes of slots */
 };
 
-#define REFS_ON_FREELIST 0x80000000
-#define REFS_MASK	 0x7FFFFFFF
+typedef int (*freelist_init_node_cb)(void *context, struct freelist_node *);
+
+/* attach object to percpu slot */
+static inline void
+__freelist_insert_node(struct freelist_node *node, struct freelist_slot *slot)
+{
+	atomic_set_release(&node->refs, 1);
+	node->next = slot->fs_head;
+	slot->fs_head = node;
+}
+
+/* allocate and initialize percpu slots */
+static inline int
+__freelist_init_slots(struct freelist_head *head, uint32_t nobjs,
+                      void *context, freelist_init_node_cb objinit)
+{
+	uint32_t i, objsz, cpus = head->fh_ncpus;
+	gfp_t gfp = head->fh_gfp;
+
+	/* allocate array for percpu slots */
+	head->fh_slots = kzalloc(cpus * sizeof(uint32_t) +
+	                         cpus * sizeof(void *), gfp);
+	if (!head->fh_slots)
+		return -ENOMEM;
+	head->fh_sz_slots = (uint32_t *)&head->fh_slots[cpus];
+
+	/* aligned object size by sizeof(void *) */
+	objsz = ALIGN(head->fh_objsz, sizeof(void *));
+
+	/* shall we allocate objects along with freelist_slot */
+	if (objsz)
+		head->fh_in_slot = 1;
+
+	/* intialize per-cpu slots */
+	for (i = 0; i < cpus; i++) {
+		struct freelist_slot *slot;
+		uint32_t j, n, s;
+
+		/* compute how many objects to be managed by this slot */
+		n = nobjs / cpus;
+		if (i < (nobjs % cpus))
+			n++;
+		s = sizeof(struct freelist_slot) + objsz * n;
+
+		/* decide which zone shall the slot be allocated from */
+		if (0 == i) {
+			if ((gfp & GFP_ATOMIC) || s < PAGE_SIZE)
+				head->fh_vmalloc = 0;
+			else
+				head->fh_vmalloc = 1;
+		}
+
+		/* allocate percpu slot & objects from local memory */
+		if (head->fh_vmalloc)
+			slot = vmalloc_node(s, cpu_to_node(i));
+		else
+			slot = kmalloc_node(s, head->fh_gfp, cpu_to_node(i));
+		if (!slot)
+			return -ENOMEM;
+
+		head->fh_slots[i] = slot;
+		head->fh_sz_slots[i] = s;
+
+		/* initialize percpu slot for the i-th cpu */
+		memset(slot, 0, s);
+		/* initialize pre-allocated record entries */
+		for (j = 0; head->fh_in_slot && j < n; j++) {
+			struct freelist_node *node;
+			node = SLOT_OBJS(slot) + j * objsz;
+			if (objinit) {
+				int rc = objinit(context, node);
+				if (rc)
+					return rc;
+			}
+			__freelist_insert_node(node, slot);
+			head->fh_nobjs++;
+		}
+	}
+
+	return 0;
+}
 
-static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
+/* cleanup all percpu slots of the object pool */
+static inline void __freelist_fini_slots(struct freelist_head *head)
+{
+	uint32_t i;
+
+	if (!head->fh_slots)
+		return;
+
+	for (i = 0; i < head->fh_ncpus; i++) {
+		if (!head->fh_slots[i])
+			continue;
+		if (head->fh_vmalloc)
+			vfree(head->fh_slots[i]);
+		else
+			kfree(head->fh_slots[i]);
+	}
+	kfree(head->fh_slots);
+	head->fh_slots = NULL;
+	head->fh_sz_slots = NULL;
+}
+
+/**
+ * freelist_init: initialize object pool and pre-allocate objects
+ *
+ * args:
+ * @fh:    the object pool to be initialized, declared by the caller
+ * @nojbs: total objects to be managed by this object pool
+ * @ojbsz: size of an object, to be pre-allocated if objsz is not 0
+ * @gfp:   gfp flags of caller's context for memory allocation
+ * @context: user context for object initialization callback
+ * @objinit: object initialization callback
+ *
+ * return:
+ *         0 for success, otherwise error code
+ *
+ * All pre-allocated objects are to be zeroed. Caller should do extra
+ * initialization before using.
+ */
+static inline int
+freelist_init(struct freelist_head *head, int nobjs, int objsz, gfp_t gfp,
+              void *context, freelist_init_node_cb objinit)
+{
+	memset(head, 0, sizeof(struct freelist_head));
+	head->fh_ncpus = num_possible_cpus();
+	head->fh_objsz = objsz;
+	head->fh_gfp = gfp & ~__GFP_ZERO;
+
+	if (__freelist_init_slots(head, nobjs, context, objinit)) {
+		__freelist_fini_slots(head);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * freelist_add_scattered: adding pre-allocated objects to objects pool
+ * during initialization. it will try to balance the object numbers of
+ * all slots.
+ *
+ * args:
+ * @node: object pointer to be added to object pool
+ * @head: object pool
+ *
+ * return:
+ *     0 or error code
+ *
+ * freelist_add_scattered doesn't handle race conditions, can only be
+ * called during object pool initialization
+ */
+static inline int
+freelist_add_scattered(struct freelist_node *node, struct freelist_head *head)
+{
+	uint32_t cpu;
+
+	/* try balance object numbers among slots */
+	cpu = head->fh_nobjs % head->fh_ncpus;
+	__freelist_insert_node(node, head->fh_slots[cpu]);
+	head->fh_nobjs++;
+
+	return 0;
+}
+
+/**
+ * freelist_populate: add objects from user provided pool in batch
+ *  *
+ * args:
+ * @oh:  object pool
+ * @buf: user buffer for pre-allocated objects
+ * @size: size of user buffer
+ * @objsz: size of object & element
+ * @context: user context for objinit callback
+ * @objinit: object initialization callback
+ *
+ * return:
+ *     0 or error code
+ */
+static inline int
+freelist_populate(struct freelist_head *head, void *buf, int size, int objsz,
+                  void *context, freelist_init_node_cb objinit)
+{
+	int used = 0;
+
+	if (head->fh_pool || !buf || !objsz || size < objsz)
+		return -EINVAL;
+	if (head->fh_objsz && head->fh_objsz != objsz)
+		return -EINVAL;
+
+	WARN_ON_ONCE(((unsigned long)buf) & (sizeof(void *) - 1));
+	WARN_ON_ONCE(((uint32_t)objsz) & (sizeof(void *) - 1));
+
+	while (used + objsz <= size) {
+		struct freelist_node *node = buf + used;
+		if (objinit) {
+			int rc = objinit(context, node);
+			if (rc)
+				return rc;
+		}
+		if (freelist_add_scattered(node, head))
+			break;
+		used += objsz;
+	}
+
+	if (!used)
+		return -ENOENT;
+
+	head->fh_pool = buf;
+	head->fh_sz_pool = size;
+	head->fh_objsz = objsz;
+
+	return 0;
+}
+
+static inline void __freelist_cas_add(struct freelist_node *node, struct freelist_slot *slot)
 {
 	/*
 	 * Since the refcount is zero, and nobody can increase it once it's
@@ -43,25 +386,26 @@ static inline void __freelist_add(struct freelist_node *node, struct freelist_he
 	 * who puts the refcount back to zero (which could be us, hence the
 	 * loop).
 	 */
-	struct freelist_node *head = READ_ONCE(list->head);
+	struct freelist_node *head = READ_ONCE(slot->fs_head);
 
 	for (;;) {
 		WRITE_ONCE(node->next, head);
 		atomic_set_release(&node->refs, 1);
 
-		if (!try_cmpxchg_release(&list->head, &head, node)) {
-			/*
-			 * Hmm, the add failed, but we can only try again when
-			 * the refcount goes back to zero.
-			 */
-			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
-				continue;
-		}
-		return;
+		if (try_cmpxchg_release(&slot->fs_head, &head, node))
+			break;
+
+		/*
+		 * Hmm, the add failed, but we can only try again when refcount
+		 * goes back to zero (with REFS_ON_FREELIST set).
+		 */
+		if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) != 1)
+			break;
 	}
 }
 
-static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
+/* adding object to slot */
+static inline int __freelist_add_slot(struct freelist_node *node, struct freelist_slot *slot)
 {
 	/*
 	 * We know that the should-be-on-freelist bit is 0 at this point, so
@@ -72,13 +416,34 @@ static inline void freelist_add(struct freelist_node *node, struct freelist_head
 		 * Oh look! We were the last ones referencing this node, and we
 		 * know we want to add it to the free list, so let's do it!
 		 */
-		__freelist_add(node, list);
+		__freelist_cas_add(node, slot);
 	}
+
+	return 0;
 }
 
-static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
+/**
+ * freelist_push: reclaim the object and return back to objects pool
+ *
+ * args:
+ * @node: object pointer to be pushed to object pool
+ * @head: object pool
+ *
+ * return:
+ *     0 (freelist_push never fail)
+ *
+ * freelist_push() can be nested (irp/softirq/preemption)
+ */
+static inline int freelist_push(struct freelist_node *node, struct freelist_head *head)
 {
-	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
+	int cpu = raw_smp_processor_id();
+	return __freelist_add_slot(node, head->fh_slots[cpu]);
+}
+
+/* try to retrieve object from slot */
+static inline struct freelist_node *__freelist_pop_slot(struct freelist_slot *slot)
+{
+	struct freelist_node *prev, *next, *head = smp_load_acquire(&slot->fs_head);
 	unsigned int refs;
 
 	while (head) {
@@ -86,7 +451,7 @@ static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
 		refs = atomic_read(&head->refs);
 		if ((refs & REFS_MASK) == 0 ||
 		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
-			head = smp_load_acquire(&list->head);
+			head = smp_load_acquire(&slot->fs_head);
 			continue;
 		}
 
@@ -96,7 +461,7 @@ static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
 		 * it changing between now and the time we do the CAS.
 		 */
 		next = READ_ONCE(head->next);
-		if (try_cmpxchg_acquire(&list->head, &head, next)) {
+		if (try_cmpxchg_acquire(&slot->fs_head, &head, next)) {
 			/*
 			 * Yay, got the node. This means it was on the list,
 			 * which means should-be-on-freelist must be false no
@@ -120,10 +485,108 @@ static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
 		 */
 		refs = atomic_fetch_add(-1, &prev->refs);
 		if (refs == REFS_ON_FREELIST + 1)
-			__freelist_add(prev, list);
+			__freelist_cas_add(prev, slot);
+	}
+
+	return NULL;
+}
+
+/**
+ * freelist_pop: allocate an object from objects pool
+ *
+ * args:
+ * @head: object pool
+ *
+ * return:
+ *   node: NULL if failed (object pool is empty)
+ *
+ * freelist_pop can be nesed, and guaranteed to be deadlock-free.
+ * So it can be called in any context, like irq/softirq/nmi.
+ */
+static inline struct freelist_node *freelist_pop(struct freelist_head *head)
+{
+	struct freelist_node *node;
+	int i, cpu = raw_smp_processor_id();
+
+	for (i = 0; i < head->fh_ncpus; i++) {
+		struct freelist_slot *slot;
+		slot = head->fh_slots[cpu];
+		node = __freelist_pop_slot(slot);
+		if (node)
+			return node;
+		if (++cpu >= head->fh_ncpus)
+			cpu = 0;
 	}
 
 	return NULL;
 }
 
+/* whether this object is from user buffer (batched adding) */
+static inline int freelist_is_inpool(void *obj, struct freelist_head *fh)
+{
+	return (obj && obj >= fh->fh_pool &&
+		obj < fh->fh_pool + fh->fh_sz_pool);
+}
+
+/* whether this object is pre-allocated with percpu slots */
+static inline int freelist_is_inslot(void *obj, struct freelist_head *fh)
+{
+	uint32_t i;
+
+	for (i = 0; i < fh->fh_ncpus; i++) {
+		void *ptr = fh->fh_slots[i];
+		if (obj && obj >= ptr && obj < ptr + fh->fh_sz_slots[i])
+		    return 1;
+	}
+
+	return 0;
+}
+
+/**
+ * freelist_fini: cleanup the whole object pool (releasing all objects)
+ *
+ * args:
+ * @head: object pool
+ * @context: user provided value for the callback of release() funciton
+ * @release: user provided callback for resource cleanup or statistics
+ *
+ * the protocol of release callback:
+ * static int release(void *context, void *obj, int user, int element);
+ * args:
+ *  context: user provided value
+ *  obj: the object (element or buffer) to be cleaned up
+ *  user: the object is manually provided by user
+ *  element: obj is an object or user-provided buffer
+ */
+static inline void freelist_fini(struct freelist_head *head, void *context,
+                                 int (*release)(void *, void *, int, int))
+{
+	uint32_t i;
+
+	if (!head->fh_slots)
+		return;
+
+	for (i = 0; release && i < head->fh_ncpus; i++) {
+		void *obj;
+		if (!head->fh_slots[i])
+			continue;
+		do {
+			obj = __freelist_pop_slot(head->fh_slots[i]);
+			if (obj) {
+				int user = !freelist_is_inpool(obj, head) &&
+				           !freelist_is_inslot(obj, head);
+				release(context, obj, user, 1);
+			}
+		} while (obj);
+	}
+
+	if (head->fh_pool && release) {
+		release(context, head->fh_pool, 1, 0);
+		head->fh_pool = NULL;
+		head->fh_sz_pool = 0;
+	}
+
+	__freelist_fini_slots(head);
+}
+
 #endif /* FREELIST_H */
-- 
2.25.1

