Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F8D3553CF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbhDFM0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 08:26:34 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54600 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239328AbhDFM0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 08:26:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617711983; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=qGvFg0vtqKWMNlOyiMyaboiua5Csfjf0wXj4RSrrAec=; b=qkhI/FIqdGvLLb95zHiqJSyB7FheVPmUphMkvsJvlnzV+XFNUHlzu9M5uP00TcSSRsdg0Gzs
 350i+jQc1/UFZgpLEphV3oebRQejCO+CPhiikXdsAV56gsJ3KIgS1VoOD5+PQlP4uKt3E90m
 u20mEiIylgxZN/Cm8poBcMwsxIA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 606c536903cfff34528a9f52 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 06 Apr 2021 12:26:17
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6535CC433C6; Tue,  6 Apr 2021 12:26:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11CD2C433CA;
        Tue,  6 Apr 2021 12:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11CD2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH] mm: slub: move sysfs slab alloc/free interfaces to debugfs
Date:   Tue,  6 Apr 2021 17:55:59 +0530
Message-Id: <1617711959-11146-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_calls and free_calls implementation in sysfs have two issues,
one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
to "one value per file" rule.

To overcome this issues, move the alloc_calls and free_calls implemeation
to debugfs.

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 mm/slub.c | 518 ++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 286 insertions(+), 232 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3021ce9..4d20ee0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -36,6 +36,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 
+#include <linux/debugfs.h>
 #include <trace/events/kmem.h>
 
 #include "internal.h"
@@ -225,6 +226,12 @@ static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
 							{ return 0; }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+static void debugfs_slab_add(struct kmem_cache *);
+#else
+static inline void debugfs_slab_add(struct kmem_cache *) { }
+#endif
+
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
 {
 #ifdef CONFIG_SLUB_STATS
@@ -4542,6 +4549,8 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	if (err)
 		__kmem_cache_release(s);
 
+	debugfs_slab_add(s);
+
 	return err;
 }
 
@@ -4682,221 +4691,6 @@ static long validate_slab_cache(struct kmem_cache *s)
 
 	return count;
 }
-/*
- * Generate lists of code addresses where slabcache objects are allocated
- * and freed.
- */
-
-struct location {
-	unsigned long count;
-	unsigned long addr;
-	long long sum_time;
-	long min_time;
-	long max_time;
-	long min_pid;
-	long max_pid;
-	DECLARE_BITMAP(cpus, NR_CPUS);
-	nodemask_t nodes;
-};
-
-struct loc_track {
-	unsigned long max;
-	unsigned long count;
-	struct location *loc;
-};
-
-static void free_loc_track(struct loc_track *t)
-{
-	if (t->max)
-		free_pages((unsigned long)t->loc,
-			get_order(sizeof(struct location) * t->max));
-}
-
-static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
-{
-	struct location *l;
-	int order;
-
-	order = get_order(sizeof(struct location) * max);
-
-	l = (void *)__get_free_pages(flags, order);
-	if (!l)
-		return 0;
-
-	if (t->count) {
-		memcpy(l, t->loc, sizeof(struct location) * t->count);
-		free_loc_track(t);
-	}
-	t->max = max;
-	t->loc = l;
-	return 1;
-}
-
-static int add_location(struct loc_track *t, struct kmem_cache *s,
-				const struct track *track)
-{
-	long start, end, pos;
-	struct location *l;
-	unsigned long caddr;
-	unsigned long age = jiffies - track->when;
-
-	start = -1;
-	end = t->count;
-
-	for ( ; ; ) {
-		pos = start + (end - start + 1) / 2;
-
-		/*
-		 * There is nothing at "end". If we end up there
-		 * we need to add something to before end.
-		 */
-		if (pos == end)
-			break;
-
-		caddr = t->loc[pos].addr;
-		if (track->addr == caddr) {
-
-			l = &t->loc[pos];
-			l->count++;
-			if (track->when) {
-				l->sum_time += age;
-				if (age < l->min_time)
-					l->min_time = age;
-				if (age > l->max_time)
-					l->max_time = age;
-
-				if (track->pid < l->min_pid)
-					l->min_pid = track->pid;
-				if (track->pid > l->max_pid)
-					l->max_pid = track->pid;
-
-				cpumask_set_cpu(track->cpu,
-						to_cpumask(l->cpus));
-			}
-			node_set(page_to_nid(virt_to_page(track)), l->nodes);
-			return 1;
-		}
-
-		if (track->addr < caddr)
-			end = pos;
-		else
-			start = pos;
-	}
-
-	/*
-	 * Not found. Insert new tracking element.
-	 */
-	if (t->count >= t->max && !alloc_loc_track(t, 2 * t->max, GFP_ATOMIC))
-		return 0;
-
-	l = t->loc + pos;
-	if (pos < t->count)
-		memmove(l + 1, l,
-			(t->count - pos) * sizeof(struct location));
-	t->count++;
-	l->count = 1;
-	l->addr = track->addr;
-	l->sum_time = age;
-	l->min_time = age;
-	l->max_time = age;
-	l->min_pid = track->pid;
-	l->max_pid = track->pid;
-	cpumask_clear(to_cpumask(l->cpus));
-	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
-	nodes_clear(l->nodes);
-	node_set(page_to_nid(virt_to_page(track)), l->nodes);
-	return 1;
-}
-
-static void process_slab(struct loc_track *t, struct kmem_cache *s,
-		struct page *page, enum track_item alloc)
-{
-	void *addr = page_address(page);
-	void *p;
-	unsigned long *map;
-
-	map = get_map(s, page);
-	for_each_object(p, s, addr, page->objects)
-		if (!test_bit(__obj_to_index(s, addr, p), map))
-			add_location(t, s, get_track(s, p, alloc));
-	put_map(map);
-}
-
-static int list_locations(struct kmem_cache *s, char *buf,
-			  enum track_item alloc)
-{
-	int len = 0;
-	unsigned long i;
-	struct loc_track t = { 0, 0, NULL };
-	int node;
-	struct kmem_cache_node *n;
-
-	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
-			     GFP_KERNEL)) {
-		return sysfs_emit(buf, "Out of memory\n");
-	}
-	/* Push back cpu slabs */
-	flush_all(s);
-
-	for_each_kmem_cache_node(s, node, n) {
-		unsigned long flags;
-		struct page *page;
-
-		if (!atomic_long_read(&n->nr_slabs))
-			continue;
-
-		spin_lock_irqsave(&n->list_lock, flags);
-		list_for_each_entry(page, &n->partial, slab_list)
-			process_slab(&t, s, page, alloc);
-		list_for_each_entry(page, &n->full, slab_list)
-			process_slab(&t, s, page, alloc);
-		spin_unlock_irqrestore(&n->list_lock, flags);
-	}
-
-	for (i = 0; i < t.count; i++) {
-		struct location *l = &t.loc[i];
-
-		len += sysfs_emit_at(buf, len, "%7ld ", l->count);
-
-		if (l->addr)
-			len += sysfs_emit_at(buf, len, "%pS", (void *)l->addr);
-		else
-			len += sysfs_emit_at(buf, len, "<not-available>");
-
-		if (l->sum_time != l->min_time)
-			len += sysfs_emit_at(buf, len, " age=%ld/%ld/%ld",
-					     l->min_time,
-					     (long)div_u64(l->sum_time,
-							   l->count),
-					     l->max_time);
-		else
-			len += sysfs_emit_at(buf, len, " age=%ld", l->min_time);
-
-		if (l->min_pid != l->max_pid)
-			len += sysfs_emit_at(buf, len, " pid=%ld-%ld",
-					     l->min_pid, l->max_pid);
-		else
-			len += sysfs_emit_at(buf, len, " pid=%ld",
-					     l->min_pid);
-
-		if (num_online_cpus() > 1 &&
-		    !cpumask_empty(to_cpumask(l->cpus)))
-			len += sysfs_emit_at(buf, len, " cpus=%*pbl",
-					     cpumask_pr_args(to_cpumask(l->cpus)));
-
-		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
-			len += sysfs_emit_at(buf, len, " nodes=%*pbl",
-					     nodemask_pr_args(&l->nodes));
-
-		len += sysfs_emit_at(buf, len, "\n");
-	}
-
-	free_loc_track(&t);
-	if (!t.count)
-		len += sysfs_emit_at(buf, len, "No data\n");
-
-	return len;
-}
 #endif	/* CONFIG_SLUB_DEBUG */
 
 #ifdef SLUB_RESILIENCY_TEST
@@ -5346,21 +5140,6 @@ static ssize_t validate_store(struct kmem_cache *s,
 }
 SLAB_ATTR(validate);
 
-static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
-{
-	if (!(s->flags & SLAB_STORE_USER))
-		return -ENOSYS;
-	return list_locations(s, buf, TRACK_ALLOC);
-}
-SLAB_ATTR_RO(alloc_calls);
-
-static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
-{
-	if (!(s->flags & SLAB_STORE_USER))
-		return -ENOSYS;
-	return list_locations(s, buf, TRACK_FREE);
-}
-SLAB_ATTR_RO(free_calls);
 #endif /* CONFIG_SLUB_DEBUG */
 
 #ifdef CONFIG_FAILSLAB
@@ -5524,8 +5303,6 @@ static struct attribute *slab_attrs[] = {
 	&poison_attr.attr,
 	&store_user_attr.attr,
 	&validate_attr.attr,
-	&alloc_calls_attr.attr,
-	&free_calls_attr.attr,
 #endif
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
@@ -5814,6 +5591,283 @@ static int __init slab_sysfs_init(void)
 __initcall(slab_sysfs_init);
 #endif /* CONFIG_SYSFS */
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
+/*
+ * Generate lists of code addresses where slabcache objects are allocated
+ * and freed.
+ */
+
+struct location {
+	unsigned long count;
+	unsigned long addr;
+	long long sum_time;
+	long min_time;
+	long max_time;
+	long min_pid;
+	long max_pid;
+	DECLARE_BITMAP(cpus, NR_CPUS);
+	nodemask_t nodes;
+};
+
+struct loc_track {
+	unsigned long max;
+	unsigned long count;
+	struct location *loc;
+};
+
+static struct dentry *slab_debugfs_root;
+
+static struct dentry *slab_debugfs_cache;
+
+static void free_loc_track(struct loc_track *t)
+{
+	if (t->max)
+		free_pages((unsigned long)t->loc,
+			get_order(sizeof(struct location) * t->max));
+}
+
+static int alloc_loc_track(struct loc_track *t, unsigned long max, gfp_t flags)
+{
+	struct location *l;
+	int order;
+
+	order = get_order(sizeof(struct location) * max);
+
+	l = (void *)__get_free_pages(flags, order);
+	if (!l)
+		return 0;
+
+	if (t->count) {
+		memcpy(l, t->loc, sizeof(struct location) * t->count);
+		free_loc_track(t);
+	}
+	t->max = max;
+	t->loc = l;
+	return 1;
+}
+
+static int add_location(struct loc_track *t, struct kmem_cache *s,
+				const struct track *track)
+{
+	long start, end, pos;
+	struct location *l;
+	unsigned long caddr;
+	unsigned long age = jiffies - track->when;
+
+	start = -1;
+	end = t->count;
+
+	for ( ; ; ) {
+		pos = start + (end - start + 1) / 2;
+
+		/*
+		 * There is nothing at "end". If we end up there
+		 * we need to add something to before end.
+		 */
+		if (pos == end)
+			break;
+
+		caddr = t->loc[pos].addr;
+		if (track->addr == caddr) {
+
+			l = &t->loc[pos];
+			l->count++;
+			if (track->when) {
+				l->sum_time += age;
+				if (age < l->min_time)
+					l->min_time = age;
+				if (age > l->max_time)
+					l->max_time = age;
+
+				if (track->pid < l->min_pid)
+					l->min_pid = track->pid;
+				if (track->pid > l->max_pid)
+					l->max_pid = track->pid;
+
+				cpumask_set_cpu(track->cpu,
+						to_cpumask(l->cpus));
+			}
+			node_set(page_to_nid(virt_to_page(track)), l->nodes);
+			return 1;
+		}
+
+		if (track->addr < caddr)
+			end = pos;
+		else
+			start = pos;
+	}
+
+	/*
+	 * Not found. Insert new tracking element.
+	 */
+	if (t->count >= t->max && !alloc_loc_track(t, 2 * t->max, GFP_ATOMIC))
+		return 0;
+
+	l = t->loc + pos;
+	if (pos < t->count)
+		memmove(l + 1, l,
+			(t->count - pos) * sizeof(struct location));
+	t->count++;
+	l->count = 1;
+	l->addr = track->addr;
+	l->sum_time = age;
+	l->min_time = age;
+	l->max_time = age;
+	l->min_pid = track->pid;
+	l->max_pid = track->pid;
+	cpumask_clear(to_cpumask(l->cpus));
+	cpumask_set_cpu(track->cpu, to_cpumask(l->cpus));
+	nodes_clear(l->nodes);
+	node_set(page_to_nid(virt_to_page(track)), l->nodes);
+	return 1;
+}
+
+static void process_slab(struct loc_track *t, struct kmem_cache *s,
+		struct page *page, enum track_item alloc)
+{
+	void *addr = page_address(page);
+	void *p;
+	unsigned long *map;
+
+	map = get_map(s, page);
+	for_each_object(p, s, addr, page->objects)
+		if (!test_bit(__obj_to_index(s, addr, p), map))
+			add_location(t, s, get_track(s, p, alloc));
+	put_map(map);
+}
+
+static int list_locations(struct seq_file *seq, struct kmem_cache *s,
+						enum track_item alloc)
+{
+	unsigned long i;
+	struct loc_track t = { 0, 0, NULL };
+	int node;
+	struct kmem_cache_node *n;
+
+	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
+			     GFP_KERNEL)) {
+		seq_puts(seq, "Out of memory\n");
+		return -ENOMEM;
+	}
+	/* Push back cpu slabs */
+	flush_all(s);
+
+	for_each_kmem_cache_node(s, node, n) {
+		unsigned long flags;
+		struct page *page;
+
+		if (!atomic_long_read(&n->nr_slabs))
+			continue;
+
+		spin_lock_irqsave(&n->list_lock, flags);
+		list_for_each_entry(page, &n->partial, slab_list)
+			process_slab(&t, s, page, alloc);
+		list_for_each_entry(page, &n->full, slab_list)
+			process_slab(&t, s, page, alloc);
+		spin_unlock_irqrestore(&n->list_lock, flags);
+	}
+
+	for (i = 0; i < t.count; i++) {
+		struct location *l = &t.loc[i];
+
+		seq_printf(seq, "%7ld ", l->count);
+
+		if (l->addr)
+			seq_printf(seq, "%pS", (void *)l->addr);
+		else
+			seq_puts(seq, "<not-available>");
+
+		if (l->sum_time != l->min_time) {
+			seq_printf(seq, " age=%ld/%ld/%ld",
+				l->min_time,
+				(long)div_u64(l->sum_time, l->count),
+				l->max_time);
+		} else
+			seq_printf(seq, " age=%ld",
+				l->min_time);
+
+		if (l->min_pid != l->max_pid)
+			seq_printf(seq, " pid=%ld-%ld",
+				l->min_pid, l->max_pid);
+		else
+			seq_printf(seq, " pid=%ld",
+				l->min_pid);
+
+		if (num_online_cpus() > 1 &&
+				!cpumask_empty(to_cpumask(l->cpus)))
+			seq_printf(seq, " cpus=%*pbl",
+					 cpumask_pr_args(to_cpumask(l->cpus)));
+
+		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
+			seq_printf(seq, " nodes=%*pbl",
+					 nodemask_pr_args(&l->nodes));
+
+		seq_puts(seq, "\n");
+	}
+
+	free_loc_track(&t);
+	if (!t.count)
+		seq_puts(seq, "No data\n");
+	return 0;
+}
+
+static int slab_debug_trace(struct seq_file *seq, void *ignored)
+{
+	struct kmem_cache *s = seq->private;
+
+	if (!(s->flags & SLAB_STORE_USER))
+		return 0;
+
+	if (strcmp(seq->file->f_path.dentry->d_name.name, "alloc_trace") == 0)
+		return list_locations(seq, s, TRACK_ALLOC);
+	else
+		return list_locations(seq, s, TRACK_FREE);
+
+	return 0;
+}
+
+static int slab_debug_trace_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, slab_debug_trace,
+				file_inode(filp)->i_private);
+}
+
+static const struct file_operations slab_debug_fops = {
+	.open    = slab_debug_trace_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = single_release,
+};
+
+static void debugfs_slab_add(struct kmem_cache *s)
+{
+	if (unlikely(!slab_debugfs_root))
+		return;
+
+	slab_debugfs_cache = debugfs_create_dir(s->name, slab_debugfs_root);
+	if (!IS_ERR(slab_debugfs_cache)) {
+		debugfs_create_file("alloc_trace", 0400,
+			slab_debugfs_cache, s, &slab_debug_fops);
+
+		debugfs_create_file("free_trace", 0400,
+			slab_debugfs_cache, s, &slab_debug_fops);
+	}
+}
+
+static void __init slab_debugfs_init(void)
+{
+	struct kmem_cache *s;
+
+	slab_debugfs_root = debugfs_create_dir("slab", NULL);
+	if (!IS_ERR(slab_debugfs_root))
+		list_for_each_entry(s, &slab_caches, list)
+			debugfs_slab_add(s);
+	else
+		pr_err("Cannot create slab debugfs.\n");
+
+}
+__initcall(slab_debugfs_init);
+#endif
 /*
  * The /proc/slabinfo ABI
  */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

