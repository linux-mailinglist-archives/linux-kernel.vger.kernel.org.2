Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838E3409A43
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbhIMRDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:03:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50534 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbhIMRDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:03:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8E3221D1A;
        Mon, 13 Sep 2021 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631552512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b9fYgzV2F3E6jybacf+q6QUjSxdILkNO2qAvK0C1GYA=;
        b=oRTkbEsa7OAwDMuob1yjPZrzvOk/g/qXprR83dA5cq9mFcYbbPYjwVBS3qHPU/FxIE3xNK
        WeWqVhOfq7Aas95AAfJesUnRAy6wBakpx1JcLOxq5Rqetmue2FRYY1e5eUQs3Dvhu9ffvb
        vOsWqHB3YT3CwX0kr66wXUITqXxnnC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631552512;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=b9fYgzV2F3E6jybacf+q6QUjSxdILkNO2qAvK0C1GYA=;
        b=XmRg1pROFaG73QYKnIeHl6oB2ocGJS2KeLnrDlXz3WxwsO8MPttUjtxiS39/E1FRoLyth7
        uYw1Ln94zJCwmiBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFDEA13AAB;
        Mon, 13 Sep 2021 17:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HgUqLgCEP2FaPAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 13 Sep 2021 17:01:52 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [RFC PATCH] mm, slub: change percpu partial accounting from objects to pages
Date:   Mon, 13 Sep 2021 19:01:48 +0200
Message-Id: <20210913170148.10992-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12138; h=from:subject; bh=2Uo9g0q4F74quuKCkX0qcsMIortUYQKwxxBTciHJkSY=; b=owEBbQGS/pANAwAIAeAhynPxiakQAcsmYgBhP4P5j1Fjc4+IeC/x3GcKgxm+00Une/4aCvqfDdEw u4SmFeaJATMEAAEIAB0WIQSNS5MBqTXjGL5IXszgIcpz8YmpEAUCYT+D+QAKCRDgIcpz8YmpEHroCA CJmdJ1c7ZMMuAKITwI+QXKu3QqMaDKfMbTCTBrpMgTZ2v+6OPfNky9XeJSxq/AhZjL7R/mbhMcjRdu mBRG/f2hRc0cnn0RckHQ0WfJ33LhPmg5y4Nvk+aHeSY6SjrFXofYrE8J6ONFeuqqW0IvwzE7El7gjp Q5OUy7Yc4ZUZI2ymeIHVizcn8aTWPCq4JFQeEY6WuHoGqnfMu9m6P4fZ1Fuixqy3uqeCUW+SWmW1R2 6FPskwKkTAAZFAkO4DU7edzWkKUpc995DL54IXPtFgwktU6+a66hhR8LULthZ8CRdkTekDepiYM6H5 xax5onRXtYZpdWJrrlGH+fsQ1jH78c
X-Developer-Key: i=vbabka@suse.cz; a=openpgp; fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_SLUB_CPU_PARTIAL enabled, SLUB keeps a percpu list of partial
slabs that can be promoted to cpu slab when the previous one is depleted,
without accessing the shared partial list. A slab can be added to this list
by 1) refill of an empty list from get_partial_node() - once we really have to
access the shared partial list, we acquire multiple slabs to amortize the cost
of locking, and 2) first free to a previously full slab - instead of putting
the slab on a shared partial list, we can more cheaply freeze it and put it on
the per-cpu list.

To control how large a percpu partial list can grow for a kmem cache,
set_cpu_partial() calculates a target number of free objects on each cpu's
percpu partial list, and this can be also set by the sysfs file cpu_partial.

However, the tracking of actual number of objects is imprecise, in order to
limit overhead from cpu X freeing an objects to a slab on percpu partial
list of cpu Y. Basically, the percpu partial slabs form a single linked list,
and when we add a new slab to the list with current head "oldpage", we set in
the struct page of the slab we're adding:

page->pages = oldpage->pages + 1; // this is precise
page->pobjects = oldpage->pobjects + (page->objects - page->inuse);
page->next = oldpage;

Thus the real number of free objects in the slab (objects - inuse) is only
determined at the moment of adding the slab to the percpu partial list, and
further freeing doesn't update the pobjects counter nor propagate it to the
current list head. As Jann reports [1], this can easily lead to large
inaccuracies, where the target number of objects (up to 30 by default) can
translate to the same number of (empty) slab pages on the list. In case 2)
above, we put a slab with 1 free object on the list, thus only increase
page->pobjects by 1, even if there are subsequent frees on the same slab. Jann
has noticed this in practice and so did we [2] when investigating significant
increase of kmemcg usage after switching from SLAB to SLUB.

While this is no longer a problem in kmemcg context thanks to the accounting
rewrite in 5.9, the memory waste is still not ideal and it's questionable
whether it makes sense to perform free object count based control when object
counts can easily become so much inaccurate. So this patch converts the
accounting to be based on number of pages only (which is precise) and removes
the page->pobjects field completely. This is also ultimately simpler.

To retain the existing set_cpu_partial() heuristic, first calculate the target
number of objects as previously, but then convert it to target number of pages
by assuming the pages will be half-filled on average. This assumption might
obviously also be inaccurate in practice, but cannot degrade to actual number of
pages being equal to the target number of objects.

We could also skip the intermediate step with target number of objects and
rewrite the heuristic in terms of pages. However we still have the sysfs file
cpu_partial which uses number of objects and could break existing users if it
suddenly becomes number of pages, so this patch doesn't do that.

In practice, after this patch the heuristics limit the size of percpu partial
list up to 2 pages. In case of a reported regression (which would mean some
workload has benefited from the previous imprecise object based counting), we
can tune the heuristics to get a better compromise within the new scheme, while
still avoid the unexpectedly long percpu partial lists.

[1] https://lore.kernel.org/linux-mm/CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com/
[2] https://lore.kernel.org/all/2f0f46e8-2535-410a-1859-e9cfa4e57c18@suse.cz/

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm_types.h |  2 -
 include/linux/slub_def.h | 13 +-----
 mm/slub.c                | 89 ++++++++++++++++++++++++++--------------
 3 files changed, 61 insertions(+), 43 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7f8ee09c711f..68ffa064b7a8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -124,10 +124,8 @@ struct page {
 					struct page *next;
 #ifdef CONFIG_64BIT
 					int pages;	/* Nr of pages left */
-					int pobjects;	/* Approximate count */
 #else
 					short int pages;
-					short int pobjects;
 #endif
 				};
 			};
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 85499f0586b0..0fa751b946fa 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -99,6 +99,8 @@ struct kmem_cache {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	/* Number of per cpu partial objects to keep around */
 	unsigned int cpu_partial;
+	/* Number of per cpu partial pages to keep around */
+	unsigned int cpu_partial_pages;
 #endif
 	struct kmem_cache_order_objects oo;
 
@@ -141,17 +143,6 @@ struct kmem_cache {
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
 
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-#define slub_cpu_partial(s)		((s)->cpu_partial)
-#define slub_set_cpu_partial(s, n)		\
-({						\
-	slub_cpu_partial(s) = (n);		\
-})
-#else
-#define slub_cpu_partial(s)		(0)
-#define slub_set_cpu_partial(s, n)
-#endif /* CONFIG_SLUB_CPU_PARTIAL */
-
 #ifdef CONFIG_SYSFS
 #define SLAB_SUPPORTS_SYSFS
 void sysfs_slab_unlink(struct kmem_cache *);
diff --git a/mm/slub.c b/mm/slub.c
index 3d2025f7163b..3757f31c5d97 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -414,6 +414,29 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 	return x.x & OO_MASK;
 }
 
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
+{
+	unsigned int nr_pages;
+
+	s->cpu_partial = nr_objects;
+
+	/*
+	 * We take the number of objects but actually limit the number of
+	 * pages on the per cpu partial list, in order to limit excessive
+	 * growth of the list. For simplicity we assume that the pages will
+	 * be half-full.
+	 */
+	nr_pages = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
+	s->cpu_partial_pages = nr_pages;
+}
+#else
+static inline void
+slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
+{
+}
+#endif /* CONFIG_SLUB_CPU_PARTIAL */
+
 /*
  * Per slab locking using the pagelock
  */
@@ -2045,7 +2068,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
  */
 static inline void *acquire_slab(struct kmem_cache *s,
 		struct kmem_cache_node *n, struct page *page,
-		int mode, int *objects)
+		int mode)
 {
 	void *freelist;
 	unsigned long counters;
@@ -2061,7 +2084,6 @@ static inline void *acquire_slab(struct kmem_cache *s,
 	freelist = page->freelist;
 	counters = page->counters;
 	new.counters = counters;
-	*objects = new.objects - new.inuse;
 	if (mode) {
 		new.inuse = page->objects;
 		new.freelist = NULL;
@@ -2099,9 +2121,8 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 {
 	struct page *page, *page2;
 	void *object = NULL;
-	unsigned int available = 0;
 	unsigned long flags;
-	int objects;
+	unsigned int partial_pages = 0;
 
 	/*
 	 * Racy check. If we mistakenly see no partial slabs then we
@@ -2119,11 +2140,10 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		if (!pfmemalloc_match(page, gfpflags))
 			continue;
 
-		t = acquire_slab(s, n, page, object == NULL, &objects);
+		t = acquire_slab(s, n, page, object == NULL);
 		if (!t)
 			break;
 
-		available += objects;
 		if (!object) {
 			*ret_page = page;
 			stat(s, ALLOC_FROM_PARTIAL);
@@ -2131,10 +2151,15 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 		} else {
 			put_cpu_partial(s, page, 0);
 			stat(s, CPU_PARTIAL_NODE);
+			partial_pages++;
 		}
+#ifdef CONFIG_SLUB_CPU_PARTIAL
 		if (!kmem_cache_has_cpu_partial(s)
-			|| available > slub_cpu_partial(s) / 2)
+			|| partial_pages > s->cpu_partial_pages / 2)
 			break;
+#else
+		break;
+#endif
 
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
@@ -2539,14 +2564,13 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 	struct page *page_to_unfreeze = NULL;
 	unsigned long flags;
 	int pages = 0;
-	int pobjects = 0;
 
 	local_lock_irqsave(&s->cpu_slab->lock, flags);
 
 	oldpage = this_cpu_read(s->cpu_slab->partial);
 
 	if (oldpage) {
-		if (drain && oldpage->pobjects > slub_cpu_partial(s)) {
+		if (drain && oldpage->pages >= s->cpu_partial_pages) {
 			/*
 			 * Partial array is full. Move the existing set to the
 			 * per node partial list. Postpone the actual unfreezing
@@ -2555,16 +2579,13 @@ static void put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 			page_to_unfreeze = oldpage;
 			oldpage = NULL;
 		} else {
-			pobjects = oldpage->pobjects;
 			pages = oldpage->pages;
 		}
 	}
 
 	pages++;
-	pobjects += page->objects - page->inuse;
 
 	page->pages = pages;
-	page->pobjects = pobjects;
 	page->next = oldpage;
 
 	this_cpu_write(s->cpu_slab->partial, page);
@@ -3980,6 +4001,8 @@ static void set_min_partial(struct kmem_cache *s, unsigned long min)
 static void set_cpu_partial(struct kmem_cache *s)
 {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
+	unsigned int nr_objects;
+
 	/*
 	 * cpu_partial determined the maximum number of objects kept in the
 	 * per cpu partial lists of a processor.
@@ -3989,24 +4012,22 @@ static void set_cpu_partial(struct kmem_cache *s)
 	 * filled up again with minimal effort. The slab will never hit the
 	 * per node partial lists and therefore no locking will be required.
 	 *
-	 * This setting also determines
-	 *
-	 * A) The number of objects from per cpu partial slabs dumped to the
-	 *    per node list when we reach the limit.
-	 * B) The number of objects in cpu partial slabs to extract from the
-	 *    per node list when we run out of per cpu objects. We only fetch
-	 *    50% to keep some capacity around for frees.
+	 * For backwards compatibility reasons, this is determined as number
+	 * of objects, even though we now limit maximum number of pages, see
+	 * slub_set_cpu_partial()
 	 */
 	if (!kmem_cache_has_cpu_partial(s))
-		slub_set_cpu_partial(s, 0);
+		nr_objects = 0;
 	else if (s->size >= PAGE_SIZE)
-		slub_set_cpu_partial(s, 2);
+		nr_objects = 2;
 	else if (s->size >= 1024)
-		slub_set_cpu_partial(s, 6);
+		nr_objects = 6;
 	else if (s->size >= 256)
-		slub_set_cpu_partial(s, 13);
+		nr_objects = 13;
 	else
-		slub_set_cpu_partial(s, 30);
+		nr_objects = 30;
+
+	slub_set_cpu_partial(s, nr_objects);
 #endif
 }
 
@@ -5379,7 +5400,12 @@ SLAB_ATTR(min_partial);
 
 static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
 {
-	return sysfs_emit(buf, "%u\n", slub_cpu_partial(s));
+	unsigned int nr_partial = 0;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+	nr_partial = s->cpu_partial;
+#endif
+
+	return sysfs_emit(buf, "%u\n", nr_partial);
 }
 
 static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
@@ -5450,12 +5476,12 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 
 		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
 
-		if (page) {
+		if (page)
 			pages += page->pages;
-			objects += page->pobjects;
-		}
 	}
 
+	/* Approximate half-full pages , see slub_set_cpu_partial() */
+	objects = (pages * oo_objects(s->oo)) / 2;
 	len += sysfs_emit_at(buf, len, "%d(%d)", objects, pages);
 
 #ifdef CONFIG_SMP
@@ -5463,9 +5489,12 @@ static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 		struct page *page;
 
 		page = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
-		if (page)
+		if (page) {
+			pages = READ_ONCE(page->pages);
+			objects = (pages * oo_objects(s->oo)) / 2;
 			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
-					     cpu, page->pobjects, page->pages);
+					     cpu, objects, pages);
+		}
 	}
 #endif
 	len += sysfs_emit_at(buf, len, "\n");
-- 
2.33.0

