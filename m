Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0250357BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbhDHFYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhDHFYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:24:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F5FC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 22:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mV9+VvLdUIRw1Snl9/obQu2+Xv6DCsYwlWAVEBnHork=; b=GDhrnVq9zK+eMPIYf3a1Vk4gFb
        81AAMLbUew2ohttbLycI0YuySviwa2P4AvpXsPTL9DqEWyMHOhnqunMprL4gLP4xm1ReKi2h/00Nx
        YS8uTzvDSVSTNaY0x0Tjn6AtcX9idWsP6WLa408XB93F3Aaz8XviZJc7V9UOawzaH7vONETVWav3P
        oeba+HHdPgtiWHu03yz5JEMq52WBTyV3NnGaj87R3FkQcxjpDomqHSt/ALusTogIg9kagIeGl16GQ
        ydE9P7/JkK7xU53NZRZzuI33ePEGAGb/IFKOQ8pbDfGrKZc/oIKnlvEbEjLpVDlSoeToS5K0IHd3z
        nTRIertA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lUN8q-00FcgR-Tt; Thu, 08 Apr 2021 05:23:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [RFC PATCH] Add split_lock
Date:   Thu,  8 Apr 2021 06:23:38 +0100
Message-Id: <20210408052338.3722069-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bit_spinlocks are horrible on RT because there's absolutely nowhere
to put the mutex to sleep on.  They also do not participate in lockdep
because there's nowhere to put the map.

Most (all?) bit spinlocks are actually a split lock; logically they
could be treated as a single spinlock, but for performance, we want to
split the lock over many objects.  Introduce the split_lock as somewhere
to store the lockdep map and as somewhere that the RT kernel can put
a mutex.  It may also let us store a ticket lock for better performance
on non-RT kernels in the future, but I have left the current cpu_relax()
implementation intact for now.

The API change breaks all users except for the two which have been
converted.  This is an RFC, and I'm willing to fix all the rest.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/dcache.c                  | 25 ++++++++++----------
 include/linux/bit_spinlock.h | 36 ++++++++++++++---------------
 include/linux/list_bl.h      |  9 ++++----
 include/linux/split_lock.h   | 45 ++++++++++++++++++++++++++++++++++++
 mm/slub.c                    |  6 +++--
 5 files changed, 84 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/split_lock.h

diff --git a/fs/dcache.c b/fs/dcache.c
index 7d24ff7eb206..a3861d330001 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -96,6 +96,7 @@ EXPORT_SYMBOL(slash_name);
 
 static unsigned int d_hash_shift __read_mostly;
 
+static DEFINE_SPLIT_LOCK(d_hash_lock);
 static struct hlist_bl_head *dentry_hashtable __read_mostly;
 
 static inline struct hlist_bl_head *d_hash(unsigned int hash)
@@ -469,9 +470,9 @@ static void ___d_drop(struct dentry *dentry)
 	else
 		b = d_hash(dentry->d_name.hash);
 
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	__hlist_bl_del(&dentry->d_hash);
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 }
 
 void __d_drop(struct dentry *dentry)
@@ -2074,9 +2075,9 @@ static struct dentry *__d_instantiate_anon(struct dentry *dentry,
 	__d_set_inode_and_type(dentry, inode, add_flags);
 	hlist_add_head(&dentry->d_u.d_alias, &inode->i_dentry);
 	if (!disconnected) {
-		hlist_bl_lock(&dentry->d_sb->s_roots);
+		hlist_bl_lock(&dentry->d_sb->s_roots, &d_hash_lock);
 		hlist_bl_add_head(&dentry->d_hash, &dentry->d_sb->s_roots);
-		hlist_bl_unlock(&dentry->d_sb->s_roots);
+		hlist_bl_unlock(&dentry->d_sb->s_roots, &d_hash_lock);
 	}
 	spin_unlock(&dentry->d_lock);
 	spin_unlock(&inode->i_lock);
@@ -2513,9 +2514,9 @@ static void __d_rehash(struct dentry *entry)
 {
 	struct hlist_bl_head *b = d_hash(entry->d_name.hash);
 
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	hlist_bl_add_head_rcu(&entry->d_hash, b);
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 }
 
 /**
@@ -2606,9 +2607,9 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 		goto retry;
 	}
 
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	if (unlikely(READ_ONCE(parent->d_inode->i_dir_seq) != seq)) {
-		hlist_bl_unlock(b);
+		hlist_bl_unlock(b, &d_hash_lock);
 		rcu_read_unlock();
 		goto retry;
 	}
@@ -2626,7 +2627,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 			continue;
 		if (!d_same_name(dentry, parent, name))
 			continue;
-		hlist_bl_unlock(b);
+		hlist_bl_unlock(b, &d_hash_lock);
 		/* now we can try to grab a reference */
 		if (!lockref_get_not_dead(&dentry->d_lockref)) {
 			rcu_read_unlock();
@@ -2664,7 +2665,7 @@ struct dentry *d_alloc_parallel(struct dentry *parent,
 	new->d_flags |= DCACHE_PAR_LOOKUP;
 	new->d_wait = wq;
 	hlist_bl_add_head_rcu(&new->d_u.d_in_lookup_hash, b);
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 	return new;
 mismatch:
 	spin_unlock(&dentry->d_lock);
@@ -2677,12 +2678,12 @@ void __d_lookup_done(struct dentry *dentry)
 {
 	struct hlist_bl_head *b = in_lookup_hash(dentry->d_parent,
 						 dentry->d_name.hash);
-	hlist_bl_lock(b);
+	hlist_bl_lock(b, &d_hash_lock);
 	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
 	__hlist_bl_del(&dentry->d_u.d_in_lookup_hash);
 	wake_up_all(dentry->d_wait);
 	dentry->d_wait = NULL;
-	hlist_bl_unlock(b);
+	hlist_bl_unlock(b, &d_hash_lock);
 	INIT_HLIST_NODE(&dentry->d_u.d_alias);
 	INIT_LIST_HEAD(&dentry->d_lru);
 }
diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505..641623d471b0 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_BIT_SPINLOCK_H
 #define __LINUX_BIT_SPINLOCK_H
 
+#include <linux/split_lock.h>
 #include <linux/kernel.h>
 #include <linux/preempt.h>
 #include <linux/atomic.h>
@@ -13,32 +14,23 @@
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
  */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+static inline void bit_spin_lock(int bitnum, unsigned long *addr,
+		struct split_lock *lock)
 {
-	/*
-	 * Assuming the lock is uncontended, this never enters
-	 * the body of the outer loop. If it is contended, then
-	 * within the inner loop a non-atomic test is used to
-	 * busywait with less bus contention for a good time to
-	 * attempt to acquire the lock bit.
-	 */
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
-	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
-		preempt_enable();
-		do {
-			cpu_relax();
-		} while (test_bit(bitnum, addr));
-		preempt_disable();
-	}
+	while (unlikely(test_and_set_bit_lock(bitnum, addr)))
+		split_lock_spin(lock, bitnum, addr);
 #endif
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	__acquire(bitlock);
 }
 
 /*
  * Return true if it was acquired
  */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+static inline int bit_spin_trylock(int bitnum, unsigned long *addr,
+		struct split_lock *lock)
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
@@ -47,6 +39,7 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 		return 0;
 	}
 #endif
+	spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 	__acquire(bitlock);
 	return 1;
 }
@@ -54,13 +47,16 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 /*
  *  bit-based spin_unlock()
  */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+static inline void bit_spin_unlock(int bitnum, unsigned long *addr,
+		struct split_lock *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
 #endif
+	spin_release(&lock->dep_map, _RET_IP_);
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	clear_bit_unlock(bitnum, addr);
+	split_lock_unlock(lock, bitnum, addr);
 #endif
 	preempt_enable();
 	__release(bitlock);
@@ -71,13 +67,16 @@ static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
  *  non-atomic version, which can be used eg. if the bit lock itself is
  *  protecting the rest of the flags in the word.
  */
-static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
+static inline void __bit_spin_unlock(int bitnum, unsigned long *addr,
+		struct split_lock *lock)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
 #endif
+	spin_release(&lock->dep_map, _RET_IP_);
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	__clear_bit_unlock(bitnum, addr);
+	split_lock_unlock(lock, bitnum, addr);
 #endif
 	preempt_enable();
 	__release(bitlock);
@@ -98,4 +97,3 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 }
 
 #endif /* __LINUX_BIT_SPINLOCK_H */
-
diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ae1b541446c9..e6c57c670358 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -143,14 +143,15 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 	}
 }
 
-static inline void hlist_bl_lock(struct hlist_bl_head *b)
+static inline void hlist_bl_lock(struct hlist_bl_head *b, struct split_lock *sl)
 {
-	bit_spin_lock(0, (unsigned long *)b);
+	bit_spin_lock(0, (unsigned long *)b, sl);
 }
 
-static inline void hlist_bl_unlock(struct hlist_bl_head *b)
+static inline void hlist_bl_unlock(struct hlist_bl_head *b,
+		struct split_lock *sl)
 {
-	__bit_spin_unlock(0, (unsigned long *)b);
+	__bit_spin_unlock(0, (unsigned long *)b, sl);
 }
 
 static inline bool hlist_bl_is_locked(struct hlist_bl_head *b)
diff --git a/include/linux/split_lock.h b/include/linux/split_lock.h
new file mode 100644
index 000000000000..d9c7816fb73c
--- /dev/null
+++ b/include/linux/split_lock.h
@@ -0,0 +1,45 @@
+#ifndef _LINUX_SPLIT_LOCK_H
+#define _LINUX_SPLIT_LOCK_H
+
+#include <linux/lockdep_types.h>
+
+struct split_lock {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+};
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define SPLIT_DEP_MAP_INIT(lockname)					\
+	.dep_map = {							\
+		.name = #lockname,					\
+		.wait_type_inner = LD_WAIT_SPIN,			\
+	}
+#else
+#define SPLIT_DEP_MAP_INIT(lockname)
+#endif
+
+#define DEFINE_SPLIT_LOCK(name)						\
+struct split_lock name = {						\
+	SPLIT_DEP_MAP_INIT(name)					\
+};
+
+/*
+ * This is only called if we're contended.  We use a non-atomic test
+ * to reduce contention on the cacheline while we wait.
+ */
+static inline void split_lock_spin(struct split_lock *lock, int bitnum,
+		unsigned long *addr)
+{
+	preempt_enable();
+	do {
+		cpu_relax();
+	} while (test_bit(bitnum, addr));
+	preempt_disable();
+}
+
+static inline void split_lock_unlock(struct split_lock *lock, int bitnum,
+		unsigned long *addr)
+{
+}
+#endif /* _LINUX_SPLIT_LOCK_H */
diff --git a/mm/slub.c b/mm/slub.c
index 9c0e26ddf300..eb7c22fbc8fc 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -346,19 +346,21 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 	return x.x & OO_MASK;
 }
 
+static DEFINE_SPLIT_LOCK(slab_split_lock);
+
 /*
  * Per slab locking using the pagelock
  */
 static __always_inline void slab_lock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	bit_spin_lock(PG_locked, &page->flags);
+	bit_spin_lock(PG_locked, &page->flags, &slab_split_lock);
 }
 
 static __always_inline void slab_unlock(struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
-	__bit_spin_unlock(PG_locked, &page->flags);
+	__bit_spin_unlock(PG_locked, &page->flags, &slab_split_lock);
 }
 
 /* Interrupts must be disabled (for the fallback code to work right) */
-- 
2.30.2

