Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52EF36806D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhDVM2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236379AbhDVM23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:28:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7346146D;
        Thu, 22 Apr 2021 12:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619094474;
        bh=n18kBwlQR2i6hC2w0YLOUB8PNcI4JxnjTciNFS8vLD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NqsKiVeNc0I6RDE8kYNAqeEx3qrJkFYRamtgWmNq3cYBfgkFurQfoyUk1slAcUCBp
         RqIUMEETroDg+02lcT7i+8Ckb/5uD+PC7aWyg1fMfMAIlt1/Vdg/kETPOtGpwKBYGk
         4mWA6mcwJ91/ZDJdt7bnw+DiY7UpuqBO8O7UAlr9zpknUcxDZuRS5bh9hsS+KkNGIe
         ymTtB1O5gly4F2ONB/Sg+sEQR8AFeF8rjsbAKbl3w96aeV7+zLuWgkH6RA7Rih1dZG
         EOyWlyQM2MODUSnHjlqVMRIinnC7EGkibN9A9Ppus4VaPB82crNb4rC+lZ/2toiRJ6
         07ydc8ccnnjRA==
From:   legion@kernel.org
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
        Oleg Nesterov <oleg@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v11 7/9] Reimplement RLIMIT_MEMLOCK on top of ucounts
Date:   Thu, 22 Apr 2021 14:27:14 +0200
Message-Id: <970d50c70c71bfd4496e0e8d2a0a32feebebb350.1619094428.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1619094428.git.legion@kernel.org>
References: <cover.1619094428.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Gladkov <legion@kernel.org>

The rlimit counter is tied to uid in the user_namespace. This allows
rlimit values to be specified in userns even if they are already
globally exceeded by the user. However, the value of the previous
user_namespaces cannot be exceeded.

Changelog

v11:
* Fix issue found by lkp robot.

v8:
* Fix issues found by lkp-tests project.

v7:
* Keep only ucounts for RLIMIT_MEMLOCK checks instead of struct cred.

v6:
* Fix bug in hugetlb_file_setup() detected by trinity.

Reported-by: kernel test robot <oliver.sang@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/hugetlbfs/inode.c           | 16 ++++++++--------
 include/linux/hugetlb.h        |  4 ++--
 include/linux/mm.h             |  4 ++--
 include/linux/sched/user.h     |  1 -
 include/linux/shmem_fs.h       |  2 +-
 include/linux/user_namespace.h |  1 +
 ipc/shm.c                      | 26 +++++++++++++-------------
 kernel/fork.c                  |  1 +
 kernel/ucount.c                |  1 +
 kernel/user.c                  |  1 -
 kernel/user_namespace.c        |  1 +
 mm/memfd.c                     |  4 ++--
 mm/mlock.c                     | 22 ++++++++++++++--------
 mm/mmap.c                      |  4 ++--
 mm/shmem.c                     | 10 +++++-----
 15 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 701c82c36138..be519fc9559a 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1443,7 +1443,7 @@ static int get_hstate_idx(int page_size_log)
  * otherwise hugetlb_reserve_pages reserves one less hugepages than intended.
  */
 struct file *hugetlb_file_setup(const char *name, size_t size,
-				vm_flags_t acctflag, struct user_struct **user,
+				vm_flags_t acctflag, struct ucounts **ucounts,
 				int creat_flags, int page_size_log)
 {
 	struct inode *inode;
@@ -1455,20 +1455,20 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	if (hstate_idx < 0)
 		return ERR_PTR(-ENODEV);
 
-	*user = NULL;
+	*ucounts = NULL;
 	mnt = hugetlbfs_vfsmount[hstate_idx];
 	if (!mnt)
 		return ERR_PTR(-ENOENT);
 
 	if (creat_flags == HUGETLB_SHMFS_INODE && !can_do_hugetlb_shm()) {
-		*user = current_user();
-		if (user_shm_lock(size, *user)) {
+		*ucounts = current_ucounts();
+		if (user_shm_lock(size, *ucounts)) {
 			task_lock(current);
 			pr_warn_once("%s (%d): Using mlock ulimits for SHM_HUGETLB is deprecated\n",
 				current->comm, current->pid);
 			task_unlock(current);
 		} else {
-			*user = NULL;
+			*ucounts = NULL;
 			return ERR_PTR(-EPERM);
 		}
 	}
@@ -1495,9 +1495,9 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 
 	iput(inode);
 out:
-	if (*user) {
-		user_shm_unlock(size, *user);
-		*user = NULL;
+	if (*ucounts) {
+		user_shm_unlock(size, *ucounts);
+		*ucounts = NULL;
 	}
 	return file;
 }
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index cccd1aab69dd..96d63dbdec65 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -434,7 +434,7 @@ static inline struct hugetlbfs_inode_info *HUGETLBFS_I(struct inode *inode)
 extern const struct file_operations hugetlbfs_file_operations;
 extern const struct vm_operations_struct hugetlb_vm_ops;
 struct file *hugetlb_file_setup(const char *name, size_t size, vm_flags_t acct,
-				struct user_struct **user, int creat_flags,
+				struct ucounts **ucounts, int creat_flags,
 				int page_size_log);
 
 static inline bool is_file_hugepages(struct file *file)
@@ -454,7 +454,7 @@ static inline struct hstate *hstate_inode(struct inode *i)
 #define is_file_hugepages(file)			false
 static inline struct file *
 hugetlb_file_setup(const char *name, size_t size, vm_flags_t acctflag,
-		struct user_struct **user, int creat_flags,
+		struct ucounts **ucounts, int creat_flags,
 		int page_size_log)
 {
 	return ERR_PTR(-ENOSYS);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64a71bf20536..7466eab000d0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1658,8 +1658,8 @@ extern bool can_do_mlock(void);
 #else
 static inline bool can_do_mlock(void) { return false; }
 #endif
-extern int user_shm_lock(size_t, struct user_struct *);
-extern void user_shm_unlock(size_t, struct user_struct *);
+extern int user_shm_lock(size_t, struct ucounts *);
+extern void user_shm_unlock(size_t, struct ucounts *);
 
 /*
  * Parameter block passed down to zap_pte_range in exceptional cases.
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 8ba9cec4fb99..82bd2532da6b 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -18,7 +18,6 @@ struct user_struct {
 #ifdef CONFIG_EPOLL
 	atomic_long_t epoll_watches; /* The number of file descriptors currently watched */
 #endif
-	unsigned long locked_shm; /* How many pages of mlocked shm ? */
 	unsigned long unix_inflight;	/* How many files in flight in unix sockets */
 	atomic_long_t pipe_bufs;  /* how many pages are allocated in pipe buffers */
 
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d82b6f396588..aa77dcd1646f 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -65,7 +65,7 @@ extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
 extern int shmem_zero_setup(struct vm_area_struct *);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
-extern int shmem_lock(struct file *file, int lock, struct user_struct *user);
+extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
 #ifdef CONFIG_SHMEM
 extern const struct address_space_operations shmem_aops;
 static inline bool shmem_mapping(struct address_space *mapping)
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 0e961bd8a090..e42efd0ae595 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -53,6 +53,7 @@ enum ucount_type {
 	UCOUNT_RLIMIT_NPROC,
 	UCOUNT_RLIMIT_MSGQUEUE,
 	UCOUNT_RLIMIT_SIGPENDING,
+	UCOUNT_RLIMIT_MEMLOCK,
 	UCOUNT_COUNTS,
 };
 
diff --git a/ipc/shm.c b/ipc/shm.c
index febd88daba8c..003234fbbd17 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -60,7 +60,7 @@ struct shmid_kernel /* private to the kernel */
 	time64_t		shm_ctim;
 	struct pid		*shm_cprid;
 	struct pid		*shm_lprid;
-	struct user_struct	*mlock_user;
+	struct ucounts		*mlock_ucounts;
 
 	/* The task created the shm object.  NULL if the task is dead. */
 	struct task_struct	*shm_creator;
@@ -286,10 +286,10 @@ static void shm_destroy(struct ipc_namespace *ns, struct shmid_kernel *shp)
 	shm_rmid(ns, shp);
 	shm_unlock(shp);
 	if (!is_file_hugepages(shm_file))
-		shmem_lock(shm_file, 0, shp->mlock_user);
-	else if (shp->mlock_user)
+		shmem_lock(shm_file, 0, shp->mlock_ucounts);
+	else if (shp->mlock_ucounts)
 		user_shm_unlock(i_size_read(file_inode(shm_file)),
-				shp->mlock_user);
+				shp->mlock_ucounts);
 	fput(shm_file);
 	ipc_update_pid(&shp->shm_cprid, NULL);
 	ipc_update_pid(&shp->shm_lprid, NULL);
@@ -625,7 +625,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 
 	shp->shm_perm.key = key;
 	shp->shm_perm.mode = (shmflg & S_IRWXUGO);
-	shp->mlock_user = NULL;
+	shp->mlock_ucounts = NULL;
 
 	shp->shm_perm.security = NULL;
 	error = security_shm_alloc(&shp->shm_perm);
@@ -650,7 +650,7 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 		if (shmflg & SHM_NORESERVE)
 			acctflag = VM_NORESERVE;
 		file = hugetlb_file_setup(name, hugesize, acctflag,
-				  &shp->mlock_user, HUGETLB_SHMFS_INODE,
+				  &shp->mlock_ucounts, HUGETLB_SHMFS_INODE,
 				(shmflg >> SHM_HUGE_SHIFT) & SHM_HUGE_MASK);
 	} else {
 		/*
@@ -698,8 +698,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 no_id:
 	ipc_update_pid(&shp->shm_cprid, NULL);
 	ipc_update_pid(&shp->shm_lprid, NULL);
-	if (is_file_hugepages(file) && shp->mlock_user)
-		user_shm_unlock(size, shp->mlock_user);
+	if (is_file_hugepages(file) && shp->mlock_ucounts)
+		user_shm_unlock(size, shp->mlock_ucounts);
 	fput(file);
 	ipc_rcu_putref(&shp->shm_perm, shm_rcu_free);
 	return error;
@@ -1105,12 +1105,12 @@ static int shmctl_do_lock(struct ipc_namespace *ns, int shmid, int cmd)
 		goto out_unlock0;
 
 	if (cmd == SHM_LOCK) {
-		struct user_struct *user = current_user();
+		struct ucounts *ucounts = current_ucounts();
 
-		err = shmem_lock(shm_file, 1, user);
+		err = shmem_lock(shm_file, 1, ucounts);
 		if (!err && !(shp->shm_perm.mode & SHM_LOCKED)) {
 			shp->shm_perm.mode |= SHM_LOCKED;
-			shp->mlock_user = user;
+			shp->mlock_ucounts = ucounts;
 		}
 		goto out_unlock0;
 	}
@@ -1118,9 +1118,9 @@ static int shmctl_do_lock(struct ipc_namespace *ns, int shmid, int cmd)
 	/* SHM_UNLOCK */
 	if (!(shp->shm_perm.mode & SHM_LOCKED))
 		goto out_unlock0;
-	shmem_lock(shm_file, 0, shp->mlock_user);
+	shmem_lock(shm_file, 0, shp->mlock_ucounts);
 	shp->shm_perm.mode &= ~SHM_LOCKED;
-	shp->mlock_user = NULL;
+	shp->mlock_ucounts = NULL;
 	get_file(shm_file);
 	ipc_unlock_object(&shp->shm_perm);
 	rcu_read_unlock();
diff --git a/kernel/fork.c b/kernel/fork.c
index 741f896c156e..a3a5e317c3c0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -825,6 +825,7 @@ void __init fork_init(void)
 	init_user_ns.ucount_max[UCOUNT_RLIMIT_NPROC] = task_rlimit(&init_task, RLIMIT_NPROC);
 	init_user_ns.ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = task_rlimit(&init_task, RLIMIT_MSGQUEUE);
 	init_user_ns.ucount_max[UCOUNT_RLIMIT_SIGPENDING] = task_rlimit(&init_task, RLIMIT_SIGPENDING);
+	init_user_ns.ucount_max[UCOUNT_RLIMIT_MEMLOCK] = task_rlimit(&init_task, RLIMIT_MEMLOCK);
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8ce62da6a62c..d316bac3e520 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -83,6 +83,7 @@ static struct ctl_table user_table[] = {
 	{ },
 	{ },
 	{ },
+	{ },
 	{ }
 };
 #endif /* CONFIG_SYSCTL */
diff --git a/kernel/user.c b/kernel/user.c
index 6737327f83be..c82399c1618a 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -98,7 +98,6 @@ static DEFINE_SPINLOCK(uidhash_lock);
 /* root_user.__count is 1, for init task cred */
 struct user_struct root_user = {
 	.__count	= REFCOUNT_INIT(1),
-	.locked_shm     = 0,
 	.uid		= GLOBAL_ROOT_UID,
 	.ratelimit	= RATELIMIT_STATE_INIT(root_user.ratelimit, 0, 0),
 };
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index df1bed32dd48..5ef0d4b182ba 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -124,6 +124,7 @@ int create_user_ns(struct cred *new)
 	ns->ucount_max[UCOUNT_RLIMIT_NPROC] = rlimit(RLIMIT_NPROC);
 	ns->ucount_max[UCOUNT_RLIMIT_MSGQUEUE] = rlimit(RLIMIT_MSGQUEUE);
 	ns->ucount_max[UCOUNT_RLIMIT_SIGPENDING] = rlimit(RLIMIT_SIGPENDING);
+	ns->ucount_max[UCOUNT_RLIMIT_MEMLOCK] = rlimit(RLIMIT_MEMLOCK);
 	ns->ucounts = ucounts;
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
diff --git a/mm/memfd.c b/mm/memfd.c
index 2647c898990c..081dd33e6a61 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -297,9 +297,9 @@ SYSCALL_DEFINE2(memfd_create,
 	}
 
 	if (flags & MFD_HUGETLB) {
-		struct user_struct *user = NULL;
+		struct ucounts *ucounts = NULL;
 
-		file = hugetlb_file_setup(name, 0, VM_NORESERVE, &user,
+		file = hugetlb_file_setup(name, 0, VM_NORESERVE, &ucounts,
 					HUGETLB_ANONHUGE_INODE,
 					(flags >> MFD_HUGE_SHIFT) &
 					MFD_HUGE_MASK);
diff --git a/mm/mlock.c b/mm/mlock.c
index f8f8cc32d03d..dd411aabf695 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -817,9 +817,10 @@ SYSCALL_DEFINE0(munlockall)
  */
 static DEFINE_SPINLOCK(shmlock_user_lock);
 
-int user_shm_lock(size_t size, struct user_struct *user)
+int user_shm_lock(size_t size, struct ucounts *ucounts)
 {
 	unsigned long lock_limit, locked;
+	long memlock;
 	int allowed = 0;
 
 	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
@@ -828,21 +829,26 @@ int user_shm_lock(size_t size, struct user_struct *user)
 		allowed = 1;
 	lock_limit >>= PAGE_SHIFT;
 	spin_lock(&shmlock_user_lock);
-	if (!allowed &&
-	    locked + user->locked_shm > lock_limit && !capable(CAP_IPC_LOCK))
+	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
+
+	if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
+		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
+		goto out;
+	}
+	if (!get_ucounts(ucounts)) {
+		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
-	get_uid(user);
-	user->locked_shm += locked;
+	}
 	allowed = 1;
 out:
 	spin_unlock(&shmlock_user_lock);
 	return allowed;
 }
 
-void user_shm_unlock(size_t size, struct user_struct *user)
+void user_shm_unlock(size_t size, struct ucounts *ucounts)
 {
 	spin_lock(&shmlock_user_lock);
-	user->locked_shm -= (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
 	spin_unlock(&shmlock_user_lock);
-	free_uid(user);
+	put_ucounts(ucounts);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..99f97d200aa4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1605,7 +1605,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 			goto out_fput;
 		}
 	} else if (flags & MAP_HUGETLB) {
-		struct user_struct *user = NULL;
+		struct ucounts *ucounts = NULL;
 		struct hstate *hs;
 
 		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
@@ -1621,7 +1621,7 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		 */
 		file = hugetlb_file_setup(HUGETLB_ANON_FILE, len,
 				VM_NORESERVE,
-				&user, HUGETLB_ANONHUGE_INODE,
+				&ucounts, HUGETLB_ANONHUGE_INODE,
 				(flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
 		if (IS_ERR(file))
 			return PTR_ERR(file);
diff --git a/mm/shmem.c b/mm/shmem.c
index b2db4ed0fbc7..7ee6d27222e9 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2227,7 +2227,7 @@ static struct mempolicy *shmem_get_policy(struct vm_area_struct *vma,
 }
 #endif
 
-int shmem_lock(struct file *file, int lock, struct user_struct *user)
+int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 {
 	struct inode *inode = file_inode(file);
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -2239,13 +2239,13 @@ int shmem_lock(struct file *file, int lock, struct user_struct *user)
 	 * no serialization needed when called from shm_destroy().
 	 */
 	if (lock && !(info->flags & VM_LOCKED)) {
-		if (!user_shm_lock(inode->i_size, user))
+		if (!user_shm_lock(inode->i_size, ucounts))
 			goto out_nomem;
 		info->flags |= VM_LOCKED;
 		mapping_set_unevictable(file->f_mapping);
 	}
-	if (!lock && (info->flags & VM_LOCKED) && user) {
-		user_shm_unlock(inode->i_size, user);
+	if (!lock && (info->flags & VM_LOCKED) && ucounts) {
+		user_shm_unlock(inode->i_size, ucounts);
 		info->flags &= ~VM_LOCKED;
 		mapping_clear_unevictable(file->f_mapping);
 	}
@@ -4093,7 +4093,7 @@ int shmem_unuse(unsigned int type, bool frontswap,
 	return 0;
 }
 
-int shmem_lock(struct file *file, int lock, struct user_struct *user)
+int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 {
 	return 0;
 }
-- 
2.29.3

