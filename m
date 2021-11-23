Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094C545A3BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 14:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbhKWNcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 08:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235934AbhKWNcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 08:32:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A149A6101A;
        Tue, 23 Nov 2021 13:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637674173;
        bh=4KZgWIj0JiY+UFXx9pxc6RrLWe65vv8XIsIKxLdl6Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+x+76KyE2EqRMXIhMmk6znpxVbuHoa+mU36mEwHjSjvUs1dEViVKCtITX+H2ZPgI
         wENddr5LsrqlG2ejWr1KkvbeACMl4FhL/K4f8/76xH1NjEcKek2bJIT9rtHtAI0RjT
         hdstWqCWH36IcjGDHDR2rRhvty/h3s2CWfG0lORwMEcHx0JVSbCx+m86lxkw0tN5S1
         X1L2iEqI09dUrAlBgdYzlluDRCjSSvtJHuuUY/LTM40EFMYqqy2sbuxqoyX2LD8XGt
         BQUK+uHq7qIGV3M6hL+bpNyFiTYIphcbk11guMUUayLUDuxFKN6vNbkrz9VrDgGgWO
         XPZlIaUB4yE9A==
From:   Christian Brauner <brauner@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     Peter Collingbourne <pcc@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 1/3] pid: introduce task_by_pid()
Date:   Tue, 23 Nov 2021 14:29:05 +0100
Message-Id: <20211123132907.3138476-2-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123132907.3138476-1-brauner@kernel.org>
References: <20211123132907.3138476-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11907; h=from:subject; bh=FNbmOUx/4AM/AQ6nG6EDaLa5qZJu75KfuCvWsIQd9Lo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOeTPfv3HBo5V8Jn2Rd8WYG5VKGzzeck7YINZ/JinfldnS crljRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQeSTAybM3O3tOcfvB4/awLM07t51 q4pfge894/Z9QVt6ld2nDcewYjQ5fCGq9d39P7ZrD6GUV/e7qr9Ccjd8H/3we12ir26pco8wMA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

We have a lot of places that open code

if (who)
        p = find_task_by_vpid(who);
else
        p = current;

Introduce a simpler helper which can be used instead.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 arch/mips/kernel/mips-mt-fpaff.c       | 14 ++-----------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 19 +++++++-----------
 block/ioprio.c                         | 10 ++--------
 include/linux/sched.h                  |  7 +++++++
 kernel/cgroup/cgroup.c                 | 12 ++++--------
 kernel/events/core.c                   |  5 +----
 kernel/futex/syscalls.c                | 20 ++++++-------------
 kernel/pid.c                           |  5 +++++
 kernel/sched/core.c                    | 27 ++++++++------------------
 kernel/sched/core_sched.c              | 12 ++++--------
 kernel/sys.c                           | 12 +++---------
 mm/mempolicy.c                         |  2 +-
 12 files changed, 50 insertions(+), 95 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 67e130d3f038..53c8a56815ea 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -33,16 +33,6 @@ unsigned long mt_fpemul_threshold;
  * updated when kernel/sched/core.c changes.
  */
 
-/*
- * find_process_by_pid - find a process with a matching PID value.
- * used in sys_sched_set/getaffinity() in kernel/sched/core.c, so
- * cloned here.
- */
-static inline struct task_struct *find_process_by_pid(pid_t pid)
-{
-	return pid ? find_task_by_vpid(pid) : current;
-}
-
 /*
  * check the target process has a UID that matches the current process's
  */
@@ -79,7 +69,7 @@ asmlinkage long mipsmt_sys_sched_setaffinity(pid_t pid, unsigned int len,
 	cpus_read_lock();
 	rcu_read_lock();
 
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p) {
 		rcu_read_unlock();
 		cpus_read_unlock();
@@ -170,7 +160,7 @@ asmlinkage long mipsmt_sys_sched_getaffinity(pid_t pid, unsigned int len,
 	rcu_read_lock();
 
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p)
 		goto out_unlock;
 	retval = security_task_getscheduler(p);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6a7..577d0ffebb9d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -660,19 +660,14 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
 	int ret;
 
 	rcu_read_lock();
-	if (pid) {
-		tsk = find_task_by_vpid(pid);
-		if (!tsk) {
-			rcu_read_unlock();
-			rdt_last_cmd_printf("No task %d\n", pid);
-			return -ESRCH;
-		}
-	} else {
-		tsk = current;
-	}
-
-	get_task_struct(tsk);
+	tsk = task_by_pid(pid);
+	if (tsk)
+		get_task_struct(tsk);
 	rcu_read_unlock();
+	if (!tsk) {
+		rdt_last_cmd_printf("No task %d\n", pid);
+		return -ESRCH;
+	}
 
 	ret = rdtgroup_task_write_permission(tsk, of);
 	if (!ret)
diff --git a/block/ioprio.c b/block/ioprio.c
index 313c14a70bbd..9a9349048d0d 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -113,10 +113,7 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 	rcu_read_lock();
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
-			if (!who)
-				p = current;
-			else
-				p = find_task_by_vpid(who);
+			p = task_by_pid(who);
 			if (p)
 				ret = set_task_ioprio(p, ioprio);
 			break;
@@ -208,10 +205,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 	rcu_read_lock();
 	switch (which) {
 		case IOPRIO_WHO_PROCESS:
-			if (!who)
-				p = current;
-			else
-				p = find_task_by_vpid(who);
+			p = task_by_pid(who);
 			if (p)
 				ret = get_task_ioprio(p);
 			break;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..28ce2fb581f7 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1900,6 +1900,13 @@ extern unsigned long init_stack[THREAD_SIZE / sizeof(unsigned long)];
  */
 
 extern struct task_struct *find_task_by_vpid(pid_t nr);
+/**
+ * task_by_pid - find a process with a matching PID value.
+ * @pid: the pid in question.
+ *
+ * The task of @pid, if found. %NULL otherwise.
+ */
+extern struct task_struct *task_by_pid(pid_t nr);
 extern struct task_struct *find_task_by_pid_ns(pid_t nr, struct pid_namespace *ns);
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194de39c8..a674fa07a291 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2838,14 +2838,10 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	}
 
 	rcu_read_lock();
-	if (pid) {
-		tsk = find_task_by_vpid(pid);
-		if (!tsk) {
-			tsk = ERR_PTR(-ESRCH);
-			goto out_unlock_threadgroup;
-		}
-	} else {
-		tsk = current;
+	tsk = task_by_pid(pid);
+	if (!tsk) {
+		tsk = ERR_PTR(-ESRCH);
+		goto out_unlock_threadgroup;
 	}
 
 	if (threadgroup)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 523106a506ee..ef417285911d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4604,10 +4604,7 @@ find_lively_task_by_vpid(pid_t vpid)
 	struct task_struct *task;
 
 	rcu_read_lock();
-	if (!vpid)
-		task = current;
-	else
-		task = find_task_by_vpid(vpid);
+	task = task_by_pid(vpid);
 	if (task)
 		get_task_struct(task);
 	rcu_read_unlock();
diff --git a/kernel/futex/syscalls.c b/kernel/futex/syscalls.c
index 6f91a07a6a83..3e22f6d51815 100644
--- a/kernel/futex/syscalls.c
+++ b/kernel/futex/syscalls.c
@@ -62,13 +62,9 @@ SYSCALL_DEFINE3(get_robust_list, int, pid,
 	rcu_read_lock();
 
 	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
+	p = task_by_pid(pid);
+	if (!p)
+		goto err_unlock;
 
 	ret = -EPERM;
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
@@ -348,13 +344,9 @@ COMPAT_SYSCALL_DEFINE3(get_robust_list, int, pid,
 	rcu_read_lock();
 
 	ret = -ESRCH;
-	if (!pid)
-		p = current;
-	else {
-		p = find_task_by_vpid(pid);
-		if (!p)
-			goto err_unlock;
-	}
+	p = task_by_pid(pid);
+	if (!p)
+		goto err_unlock;
 
 	ret = -EPERM;
 	if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS))
diff --git a/kernel/pid.c b/kernel/pid.c
index 2fc0a16ec77b..1cd82fa58273 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -422,6 +422,11 @@ struct task_struct *find_task_by_vpid(pid_t vnr)
 	return find_task_by_pid_ns(vnr, task_active_pid_ns(current));
 }
 
+struct task_struct *task_by_pid(pid_t nr)
+{
+	return nr ? find_task_by_vpid(nr) : current;
+}
+
 struct task_struct *find_get_task_by_vpid(pid_t nr)
 {
 	struct task_struct *task;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fda64ac..01a517cba040 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7131,17 +7131,6 @@ unsigned long sched_cpu_util(int cpu, unsigned long max)
 }
 #endif /* CONFIG_SMP */
 
-/**
- * find_process_by_pid - find a process with a matching PID value.
- * @pid: the pid in question.
- *
- * The task of @pid, if found. %NULL otherwise.
- */
-static struct task_struct *find_process_by_pid(pid_t pid)
-{
-	return pid ? find_task_by_vpid(pid) : current;
-}
-
 /*
  * sched_setparam() passes in -1 for its policy, to let the functions
  * it calls know not to change it.
@@ -7584,7 +7573,7 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 
 	rcu_read_lock();
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (likely(p))
 		get_task_struct(p);
 	rcu_read_unlock();
@@ -7707,7 +7696,7 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 
 	rcu_read_lock();
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (likely(p))
 		get_task_struct(p);
 	rcu_read_unlock();
@@ -7739,7 +7728,7 @@ SYSCALL_DEFINE1(sched_getscheduler, pid_t, pid)
 
 	retval = -ESRCH;
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (p) {
 		retval = security_task_getscheduler(p);
 		if (!retval)
@@ -7768,7 +7757,7 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, pid, struct sched_param __user *, param)
 		return -EINVAL;
 
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	retval = -ESRCH;
 	if (!p)
 		goto out_unlock;
@@ -7851,7 +7840,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		return -EINVAL;
 
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	retval = -ESRCH;
 	if (!p)
 		goto out_unlock;
@@ -7960,7 +7949,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 
 	rcu_read_lock();
 
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p) {
 		rcu_read_unlock();
 		return -ESRCH;
@@ -8039,7 +8028,7 @@ long sched_getaffinity(pid_t pid, struct cpumask *mask)
 	rcu_read_lock();
 
 	retval = -ESRCH;
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p)
 		goto out_unlock;
 
@@ -8439,7 +8428,7 @@ static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
 
 	retval = -ESRCH;
 	rcu_read_lock();
-	p = find_process_by_pid(pid);
+	p = task_by_pid(pid);
 	if (!p)
 		goto out_unlock;
 
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 517f72b008f5..9a1ef7fffc94 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -144,14 +144,10 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 		return -EINVAL;
 
 	rcu_read_lock();
-	if (pid == 0) {
-		task = current;
-	} else {
-		task = find_task_by_vpid(pid);
-		if (!task) {
-			rcu_read_unlock();
-			return -ESRCH;
-		}
+	task = task_by_pid(pid);
+	if (!task) {
+		rcu_read_unlock();
+		return -ESRCH;
 	}
 	get_task_struct(task);
 	rcu_read_unlock();
diff --git a/kernel/sys.c b/kernel/sys.c
index 8fdac0d90504..1e75b0088214 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -223,10 +223,7 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
-		if (who)
-			p = find_task_by_vpid(who);
-		else
-			p = current;
+		p = task_by_pid(who);
 		if (p)
 			error = set_one_prio(p, niceval, error);
 		break;
@@ -286,10 +283,7 @@ SYSCALL_DEFINE2(getpriority, int, which, int, who)
 	read_lock(&tasklist_lock);
 	switch (which) {
 	case PRIO_PROCESS:
-		if (who)
-			p = find_task_by_vpid(who);
-		else
-			p = current;
+		p = task_by_pid(who);
 		if (p) {
 			niceval = nice_to_rlimit(task_nice(p));
 			if (niceval > retval)
@@ -1659,7 +1653,7 @@ SYSCALL_DEFINE4(prlimit64, pid_t, pid, unsigned int, resource,
 	}
 
 	rcu_read_lock();
-	tsk = pid ? find_task_by_vpid(pid) : current;
+	tsk = task_by_pid(pid);
 	if (!tsk) {
 		rcu_read_unlock();
 		return -ESRCH;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10e9c87260ed..1199b9fc2250 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1538,7 +1538,7 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 
 	/* Find the mm_struct */
 	rcu_read_lock();
-	task = pid ? find_task_by_vpid(pid) : current;
+	task = task_by_pid(pid);
 	if (!task) {
 		rcu_read_unlock();
 		err = -ESRCH;
-- 
2.30.2

