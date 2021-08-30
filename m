Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC45E3FBB00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238206AbhH3Red (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238095AbhH3Re3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:34:29 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692EC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:33:35 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id s29so7931427pfw.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZepU6FVush7NIrtv7RvTmFSGkSQMOdNprFsBqVj+OU8=;
        b=ibPtszB/Acgqp8QxMMwr2+L0V//h6ny78O9g34Upu0hepxLPVAU9jg4ZVT2P5qoeNd
         BZErLqSRhtfhqfnkgYFYVoHWVWUTSudaQIAKLd3EzBpjmtE3E0Hj8VYNziXM26EQvPHw
         +v4k6ACRKxJjqs1NwXss2my/HvvIfmPjkwjWEtJxRSWX57UJ3tj2BgR4fxUk0McjEkkP
         vENjACRwtpkO6/2hU1Z5VPozj/yWqPqhwJsWYcdUGzGCg4zuecdMqta3VIjcmxD8aTp+
         +OXpZLs7SIW+xOxkaKubtT5HnMflJ3PwuiVMmwwDMrvywNIn4tknxS75kdLP9C1cAbB3
         HOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZepU6FVush7NIrtv7RvTmFSGkSQMOdNprFsBqVj+OU8=;
        b=Flpt9+VLYhQK7sa1oAWRmELVcHrEK4xR0PcbhXM7anj/EkCrya+Zbwiaazxh+4T+Gm
         OZh8TcnFWb2DbZ8kDPe64P5xPypN+3mO2aqvZTdeB05dCw5/lzJGBGRMz3Gxhb2HbyM2
         5pYyzKwEY8hai1fdRNBXCcn64C4YYHry8m46kfSYuDmUxP3N8jfAVV12eYTpOLuyct09
         /ZwNBMSGTWEWTq+f+XFl50yzXCuym5c5670bwspbEllC0Hydt1CWJNVEn7iz4VM5IDJ7
         JiWAqcMGjWdebaOusFKFobv2NcCC+7YiUxm48/enQMaBPstN21Lxeoeck3VLbaJyK6Hq
         f95w==
X-Gm-Message-State: AOAM532ldtjXKNH2CE5sRAbd036EsfwMK21Q59Hj5mLY9HJxjgA6uFhs
        p1FslYRCLOjU+GxePtX/oThDRQ==
X-Google-Smtp-Source: ABdhPJxV4M5/kRVxtLnIrrxBkwWrdeGdlaDDDBBlSLUmEaM/L955tPwYCuz6WlpbIOQMQnkq6Qjlng==
X-Received: by 2002:a63:5c51:: with SMTP id n17mr22442392pgm.376.1630344815204;
        Mon, 30 Aug 2021 10:33:35 -0700 (PDT)
Received: from T490.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 26sm20183619pgx.72.2021.08.30.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 10:33:34 -0700 (PDT)
From:   wuqiang <wuqiang.matt@bytedance.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        wuqiang.matt@bytedance.com
Cc:     mattwu@163.com
Subject: [PATCH v2] kretprobe scalability improvement
Date:   Tue, 31 Aug 2021 01:33:24 +0800
Message-Id: <20210830173324.32507-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kretprobe is using freelist to manage return-instances, but freelist,
as LIFO queue based on singly linked list, scales badly and lowers
the throughput of kretprobed routines, especially for high contention
scenarios. Here's a typical case (2 XEON 8260, 48 cores/96 threads):

      1X       2X       4X       6X       8X      12X     16X
10880312 18121228 23214783 13155457 11190217 10991228 9623992
     24X      32X      48X      64X      96X     128X    192X
 8484455  8376786  6766684  5698349  4113405  4528009 4081401

This patch implements a scalable, lock-less and numa-aware object pool,
which brings near-linear scalability to kretprobed routines. Tests of
kretprobe throughput show the biggest gain as 181.5x of the original
freelist. And extreme tests of raw queue throughput can be up to 388.8x
over freelist. Here are the comparison results:

                  1X         2X         4X         8X        16X
freelist:  237911411  163596418   33048459   15506757   10640043
objpool:   234799081  294086132  585290693 1164205947 2334923746
                 24X        32X        48X        64X        96X
freelist:    9025299    7965531    6800225    5507639    4284752
objpool:  3508905695 1106760339 1101385147 1221763856 1211654038

The object pool is a percpu-extended version of the original freelist,
with compact memory footprints and balanced performance results for 3
test cases: nonblockable retrieval (most common kertprobe use cases),
bulk retrieval in a row (multiple-threaded blockable kretprobe), huge
misses (preallocated objects much less than what's required). More
information is available at: https://github.com/mattwuq/kretprobe.

Changes since V1 (Aug 30,2021):
1) reformat to a single patch as Masami Hiramatsu suggested
2) use __vmalloc_node to replace vmalloc_node for vmalloc
3) a few minor fixes: typo and coding-style issues

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/freelist.h | 522 ++++++++++++++++++++++++++++++++++++---
 include/linux/kprobes.h  |   2 +-
 kernel/kprobes.c         |  83 ++++---
 3 files changed, 537 insertions(+), 70 deletions(-)

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
index fc1842b96469..7306a34e3811 100644
--- a/include/linux/freelist.h
+++ b/include/linux/freelist.h
@@ -2,32 +2,376 @@
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
+ *	static int obj_init(void *context, struct freelist_node *obj)
+ *	{
+ *		struct my_node *node;
+ *		node = container_of(obj, struct my_node, obj);
+ *		do_init_node(context, node);
+ *		return 0;
+ *	}
+ *
+ * main():
+ *	freelist_init(&fh, num_possible_cpus() * 4, 16, GFP_KERNEL, context, obj_init);
+ *	<object pool initialized>
+ *
+ *	obj = freelist_pop(&fh);
+ *	do_something_with(obj);
+ *	freelist_push(obj, &fh);
+ *
+ *	<object pool to be destroyed>
+ *	freelist_fini(&fh, NULL, NULL);
+ *
+ * 2) batced with user's buffer
+ *
+ * obj_init():
+ *	static int obj_init(void *context, struct freelist_node *obj)
+ *	{
+ *		struct my_node *node;
+ *		node = container_of(obj, struct my_node, obj);
+ *		do_init_node(context, node);
+ *		return 0;
+ *	}
+ *
+ * free_buf():
+ *	static int free_buf(void *context, void *obj, int user, int element)
+ *	{
+ *		if (obj && user && !element)
+ *			kfree(obj);
+ *	}
+ *
+ * main():
+ *	freelist_init(&fh, num_possible_cpus() * 4, 0, GFP_KERNEL, 0, 0);
+ *	buffer = kmalloc(size, ...);
+ *	freelist_populate(&fh, buffer, size, 16, context, obj_init);
+ *	<object pool initialized>
+ *
+ *	obj = freelist_pop(&fh);
+ *	do_something_with(obj);
+ *	freelist_push(obj, &fh);
+ *
+ *	<object pool to be destroyed>
+ *	freelist_fini(&fh, context, free_buf);
+ *
+ * 3) manually added with user objects
+ *
+ * free_obj():
+ *	static int free_obj(void *context, void *obj, int user, int element)
+ *	{
+ *		struct my_node *node;
+ *		node = container_of(obj, struct my_node, obj);
+ *		if (obj && user && element)
+ *			kfree(node);
+ *	}
+ *
+ * main():
+ *	freelist_init(&fh, num_possible_cpus() * 4, 0, 0, GFP_KERNEL, 0, 0);
+ *	for () {
+ *		node = kmalloc(objsz, ...);
+ *		do_init_node(node);
+ *		freelist_add_scattered(&node.obj, oh);
+ *	}
+ *	<object pool initialized>
+ *
+ *	obj = freelist_pop(&fh);
+ *	do_something_with(obj);
+ *	freelist_push(obj, &fh);
+ *
+ *	<object pool to be destroyed>
+ *	freelist_fini(&fh, context, free_obj);
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
+			void *context, freelist_init_node_cb objinit)
+{
+	uint32_t i, objsz, cpus = head->fh_ncpus;
+	gfp_t gfp = head->fh_gfp;
+
+	/* allocate array for percpu slots */
+	head->fh_slots = kzalloc(cpus * sizeof(uint32_t) +
+				cpus * sizeof(void *), gfp);
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
+	/* initialize per-cpu slots */
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
+			slot = __vmalloc_node(s, 1, gfp, cpu_to_node(i),
+					__builtin_return_address(0));
+		else
+			slot = kmalloc_node(s, gfp, cpu_to_node(i));
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
+		void *context, freelist_init_node_cb objinit)
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
+		void *context, freelist_init_node_cb objinit)
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
@@ -43,25 +387,26 @@ static inline void __freelist_add(struct freelist_node *node, struct freelist_he
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
@@ -72,13 +417,34 @@ static inline void freelist_add(struct freelist_node *node, struct freelist_head
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
@@ -86,7 +452,7 @@ static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
 		refs = atomic_read(&head->refs);
 		if ((refs & REFS_MASK) == 0 ||
 		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
-			head = smp_load_acquire(&list->head);
+			head = smp_load_acquire(&slot->fs_head);
 			continue;
 		}
 
@@ -96,7 +462,7 @@ static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
 		 * it changing between now and the time we do the CAS.
 		 */
 		next = READ_ONCE(head->next);
-		if (try_cmpxchg_acquire(&list->head, &head, next)) {
+		if (try_cmpxchg_acquire(&slot->fs_head, &head, next)) {
 			/*
 			 * Yay, got the node. This means it was on the list,
 			 * which means should-be-on-freelist must be false no
@@ -120,10 +486,108 @@ static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
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
+			return 1;
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
+ * prototype of release callback:
+ * static int release(void *context, void *obj, int user, int element);
+ * args:
+ *  context: user provided value
+ *  obj: the object (element or buffer) to be cleaned up
+ *  user: the object is manually provided by user
+ *  element: obj is an object or user-provided buffer
+ */
+static inline void freelist_fini(struct freelist_head *head, void *context,
+				int (*release)(void *, void *, int, int))
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
+					!freelist_is_inslot(obj, head);
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
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index e4f3bfe08757..c63b8981d4c5 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -140,6 +140,7 @@ static inline int kprobe_ftrace(struct kprobe *p)
  */
 struct kretprobe_holder {
 	struct kretprobe	*rp;
+	struct freelist_head    fh;
 	refcount_t		ref;
 };
 
@@ -150,7 +151,6 @@ struct kretprobe {
 	int maxactive;
 	int nmissed;
 	size_t data_size;
-	struct freelist_head freelist;
 	struct kretprobe_holder *rph;
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 790a573bbe00..12879a3c582f 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1211,10 +1211,12 @@ NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
 static void free_rp_inst_rcu(struct rcu_head *head)
 {
 	struct kretprobe_instance *ri = container_of(head, struct kretprobe_instance, rcu);
+	struct kretprobe_holder *rph = ri->rph;
 
-	if (refcount_dec_and_test(&ri->rph->ref))
-		kfree(ri->rph);
-	kfree(ri);
+	if (refcount_dec_and_test(&rph->ref)) {
+		freelist_fini(&rph->fh, NULL, NULL);
+		kfree(rph);
+	}
 }
 NOKPROBE_SYMBOL(free_rp_inst_rcu);
 
@@ -1223,9 +1225,10 @@ static void recycle_rp_inst(struct kretprobe_instance *ri)
 	struct kretprobe *rp = get_kretprobe(ri);
 
 	if (likely(rp)) {
-		freelist_add(&ri->freelist, &rp->freelist);
-	} else
+		freelist_push(&ri->freelist, &rp->rph->fh);
+	} else {
 		call_rcu(&ri->rcu, free_rp_inst_rcu);
+	}
 }
 NOKPROBE_SYMBOL(recycle_rp_inst);
 
@@ -1280,23 +1283,19 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
 
 static inline void free_rp_inst(struct kretprobe *rp)
 {
-	struct kretprobe_instance *ri;
-	struct freelist_node *node;
-	int count = 0;
-
-	node = rp->freelist.head;
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, freelist);
-		node = node->next;
-
-		kfree(ri);
-		count++;
-	}
+	struct kretprobe_holder *rph = rp->rph;
+	struct freelist_node *fn;
 
-	if (refcount_sub_and_test(count, &rp->rph->ref)) {
-		kfree(rp->rph);
-		rp->rph = NULL;
-	}
+	rp->rph = NULL;
+	do {
+		/* must do pop() first since we have one extra ref grabbed */
+		fn = freelist_pop(&rph->fh);
+		if (refcount_dec_and_test(&rph->ref)) {
+			freelist_fini(&rph->fh, NULL, NULL);
+			kfree(rph);
+			break;
+		}
+	} while (fn);
 }
 
 /* Add the new probe to ap->list */
@@ -1922,19 +1921,18 @@ NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
 static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 {
 	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
-	struct kretprobe_instance *ri;
 	struct freelist_node *fn;
+	struct kretprobe_instance *ri;
 
-	fn = freelist_try_get(&rp->freelist);
+	fn = freelist_pop(&rp->rph->fh);
 	if (!fn) {
-		rp->nmissed++;
+		atomic_inc((atomic_t *)&rp->nmissed);
 		return 0;
 	}
-
 	ri = container_of(fn, struct kretprobe_instance, freelist);
 
 	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
-		freelist_add(&ri->freelist, &rp->freelist);
+		freelist_push(fn, &rp->rph->fh);
 		return 0;
 	}
 
@@ -1980,10 +1978,19 @@ int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long o
 	return 0;
 }
 
+static int kretprobe_init_inst(void *context, struct freelist_node *fn)
+{
+	struct kretprobe_instance *ri;
+
+	ri = container_of(fn, struct kretprobe_instance, freelist);
+	ri->rph = context;
+
+	return 0;
+}
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret;
-	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
 
@@ -2017,24 +2024,20 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
-	rp->freelist.head = NULL;
+
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
 	if (!rp->rph)
 		return -ENOMEM;
 
-	rp->rph->rp = rp;
-	for (i = 0; i < rp->maxactive; i++) {
-		inst = kzalloc(sizeof(struct kretprobe_instance) +
-			       rp->data_size, GFP_KERNEL);
-		if (inst == NULL) {
-			refcount_set(&rp->rph->ref, i);
-			free_rp_inst(rp);
-			return -ENOMEM;
-		}
-		inst->rph = rp->rph;
-		freelist_add(&inst->freelist, &rp->freelist);
+	if (freelist_init(&rp->rph->fh, rp->maxactive, rp->data_size +
+			  sizeof(struct kretprobe_instance), GFP_KERNEL,
+			  rp->rph, kretprobe_init_inst)) {
+		kfree(rp->rph);
+		rp->rph = NULL;
+		return -ENOMEM;
 	}
-	refcount_set(&rp->rph->ref, i);
+	refcount_set(&rp->rph->ref, rp->maxactive + 1);
+	rp->rph->rp = rp;
 
 	rp->nmissed = 0;
 	/* Establish function entry probe point */
-- 
2.25.1

