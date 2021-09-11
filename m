Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 029D3407583
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 09:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhIKHwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 03:52:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9029 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235331AbhIKHwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 03:52:20 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H64f70NvDzVqd6;
        Sat, 11 Sep 2021 15:50:07 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 11 Sep 2021 15:51:02 +0800
Received: from huawei.com (10.67.175.23) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 11 Sep
 2021 15:51:02 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
Subject: [PATCH v2] kernel/sched: Fix sched_fork() access an invalid sched_task_group
Date:   Sat, 11 Sep 2021 15:50:54 +0800
Message-ID: <20210911075054.6358-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.23]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a small race between copy_process() and sched_fork()
where child->sched_task_group point to an already freed pointer.

parent doing fork()      | someone moving the parent
				to another cgroup
-------------------------------+-------------------------------
copy_process()
    + dup_task_struct()<1>
				parent move to another cgroup,
				and free the old cgroup. <2>
    + sched_fork()
      + __set_task_cpu()<3>
      + task_fork_fair()
        + sched_slice()<4>

In the worst case, this bug can lead to "use-after-free" and
cause panic as shown above,
(1)parent copy its sched_task_group to child at <1>;
(2)someone move the parent to another cgroup and free the old
   cgroup at <2>;
(3)the sched_task_group and cfs_rq that belong to the old cgroup
   will be accessed at <3> and <4>, which cause a panic:

[89249.732198] BUG: unable to handle kernel NULL pointer
dereference at 0000000000000000
[89249.732701] PGD 8000001fa0a86067 P4D 8000001fa0a86067 PUD
2029955067 PMD 0
[89249.733005] Oops: 0000 [#1] SMP PTI
[89249.733288] CPU: 7 PID: 648398 Comm: ebizzy Kdump: loaded
Tainted: G           OE    --------- -  - 4.18.0.x86_64+ #1
[89249.734318] RIP: 0010:sched_slice+0x84/0xc0
 ....
[89249.737910] Call Trace:
[89249.738181]  task_fork_fair+0x81/0x120
[89249.738457]  sched_fork+0x132/0x240
[89249.738732]  copy_process.part.5+0x675/0x20e0
[89249.739010]  ? __handle_mm_fault+0x63f/0x690
[89249.739286]  _do_fork+0xcd/0x3b0
[89249.739558]  do_syscall_64+0x5d/0x1d0
[89249.739830]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[89249.740107] RIP: 0033:0x7f04418cd7e1

Between cgroup_can_fork() and cgroup_post_fork(), the cgroup
membership is fixed and thus sched_task_group can't change. So
call sched_fork() after cgroup_can_fork() and update the child's
sched_task_group before it is used.

Fixes: 8323f26ce342 ("sched: Fix race in task_group")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
Changes since v1:
 - revert changes of sched_post_fork()
 - call sched_fork() after cgroup_can_fork()
---
 include/linux/sched/task.h |  3 ++-
 kernel/fork.c              | 17 +++++++++--------
 kernel/sched/core.c        |  9 ++++++++-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ef02be869cf2..57eb217f1a86 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -53,7 +53,8 @@ extern int lockdep_tasklist_lock_is_held(void);
 extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
-extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
+extern int sched_fork(unsigned long clone_flags, struct task_struct *p,
+		      struct kernel_clone_args *kargs);
 extern void sched_post_fork(struct task_struct *p);
 extern void sched_dead(struct task_struct *p);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..1874fe754a56 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2160,11 +2160,6 @@ static __latent_entropy struct task_struct *copy_process(
 	p->bpf_ctx = NULL;
 #endif
 
-	/* Perform scheduler related setup. Assign this task to a CPU. */
-	retval = sched_fork(clone_flags, p);
-	if (retval)
-		goto bad_fork_cleanup_policy;
-
 	retval = perf_event_init_task(p, clone_flags);
 	if (retval)
 		goto bad_fork_cleanup_policy;
@@ -2295,6 +2290,11 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_put_pidfd;
 
+	/* Perform scheduler related setup. Assign this task to a CPU. */
+	retval = sched_fork(clone_flags, p, args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
+
 	/*
 	 * From this point on we must avoid any synchronous user-space
 	 * communication until we take the tasklist-lock. In particular, we do
@@ -2343,13 +2343,13 @@ static __latent_entropy struct task_struct *copy_process(
 	/* Don't start children in a dying pid namespace */
 	if (unlikely(!(ns_of_pid(pid)->pid_allocated & PIDNS_ADDING))) {
 		retval = -ENOMEM;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_clean_sched;
 	}
 
 	/* Let kill terminate clone/fork in the middle */
 	if (fatal_signal_pending(current)) {
 		retval = -EINTR;
-		goto bad_fork_cancel_cgroup;
+		goto bad_fork_clean_sched;
 	}
 
 	/* past the last point of failure */
@@ -2416,10 +2416,11 @@ static __latent_entropy struct task_struct *copy_process(
 
 	return p;
 
-bad_fork_cancel_cgroup:
+bad_fork_clean_sched:
 	sched_core_free(p);
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
+bad_fork_cancel_cgroup:
 	cgroup_cancel_fork(p, args);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4462c454ab9..acb30e418c4d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4326,10 +4326,17 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 /*
  * fork()/clone()-time setup:
  */
-int sched_fork(unsigned long clone_flags, struct task_struct *p)
+int sched_fork(unsigned long clone_flags, struct task_struct *p,
+		struct kernel_clone_args *kargs)
 {
 	unsigned long flags;
+#ifdef CONFIG_CGROUP_SCHED
+	struct task_group *tg;
 
+	tg = container_of(kargs->cset->subsys[cpu_cgrp_id],
+			  struct task_group, css);
+	p->sched_task_group = autogroup_task_group(p, tg);
+#endif
 	__sched_fork(clone_flags, p);
 	/*
 	 * We mark the process as NEW here. This guarantees that
-- 
2.25.1

