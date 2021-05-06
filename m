Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1B7375237
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhEFKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:23:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56768 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232085AbhEFKXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:23:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620296571; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4HeYf0SOVpwKNRj2HiaMr+axZWRmAnYkslP2OQu5Y7w=; b=ctMV3CaG4xO89H2+wtspDXBBN3gCqB/T+MLMzVWGhemE2s80e9+LhaZnc7UbFZVWqrVvMeyD
 AGFHgIhYa2AVivtP9TMG/COO0jkVpgrfTGgQL82hmK0Bt73xHBGXGp2l2aJV3L112xkV4c8r
 QnZUBiDYaDGSS6f2k9Ppy5FQVN0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6093c35b55b14811b43337c1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 06 May 2021 10:22:19
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 689E9C433D3; Thu,  6 May 2021 10:22:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from faiyazm-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 93FA9C43460;
        Thu,  6 May 2021 10:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93FA9C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, glittao@gmail.com
Cc:     vinmenon@codeaurora.org, Faiyaz Mohammed <faiyazm@codeaurora.org>
Subject: [PATCH v5] mm: slub: move sysfs slab alloc/free interfaces to debugfs
Date:   Thu,  6 May 2021 15:52:03 +0530
Message-Id: <1620296523-21922-1-git-send-email-faiyazm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_calls and free_calls implementation in sysfs have two issues,
one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
to "one value per file" rule.

To overcome this issues, move the alloc_calls and free_calls implemeation
to debugfs.

Rename the alloc_calls/free_calls to alloc_traces/free_traces,
to be inline with what it does.

Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
---
 include/linux/slub_def.h |  10 ++
 mm/slab_common.c         |   9 ++
 mm/slub.c                | 362 ++++++++++++++++++++++++++++++++++++-----------
 3 files changed, 299 insertions(+), 82 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index dcde82a..f8c268d 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -110,6 +110,9 @@ struct kmem_cache {
 #ifdef CONFIG_SYSFS
 	struct kobject kobj;	/* For sysfs */
 #endif
+#ifdef CONFIG_SLUB_DEBUG
+	struct dentry *slab_cache_dentry;
+#endif
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
 	unsigned long random;
 #endif
@@ -159,6 +162,13 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
 }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+void debugfs_slab_release(struct kmem_cache *);
+#else
+static inline void debugfs_slab_release(struct kmem_cache *s)
+{
+}
+#endif
 void object_err(struct kmem_cache *s, struct page *page,
 		u8 *object, char *reason);
 
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f8833d3..f3afe6b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -445,6 +445,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
 #else
 		slab_kmem_cache_release(s);
 #endif
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB)
+		debugfs_slab_release(s);
+#endif
 	}
 }
 
@@ -462,6 +465,9 @@ static int shutdown_cache(struct kmem_cache *s)
 #ifdef SLAB_SUPPORTS_SYSFS
 		sysfs_slab_unlink(s);
 #endif
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB)
+		debugfs_slab_release(s);
+#endif
 		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
 		schedule_work(&slab_caches_to_rcu_destroy_work);
 	} else {
@@ -472,6 +478,9 @@ static int shutdown_cache(struct kmem_cache *s)
 #else
 		slab_kmem_cache_release(s);
 #endif
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB)
+		debugfs_slab_release(s);
+#endif
 	}
 
 	return 0;
diff --git a/mm/slub.c b/mm/slub.c
index 68123b2..a5347f1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -36,6 +36,7 @@
 #include <linux/memcontrol.h>
 #include <linux/random.h>
 
+#include <linux/debugfs.h>
 #include <trace/events/kmem.h>
 
 #include "internal.h"
@@ -225,6 +226,15 @@ static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
 							{ return 0; }
 #endif
 
+#ifdef CONFIG_DEBUG_FS
+static void debugfs_slab_add(struct kmem_cache *);
+static int debugfs_slab_alias(struct kmem_cache *, const char *);
+#else
+static inline void debugfs_slab_add(struct kmem_cache *s) { }
+static inline int debugfs_slab_alias(struct kmem_cache *s, const char *p)
+							{ return 0; }
+#endif
+
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
 {
 #ifdef CONFIG_SLUB_STATS
@@ -4533,6 +4543,8 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 			s->refcount--;
 			s = NULL;
 		}
+
+		debugfs_slab_alias(s, name);
 	}
 
 	return s;
@@ -4554,6 +4566,8 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	if (err)
 		__kmem_cache_release(s);
 
+	debugfs_slab_add(s);
+
 	return err;
 }
 
@@ -4694,6 +4708,8 @@ static long validate_slab_cache(struct kmem_cache *s)
 
 	return count;
 }
+
+#ifdef CONFIG_DEBUG_FS
 /*
  * Generate lists of code addresses where slabcache objects are allocated
  * and freed.
@@ -4717,6 +4733,9 @@ struct loc_track {
 	struct location *loc;
 };
 
+static struct dentry *slab_debugfs_root;
+struct loc_track t = { 0, 0, NULL };
+
 static void free_loc_track(struct loc_track *t)
 {
 	if (t->max)
@@ -4833,82 +4852,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
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
@@ -5360,17 +5304,25 @@ SLAB_ATTR(validate);
 
 static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
 {
-	if (!(s->flags & SLAB_STORE_USER))
-		return -ENOSYS;
-	return list_locations(s, buf, TRACK_ALLOC);
+	int len = 0;
+
+	len += sprintf(buf + len, "Deprecated, use the equvalent under\n");
+	len += sprintf(buf + len, "/sys/kernel/debug/slab/%s/alloc_traces\n",
+			s->name);
+
+	return len;
 }
 SLAB_ATTR_RO(alloc_calls);
 
 static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
 {
-	if (!(s->flags & SLAB_STORE_USER))
-		return -ENOSYS;
-	return list_locations(s, buf, TRACK_FREE);
+	int len = 0;
+
+	len += sprintf(buf + len, "Deprecated, use the equvalent under\n");
+	len += sprintf(buf + len, "/sys/kernel/debug/slab/%s/free_traces\n",
+			s->name);
+
+	return len;
 }
 SLAB_ATTR_RO(free_calls);
 #endif /* CONFIG_SLUB_DEBUG */
@@ -5826,6 +5778,252 @@ static int __init slab_sysfs_init(void)
 __initcall(slab_sysfs_init);
 #endif /* CONFIG_SYSFS */
 
+#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
+static int debugfs_slab_alias(struct kmem_cache *s, const char *name)
+{
+	struct saved_alias *al;
+
+	if (slab_state == FULL) {
+		/*
+		 * If we have a leftover link then remove it.
+		 */
+		debugfs_remove(s->slab_cache_dentry);
+		s->slab_cache_dentry = debugfs_create_symlink(name, slab_debugfs_root, NULL);
+		return IS_ERR(s->slab_cache_dentry);
+	}
+
+	al = kmalloc(sizeof(struct saved_alias), GFP_KERNEL);
+	if (!al)
+		return -ENOMEM;
+
+	al->s = s;
+	al->name = name;
+	al->next = alias_list;
+	alias_list = al;
+	return 0;
+}
+
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
+	if (!(s->flags & SLAB_STORE_USER))
+		return ERR_PTR(-EOPNOTSUPP);
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
+		debugfs_remove_recursive(s->slab_cache_dentry);
+		name = s->name;
+	} else {
+		/*
+		 * Create a unique name for the slab as a target
+		 * for the symlinks.
+		 */
+		name = create_unique_id(s);
+	}
+
+	s->slab_cache_dentry = debugfs_create_dir(name, slab_debugfs_root);
+	if (!IS_ERR(s->slab_cache_dentry)) {
+		debugfs_create_file("alloc_traces", 0400,
+			s->slab_cache_dentry, s, &slab_debugfs_fops);
+
+		debugfs_create_file("free_traces", 0400,
+			s->slab_cache_dentry, s, &slab_debugfs_fops);
+	}
+
+	if (!unmergeable) {
+		/* Setup first alias */
+		debugfs_slab_alias(s, s->name);
+	}
+}
+
+void debugfs_slab_release(struct kmem_cache *s)
+{
+	if (slab_state >= FULL)
+		debugfs_remove_recursive(s->slab_cache_dentry);
+}
+
+static int __init slab_debugfs_init(void)
+{
+	struct kmem_cache *s;
+	int err;
+
+	slab_debugfs_root = debugfs_create_dir("slab", NULL);
+	if (!IS_ERR(slab_debugfs_root)) {
+
+		slab_state = FULL;
+
+		list_for_each_entry(s, &slab_caches, list)
+			debugfs_slab_add(s);
+	} else {
+		pr_err("Cannot create slab debugfs.\n");
+		return IS_ERR(slab_debugfs_root);
+	}
+
+	while (alias_list) {
+		struct saved_alias *al = alias_list;
+
+		alias_list = alias_list->next;
+
+		err = debugfs_slab_alias(al->s, al->name);
+		if (err)
+			pr_err("SLUB: Unable to add boot slab alias %s to debugfs\n",
+			       al->name);
+		kfree(al);
+	}
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

