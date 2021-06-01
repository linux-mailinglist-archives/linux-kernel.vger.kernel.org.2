Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4B43970F3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhFAKKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:10:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:21659 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhFAKKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:10:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622542102; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J/oeeSIFTZ6FnCyG1cebEeK4i9jqm24uVRLtQWeIvf8=; b=dwSZTeda/lS0pV2oCZfleyqV6lysyCFNXXLbAiRadlpYlYYaNfbhFdPV/X+WMO/G8xJ+XWyz
 DYI2ArfhcqeMO/iZ0RidaokvsWoo+7vLOakW1bO3/zKl02nOUjffhwoanvvgLq7Cvfrlzz9U
 jYj+ykGAFTVxObgUTXyVIqnuEM8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60b606f8e27c0cc77f84dbf0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 01 Jun 2021 10:07:52
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E533C43460; Tue,  1 Jun 2021 10:07:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFF30C433D3;
        Tue,  1 Jun 2021 10:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFF30C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, greg@kroah.com,
        glittao@gmail.com
Cc:     vinmenon@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH v8] mm: slub: move sysfs slab alloc/free interfaces to debugfs
Date:   Tue,  1 Jun 2021 15:37:37 +0530
Message-Id: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_calls and free_calls implementation in sysfs have two issues,
one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
to "one value per file" rule.

To overcome this issues, move the alloc_calls and free_calls implemeation
to debugfs.

Debugfs cache will be created if SLAB_STORE_USER flag is set.

Rename the alloc_calls/free_calls to alloc_traces/free_traces,
to be inline with what it does.

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
changes in v8:
	- Debugfs cache file will not be created if SLAB_STORE_USER flag is not set.
	- Make sure the debugfs slab release happen before slab kmem cahce release.
	
changes in V7:
	- https://lore.kernel.org/linux-mm/1621928285-751-1-git-send-email-faiyazm@codeaurora.org/

changes in v6:
	- https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/

changes in v5:
	- https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/

changes in v4:
	- https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/

changes in v3:
	- https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/

changes in v2:
	- https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/

changes in v1
	- https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/

 include/linux/slab_def.h |   2 +
 include/linux/slub_def.h |   8 ++
 mm/slab_common.c         |   3 +
 mm/slub.c                | 306 +++++++++++++++++++++++++++++++++--------------
 4 files changed, 226 insertions(+), 93 deletions(-)

diff --git a/include/linux/slab_def.h b/include/linux/slab_def.h
index 3aa5e1e..02ca311 100644
--- a/include/linux/slab_def.h
+++ b/include/linux/slab_def.h
@@ -120,4 +120,6 @@ static inline int objs_per_slab_page(const struct kmem_cache *cache,
 	return cache->num;
 }
 
+static inline void debugfs_slab_release(struct kmem_cache *s) { }
+
 #endif	/* _LINUX_SLAB_DEF_H */
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index dcde82a..90d659a 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -159,6 +159,14 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
 }
 #endif
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
+void debugfs_slab_release(struct kmem_cache *);
+#else
+static inline void debugfs_slab_release(struct kmem_cache *s)
+{
+}
+#endif
+
 void object_err(struct kmem_cache *s, struct page *page,
 		u8 *object, char *reason);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index a4a5714..ca39e84 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -449,6 +449,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 	rcu_barrier();
 
 	list_for_each_entry_safe(s, s2, &to_destroy, list) {
+		debugfs_slab_release(s);
 		kfence_shutdown_cache(s);
 #ifdef SLAB_SUPPORTS_SYSFS
 		sysfs_slab_release(s);
@@ -469,6 +470,7 @@ static int shutdown_cache(struct kmem_cache *s)
 	list_del(&s->list);
 
 	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
+		debugfs_slab_release(s);
 #ifdef SLAB_SUPPORTS_SYSFS
 		sysfs_slab_unlink(s);
 #endif
@@ -476,6 +478,7 @@ static int shutdown_cache(struct kmem_cache *s)
 		schedule_work(&slab_caches_to_rcu_destroy_work);
 	} else {
 		kfence_shutdown_cache(s);
+		debugfs_slab_release(s);
 #ifdef SLAB_SUPPORTS_SYSFS
 		sysfs_slab_unlink(s);
 		sysfs_slab_release(s);
diff --git a/mm/slub.c b/mm/slub.c
index 3f96e09..f7735c1 100644
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
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
+static void debugfs_slab_add(struct kmem_cache *);
+#else
+static inline void debugfs_slab_add(struct kmem_cache *s) { }
+#endif
+
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
 {
 #ifdef CONFIG_SLUB_STATS
@@ -4546,6 +4553,9 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	if (err)
 		__kmem_cache_release(s);
 
+	if (s->flags & SLAB_STORE_USER)
+		debugfs_slab_add(s);
+
 	return err;
 }
 
@@ -4686,6 +4696,8 @@ static long validate_slab_cache(struct kmem_cache *s)
 
 	return count;
 }
+
+#ifdef CONFIG_DEBUG_FS
 /*
  * Generate lists of code addresses where slabcache objects are allocated
  * and freed.
@@ -4709,6 +4721,9 @@ struct loc_track {
 	struct location *loc;
 };
 
+static struct dentry *slab_debugfs_root;
+struct loc_track t = { 0, 0, NULL };
+
 static void free_loc_track(struct loc_track *t)
 {
 	if (t->max)
@@ -4825,82 +4840,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
 			add_location(t, s, get_track(s, p, alloc));
 	put_map(map);
 }
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
+#endif  /* CONFIG_DEBUG_FS   */
 #endif	/* CONFIG_SLUB_DEBUG */
 
 #ifdef SLUB_RESILIENCY_TEST
@@ -5350,21 +5290,6 @@ static ssize_t validate_store(struct kmem_cache *s,
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
@@ -5528,8 +5453,6 @@ static struct attribute *slab_attrs[] = {
 	&poison_attr.attr,
 	&store_user_attr.attr,
 	&validate_attr.attr,
-	&alloc_calls_attr.attr,
-	&free_calls_attr.attr,
 #endif
 #ifdef CONFIG_ZONE_DMA
 	&cache_dma_attr.attr,
@@ -5818,6 +5741,203 @@ static int __init slab_sysfs_init(void)
 __initcall(slab_sysfs_init);
 #endif /* CONFIG_SYSFS */
 
+#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
+static int slab_debugfs_show(struct seq_file *seq, void *v)
+{
+
+	struct location *l;
+	unsigned int idx = *(unsigned int *)v;
+
+	if (idx < t.count) {
+		l = &t.loc[idx];
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
+				 cpumask_pr_args(to_cpumask(l->cpus)));
+
+		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
+			seq_printf(seq, " nodes=%*pbl",
+				 nodemask_pr_args(&l->nodes));
+
+		seq_puts(seq, "\n");
+	}
+
+	if (t.count == 0)
+		seq_puts(seq, "No data\n");
+
+	return 0;
+}
+
+static void slab_debugfs_stop(struct seq_file *seq, void *v)
+{
+	if (!v && t.max) {
+		free_loc_track(&t);
+		t.max = 0;
+	}
+}
+
+static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
+{
+	loff_t *spos = v;
+
+	if (*ppos < t.count) {
+		*spos = *spos + 1;
+		*ppos = *spos;
+		return spos;
+	}
+
+	return NULL;
+}
+
+static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
+{
+	struct kmem_cache_node *n;
+	struct kmem_cache *s;
+	enum track_item alloc;
+	int node;
+	loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
+
+	s = seq->file->f_inode->i_private;
+
+	if (!spos)
+		return NULL;
+
+	if (*ppos == 0) {
+
+		t.count = 0;
+		t.max = 0;
+		t.loc = NULL;
+		if (strcmp(seq->file->f_path.dentry->d_name.name, "alloc_traces") == 0)
+			alloc =  TRACK_ALLOC;
+		else
+			alloc =  TRACK_FREE;
+
+		if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
+			     GFP_KERNEL)) {
+			seq_puts(seq, "Out of memory\n");
+			kfree(spos);
+			return ERR_PTR(-ENOMEM);
+		}
+		/* Push back cpu slabs */
+		flush_all(s);
+
+		for_each_kmem_cache_node(s, node, n) {
+			unsigned long flags;
+			struct page *page;
+
+			if (!atomic_long_read(&n->nr_slabs))
+				continue;
+
+			spin_lock_irqsave(&n->list_lock, flags);
+			list_for_each_entry(page, &n->partial, slab_list)
+				process_slab(&t, s, page, alloc);
+			list_for_each_entry(page, &n->full, slab_list)
+				process_slab(&t, s, page, alloc);
+			spin_unlock_irqrestore(&n->list_lock, flags);
+		}
+	}
+
+	if (*ppos < t.count) {
+		*spos = *ppos;
+		return spos;
+	}
+
+	kfree(spos);
+	return NULL;
+}
+
+static const struct seq_operations slab_debugfs_sops = {
+	.start  = slab_debugfs_start,
+	.next   = slab_debugfs_next,
+	.stop   = slab_debugfs_stop,
+	.show   = slab_debugfs_show
+};
+DEFINE_SEQ_ATTRIBUTE(slab_debugfs);
+
+static void debugfs_slab_add(struct kmem_cache *s)
+{
+	const char *name;
+	struct dentry *slab_cache_dir;
+	int unmergeable = slab_unmergeable(s);
+
+	if (unlikely(!slab_debugfs_root))
+		return;
+
+	if (!unmergeable && disable_higher_order_debug &&
+			(slub_debug & DEBUG_METADATA_FLAGS))
+		unmergeable = 1;
+
+	if (unmergeable) {
+		/*
+		 * Slabcache can never be merged so we can use the name proper.
+		 * This is typically the case for debug situations. In that
+		 * case we can catch duplicate names easily.
+		 */
+		slab_cache_dir = debugfs_lookup(s->name, slab_debugfs_root);
+		debugfs_remove_recursive(slab_cache_dir);
+		name = s->name;
+	} else {
+		/*
+		 * Create a unique name for the slab as a target
+		 * for the symlinks.
+		 */
+		name = create_unique_id(s);
+	}
+
+	slab_cache_dir = debugfs_create_dir(name, slab_debugfs_root);
+
+	debugfs_create_file("alloc_traces", 0400,
+		slab_cache_dir, s, &slab_debugfs_fops);
+
+	debugfs_create_file("free_traces", 0400,
+		slab_cache_dir, s, &slab_debugfs_fops);
+}
+
+void debugfs_slab_release(struct kmem_cache *s)
+{
+	debugfs_remove_recursive(debugfs_lookup(s->name,
+					slab_debugfs_root));
+}
+
+static int __init slab_debugfs_init(void)
+{
+	struct kmem_cache *s;
+
+	slab_debugfs_root = debugfs_create_dir("slab", NULL);
+
+	list_for_each_entry(s, &slab_caches, list)
+		if (s->flags & SLAB_STORE_USER)
+			debugfs_slab_add(s);
+
+	return 0;
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

