Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A094F359264
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhDIDCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhDIDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:02:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA89C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p5O+YfzhbSOEW+YNsQ9Wekh4cXltadiHCoSHXULSbic=; b=M8orZNYTqj09D378OLA6YQnUyF
        OR+xi361aCoFkvureKCjnhfhjBjD5CH43YDpy1H0XXEDv7dgdCXPICMAMRVxmZc4Dps1K75P8NRJQ
        pM+bxJw4XQ9ZucR3cQPBVV4LUv104K7uJdhYYNrKEN8CSKelNWOkZkcLF+vVc8N9T9p387M7mT5Kq
        QoDUg4lEvk50uFLp95u9XNbh1Ma76k4zpnm7BYNBc/XnkCb+7RMypaQNQysyMaJjHPtEh7z+MRqbG
        Rafzw6Vi7PkfJmQ4KK0escRINQUAaQ9zYs3MIQoDYMq717R78//+ITYtebVprrKej484WXDrGzCGt
        iQBuCmSA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUhOB-00HH5j-E2; Fri, 09 Apr 2021 03:01:00 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     neilb@suse.de, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] rhashtable: Convert to split_lock
Date:   Fri,  9 Apr 2021 03:51:30 +0100
Message-Id: <20210409025131.4114078-17-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210409025131.4114078-1-willy@infradead.org>
References: <20210409025131.4114078-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NeilBrown noticed the same problem with bit spinlocks that I did,
but chose to solve it locally in the rhashtable implementation rather
than lift it all the way to the bit spin lock implementation.  Convert
rhashtables to use split_locks.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: NeilBrown <neilb@suse.de>
---
 include/linux/rhashtable.h | 20 +++++++-------------
 lib/rhashtable.c           |  5 +----
 2 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/include/linux/rhashtable.h b/include/linux/rhashtable.h
index 68dab3e08aad..4df164fe6222 100644
--- a/include/linux/rhashtable.h
+++ b/include/linux/rhashtable.h
@@ -65,12 +65,11 @@ struct rhash_lock_head {};
  * struct bucket_table - Table of hash buckets
  * @size: Number of hash buckets
  * @nest: Number of bits of first-level nested table.
- * @rehash: Current bucket being rehashed
  * @hash_rnd: Random seed to fold into hash
  * @walkers: List of active walkers
  * @rcu: RCU structure for freeing the table
  * @future_tbl: Table under construction during rehashing
- * @ntbl: Nested table used when out of memory.
+ * @sl: Conceptual spinlock representing every per-bucket lock.
  * @buckets: size * hash buckets
  */
 struct bucket_table {
@@ -82,7 +81,7 @@ struct bucket_table {
 
 	struct bucket_table __rcu *future_tbl;
 
-	struct lockdep_map	dep_map;
+	struct split_lock	sl;
 
 	struct rhash_lock_head __rcu *buckets[] ____cacheline_aligned_in_smp;
 };
@@ -327,8 +326,7 @@ static inline void rht_lock(struct bucket_table *tbl,
 			    struct rhash_lock_head __rcu **bkt)
 {
 	local_bh_disable();
-	bit_spin_lock(0, (unsigned long *)bkt);
-	lock_map_acquire(&tbl->dep_map);
+	bit_spin_lock(0, (unsigned long *)bkt, &tbl->sl);
 }
 
 static inline void rht_lock_nested(struct bucket_table *tbl,
@@ -336,15 +334,13 @@ static inline void rht_lock_nested(struct bucket_table *tbl,
 				   unsigned int subclass)
 {
 	local_bh_disable();
-	bit_spin_lock(0, (unsigned long *)bucket);
-	lock_acquire_exclusive(&tbl->dep_map, subclass, 0, NULL, _THIS_IP_);
+	bit_spin_lock_nested(0, (unsigned long *)bucket, &tbl->sl, subclass);
 }
 
 static inline void rht_unlock(struct bucket_table *tbl,
 			      struct rhash_lock_head __rcu **bkt)
 {
-	lock_map_release(&tbl->dep_map);
-	bit_spin_unlock(0, (unsigned long *)bkt);
+	bit_spin_unlock(0, (unsigned long *)bkt, &tbl->sl);
 	local_bh_enable();
 }
 
@@ -397,10 +393,8 @@ static inline void rht_assign_unlock(struct bucket_table *tbl,
 {
 	if (rht_is_a_nulls(obj))
 		obj = NULL;
-	lock_map_release(&tbl->dep_map);
-	rcu_assign_pointer(*bkt, (void *)obj);
-	preempt_enable();
-	__release(bitlock);
+	bit_spin_unlock_assign((unsigned long *)bkt, (unsigned long)obj,
+				&tbl->sl);
 	local_bh_enable();
 }
 
diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index c949c1e3b87c..bfdb0bf87f99 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -179,7 +179,6 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	struct bucket_table *tbl = NULL;
 	size_t size;
 	int i;
-	static struct lock_class_key __key;
 
 	tbl = kvzalloc(struct_size(tbl, buckets, nbuckets), gfp);
 
@@ -193,10 +192,8 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	if (tbl == NULL)
 		return NULL;
 
-	lockdep_init_map(&tbl->dep_map, "rhashtable_bucket", &__key, 0);
-
+	split_lock_init(&tbl->sl);
 	tbl->size = size;
-
 	rcu_head_init(&tbl->rcu);
 	INIT_LIST_HEAD(&tbl->walkers);
 
-- 
2.30.2

