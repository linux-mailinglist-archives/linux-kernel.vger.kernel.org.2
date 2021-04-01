Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548D351E77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240993AbhDASmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237252AbhDASTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:19:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7EBC08EC26
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Ck1Vt+LWP+f5xJMw5Ahyi0L+icz3Kd45ldv2t8Pax4c=; b=XhiZynRdIaaddUFdhQw0lSGudo
        RpACE9tyw5x+i8jwD9x+nc0Mh+Icd3Vx6SQid7yy7yvrqotxN8KAmZzSy6wwtahTtsjigUFihMdfe
        kTCwFCOC+QhqOh+EzAvTjSWJVXxIlvmCM4sWBqNij9nMR3rqZNjj7V6jhY5JsPbBYBMPi1PgkFDXO
        lmIIFjxDbUaEkbKT5mVuuA8oN24F272j+lMa+Iexfqc/88b9e727l84jcdxG6Vbaehs/xqEXMx9RD
        1cDgtGM1H+inqJt75JimcH9j3bsux4w+z6fFgHJ/6Gd8RrdF2ombtZNU6VfuVTh7h31rXyiACgw3u
        o3ZoX3qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxaq-006Bob-4Y; Thu, 01 Apr 2021 13:42:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5085C3077D7;
        Thu,  1 Apr 2021 15:42:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id EB55624C1A53F; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.590280797@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 9/9] sched: prctl() and cgroup interaction
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the nasty bits that manage prctl() and cgroup core-sched
interaction.

In order to manage this; a 'fat' cookie is introduced, this is
basically a nested cookie that links to two other cookies. Any unique
combination of task and cgroup cookies will get _one_ fat cookie.

Uniqueness of fat cookies is ensured by use of a global tree.

Due to the locking rules for cookies, the need for fat cookies is not
apparent up-front, nor can they be allocated in-situ, therefore
pre-allocate them agressively and mostly free them instantly when not
used.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h     |    1 
 kernel/sched/core.c       |   25 +++
 kernel/sched/core_sched.c |  329 ++++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h      |   11 +
 4 files changed, 337 insertions(+), 29 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -704,6 +704,7 @@ struct task_struct {
 #ifdef CONFIG_SCHED_CORE
 	struct rb_node			core_node;
 	unsigned long			core_cookie;
+	void				*core_spare_fat;
 	unsigned int			core_occupation;
 #endif
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9487,7 +9487,7 @@ void sched_move_task(struct task_struct
 	task_rq_unlock(rq, tsk, &rf);
 
 	cookie = sched_core_cgroup_cookie(tsk->sched_task_group);
-	cookie = sched_core_update_cookie(tsk, cookie);
+	cookie = sched_core_update_cookie(tsk, cookie | GROUP_COOKIE);
 	sched_core_put_cookie(cookie);
 }
 
@@ -9592,6 +9592,10 @@ static int cpu_cgroup_can_attach(struct
 
 		if (ret)
 			break;
+
+		ret = sched_core_prealloc_fat(task);
+		if (ret)
+			break;
 	}
 	return ret;
 }
@@ -10122,13 +10126,28 @@ int cpu_sched_core_write_u64(struct cgro
 
 	old_cookie = tg->core_cookie;
 	if (val) {
-		cookie = sched_core_alloc_cookie();
+		cookie = sched_core_alloc_cookie(GROUP_COOKIE);
 		if (!cookie) {
 			ret = -ENOMEM;
 			goto unlock;
 		}
 		WARN_ON_ONCE(old_cookie);
 
+		css_for_each_descendant_pre(cssi, css) {
+			struct css_task_iter it;
+			struct task_struct *p;
+
+			css_task_iter_start(cssi, 0, &it);
+			while ((p = css_task_iter_next(&it))) {
+				ret = sched_core_prealloc_fat(p);
+				if (ret) {
+					css_task_iter_end(&it);
+					goto unlock;
+				}
+			}
+			css_task_iter_end(&it);
+		}
+
 	} else if (tg->parent) {
 		if (tg->parent->core_parent)
 			parent = tg->parent->core_parent;
@@ -10164,7 +10183,7 @@ int cpu_sched_core_write_u64(struct cgro
 			unsigned long p_cookie;
 
 			cookie = sched_core_get_cookie(cookie);
-			p_cookie = sched_core_update_cookie(p, cookie);
+			p_cookie = sched_core_update_cookie(p, cookie | GROUP_COOKIE);
 			sched_core_put_cookie(p_cookie);
 		}
 		css_task_iter_end(&it);
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/prctl.h>
+#include <linux/rbtree.h>
+#include <linux/cgroup.h>
 #include "sched.h"
 
 /*
@@ -8,26 +10,243 @@
  * address is used to compute the cookie of the task.
  */
 struct sched_core_cookie {
-	refcount_t refcnt;
+	refcount_t	refcnt;
+	unsigned int	type;
 };
 
-unsigned long sched_core_alloc_cookie(void)
+static inline void *cookie_ptr(unsigned long cookie)
+{
+	return (void *)(cookie & ~3UL);
+}
+
+static inline int cookie_type(unsigned long cookie)
+{
+	return cookie & 3;
+}
+
+static inline void sched_core_init_cookie(struct sched_core_cookie *ck, unsigned int type)
+{
+	refcount_set(&ck->refcnt, 1);
+	ck->type = type;
+}
+
+#ifdef CONFIG_CGROUP_SCHED
+
+#define FAT_COOKIE	0x03
+
+struct sched_core_fat_cookie {
+	struct sched_core_cookie	cookie;
+	unsigned long			task_cookie;
+	unsigned long			group_cookie;
+	struct rb_node			node;
+};
+
+static DEFINE_RAW_SPINLOCK(fat_lock);
+static struct rb_root fat_root;
+
+static void fat_mutex_lock(void)
+{
+	/*
+	 * { ss->can_attach(), ss->attach() } vs prctl() for p->core_spare_fat
+	 */
+	mutex_lock(&cgroup_mutex);
+}
+
+static void fat_mutex_unlock(void)
+{
+	mutex_unlock(&cgroup_mutex);
+}
+
+static void sched_core_put_fat(struct sched_core_fat_cookie *fat)
+{
+	unsigned long flags;
+
+	if (fat->cookie.type != FAT_COOKIE)
+		return;
+
+	sched_core_put_cookie(fat->task_cookie);
+	sched_core_put_cookie(fat->group_cookie);
+
+	if (!RB_EMPTY_NODE(&fat->node)) {
+		raw_spin_lock_irqsave(&fat_lock, flags);
+		rb_erase(&fat->node, &fat_root);
+		raw_spin_unlock_irqrestore(&fat_lock, flags);
+	}
+}
+
+static void *node_2_fat(struct rb_node *n)
+{
+	return rb_entry(n, struct sched_core_fat_cookie, node);
+}
+
+static int fat_cmp(struct rb_node *a, struct rb_node *b)
+{
+	struct sched_core_fat_cookie *ca = node_2_fat(a);
+	struct sched_core_fat_cookie *cb = node_2_fat(b);
+
+	if (ca->group_cookie < cb->group_cookie)
+		return -1;
+	if (ca->group_cookie > cb->group_cookie)
+		return 1;
+
+	if (ca->task_cookie < cb->task_cookie)
+		return -1;
+	if (ca->task_cookie > cb->task_cookie)
+		return 1;
+
+	if (refcount_inc_not_zero(&cb->cookie.refcnt))
+		return 0;
+
+	return 1;
+}
+
+static unsigned long __sched_core_fat_cookie(struct task_struct *p,
+					     void **spare_fat,
+					     unsigned long cookie)
+{
+	unsigned long task_cookie, group_cookie;
+	unsigned int p_type = cookie_type(p->core_cookie);
+	unsigned int c_type = cookie_type(cookie);
+	struct sched_core_fat_cookie *fat;
+	unsigned long flags;
+	struct rb_node *n;
+
+	if (WARN_ON_ONCE(c_type == FAT_COOKIE))
+		return cookie;
+
+	if (!p_type || p_type == c_type)
+		return cookie;
+
+	if (p_type == FAT_COOKIE) {
+		fat = cookie_ptr(p->core_cookie);
+
+		/* loose fat */
+		if (!cookie_ptr(cookie)) {
+			if (c_type == TASK_COOKIE)
+				cookie = fat->group_cookie;
+			else
+				cookie = fat->task_cookie;
+
+			WARN_ON_ONCE(!cookie_ptr(cookie));
+			return sched_core_get_cookie(cookie);
+		}
+
+		/* other fat */
+		if (c_type == TASK_COOKIE)
+			group_cookie = fat->group_cookie;
+		else
+			task_cookie = fat->task_cookie;
+
+	} else {
+
+		/* new fat */
+		if (p_type == TASK_COOKIE)
+			task_cookie = p->core_cookie;
+		else
+			group_cookie = p->core_cookie;
+	}
+
+	if (c_type == TASK_COOKIE)
+		task_cookie = cookie;
+	else
+		group_cookie = cookie;
+
+	fat = *spare_fat;
+	if (WARN_ON_ONCE(!fat))
+		return cookie;
+
+	sched_core_init_cookie(&fat->cookie, FAT_COOKIE);
+	fat->task_cookie = sched_core_get_cookie(task_cookie);
+	fat->group_cookie = sched_core_get_cookie(group_cookie);
+	RB_CLEAR_NODE(&fat->node);
+
+	raw_spin_lock_irqsave(&fat_lock, flags);
+	n = rb_find_add(&fat->node, &fat_root, fat_cmp);
+	raw_spin_unlock_irqrestore(&fat_lock, flags);
+
+	if (n) {
+		sched_core_put_fat(fat);
+		fat = node_2_fat(n);
+	} else {
+		*spare_fat = NULL;
+	}
+
+	return (unsigned long)fat | FAT_COOKIE;
+}
+
+static int __sched_core_alloc_fat(void **spare_fat)
+{
+	if (*spare_fat)
+		return 0;
+
+	*spare_fat = kmalloc(sizeof(struct sched_core_fat_cookie), GFP_KERNEL);
+	if (!*spare_fat)
+		return -ENOMEM;
+
+	return 0;
+}
+
+int sched_core_prealloc_fat(struct task_struct *p)
+{
+	lockdep_assert_held(&cgroup_mutex);
+	return __sched_core_alloc_fat(&p->core_spare_fat);
+}
+
+static inline unsigned long __sched_core_task_cookie(struct task_struct *p)
+{
+	unsigned long cookie = p->core_cookie;
+	unsigned int c_type = cookie_type(cookie);
+
+	if (!(c_type & TASK_COOKIE))
+		return 0;
+
+	if (c_type == FAT_COOKIE)
+		cookie = ((struct sched_core_fat_cookie *)cookie_ptr(cookie))->task_cookie;
+
+	return cookie;
+}
+
+#else
+
+static inline void fat_mutex_lock(void) { }
+static inline void fat_mutex_unlock(void) { }
+
+static inline void sched_core_put_fat(void *ptr) { }
+static inline int __sched_core_alloc_fat(void **spare_fat) { return 0; }
+
+static inline unsigned long __sched_core_fat_cookie(struct task_struct *p,
+						    void **spare_fat,
+						    unsigned long cookie)
+{
+	return cookie;
+}
+
+static inline unsigned long __sched_core_task_cookie(struct task_struct *p)
+{
+	return p->core_cookie;
+}
+
+#endif /* CGROUP_SCHED */
+
+unsigned long sched_core_alloc_cookie(unsigned int type)
 {
 	struct sched_core_cookie *ck = kmalloc(sizeof(*ck), GFP_KERNEL);
 	if (!ck)
 		return 0;
 
-	refcount_set(&ck->refcnt, 1);
+	WARN_ON_ONCE(type > GROUP_COOKIE);
+	sched_core_init_cookie(ck, type);
 	sched_core_get();
 
-	return (unsigned long)ck;
+	return (unsigned long)ck | type;
 }
 
 void sched_core_put_cookie(unsigned long cookie)
 {
-	struct sched_core_cookie *ptr = (void *)cookie;
+	struct sched_core_cookie *ptr = cookie_ptr(cookie);
 
 	if (ptr && refcount_dec_and_test(&ptr->refcnt)) {
+		sched_core_put_fat((void *)ptr);
 		kfree(ptr);
 		sched_core_put();
 	}
@@ -35,7 +254,7 @@ void sched_core_put_cookie(unsigned long
 
 unsigned long sched_core_get_cookie(unsigned long cookie)
 {
-	struct sched_core_cookie *ptr = (void *)cookie;
+	struct sched_core_cookie *ptr = cookie_ptr(cookie);
 
 	if (ptr)
 		refcount_inc(&ptr->refcnt);
@@ -50,14 +269,22 @@ unsigned long sched_core_get_cookie(unsi
  * @cookie: The new cookie.
  * @cookie_type: The cookie field to which the cookie corresponds.
  */
-unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+static unsigned long __sched_core_update_cookie(struct task_struct *p,
+						void **spare_fat,
+						unsigned long cookie)
 {
 	unsigned long old_cookie;
 	struct rq_flags rf;
 	struct rq *rq;
 	bool enqueued;
 
-	rq = task_rq_lock(p, &rf);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
+
+	cookie = __sched_core_fat_cookie(p, spare_fat, cookie);
+	if (!cookie_ptr(cookie))
+		cookie = 0UL;
+
+	rq = __task_rq_lock(p, &rf);
 
 	/*
 	 * Since creating a cookie implies sched_core_get(), and we cannot set
@@ -90,9 +317,19 @@ unsigned long sched_core_update_cookie(s
 	return old_cookie;
 }
 
+unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie)
+{
+	cookie =  __sched_core_update_cookie(p, &p->core_spare_fat, cookie);
+	if (p->core_spare_fat) {
+		kfree(p->core_spare_fat);
+		p->core_spare_fat = NULL;
+	}
+	return cookie;
+}
+
 static unsigned long sched_core_clone_cookie(struct task_struct *p)
 {
-	unsigned long cookie, flags;
+	unsigned long flags, cookie;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	cookie = sched_core_get_cookie(p->core_cookie);
@@ -101,26 +338,47 @@ static unsigned long sched_core_clone_co
 	return cookie;
 }
 
+static unsigned long sched_core_clone_task_cookie(struct task_struct *p)
+{
+	unsigned long flags, cookie;
+
+	raw_spin_lock_irqsave(&p->pi_lock, flags);
+	cookie = sched_core_get_cookie(__sched_core_task_cookie(p));
+	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+
+	return cookie;
+}
+
 void sched_core_fork(struct task_struct *p)
 {
 	RB_CLEAR_NODE(&p->core_node);
 	p->core_cookie = sched_core_clone_cookie(current);
+	p->core_spare_fat = NULL;
 }
 
 void sched_core_free(struct task_struct *p)
 {
 	sched_core_put_cookie(p->core_cookie);
+	kfree(p->core_spare_fat);
 }
 
 int sched_core_exec(void)
 {
 	/* absent a policy mech, if task had a cookie, give it a new one */
-	if (current->core_cookie) {
-		unsigned long cookie = sched_core_alloc_cookie();
+	if (current->core_cookie & TASK_COOKIE) {
+		void *spare_fat = NULL;
+		unsigned long cookie;
+
+		if (__sched_core_alloc_fat(&spare_fat))
+			return -ENOMEM;
+
+		cookie = sched_core_alloc_cookie(TASK_COOKIE);
 		if (!cookie)
 			return -ENOMEM;
-		cookie = sched_core_update_cookie(current, cookie);
+
+		cookie = __sched_core_update_cookie(current, &spare_fat, cookie);
 		sched_core_put_cookie(cookie);
+		kfree(spare_fat);
 	}
 
 	return 0;
@@ -129,7 +387,7 @@ int sched_core_exec(void)
 static void __sched_core_set(struct task_struct *p, unsigned long cookie)
 {
 	cookie = sched_core_get_cookie(cookie);
-	cookie = sched_core_update_cookie(p, cookie);
+	cookie = sched_core_update_cookie(p, cookie | TASK_COOKIE);
 	sched_core_put_cookie(cookie);
 }
 
@@ -171,55 +429,62 @@ int sched_core_share_pid(unsigned int cm
 		goto out;
 	}
 
+	fat_mutex_lock();
+
+	err = sched_core_prealloc_fat(task);
+	if (err)
+		goto out_unlock;
+
 	switch (cmd) {
 	case PR_SCHED_CORE_GET:
 		if (type != PIDTYPE_PID || uaddr & 7) {
 			err = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
-		cookie = sched_core_clone_cookie(task);
-		if (cookie) {
+		cookie = sched_core_clone_task_cookie(task);
+		if (cookie_ptr(cookie)) {
 			/* XXX improve ? */
 			ptr_to_hashval((void *)cookie, &id);
 		}
 		err = put_user(id, (u64 __user *)uaddr);
-		goto out;
+		goto out_unlock;
 
 	case PR_SCHED_CORE_CLEAR:
 		cookie = 0;
 		break;
 
 	case PR_SCHED_CORE_CREATE:
-		cookie = sched_core_alloc_cookie();
+		cookie = sched_core_alloc_cookie(TASK_COOKIE);
 		if (!cookie) {
 			err = -ENOMEM;
-			goto out;
+			goto out_unlock;
 		}
 		break;
 
 	case PR_SCHED_CORE_SHARE_TO:
-		cookie = sched_core_clone_cookie(current);
+		cookie = sched_core_clone_task_cookie(current);
 		break;
 
 	case PR_SCHED_CORE_SHARE_FROM:
 		if (type != PIDTYPE_PID) {
 			err = -EINVAL;
-			goto out;
+			goto out_unlock;
 		}
-		cookie = sched_core_clone_cookie(task);
+		cookie = sched_core_clone_task_cookie(task);
 		__sched_core_set(current, cookie);
-		goto out;
+		goto out_unlock;
 
 	default:
 		err = -EINVAL;
-		goto out;
+		goto out_unlock;
 	};
 
 	if (type == PIDTYPE_PID) {
 		__sched_core_set(task, cookie);
-		goto out;
+		goto out_unlock;
 	}
 
+again:
 	read_lock(&tasklist_lock);
 	grp = task_pid_type(task, type);
 
@@ -228,6 +493,18 @@ int sched_core_share_pid(unsigned int cm
 			err = -EPERM;
 			goto out_tasklist;
 		}
+
+		if (IS_ENABLED(CONFIG_CGROUP_SCHED) && !p->core_spare_fat) {
+			get_task_struct(p);
+			read_unlock(&tasklist_lock);
+
+			err = sched_core_prealloc_fat(p);
+			put_task_struct(p);
+			if (err)
+				goto out_unlock;
+
+			goto again;
+		}
 	} while_each_pid_thread(grp, type, p);
 
 	do_each_pid_thread(grp, type, p) {
@@ -236,6 +513,8 @@ int sched_core_share_pid(unsigned int cm
 out_tasklist:
 	read_unlock(&tasklist_lock);
 
+out_unlock:
+	fat_mutex_unlock();
 out:
 	sched_core_put_cookie(cookie);
 	put_task_struct(task);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1240,10 +1240,14 @@ extern void sched_core_dequeue(struct rq
 extern void sched_core_get(void);
 extern void sched_core_put(void);
 
-extern unsigned long sched_core_alloc_cookie(void);
+#define TASK_COOKIE	0x01
+#define GROUP_COOKIE	0x02
+
+extern unsigned long sched_core_alloc_cookie(unsigned int type);
 extern void sched_core_put_cookie(unsigned long cookie);
 extern unsigned long sched_core_get_cookie(unsigned long cookie);
 extern unsigned long sched_core_update_cookie(struct task_struct *p, unsigned long cookie);
+extern int sched_core_prealloc_fat(struct task_struct *p);
 
 #else /* !CONFIG_SCHED_CORE */
 
@@ -1257,6 +1261,11 @@ static inline bool sched_core_disabled(v
 	return true;
 }
 
+static inline int sched_core_prealloc_fat(struct task_struct *p)
+{
+	return 0;
+}
+
 static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;


