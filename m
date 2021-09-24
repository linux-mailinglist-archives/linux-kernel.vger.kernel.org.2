Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38901416A78
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 05:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244057AbhIXDio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 23:38:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:36028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244031AbhIXDik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 23:38:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6BED61241;
        Fri, 24 Sep 2021 03:37:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1mTc1K-003I0H-Np; Thu, 23 Sep 2021 23:37:06 -0400
Message-ID: <20210924033706.539296792@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 23 Sep 2021 23:35:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH 2/2] tracing: Create a sparse bitmask for pid filtering
References: <20210924033547.939554938@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When the trace_pid_list was created, the default pid max was 32768.
Creating a bitmask that can hold one bit for all 32768 took up 4096 (one
page). Having a one page bitmask was not much of a problem, and that was
used for mapping pids. But today, systems are bigger and can run more
tasks, and now the default pid_max is usually set to 4194304. Which means
to handle that many pids requires 524288 bytes. Worse yet, the pid_max can
be set to 2^30 (1073741824 or 1G) which would take 134217728 (128M) of
memory to store this array.

Since the pid_list array is very sparsely populated, it is a huge waste of
memory to store all possible bits for each pid when most will not be set.

Instead, use a page table scheme to store the array, and allow this to
handle up to 32 bit pids.

The pid_mask will start out with 1024 entries for the first 10 MSB bits.
This will cost 4K for 32 bit architectures and 8K for 64 bit. Each of
these will have a 1024 array to store the next 10 bits of the pid (another
4 or 8K). These will hold an 512 byte bitmask (which will cover the LSB 12
  bits or 4096 bits).

When the trace_pid_list is allocated, it will have the 4/8K upper bits
allocated, and then it will allocate a cache for the next upper chunks and
the lower chunks (default 6 of each). Then when a bit is "set", these
chunks will be pulled from the free list and added to the array. If the
free list gets down to a lever (default 2), it will trigger an irqwork
that will refill the cache back up.

On clearing a bit, if the clear causes the bitmask to be zero, that chunk
will then be placed back into the free cache for later use, keeping the
need to allocate more down to a minimum.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/pid_list.c | 460 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 423 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/pid_list.c b/kernel/trace/pid_list.c
index b78c80d7f396..f307de267a9e 100644
--- a/kernel/trace/pid_list.c
+++ b/kernel/trace/pid_list.c
@@ -2,15 +2,182 @@
 /*
  * Copyright (C) 2021 VMware Inc, Steven Rostedt <rostedt@goodmis.org>
  */
-#include <linux/vmalloc.h>
+#include <linux/spinlock.h>
+#include <linux/irq_work.h>
 #include <linux/slab.h>
-#include "trace.h"
+
+/*
+ * In order to keep track of what pids to trace, a tree is created much
+ * like page tables are used. This creates a sparse bit map, where
+ * the tree is filled in when needed. A PID is 32 bits, and is broken
+ * up into 3 sections based on the bit map of the bits. The 10 MSB
+ * is the "upper1" section. The next 10 MSB is the "upper2" section
+ * and the 12 LSB is the "lower" section.
+ *
+ * A trace_pid_list structure holds the "upper1" section, in an
+ * array of 1024 pointers to "upper_chunk" unions, where each has an
+ * array of 1024 pointers to the "lower_chunk" structures, where each
+ * has an array of size 512 bytes representing a bitmask of the 12 LSB of
+ * the PID (512 * 8 = 4096)
+ *
+ * When a trace_pid_list is allocated, it includes the 1024 array
+ * of the upper1 unions. Then a "cache" of upper and lower is allocated
+ * where these will be assigned as needed.
+ *
+ * When a bit is set in the pid_list bitmask, the pid to use has
+ * the 10 MSB masked, and this is used to index the array in the
+ * pid_list to find the next upper union. If the element is NULL,
+ * then one is retrieved from the upper_list cache. If none is
+ * available, then -ENOMEM is returned.
+ *
+ * The next 10 MSB is used to index into the "upper2" section. If this
+ * element is NULL, then it is retrieved from the lower_list cache.
+ * Again, if one is not available -ENOMEM is returned.
+ *
+ * Finally the 12 LSB of the PID is used to set the bit in the 4096
+ * bitmask (made up of 512 bytes).
+ *
+ * The upper mask is never freed until the trace_pid_list is freed,
+ * but the lower sections are moved back to the cache list when
+ * all the bits are cleared and can be reused.
+ */
+
+#define UPPER1_SIZE	1024
+#define UPPER2_SIZE	1024
+
+#define LOWER_BITS	4096
+#define LOWER_SIZE	(LOWER_BITS / BITS_PER_LONG)
+
+#define UPPER1_SHIFT	24
+#define UPPER2_SHIFT	12
+#define LOWER_MASK	((1 << UPPER2_SHIFT) - 1)
+
+/* UPPER_MASK is 10 bits, done after the shift */
+#define UPPER_MASK	((1 << 10) - 1)
+
+/* Just keep 6 chunks of both upper and lower in the cache on alloc */
+#define CHUNK_ALLOC 6
+
+/* Have 2 chunks free, trigger a refill of the cache */
+#define CHUNK_REALLOC 2
+
+union lower_chunk {
+	union lower_chunk		*next;
+	unsigned long			data[LOWER_SIZE]; // 512B in size
+};
+
+union upper_chunk {
+	union upper_chunk		*next;
+	union lower_chunk		*data[UPPER2_SIZE]; // 4 or 8K in size
+};
 
 struct trace_pid_list {
-	int			pid_max;
-	unsigned long		*pids;
+	raw_spinlock_t			lock;
+	struct irq_work			refill_irqwork;
+	union upper_chunk		*upper[UPPER1_SIZE]; // 4 or 8K in size
+	union upper_chunk		*upper_list;
+	union lower_chunk		*lower_list;
+	int				free_upper_chunks;
+	int				free_lower_chunks;
 };
 
+static inline union lower_chunk *get_lower_chunk(struct trace_pid_list *pid_list)
+{
+	union lower_chunk *chunk;
+
+	lockdep_assert_held(&pid_list->lock);
+
+	if (!pid_list->lower_list)
+		return NULL;
+
+	chunk = pid_list->lower_list;
+	pid_list->lower_list = chunk->next;
+	pid_list->free_lower_chunks--;
+	WARN_ON_ONCE(pid_list->free_lower_chunks < 0);
+	chunk->next = NULL;
+	/*
+	 * If a refill needs to happen, it can not happen here
+	 * as the scheduler run queue locks are held.
+	 */
+	if (pid_list->free_lower_chunks <= CHUNK_REALLOC)
+		irq_work_queue(&pid_list->refill_irqwork);
+
+	return chunk;
+}
+
+static inline union upper_chunk *get_upper_chunk(struct trace_pid_list *pid_list)
+{
+	union upper_chunk *chunk;
+
+	lockdep_assert_held(&pid_list->lock);
+
+	if (!pid_list->upper_list)
+		return NULL;
+
+	chunk = pid_list->upper_list;
+	pid_list->upper_list = chunk->next;
+	pid_list->free_upper_chunks--;
+	WARN_ON_ONCE(pid_list->free_upper_chunks < 0);
+	chunk->next = NULL;
+	/*
+	 * If a refill needs to happen, it can not happen here
+	 * as the scheduler run queue locks are held.
+	 */
+	if (pid_list->free_upper_chunks <= CHUNK_REALLOC)
+		irq_work_queue(&pid_list->refill_irqwork);
+
+	return chunk;
+}
+
+static inline void put_lower_chunk(struct trace_pid_list *pid_list,
+				   union lower_chunk *chunk)
+{
+	lockdep_assert_held(&pid_list->lock);
+
+	chunk->next = pid_list->lower_list;
+	pid_list->lower_list = chunk;
+	pid_list->free_lower_chunks++;
+}
+
+static inline void put_upper_chunk(struct trace_pid_list *pid_list,
+				   union upper_chunk *chunk)
+{
+	lockdep_assert_held(&pid_list->lock);
+
+	chunk->next = pid_list->upper_list;
+	pid_list->upper_list = chunk;
+	pid_list->free_upper_chunks++;
+}
+
+static inline bool upper_empty(union upper_chunk *chunk)
+{
+	/*
+	 * If chunk->data has no lower chunks, it will be the same
+	 * as a zeroed bitmask. Use find_first_bit() to test it
+	 * and if it doesn't find any bits set, then the array
+	 * is empty.
+	 */
+	int bit = find_first_bit((unsigned long *)chunk->data,
+				 sizeof(chunk->data) * 8);
+	return bit >= sizeof(chunk->data) * 8;
+}
+
+static inline void pid_split(unsigned int pid, unsigned int *upper1,
+			     unsigned int *upper2, unsigned int *lower)
+{
+	*upper1 = (pid >> UPPER1_SHIFT) & UPPER_MASK;
+	*upper2 = (pid >> UPPER2_SHIFT) & UPPER_MASK;
+	*lower = pid & LOWER_MASK;
+}
+
+static inline unsigned int pid_join(unsigned int upper1,
+				    unsigned int upper2, unsigned int lower)
+{
+	return ((upper1 & UPPER_MASK) << UPPER1_SHIFT) |
+		((upper2 & UPPER_MASK) << UPPER2_SHIFT) |
+		(lower & LOWER_MASK);
+}
+
 /**
  * trace_pid_list_is_set - test if the pid is set in the list
  * @pid_list: The pid list to test
@@ -24,14 +191,29 @@ struct trace_pid_list {
  */
 bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
 {
-	/*
-	 * If pid_max changed after filtered_pids was created, we
-	 * by default ignore all pids greater than the previous pid_max.
-	 */
-	if (pid >= pid_list->pid_max)
+	union upper_chunk *upper_chunk;
+	union lower_chunk *lower_chunk;
+	unsigned long flags;
+	unsigned int upper1;
+	unsigned int upper2;
+	unsigned int lower;
+	bool ret = false;
+
+	if (!pid_list)
 		return false;
 
-	return test_bit(pid, pid_list->pids);
+	pid_split(pid, &upper1, &upper2, &lower);
+
+	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	upper_chunk = pid_list->upper[upper1];
+	if (upper_chunk) {
+		lower_chunk = upper_chunk->data[upper2];
+		if (lower_chunk)
+			ret = test_bit(lower, lower_chunk->data);
+	}
+	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+
+	return ret;
 }
 
 /**
@@ -47,13 +229,43 @@ bool trace_pid_list_is_set(struct trace_pid_list *pid_list, unsigned int pid)
  */
 int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
 {
-	/* Sorry, but we don't support pid_max changing after setting */
-	if (pid >= pid_list->pid_max)
-		return -EINVAL;
+	union upper_chunk *upper_chunk;
+	union lower_chunk *lower_chunk;
+	unsigned long flags;
+	unsigned int upper1;
+	unsigned int upper2;
+	unsigned int lower;
+	int ret;
+
+	if (!pid_list)
+		return -ENODEV;
 
-	set_bit(pid, pid_list->pids);
+	pid_split(pid, &upper1, &upper2, &lower);
 
-	return 0;
+	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	upper_chunk = pid_list->upper[upper1];
+	if (!upper_chunk) {
+		upper_chunk = get_upper_chunk(pid_list);
+		if (!upper_chunk) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		pid_list->upper[upper1] = upper_chunk;
+	}
+	lower_chunk = upper_chunk->data[upper2];
+	if (!lower_chunk) {
+		lower_chunk = get_lower_chunk(pid_list);
+		if (!lower_chunk) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		upper_chunk->data[upper2] = lower_chunk;
+	}
+	set_bit(lower, lower_chunk->data);
+	ret = 0;
+ out:
+	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	return ret;
 }
 
 /**
@@ -69,12 +281,40 @@ int trace_pid_list_set(struct trace_pid_list *pid_list, unsigned int pid)
  */
 int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 {
-	/* Sorry, but we don't support pid_max changing after setting */
-	if (pid >= pid_list->pid_max)
-		return -EINVAL;
+	union upper_chunk *upper_chunk;
+	union lower_chunk *lower_chunk;
+	unsigned long flags;
+	unsigned int upper1;
+	unsigned int upper2;
+	unsigned int lower;
+
+	if (!pid_list)
+		return -ENODEV;
+
+	pid_split(pid, &upper1, &upper2, &lower);
+
+	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	upper_chunk = pid_list->upper[upper1];
+	if (!upper_chunk)
+		goto out;
+
+	lower_chunk = upper_chunk->data[upper2];
+	if (!lower_chunk)
+		goto out;
 
-	clear_bit(pid, pid_list->pids);
+	clear_bit(lower, lower_chunk->data);
 
+	/* if there's no more bits set, add it to the free list */
+	if (find_first_bit(lower_chunk->data, LOWER_BITS) >= LOWER_BITS) {
+		put_lower_chunk(pid_list, lower_chunk);
+		upper_chunk->data[upper2] = NULL;
+		if (upper_empty(upper_chunk)) {
+			put_upper_chunk(pid_list, upper_chunk);
+			pid_list->upper[upper1] = NULL;
+		}
+	}
+ out:
+	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
 	return 0;
 }
 
@@ -93,13 +333,44 @@ int trace_pid_list_clear(struct trace_pid_list *pid_list, unsigned int pid)
 int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
 			unsigned int *next)
 {
-	pid = find_next_bit(pid_list->pids, pid_list->pid_max, pid);
+	union upper_chunk *upper_chunk;
+	union lower_chunk *lower_chunk;
+	unsigned long flags;
+	unsigned int upper1;
+	unsigned int upper2;
+	unsigned int lower;
+
+	if (!pid_list)
+		return -ENODEV;
+
+	pid_split(pid, &upper1, &upper2, &lower);
 
-	if (pid < pid_list->pid_max) {
-		*next = pid;
-		return 0;
+	raw_spin_lock_irqsave(&pid_list->lock, flags);
+	for (; upper1 <= UPPER_MASK; upper1++, upper2 = 0) {
+		upper_chunk = pid_list->upper[upper1];
+
+		if (!upper_chunk)
+			continue;
+
+		for (; upper2 <= UPPER_MASK; upper2++, lower = 0) {
+			lower_chunk = upper_chunk->data[upper2];
+			if (!lower_chunk)
+				continue;
+
+			lower = find_next_bit(lower_chunk->data, LOWER_BITS,
+					    lower);
+			if (lower < LOWER_BITS)
+				goto found;
+		}
 	}
-	return -1;
+
+ found:
+	raw_spin_unlock_irqrestore(&pid_list->lock, flags);
+	if (upper1 > UPPER_MASK)
+		return -1;
+
+	*next = pid_join(upper1, upper2, lower);
+	return 0;
 }
 
 /**
@@ -114,15 +385,79 @@ int trace_pid_list_next(struct trace_pid_list *pid_list, unsigned int pid,
  */
 int trace_pid_list_first(struct trace_pid_list *pid_list, unsigned int *pid)
 {
-	unsigned int first;
+	return trace_pid_list_next(pid_list, 0, pid);
+}
 
-	first = find_first_bit(pid_list->pids, pid_list->pid_max);
+static void pid_list_refill_irq(struct irq_work *iwork)
+{
+	struct trace_pid_list *pid_list = container_of(iwork, struct trace_pid_list,
+						       refill_irqwork);
+	union upper_chunk *upper;
+	union lower_chunk *lower;
+	union upper_chunk **upper_next = &upper;
+	union lower_chunk **lower_next = &lower;
+	int upper_count;
+	int lower_count;
+	int ucnt = 0;
+	int lcnt = 0;
+
+ again:
+	raw_spin_lock(&pid_list->lock);
+	upper_count = CHUNK_ALLOC - pid_list->free_upper_chunks;
+	lower_count = CHUNK_ALLOC - pid_list->free_lower_chunks;
+	raw_spin_unlock(&pid_list->lock);
+
+	if (upper_count <= 0 && lower_count <= 0)
+		return;
 
-	if (first < pid_list->pid_max) {
-		*pid = first;
-		return 0;
+	while (upper_count-- > 0) {
+		union upper_chunk *chunk;
+
+		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		if (!chunk)
+			break;
+		*upper_next = chunk;
+		upper_next = &chunk->next;
+		ucnt++;
+	}
+
+	while (lower_count-- > 0) {
+		union lower_chunk *chunk;
+
+		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		if (!chunk)
+			break;
+		*lower_next = chunk;
+		lower_next = &chunk->next;
+		lcnt++;
 	}
-	return -1;
+
+	raw_spin_lock(&pid_list->lock);
+	if (upper) {
+		*upper_next = pid_list->upper_list;
+		pid_list->upper_list = upper;
+		pid_list->free_upper_chunks += ucnt;
+	}
+	if (lower) {
+		*lower_next = pid_list->lower_list;
+		pid_list->lower_list = lower;
+		pid_list->free_lower_chunks += lcnt;
+	}
+	raw_spin_unlock(&pid_list->lock);
+
+	/*
+	 * On success of allocating all the chunks, both counters
+	 * will be less than zero. If they are not, then an allocation
+	 * failed, and we should not try again.
+	 */
+	if (upper_count >= 0 || lower_count >= 0)
+		return;
+	/*
+	 * When the locks were released, free chunks could have
+	 * been used and allocation needs to be done again. Might as
+	 * well allocate it now.
+	 */
+	goto again;
 }
 
 /**
@@ -135,18 +470,38 @@ int trace_pid_list_first(struct trace_pid_list *pid_list, unsigned int *pid)
 struct trace_pid_list *trace_pid_list_alloc(void)
 {
 	struct trace_pid_list *pid_list;
+	int i;
 
-	pid_list = kmalloc(sizeof(*pid_list), GFP_KERNEL);
+	pid_list = kzalloc(sizeof(*pid_list), GFP_KERNEL);
 	if (!pid_list)
 		return NULL;
 
-	pid_list->pid_max = READ_ONCE(pid_max);
+	init_irq_work(&pid_list->refill_irqwork, pid_list_refill_irq);
 
-	pid_list->pids = vzalloc((pid_list->pid_max + 7) >> 3);
-	if (!pid_list->pids) {
-		kfree(pid_list);
-		return NULL;
+	raw_spin_lock_init(&pid_list->lock);
+
+	for (i = 0; i < CHUNK_ALLOC; i++) {
+		union upper_chunk *chunk;
+
+		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		if (!chunk)
+			break;
+		chunk->next = pid_list->upper_list;
+		pid_list->upper_list = chunk;
+		pid_list->free_upper_chunks++;
+	}
+
+	for (i = 0; i < CHUNK_ALLOC; i++) {
+		union lower_chunk *chunk;
+
+		chunk = kzalloc(sizeof(*chunk), GFP_KERNEL);
+		if (!chunk)
+			break;
+		chunk->next = pid_list->lower_list;
+		pid_list->lower_list = chunk;
+		pid_list->free_lower_chunks++;
 	}
+
 	return pid_list;
 }
 
@@ -157,9 +512,40 @@ struct trace_pid_list *trace_pid_list_alloc(void)
  */
 void trace_pid_list_free(struct trace_pid_list *pid_list)
 {
+	union upper_chunk *upper;
+	union lower_chunk *lower;
+	int i, j;
+
 	if (!pid_list)
 		return;
 
-	vfree(pid_list->pids);
+	irq_work_sync(&pid_list->refill_irqwork);
+
+	while (pid_list->lower_list) {
+		union lower_chunk *chunk;
+
+		chunk = pid_list->lower_list;
+		pid_list->lower_list = pid_list->lower_list->next;
+		kfree(chunk);
+	}
+
+	while (pid_list->upper_list) {
+		union upper_chunk *chunk;
+
+		chunk = pid_list->upper_list;
+		pid_list->upper_list = pid_list->upper_list->next;
+		kfree(chunk);
+	}
+
+	for (i = 0; i < UPPER1_SIZE; i++) {
+		upper = pid_list->upper[i];
+		if (upper) {
+			for (j = 0; j < UPPER2_SIZE; j++) {
+				lower = upper->data[j];
+				kfree(lower);
+			}
+			kfree(upper);
+		}
+	}
 	kfree(pid_list);
 }
-- 
2.32.0
