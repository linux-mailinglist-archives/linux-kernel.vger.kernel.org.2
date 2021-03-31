Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920E0346A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhCWVAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:00:37 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:50124 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233471AbhCWVAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:00:12 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 004BD40C93;
        Tue, 23 Mar 2021 21:00:10 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v9 4/8] Reimplement RLIMIT_NPROC on top of ucounts
Date:   Tue, 23 Mar 2021 21:59:13 +0100
Message-Id: <8f0c2888b4e92d51239e154b82d75972e7e39833.1616533074.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1616533074.git.gladkov.alexey@gmail.com>
References: <cover.1616533074.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [5.9.43.93]); Tue, 23 Mar 2021 21:00:10 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rlimit counter is tied to uid in the user_namespace. This allows
rlimit values to be specified in userns even if they are already
globally exceeded by the user. However, the value of the previous
user_namespaces cannot be exceeded.

To illustrate the impact of rlimits, let's say there is a program that
does not fork. Some service-A wants to run this program as user X in
multiple containers. Since the program never fork the service wants to
set RLIMIT_NPROC=1.

service-A
 \- program (uid=1000, container1, rlimit_nproc=1)
 \- program (uid=1000, container2, rlimit_nproc=1)

The service-A sets RLIMIT_NPROC=1 and runs the program in container1.
When the service-A tries to run a program with RLIMIT_NPROC=1 in
container2 it fails since user X already has one running process.

We cannot use existing inc_ucounts / dec_ucounts because they do not
allow us to exceed the maximum for the counter. Some rlimits can be
overlimited by root or if the user has the appropriate capability.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/exec.c                      |  2 +-
 include/linux/cred.h           |  2 ++
 include/linux/sched/user.h     |  1 -
 include/linux/user_namespace.h | 13 ++++++++
 kernel/cred.c                  | 10 +++---
 kernel/exit.c                  |  2 +-
 kernel/fork.c                  |  9 ++---
 kernel/sys.c                   |  2 +-
 kernel/ucount.c                | 61 ++++++++++++++++++++++++++++++++++
 kernel/user.c                  |  1 -
 kernel/user_namespace.c        |  3 +-
 11 files changed, 91 insertions(+), 15 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d7c4187ca023..f2bcdbeb3afb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1878,7 +1878,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * whether NPROC limit is still exceeded.
 	 */
 	if ((current->flags & PF_NPROC_EXCEEDED) &&
-	    atomic_read(&current_user()->processes) > rlimit(RLIMIT_NPROC)) {
+	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		retval = -EAGAIN;
 		goto out_ret;
 	}
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 66436e655032..5ca1e8a1d035 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -372,6 +372,7 @@ static inline void put_cred(const struct cred *_cred)
 
 #define task_uid(task)		(task_cred_xxx((task), uid))
 #define task_euid(task)		(task_cred_xxx((task), euid))
+#define task_ucounts(task)	(task_cred_xxx((task), ucounts))
 
 #define current_cred_xxx(xxx)			\
 ({						\
@@ -388,6 +389,7 @@ static inline void put_cred(const struct cred *_cred)
 #define current_fsgid() 	(current_cred_xxx(fsgid))
 #define current_cap()		(current_cred_xxx(cap_effective))
 #define current_user()		(current_cred_xxx(user))
+#define current_ucounts()	(current_cred_xxx(ucounts))
 
 extern struct user_namespace init_user_ns;
 #ifdef CONFIG_USER_NS
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index a8ec3b6093fc..d33d867ad6c1 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -12,7 +12,6 @@
  */
 struct user_struct {
 	refcount_t __count;	/* reference count */
-	atomic_t processes;	/* How many processes does this user have? */
 	atomic_t sigpending;	/* How many pending signals does this user have? */
 #ifdef CONFIG_FANOTIFY
 	atomic_t fanotify_listeners;
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index d84cc2c0b443..9d1ca370c201 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -50,9 +50,12 @@ enum ucount_type {
 	UCOUNT_INOTIFY_INSTANCES,
 	UCOUNT_INOTIFY_WATCHES,
 #endif
+	UCOUNT_RLIMIT_NPROC,
 	UCOUNT_COUNTS,
 };
 
+#define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
+
 struct user_namespace {
 	struct uid_gid_map	uid_map;
 	struct uid_gid_map	gid_map;
@@ -107,6 +110,16 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid);
 struct ucounts * __must_check get_ucounts(struct ucounts *ucounts);
 void put_ucounts(struct ucounts *ucounts);
 
+static inline long get_ucounts_value(struct ucounts *ucounts, enum ucount_type type)
+{
+	return atomic_long_read(&ucounts->ucount[type]);
+}
+
+bool inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
+bool inc_rlimit_ucounts_and_test(struct ucounts *ucounts, enum ucount_type type, long v, long max);
+void dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
+bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
+
 #ifdef CONFIG_USER_NS
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
diff --git a/kernel/cred.c b/kernel/cred.c
index 58a8a9e24347..dcfa30b337c5 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -360,7 +360,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		kdebug("share_creds(%p{%d,%d})",
 		       p->cred, atomic_read(&p->cred->usage),
 		       read_cred_subscribers(p->cred));
-		atomic_inc(&p->cred->user->processes);
+		inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 		return 0;
 	}
 
@@ -395,8 +395,8 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 	}
 #endif
 
-	atomic_inc(&new->user->processes);
 	p->cred = p->real_cred = get_cred(new);
+	inc_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	alter_cred_subscribers(new, 2);
 	validate_creds(new);
 	return 0;
@@ -496,12 +496,12 @@ int commit_creds(struct cred *new)
 	 * in set_user().
 	 */
 	alter_cred_subscribers(new, 2);
-	if (new->user != old->user)
-		atomic_inc(&new->user->processes);
+	if (new->user != old->user || new->user_ns != old->user_ns)
+		inc_rlimit_ucounts(new->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 	rcu_assign_pointer(task->real_cred, new);
 	rcu_assign_pointer(task->cred, new);
 	if (new->user != old->user)
-		atomic_dec(&old->user->processes);
+		dec_rlimit_ucounts(old->ucounts, UCOUNT_RLIMIT_NPROC, 1);
 	alter_cred_subscribers(old, -2);
 
 	/* send notifications */
diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e35e69a..61c0fe902b50 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -188,7 +188,7 @@ void release_task(struct task_struct *p)
 	/* don't need to get the RCU readlock here - the process is dead and
 	 * can't be modifying its own credentials. But shut RCU-lockdep up */
 	rcu_read_lock();
-	atomic_dec(&__task_cred(p)->user->processes);
+	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	rcu_read_unlock();
 
 	cgroup_release(p);
diff --git a/kernel/fork.c b/kernel/fork.c
index 37498cca6a1d..d8a4956463ae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -819,9 +819,11 @@ void __init fork_init(void)
 	init_task.signal->rlim[RLIMIT_SIGPENDING] =
 		init_task.signal->rlim[RLIMIT_NPROC];
 
-	for (i = 0; i < UCOUNT_COUNTS; i++)
+	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
+	init_user_ns.ucount_max[UCOUNT_RLIMIT_NPROC] = task_rlimit(&init_task, RLIMIT_NPROC);
+
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
 			  NULL, free_vm_stack_cache);
@@ -1972,8 +1974,7 @@ static __latent_entropy struct task_struct *copy_process(
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
 	retval = -EAGAIN;
-	if (atomic_read(&p->real_cred->user->processes) >=
-			task_rlimit(p, RLIMIT_NPROC)) {
+	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if (p->real_cred->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_free;
@@ -2376,7 +2377,7 @@ static __latent_entropy struct task_struct *copy_process(
 #endif
 	delayacct_tsk_free(p);
 bad_fork_cleanup_count:
-	atomic_dec(&p->cred->user->processes);
+	dec_rlimit_ucounts(task_ucounts(p), UCOUNT_RLIMIT_NPROC, 1);
 	exit_creds(p);
 bad_fork_free:
 	p->state = TASK_DEAD;
diff --git a/kernel/sys.c b/kernel/sys.c
index cabfc5b86175..00266a65a000 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -473,7 +473,7 @@ static int set_user(struct cred *new)
 	 * for programs doing set*uid()+execve() by harmlessly deferring the
 	 * failure to the execve() stage.
 	 */
-	if (atomic_read(&new_user->processes) >= rlimit(RLIMIT_NPROC) &&
+	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
 			new_user != INIT_USER)
 		current->flags |= PF_NPROC_EXCEEDED;
 	else
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 7bac19bb3f1e..77699231e002 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -7,6 +7,7 @@
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
 #include <linux/user_namespace.h>
+#include <linux/security.h>
 
 struct ucounts init_ucounts = {
 	.ns    = &init_user_ns,
@@ -80,6 +81,7 @@ static struct ctl_table user_table[] = {
 	UCOUNT_ENTRY("max_inotify_instances"),
 	UCOUNT_ENTRY("max_inotify_watches"),
 #endif
+	{ },
 	{ }
 };
 #endif /* CONFIG_SYSCTL */
@@ -207,6 +209,19 @@ static inline bool atomic_long_inc_below(atomic_long_t *v, int u)
 	}
 }
 
+static inline long atomic_long_dec_value(atomic_long_t *v, long n)
+{
+	long c, old;
+	c = atomic_long_read(v);
+	for (;;) {
+		old = atomic_long_cmpxchg(v, c, c - n);
+		if (likely(old == c))
+			return c;
+		c = old;
+	}
+	return c;
+}
+
 struct ucounts *inc_ucount(struct user_namespace *ns, kuid_t uid,
 			   enum ucount_type type)
 {
@@ -240,6 +255,51 @@ void dec_ucount(struct ucounts *ucounts, enum ucount_type type)
 	put_ucounts(ucounts);
 }
 
+bool inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
+{
+	struct ucounts *iter;
+	bool overlimit = false;
+
+	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
+		long max = READ_ONCE(iter->ns->ucount_max[type]);
+		if (atomic_long_add_return(v, &iter->ucount[type]) > max)
+			overlimit = true;
+	}
+
+	return overlimit;
+}
+
+bool inc_rlimit_ucounts_and_test(struct ucounts *ucounts, enum ucount_type type,
+		long v, long max)
+{
+	bool overlimit = inc_rlimit_ucounts(ucounts, type, v);
+	if (!overlimit && get_ucounts_value(ucounts, type) > max)
+		overlimit = true;
+	return overlimit;
+}
+
+void dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
+{
+	struct ucounts *iter;
+	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
+		long dec = atomic_long_dec_value(&iter->ucount[type], v);
+		WARN_ON_ONCE(dec < 0);
+	}
+}
+
+bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max)
+{
+	struct ucounts *iter;
+	if (get_ucounts_value(ucounts, type) > max)
+		return true;
+	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
+		max = READ_ONCE(iter->ns->ucount_max[type]);
+		if (get_ucounts_value(iter, type) > max)
+			return true;
+	}
+	return false;
+}
+
 static __init int user_namespace_sysctl_init(void)
 {
 #ifdef CONFIG_SYSCTL
@@ -256,6 +316,7 @@ static __init int user_namespace_sysctl_init(void)
 	BUG_ON(!setup_userns_sysctls(&init_user_ns));
 #endif
 	hlist_add_ucounts(&init_ucounts);
+	inc_rlimit_ucounts(&init_ucounts, UCOUNT_RLIMIT_NPROC, 1);
 	return 0;
 }
 subsys_initcall(user_namespace_sysctl_init);
diff --git a/kernel/user.c b/kernel/user.c
index a2478cddf536..7f5ff498207a 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -98,7 +98,6 @@ static DEFINE_SPINLOCK(uidhash_lock);
 /* root_user.__count is 1, for init task cred */
 struct user_struct root_user = {
 	.__count	= REFCOUNT_INIT(1),
-	.processes	= ATOMIC_INIT(1),
 	.sigpending	= ATOMIC_INIT(0),
 	.locked_shm     = 0,
 	.uid		= GLOBAL_ROOT_UID,
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 516db53166ab..2434b13b02e5 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -118,9 +118,10 @@ int create_user_ns(struct cred *new)
 	ns->owner = owner;
 	ns->group = group;
 	INIT_WORK(&ns->work, free_user_ns);
-	for (i = 0; i < UCOUNT_COUNTS; i++) {
+	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
 	}
+	ns->ucount_max[UCOUNT_RLIMIT_NPROC] = rlimit(RLIMIT_NPROC);
 	ns->ucounts = ucounts;
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
-- 
2.29.3

