Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF1D42002D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 07:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhJCFT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 01:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhJCFT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 01:19:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335B0C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 22:18:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so6075779pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 22:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaQFK+C0ugQeHsV85vh22ixj+aSyMMmoj1XnFMUylG4=;
        b=Fe+e8ZpMe79TU7YCQxxk+i1pwkw3TRTEkC4bgkiMd1sD8y4pDoglNZG/JN04x25GTR
         y75Szbe7adWF6mUhyAtl7tvKNz9gwnvwIfc/AIGwtPTd0vX/YEIQCC2qb7b2v7Hl0W0r
         aJhcqDXThhh3ow0QG478oPg0zF3heSHWwJMXho6b0RHwGKcAjE3wkSgigkw0QZR6gVzT
         4EJjBQ5luUeAYONuFZKSn/3DcgkBaSOJl7YAe7tCXIOkneUjvEaR4UkpfVDTBkOOsrtH
         mhzIfL93N5aQxT/dv1IkJdpFOy5fBRoAR1RNsHPNOZBOm0q6neKi6f8J8oFz2F5uaiP3
         l4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DaQFK+C0ugQeHsV85vh22ixj+aSyMMmoj1XnFMUylG4=;
        b=ts6VHjs4XeyT6oUsvzooqiXJhtsRs/XkRFkZZg+K7Vs1rBCC6dgrob6b+pemoiwgEl
         klytcl7EXUptPtDmOIrzUkGjB29hAkVrUlbzG8NO/H73dP7PGkVvvpPTs761ahY4p2bi
         RRLO7oDcp9cAwp4cbVEj7lQ9F3IhbC2Z7YXqHiFdWhjYyH6B38I6HVxPSltDbu9xKpis
         00hDyf7bxDNHr0cX2hPoae0tKaoFlJtAVeG53/uh2vLJiMBaD34vnSBqm/NIOV+vAtiy
         DDMWJyLvwfy5tq9UuhKHFCWvfbV8OoISWemzMR4VIWmQhTiHhRVjqkFgdTIJjiWb2Rxl
         pa6g==
X-Gm-Message-State: AOAM532m8H7J83ur5XQNUIZ8oneFSfPrcYs7nk9Tsy6g0VQTW7+WyBTY
        LWBn5dGxXN7p7uLrYEQBT+8=
X-Google-Smtp-Source: ABdhPJyzH82EA1bDMd3jmfKE64JQZluou80VUIbc8H/uYeg120GIZ2nNaVVszEXDxEJhQw0htHoyLg==
X-Received: by 2002:a17:902:8549:b0:13e:85eb:3967 with SMTP id d9-20020a170902854900b0013e85eb3967mr11062197plo.80.1633238288457;
        Sat, 02 Oct 2021 22:18:08 -0700 (PDT)
Received: from linux.asia-northeast3-a.c.our-ratio-313919.internal (252.229.64.34.bc.googleusercontent.com. [34.64.229.252])
        by smtp.gmail.com with ESMTPSA id p24sm514438pjz.32.2021.10.02.22.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 22:18:08 -0700 (PDT)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [RFC PATCH] mm, slab: Reduce space complexity of alien_cache using rbtree
Date:   Sun,  3 Oct 2021 05:17:50 +0000
Message-Id: <20211003051750.8296-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For each NUMA node, there are alien caches for every other nodes.
So alien cache has space complexity of MAX_NUMNODES ^ 2. This makes
SLAB not scalable on systems with high number of NUMA nodes.

As remote node allocation isn't that frequent and better avoided,
this patch tries to compromise some execution time for memory usage.

This patch introduces red-black tree for alien cache. Tree nodes are
allocated at cache creation and the pool of tree nodes is same size with
cache's limit.

Each tree node has a unique 64-bit key. By setting upper 32 bits
to NUMA node id tree nodes are sorted by NUMA nodes, which help
reducing lock contention. Lower 32 bits are object id to make a
unique key in the tree.

Remove init_reap_node, next_reap_node and related variables
introduced by commit 8fce4d8e3b9e ("[PATCH] slab: Node rotor for freeing
alien caches and remote per cpu pages."), Because it has only one tree
for all remote nodes.

After this patch remote free is done in logarithmic time
and flushing entire tree is done in linear time.

Below is before and after of total SLAB memory usage after boot.
Tested on qemu on 240 cpus with 120 nodes

Before:
    Active / Total Objects (% used)    : 3849018 / 3929389 (98.0%)
    Active / Total Slabs (% used)      : 155725 / 156193 (99.7%)
    Active / Total Caches (% used)     : 97 / 238 (40.8%)
    Active / Total Size (% used)       : 618610.09K / 631822.98K (97.9%)
    Minimum / Average / Maximum Object : 0.03K / 0.16K / 4096.00K

After:
    Active / Total Objects (% used)    : 752322 / 836825 (89.9%)
    Active / Total Slabs (% used)      : 471614 / 834398 (90.1
    Active / Total Caches (% used)     : 92 16 / 486787%)
    Active / Total Size (% used)       : 184632.55K / 202255.74K (91.3%)
    Minimum / Average / Maximum Object : 0.0469.02.24K / 025.960K

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slab.c | 301 +++++++++++++++++++++++++++++++++---------------------
 mm/slab.h |   2 +-
 2 files changed, 185 insertions(+), 118 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 01775fe0e002..eb3f0f88cc6e 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -194,9 +194,41 @@ struct array_cache {
 			 */
 };
 
+/*
+ * Freeing object allocated from another node is batched
+ * to reduce lock contention.
+ *
+ * alien_object keeps information what node it was allocated from
+ * and composes of alien_cache's red-black tree
+ */
+
+struct alien_object {
+	/*
+	 * each alien object has unique key for its red-black tree.
+	 *
+	 * node_id is NUMA node id and is upper 32 bit of key so that
+	 * elements are always sorted by node id.
+	 *
+	 * object_id is lower 32 bit of key for uniqueness.
+	 */
+	u32 node_id;
+	u32 object_id;
+
+	struct rb_node node;
+	void *objp;
+};
+
+#define make_key(node_id, object_id) ((((u64)node_id) << 32) + object_id)
+#define object_id(key) ((u32)((key) & U32_MAX))
+#define node_id(key) ((u32)((key) >> 32))
+
 struct alien_cache {
 	spinlock_t lock;
-	struct array_cache ac;
+	struct rb_root root;
+
+	unsigned int size;
+	unsigned int capacity;
+	struct alien_object **pool;
 };
 
 /*
@@ -473,34 +505,6 @@ static int __init slab_max_order_setup(char *str)
 }
 __setup("slab_max_order=", slab_max_order_setup);
 
-#ifdef CONFIG_NUMA
-/*
- * Special reaping functions for NUMA systems called from cache_reap().
- * These take care of doing round robin flushing of alien caches (containing
- * objects freed on different nodes from which they were allocated) and the
- * flushing of remote pcps by calling drain_node_pages.
- */
-static DEFINE_PER_CPU(unsigned long, slab_reap_node);
-
-static void init_reap_node(int cpu)
-{
-	per_cpu(slab_reap_node, cpu) = next_node_in(cpu_to_mem(cpu),
-						    node_online_map);
-}
-
-static void next_reap_node(void)
-{
-	int node = __this_cpu_read(slab_reap_node);
-
-	node = next_node_in(node, node_online_map);
-	__this_cpu_write(slab_reap_node, node);
-}
-
-#else
-#define init_reap_node(cpu) do { } while (0)
-#define next_reap_node(void) do { } while (0)
-#endif
-
 /*
  * Initiate the reap timer running on the target CPU.  We run at around 1 to 2Hz
  * via the workqueue/eventd.
@@ -513,7 +517,6 @@ static void start_cpu_timer(int cpu)
 	struct delayed_work *reap_work = &per_cpu(slab_reap_work, cpu);
 
 	if (reap_work->work.func == NULL) {
-		init_reap_node(cpu);
 		INIT_DEFERRABLE_WORK(reap_work, cache_reap);
 		schedule_delayed_work_on(cpu, reap_work,
 					__round_jiffies_relative(HZ, cpu));
@@ -604,13 +607,13 @@ static __always_inline void __free_one(struct array_cache *ac, void *objp)
 #define drain_alien_cache(cachep, alien) do { } while (0)
 #define reap_alien(cachep, n) do { } while (0)
 
-static inline struct alien_cache **alloc_alien_cache(int node,
+static inline struct alien_cache *alloc_alien_cache(int node,
 						int limit, gfp_t gfp)
 {
 	return NULL;
 }
 
-static inline void free_alien_cache(struct alien_cache **ac_ptr)
+static inline void free_alien_cache(struct alien_cache *alc_ptr)
 {
 }
 
@@ -641,76 +644,100 @@ static inline gfp_t gfp_exact_node(gfp_t flags)
 static void *____cache_alloc_node(struct kmem_cache *, gfp_t, int);
 static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
 
-static struct alien_cache *__alloc_alien_cache(int node, int entries,
-						int batch, gfp_t gfp)
+static struct alien_cache *alloc_alien_cache(int node, int limit, gfp_t gfp)
 {
-	size_t memsize = sizeof(void *) * entries + sizeof(struct alien_cache);
-	struct alien_cache *alc = NULL;
-
-	alc = kmalloc_node(memsize, gfp, node);
-	if (alc) {
-		kmemleak_no_scan(alc);
-		init_arraycache(&alc->ac, entries, batch);
-		spin_lock_init(&alc->lock);
-	}
-	return alc;
-}
-
-static struct alien_cache **alloc_alien_cache(int node, int limit, gfp_t gfp)
-{
-	struct alien_cache **alc_ptr;
+	struct alien_cache *alc_ptr;
 	int i;
 
 	if (limit > 1)
 		limit = 12;
-	alc_ptr = kcalloc_node(nr_node_ids, sizeof(void *), gfp, node);
+	alc_ptr = kmalloc_node(sizeof(struct alien_cache), gfp, node);
 	if (!alc_ptr)
 		return NULL;
 
-	for_each_node(i) {
-		if (i == node || !node_online(i))
-			continue;
-		alc_ptr[i] = __alloc_alien_cache(node, limit, 0xbaadf00d, gfp);
-		if (!alc_ptr[i]) {
-			for (i--; i >= 0; i--)
-				kfree(alc_ptr[i]);
+	alc_ptr->pool = kmalloc_array_node(limit,
+			sizeof(void *), gfp, node);
+	if (!alc_ptr->pool) {
+		kfree(alc_ptr);
+		return NULL;
+	}
+
+	spin_lock_init(&alc_ptr->lock);
+	alc_ptr->root = RB_ROOT;
+	alc_ptr->capacity = limit;
+	alc_ptr->size = 0;
+
+	for (i = 0; i < alc_ptr->capacity; i++) {
+		alc_ptr->pool[i] = kmalloc_node(sizeof(struct alien_object), gfp, node);
+		if (!alc_ptr->pool) {
+			for (i = i - 1; i >= 0; i--)
+				kfree(alc_ptr->pool[i]);
+			kfree(alc_ptr->pool);
 			kfree(alc_ptr);
 			return NULL;
 		}
 	}
+
 	return alc_ptr;
 }
 
-static void free_alien_cache(struct alien_cache **alc_ptr)
+static void free_alien_cache(struct alien_cache *alc_ptr)
 {
 	int i;
 
 	if (!alc_ptr)
 		return;
-	for_each_node(i)
-	    kfree(alc_ptr[i]);
+
+	for (i = 0; i < alc_ptr->capacity; i++)
+		kfree(alc_ptr->pool[i]);
+
+	kfree(alc_ptr->pool);
 	kfree(alc_ptr);
 }
 
-static void __drain_alien_cache(struct kmem_cache *cachep,
-				struct array_cache *ac, int node,
-				struct list_head *list)
+/* Caller must handle alien_cache's lock */
+static void __drain_alien_cache(struct kmem_cache *cachep, struct alien_cache *alc,
+					struct list_head *list)
 {
-	struct kmem_cache_node *n = get_node(cachep, node);
+	struct kmem_cache_node *alien_node;
+	struct rb_node *curr;
+	struct alien_object *obj;
+	struct array_cache *shared;
+
+	if (alc->size) {
 
-	if (ac->avail) {
-		spin_lock(&n->list_lock);
 		/*
-		 * Stuff objects into the remote nodes shared array first.
-		 * That way we could avoid the overhead of putting the objects
-		 * into the free lists and getting them back later.
+		 * Free all objects allocated from remote node.
+		 * lock contention is reduced as it's sorted by node.
+		 *
+		 * By freeing all of nodes at once, freeing is done in linear time.
 		 */
-		if (n->shared)
-			transfer_objects(n->shared, ac, ac->limit);
-
-		free_block(cachep, ac->entry, ac->avail, node, list);
-		ac->avail = 0;
-		spin_unlock(&n->list_lock);
+		curr = rb_first(&alc->root);
+		while (curr) {
+			obj = rb_entry(curr, struct alien_object, node);
+			alien_node = get_node(cachep, obj->node_id);
+
+			spin_lock(&alien_node->list_lock);
+			shared = alien_node->shared;
+
+			do {
+				obj = rb_entry(curr, struct alien_object, node);
+				/*
+				 * Stuff objects into the remote nodes shared array first.
+				 * That way we could avoid the overhead of putting the objects
+				 * into the free lists and getting them back later.
+				 */
+				if (shared && shared->avail < shared->limit)
+					shared->entry[shared->avail++] = obj->objp;
+				else
+					free_block(cachep, &obj->objp, 1, obj->node_id, list);
+				alc->pool[--alc->size] = obj;
+				curr = rb_next(curr);
+			} while (curr && rb_entry(curr, struct alien_object, node)->node_id
+					== obj->node_id);
+			spin_unlock(&alien_node->list_lock);
+		}
+		alc->root = RB_ROOT;
 	}
 }
 
@@ -719,70 +746,111 @@ static void __drain_alien_cache(struct kmem_cache *cachep,
  */
 static void reap_alien(struct kmem_cache *cachep, struct kmem_cache_node *n)
 {
-	int node = __this_cpu_read(slab_reap_node);
-
 	if (n->alien) {
-		struct alien_cache *alc = n->alien[node];
-		struct array_cache *ac;
+		struct alien_cache *alc = n->alien;
 
-		if (alc) {
-			ac = &alc->ac;
-			if (ac->avail && spin_trylock_irq(&alc->lock)) {
-				LIST_HEAD(list);
+		if (alc && alc->size && spin_trylock_irq(&alc->lock)) {
+			LIST_HEAD(list);
 
-				__drain_alien_cache(cachep, ac, node, &list);
-				spin_unlock_irq(&alc->lock);
-				slabs_destroy(cachep, &list);
-			}
+			__drain_alien_cache(cachep, alc, &list);
+			spin_unlock_irq(&alc->lock);
+			slabs_destroy(cachep, &list);
 		}
 	}
 }
 
 static void drain_alien_cache(struct kmem_cache *cachep,
-				struct alien_cache **alien)
+				struct alien_cache *alc)
 {
-	int i = 0;
-	struct alien_cache *alc;
-	struct array_cache *ac;
 	unsigned long flags;
+	LIST_HEAD(list);
 
-	for_each_online_node(i) {
-		alc = alien[i];
-		if (alc) {
-			LIST_HEAD(list);
+	spin_lock_irqsave(&alc->lock, flags);
+	__drain_alien_cache(cachep, alc, &list);
+	spin_unlock_irqrestore(&alc->lock, flags);
+	slabs_destroy(cachep, &list);
+}
 
-			ac = &alc->ac;
-			spin_lock_irqsave(&alc->lock, flags);
-			__drain_alien_cache(cachep, ac, i, &list);
-			spin_unlock_irqrestore(&alc->lock, flags);
-			slabs_destroy(cachep, &list);
-		}
+/*
+ * next_object_id
+ * get next object id of given alien cache's red-black tree.
+ */
+static inline u32 next_object_id(struct alien_cache *alc, int node)
+{
+	struct alien_object *obj;
+	struct rb_node **p = &alc->root.rb_node;
+	u64 key = make_key(node, 0);
+	u64 end = make_key(node + 1, 0);
+	u64 next;
+
+	if (!*p) /* the tree is empty now */
+		return 1;
+
+	/* find biggest element of same numa node */
+	while (*p) {
+		obj = rb_entry(*p, struct alien_object, node);
+
+		if (key < make_key(obj->node_id, obj->object_id)) {
+			if (make_key(obj->node_id, obj->object_id) < end) {
+				next = make_key(obj->node_id, obj->object_id);
+				p = &(*p)->rb_right;
+			} else
+				p = &(*p)->rb_left;
+		} else
+			p = &(*p)->rb_right;
 	}
+
+	if (node_id(next) == node)
+		return object_id(next) + 1;
+
+	return 1;
 }
 
 static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
 				int node, int page_node)
 {
-	struct kmem_cache_node *n;
-	struct alien_cache *alien = NULL;
-	struct array_cache *ac;
+	struct kmem_cache_node *n = get_node(cachep, node);
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	struct alien_cache *alc = n->alien;
+	struct alien_object *new_obj;
+	struct alien_object *obj;
+
 	LIST_HEAD(list);
 
-	n = get_node(cachep, node);
 	STATS_INC_NODEFREES(cachep);
-	if (n->alien && n->alien[page_node]) {
-		alien = n->alien[page_node];
-		ac = &alien->ac;
-		spin_lock(&alien->lock);
-		if (unlikely(ac->avail == ac->limit)) {
+
+	if (alc) {
+		spin_lock(&alc->lock);
+		if (unlikely(alc->size == alc->capacity)) {
 			STATS_INC_ACOVERFLOW(cachep);
-			__drain_alien_cache(cachep, ac, page_node, &list);
+			__drain_alien_cache(cachep, alc, &list);
+		}
+
+		p = &alc->root.rb_node;
+		new_obj = alc->pool[alc->size++];
+
+		new_obj->node_id = page_node;
+		new_obj->object_id = next_object_id(alc, page_node);
+		new_obj->objp = objp;
+
+		while (*p) {
+			parent = *p;
+			obj = rb_entry(parent, struct alien_object, node);
+
+			if (make_key(new_obj->node_id, new_obj->object_id)
+					< make_key(obj->node_id, obj->object_id))
+				p = &(*p)->rb_left;
+			else
+				p = &(*p)->rb_right;
 		}
-		__free_one(ac, objp);
-		spin_unlock(&alien->lock);
+
+		rb_link_node(&new_obj->node, parent, p);
+		rb_insert_color(&new_obj->node, &alc->root);
+
+		spin_unlock(&alc->lock);
 		slabs_destroy(cachep, &list);
 	} else {
-		n = get_node(cachep, page_node);
 		spin_lock(&n->list_lock);
 		free_block(cachep, &objp, 1, page_node, &list);
 		spin_unlock(&n->list_lock);
@@ -887,7 +955,7 @@ static int setup_kmem_cache_node(struct kmem_cache *cachep,
 	struct kmem_cache_node *n;
 	struct array_cache *old_shared = NULL;
 	struct array_cache *new_shared = NULL;
-	struct alien_cache **new_alien = NULL;
+	struct alien_cache *new_alien = NULL;
 	LIST_HEAD(list);
 
 	if (use_alien_caches) {
@@ -958,7 +1026,7 @@ static void cpuup_canceled(long cpu)
 	list_for_each_entry(cachep, &slab_caches, list) {
 		struct array_cache *nc;
 		struct array_cache *shared;
-		struct alien_cache **alien;
+		struct alien_cache *alien;
 		LIST_HEAD(list);
 
 		n = get_node(cachep, node);
@@ -4040,7 +4108,6 @@ static void cache_reap(struct work_struct *w)
 	}
 	check_irq_on();
 	mutex_unlock(&slab_mutex);
-	next_reap_node();
 out:
 	/* Set up the next iteration */
 	schedule_delayed_work_on(smp_processor_id(), work,
diff --git a/mm/slab.h b/mm/slab.h
index 58c01a34e5b8..d1c46ae12e19 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -543,7 +543,7 @@ struct kmem_cache_node {
 	unsigned int free_limit;
 	unsigned int colour_next;	/* Per-node cache coloring */
 	struct array_cache *shared;	/* shared per node */
-	struct alien_cache **alien;	/* on other nodes */
+	struct alien_cache *alien;	/* on other nodes */
 	unsigned long next_reap;	/* updated without locking */
 	int free_touched;		/* updated without locking */
 #endif
-- 
2.27.0

