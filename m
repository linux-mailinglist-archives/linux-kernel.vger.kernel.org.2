Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1723B3BD8C8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbhGFOrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbhGFOqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:46:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B038EC0613B1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 07:32:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a14so11920122pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SouiVOY7Q5kSvZlT0fJ1KWOmmaz7DnKucRU5hxmUgFs=;
        b=XeVJ7eH5W77DB3Emn8vzrvgW7k6WhXs2ey+vYgJG27X2K0GltdIgNq0GAlY2+XxIIA
         aJvLDdOVVJttkMbi3ulOui+jAq+wNNZeaSAf4SvdnDKsC+O3VPXi/be0ZPKC7RmP+OlL
         DblDC4pOkOlr7DYXKO0qCIwIo9ymSAKhw7XBzwv4YUzC2N49Uoaqy5n8I3VG9yUaI7ik
         hEAnPPKxZ0kZSCgDnFW2xSuG8lnuwIxytchoktwiI6B8fymZADf4DMUCVdThZ18g+b4f
         4qQG4a8cFCwbbsH25EKIxfQAlOxkqKdJj1zoSOY5xd/pFubmVmaNuR682nLygUoLNpir
         GeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SouiVOY7Q5kSvZlT0fJ1KWOmmaz7DnKucRU5hxmUgFs=;
        b=uUtgg6C2ewYgtPZN+A+otJB1N9QmhhVYNnmW9LDrbBumYdzcF9xeun2Nf4D8tc1GLG
         UnayfmVj4Vgz8ceZ3UZfK/4x5gfWEW2zQx+4wQ3lz2c//lqoC8HN1tXQ7iXkCyOwuQtM
         JEjQrwNEUqZ6+agep438b6/wpDGy1c7w5hmU0GU5Fm5T75rKJlyME+Dg5P9Cg71LlVlC
         alW4k9okuT2hSrY3KXdWJcVAcPKbL6huiTliFmJeBL09ACSaly+pi9MxXVV9u9wl5Xr2
         oz8ptVhbTcn4AHnV7XpodFo0bKK5KIB7Srv5uzjifU4rqeBm6AmFcuilsJMo+TGAdkcy
         3r4A==
X-Gm-Message-State: AOAM533vTJ9qAW8aLdCwISyIoiNd9KM3xRs+9ZQETKxLKR7O6ldSL2tY
        lBNrvrMwezSumj/p8uWpYzc0EA==
X-Google-Smtp-Source: ABdhPJw8XTNHWhygyXFEGJsrucqdKMcM+eLVQi213U18wG4IDTBcVZkX406TEo2sHtP+UwyxLe7BaQ==
X-Received: by 2002:a17:902:e88b:b029:127:a2f4:37b5 with SMTP id w11-20020a170902e88bb0290127a2f437b5mr16884760plg.20.1625581978124;
        Tue, 06 Jul 2021 07:32:58 -0700 (PDT)
Received: from T490.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id e24sm16982283pfn.127.2021.07.06.07.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 07:32:57 -0700 (PDT)
From:   "wuqiang.matt" <wuqiang.matt@bytedance.com>
To:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, mhiramat@kernel.org, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        wuqiang.matt@bytedance.com
Cc:     mattwu@163.com
Subject: [PATCH v2] kretprobe scalability improvement
Date:   Tue,  6 Jul 2021 22:32:38 +0800
Message-Id: <20210706143238.239503-1-wuqiang.matt@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuqiang <wuqiang.matt@bytedance.com>

The original freelist is a LIFO queue based on singly linked list, which lacks
of scalability, and thus becomes bottleneck under high workloads. freelist was
introduced by Masami Hiramatsu's work of removing kretprobe hash lock:
url: https://lkml.org/lkml/2020/8/29/209.

An array-based MPMC lockless queue is proposed here. The solution of bounded
array can nicely avoid ABA issue. The other advantage is: order and fairness
can be ignored. The only concern is to retrieve kretprobe instance records as
fast as possible.

Tests of kretprobe on 96-CORE ARM64 show the biggest gain as 466.7x of the
original freelist throughput. The raw queue throughput can be 1,975 times of
freelist. Here are the results:

Ubuntu 20.04, 5.13.0-rc6 (XEON E5-2660V3 2.4G, DDR4 2133MT/s, 10 CORES/20 THREADS):
                1x        2x        4x        8x        10x        16x        20x        32x        40x
freelist: 13086080  22493637  32773854  20129772   18455899   18435561   18980332   18988603   18991334
array   :  13144036  26059941  47449954  94517172  115856027  116414714  125692971  125553061  125685981

Ubuntu 21.04 - 5.12.10 QEMU 96 CORES (HUAWEI TaiShan 2280V2  KP920 96 CORES 2.6G, DDR4 2944 MT/s):
                  1x          2x          4x          8x          16x          24x          48x            96x           192x
freelist: 17,233,640  10,296,664   8,095,309   6,993,545    5,050,817    4,295,283    3,382,013      2,738,050      2,743,345
array:    19,360,905  37,395,225  56,417,463  10,020,136  209,876,209  328,940,014  632,754,916  1,277,862,473  1,169,076,739

More info is available at: https://github.com/mattwuq/kretprobe

V2 changes (21/07/06):
* optimizations for large maxactive values: array to be evenly divided
* freelist_try_add to be called for the insertion during initializing

Signed-off-by: wuqiang <wuqiang.matt@bytedance.com>
---
 include/linux/freelist.h | 190 +++++++++++++++++++--------------------
 kernel/kprobes.c         |  31 ++++---
 2 files changed, 111 insertions(+), 110 deletions(-)

diff --git a/include/linux/freelist.h b/include/linux/freelist.h
index fc1842b96469..a3f3fd025724 100644
--- a/include/linux/freelist.h
+++ b/include/linux/freelist.h
@@ -1,129 +1,125 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 #ifndef FREELIST_H
 #define FREELIST_H
 
+#include <linux/slab.h>
 #include <linux/atomic.h>
 
 /*
- * Copyright: cameron@moodycamel.com
+ * lockless queue for kretprobe instances
  *
- * A simple CAS-based lock-free free list. Not the fastest thing in the world
- * under heavy contention, but simple and correct (assuming nodes are never
- * freed until after the free list is destroyed), and fairly speedy under low
- * contention.
- *
- * Adapted from: https://moodycamel.com/blog/2014/solving-the-aba-problem-for-lock-free-free-lists
+ * It's an array-based MPMC lockless queue, solely for better scalability
+ * and contention mitigation. It's simple in implementation and compact in
+ * memory efficiency. The only concern is to retrieve kretprobe instance
+ * records as fast as possible, with both order and fairness ignored.
  */
 
 struct freelist_node {
-	atomic_t		refs;
-	struct freelist_node	*next;
+	struct freelist_node    *next;
 };
-
 struct freelist_head {
-	struct freelist_node	*head;
+	uint32_t                fh_size;	/* rounded to power of 2 */
+	uint32_t                fh_mask;	/* (fh_size - 1) */
+	uint16_t                fh_bits;	/* log2(fh_size) */
+	uint16_t                fh_step;	/* per-core shift stride */
+	uint32_t                fh_used;	/* num of elements in list */
+	struct freelist_node  **fh_ents;	/* array for krp instances */
 };
 
-#define REFS_ON_FREELIST 0x80000000
-#define REFS_MASK	 0x7FFFFFFF
+static inline int freelist_init(struct freelist_head *list, int max)
+{
+	uint32_t size, cores = roundup_pow_of_two(num_possible_cpus());
+
+	list->fh_used = 0;
+	list->fh_step = ilog2(L1_CACHE_BYTES / sizeof(void *));
+	if (max < (cores << list->fh_step))
+		list->fh_size = cores << list->fh_step;
+	else
+		list->fh_size = roundup_pow_of_two(max);
+	list->fh_mask = list->fh_size - 1;
+	list->fh_bits = (uint16_t)ilog2(list->fh_size);
+	list->fh_step = list->fh_bits - (uint16_t)ilog2(cores);
+	size = list->fh_size * sizeof(struct freelist_node *);
+	list->fh_ents = kzalloc(size, GFP_KERNEL);
+	if (!list->fh_ents)
+		return -ENOMEM;
+
+	return 0;
+}
 
-static inline void __freelist_add(struct freelist_node *node, struct freelist_head *list)
+static inline int freelist_try_add(struct freelist_node *node, struct freelist_head *list)
 {
-	/*
-	 * Since the refcount is zero, and nobody can increase it once it's
-	 * zero (except us, and we run only one copy of this method per node at
-	 * a time, i.e. the single thread case), then we know we can safely
-	 * change the next pointer of the node; however, once the refcount is
-	 * back above zero, then other threads could increase it (happens under
-	 * heavy contention, when the refcount goes to zero in between a load
-	 * and a refcount increment of a node in try_get, then back up to
-	 * something non-zero, then the refcount increment is done by the other
-	 * thread) -- so if the CAS to add the node to the actual list fails,
-	 * decrese the refcount and leave the add operation to the next thread
-	 * who puts the refcount back to zero (which could be us, hence the
-	 * loop).
-	 */
-	struct freelist_node *head = READ_ONCE(list->head);
-
-	for (;;) {
-		WRITE_ONCE(node->next, head);
-		atomic_set_release(&node->refs, 1);
-
-		if (!try_cmpxchg_release(&list->head, &head, node)) {
-			/*
-			 * Hmm, the add failed, but we can only try again when
-			 * the refcount goes back to zero.
-			 */
-			if (atomic_fetch_add_release(REFS_ON_FREELIST - 1, &node->refs) == 1)
-				continue;
+	uint32_t i, hint;
+
+	hint = (list->fh_used << list->fh_step) +
+	       (list->fh_used >> (list->fh_bits - list->fh_step));
+	for (i = 0; i < list->fh_size; i++) {
+		struct freelist_node *item = NULL;
+		uint32_t slot = (i + hint) & list->fh_mask;
+		if (try_cmpxchg_release(&list->fh_ents[slot], &item, node)) {
+			list->fh_used++;
+			break;
 		}
-		return;
 	}
+
+	return (i >= list->fh_size);
 }
 
-static inline void freelist_add(struct freelist_node *node, struct freelist_head *list)
+static inline int freelist_add(struct freelist_node *node, struct freelist_head *list)
 {
-	/*
-	 * We know that the should-be-on-freelist bit is 0 at this point, so
-	 * it's safe to set it using a fetch_add.
-	 */
-	if (!atomic_fetch_add_release(REFS_ON_FREELIST, &node->refs)) {
-		/*
-		 * Oh look! We were the last ones referencing this node, and we
-		 * know we want to add it to the free list, so let's do it!
-		 */
-		__freelist_add(node, list);
-	}
+	uint32_t hint = raw_smp_processor_id() << list->fh_step;
+	uint32_t slot = ((uint32_t) hint) & list->fh_mask;
+
+	do {
+		struct freelist_node *item = NULL;
+		if (try_cmpxchg_release(&list->fh_ents[slot], &item, node))
+			return 0;
+		slot = (slot + 1) & list->fh_mask;
+	} while (1);
+
+	return -1;
 }
 
 static inline struct freelist_node *freelist_try_get(struct freelist_head *list)
 {
-	struct freelist_node *prev, *next, *head = smp_load_acquire(&list->head);
-	unsigned int refs;
-
-	while (head) {
-		prev = head;
-		refs = atomic_read(&head->refs);
-		if ((refs & REFS_MASK) == 0 ||
-		    !atomic_try_cmpxchg_acquire(&head->refs, &refs, refs+1)) {
-			head = smp_load_acquire(&list->head);
-			continue;
+	struct freelist_node *node = NULL;
+	uint32_t i, hint = raw_smp_processor_id() << list->fh_step;
+
+	for (i = 0; i < list->fh_size; i++) {
+		uint32_t slot = (hint + i) & list->fh_mask;
+		struct freelist_node *item = smp_load_acquire(&list->fh_ents[slot]);
+		if (item && try_cmpxchg_release(&list->fh_ents[slot], &item, NULL)) {
+			node = item;
+			break;
 		}
+	}
 
-		/*
-		 * Good, reference count has been incremented (it wasn't at
-		 * zero), which means we can read the next and not worry about
-		 * it changing between now and the time we do the CAS.
-		 */
-		next = READ_ONCE(head->next);
-		if (try_cmpxchg_acquire(&list->head, &head, next)) {
-			/*
-			 * Yay, got the node. This means it was on the list,
-			 * which means should-be-on-freelist must be false no
-			 * matter the refcount (because nobody else knows it's
-			 * been taken off yet, it can't have been put back on).
-			 */
-			WARN_ON_ONCE(atomic_read(&head->refs) & REFS_ON_FREELIST);
-
-			/*
-			 * Decrease refcount twice, once for our ref, and once
-			 * for the list's ref.
-			 */
-			atomic_fetch_add(-2, &head->refs);
-
-			return head;
-		}
+	return node;
+}
 
-		/*
-		 * OK, the head must have changed on us, but we still need to decrement
-		 * the refcount we increased.
-		 */
-		refs = atomic_fetch_add(-1, &prev->refs);
-		if (refs == REFS_ON_FREELIST + 1)
-			__freelist_add(prev, list);
+static inline void freelist_destroy(struct freelist_head *list, void *context,
+                                    int (*release)(void *, void *))
+{
+	uint32_t i;
+
+	if (!list->fh_ents)
+		return;
+
+	for (i = 0; i < list->fh_size; i++) {
+		uint32_t slot = i & list->fh_mask;
+		struct freelist_node *item = smp_load_acquire(&list->fh_ents[slot]);
+		while (item) {
+			if (try_cmpxchg_release(&list->fh_ents[slot], &item, NULL)) {
+				if (release)
+					release(context, item);
+				break;
+			}
+		}
 	}
 
-	return NULL;
+	if (list->fh_ents) {
+		kfree(list->fh_ents);
+		list->fh_ents = NULL;
+	}
 }
-
 #endif /* FREELIST_H */
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 471b1d18a92f..36b20ed280a1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1277,20 +1277,21 @@ void kprobe_flush_task(struct task_struct *tk)
 }
 NOKPROBE_SYMBOL(kprobe_flush_task);
 
-static inline void free_rp_inst(struct kretprobe *rp)
+static int release_ri(void *context, void *node)
 {
 	struct kretprobe_instance *ri;
-	struct freelist_node *node;
-	int count = 0;
+	ri = container_of(node, struct kretprobe_instance, freelist);
+	kfree(ri);
+	if (context)
+		(*((int *)context))++;
+	return 0;
+}
 
-	node = rp->freelist.head;
-	while (node) {
-		ri = container_of(node, struct kretprobe_instance, freelist);
-		node = node->next;
+static inline void free_rp_inst(struct kretprobe *rp)
+{
+	int count = 0;
 
-		kfree(ri);
-		count++;
-	}
+	freelist_destroy(&rp->freelist, &count, release_ri);
 
 	if (refcount_sub_and_test(count, &rp->rph->ref)) {
 		kfree(rp->rph);
@@ -2015,10 +2016,14 @@ int register_kretprobe(struct kretprobe *rp)
 		rp->maxactive = num_possible_cpus();
 #endif
 	}
-	rp->freelist.head = NULL;
+	if (freelist_init(&rp->freelist, rp->maxactive))
+		return -ENOMEM;
+
 	rp->rph = kzalloc(sizeof(struct kretprobe_holder), GFP_KERNEL);
-	if (!rp->rph)
+	if (!rp->rph) {
+		freelist_destroy(&rp->freelist, NULL, NULL);
 		return -ENOMEM;
+	}
 
 	rp->rph->rp = rp;
 	for (i = 0; i < rp->maxactive; i++) {
@@ -2030,7 +2035,7 @@ int register_kretprobe(struct kretprobe *rp)
 			return -ENOMEM;
 		}
 		inst->rph = rp->rph;
-		freelist_add(&inst->freelist, &rp->freelist);
+		freelist_try_add(&inst->freelist, &rp->freelist);
 	}
 	refcount_set(&rp->rph->ref, i);
 
-- 
2.25.1

