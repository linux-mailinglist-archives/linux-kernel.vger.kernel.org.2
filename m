Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263FF3426F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCSUdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 16:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhCSUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 16:33:05 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39391C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:05 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x16so5709627qvk.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOTCt9nawekitO2/TyPkxBtRXntgNGZynnzl7CF29Ik=;
        b=WJgp/W9SJLXvgjirapS4urkWB+LjND3JMiYFkQETA9hFyT6HViyG5fbGZeHLPmUopx
         S4DTwdxi5tibFLi/ApuSJmPnLgAHBzi/I6t4mz7SE4cG42ccDAG8onp+wYUeTOkLqtrv
         iJWXPfGfRDQHCDTyQ9Ud8xTXPdd9r8A3tQjr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOTCt9nawekitO2/TyPkxBtRXntgNGZynnzl7CF29Ik=;
        b=G0kh42jxrltV6K/vN9GWO6xZT/BLeLaYvLi2KizgSINcEd94LjtVcXmtYKFwqYS21h
         K2OdTGof2ldy4k2P740kPtVJAIjK6i6EMvjwdos6dYOoFyRZi24EyzAdSzx0XYmuNj04
         SMMQDuQ2OZgOqT0kIA07OMCL/+MvYE7AHdobuXz8Uc5CqBK3pVQQ40NbbksfBPlZUi1H
         0uOF88Q1cgFHfdQaWdzs/l1aRFk8JcgmqNrF3zK8oIUpFfFiXzxlyu2Cq+EvWUBWCWlX
         eoXzFFgx5UCcZteUHqYsUsxby07zBu4lw+/lYXkwWmdCczDyiyZ1AS79+iM+phLbtIQ2
         nkzA==
X-Gm-Message-State: AOAM531fjfAH+FbRxPmaliNdOjpE41DsuKa70LlVnTLEqq/GC4Gd72O3
        CemrnXfOdl2bFtz/w2f5e9T8ww==
X-Google-Smtp-Source: ABdhPJzXzoIUWt+Sjc36WM+KiSqqVyZmQ2ajsocR9B3b6WttS3M6mRpOhCRcfhjxq6lToECgh4s5DQ==
X-Received: by 2002:a0c:a99a:: with SMTP id a26mr11324667qvb.2.1616185984341;
        Fri, 19 Mar 2021 13:33:04 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:7422:5a6f:e616:23c9])
        by smtp.gmail.com with ESMTPSA id j26sm4588187qtp.30.2021.03.19.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 13:33:04 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 3/6] sched: prctl() cookie manipulation for core scheduling.
Date:   Fri, 19 Mar 2021 16:32:50 -0400
Message-Id: <20210319203253.3352417-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319203253.3352417-1-joel@joelfernandes.org>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>

This patch provides support for setting, clearing and copying core
scheduling 'task cookies' between threads (PID), processes (TGID), and
process groups (PGID).

The value of core scheduling isn't that tasks don't share a core, 'nosmt'
can do that. The value lies in exploiting all the sharing opportunities
that exist to recover possible lost performance and that requires a degree
of flexibility in the API. From a security perspective (and there are
others), the thread, process and process group distinction is an existent
hierarchal categorization of tasks that reflects many of the security
concerns about 'data sharing'. For example, protecting against
cache-snooping by a thread that can just read the memory directly isn't all
that useful. With this in mind, subcommands to CLEAR/CREATE/SHARE (TO/FROM)
provide a mechanism to create, clear and share cookies.
CLEAR/CREATE/SHARE_TO specify a target pid with enum pidtype used to
specify the scope of the targeted tasks. For example, PIDTYPE_TGID will
share the cookie with the process and all of it's threads as typically
desired in a security scenario.

API:

prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CREATE, tgtpid, pidtype, 0)
prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CLEAR, tgtpid, pidtype, 0)
prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_FROM, srcpid, 0, 0)
prctl(PR_SCHED_CORE_SHARE, PR_SCHED_CORE_SHARE_TO, tgtpid, pidtype, 0)

where 'tgtpid/srcpid == 0' implies the current process and pidtype is
kernel enum pid_type {PIDTYPE_PID, PIDTYPE_TGID, PIDTYPE_PGID, ...}.
PIDTYPE_SID, sharing a cookie with an entire session, was considered less
useful given the choice to create a new cookie on task exec().

For return values, EINVAL, ENOMEM are what they say. ESRCH means the
tgtpid/srcpid was not found. EPERM indicates lack of PTRACE permission access
to tgtpid/srcpid. EACCES indicates that a task in the target pidtype group was
not updated due to permission.

In terms of interaction with the cgroup interface, task cookies are set
independently of cgroup core scheduling cookies and thus would allow use
for tasks within a container using cgroup cookies.

Current hard-coded policies are:
- a user can clear the cookie of any process they can set a cookie for.
Lack of a cookie *might* be a security issue if cookies are being used
for that.
- on fork of a parent with a cookie, both process and thread child tasks
get a copy.
- on exec a task with a cookie is given a new cookie

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Josh Don <joshdon@google.com>
---
 include/linux/sched.h            |   7 ++
 include/linux/sched/task.h       |   4 +-
 include/uapi/linux/prctl.h       |   7 ++
 kernel/sched/core.c              |  11 +-
 kernel/sched/coretag.c           | 197 +++++++++++++++++++++++++++++--
 kernel/sched/sched.h             |   2 +
 kernel/sys.c                     |   7 ++
 tools/include/uapi/linux/prctl.h |   7 ++
 8 files changed, 230 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9031aa8fee5b..6ccbdbf7048b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2102,13 +2102,20 @@ void sched_core_unsafe_enter(enum ht_protect_ctx ctx);
 void sched_core_unsafe_exit(enum ht_protect_ctx ctx);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(enum ht_protect_ctx ctx);
+int sched_core_share_pid(unsigned long flags, pid_t pid, enum pid_type type);
 void sched_tsk_free(struct task_struct *tsk);
+int sched_core_exec(void);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
 #define sched_core_wait_till_safe(ignore) do { } while (0)
 #define sched_core_kernel_protected(ignore) do { } while (0)
+static inline int sched_core_share_pid(unsigned long flags, pid_t pid, enum pid_type type)
+{
+	return 0;
+}
 #define sched_tsk_free(tsk) do { } while (0)
+static inline int sched_core_exec(void) { return 0; }
 #endif
 
 #endif
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 85fb2f34c59b..033033ed641e 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -94,9 +94,9 @@ extern void free_task(struct task_struct *tsk);
 
 /* sched_exec is called by processes performing an exec */
 #ifdef CONFIG_SMP
-extern void sched_exec(void);
+int sched_exec(void);
 #else
-#define sched_exec()   {}
+static inline int sched_exec(void) { return 0; }
 #endif
 
 static inline struct task_struct *get_task_struct(struct task_struct *t)
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index c334e6a02e5f..40c7241f5fcb 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -248,4 +248,11 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+# define PR_SCHED_CORE_CLEAR		0 /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_FROM	2 /* get core_sched cookie from pid */
+# define PR_SCHED_CORE_SHARE_TO		3 /* push core_sched cookie to pid */
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2e3024a6f6e1..a62e8ad5ce58 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4654,11 +4654,17 @@ unsigned long nr_iowait(void)
  * sched_exec - execve() is a valuable balancing opportunity, because at
  * this point the task has the smallest effective memory and cache footprint.
  */
-void sched_exec(void)
+int sched_exec(void)
 {
 	struct task_struct *p = current;
 	unsigned long flags;
 	int dest_cpu;
+	int ret;
+
+	/* this may change what tasks current can share a core with */
+	ret = sched_core_exec();
+	if (ret)
+		return ret;
 
 	raw_spin_lock_irqsave(&p->pi_lock, flags);
 	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
@@ -4670,10 +4676,11 @@ void sched_exec(void)
 
 		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
 		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-		return;
+		return 0;
 	}
 unlock:
 	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	return 0;
 }
 
 #endif
diff --git a/kernel/sched/coretag.c b/kernel/sched/coretag.c
index e391b0e7b308..e3e4a9074200 100644
--- a/kernel/sched/coretag.c
+++ b/kernel/sched/coretag.c
@@ -184,6 +184,7 @@ void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
 }
 #endif
 
+/* Per-task interface: task free. */
 static void sched_core_free_task_cookie_work(struct work_struct *ws);
 
 static unsigned long sched_core_alloc_task_cookie(void)
@@ -251,11 +252,176 @@ static void sched_core_put_task_cookie_async(unsigned long cookie)
 }
 
 static inline void sched_core_update_task_cookie(struct task_struct *t,
-						unsigned long c)
+						 unsigned long c)
 {
 	sched_core_update_cookie(t, c, sched_core_task_cookie_type);
 }
 
+static int sched_core_create_cookie(struct task_struct *p)
+{
+	unsigned long cookie;
+	lockdep_assert_held(&sched_core_tasks_mutex);
+
+	cookie = sched_core_alloc_task_cookie();
+	if (!cookie)
+		return -ENOMEM;
+
+	if (p->core_cookie.task_cookie)
+		sched_core_put_task_cookie(p->core_cookie.task_cookie);
+
+	sched_core_update_task_cookie(p, cookie);
+	return 0;
+}
+
+static void sched_core_clear_cookie(struct task_struct *p)
+{
+	lockdep_assert_held(&sched_core_tasks_mutex);
+	if (p->core_cookie.task_cookie) {
+		sched_core_put_task_cookie(p->core_cookie.task_cookie);
+		sched_core_update_task_cookie(p, 0);
+	}
+}
+
+static unsigned long sched_core_get_copy_cookie(struct task_struct *p)
+{
+	unsigned long cookie = p->core_cookie.task_cookie;
+
+	lockdep_assert_held(&sched_core_tasks_mutex);
+	sched_core_get_task_cookie(cookie);
+	return cookie;
+}
+
+static void sched_core_copy_cookie_frm_to(struct task_struct *ft, struct task_struct *tt)
+{
+	unsigned long cookie;
+
+	lockdep_assert_held(&sched_core_tasks_mutex);
+
+	/* sharing a 0 cookie is a clear */
+	if (!ft->core_cookie.task_cookie) {
+		sched_core_clear_cookie(tt);
+		return;
+	}
+
+	cookie = sched_core_get_copy_cookie(ft);
+	if (tt->core_cookie.task_cookie)
+		sched_core_put_task_cookie(tt->core_cookie.task_cookie);
+	sched_core_update_task_cookie(tt, cookie);
+}
+
+/* Called from prctl interface: PR_SCHED_CORE_SHARE */
+int sched_core_share_pid(unsigned long flags, pid_t pid, enum pid_type type)
+{
+	struct task_struct *task;
+	struct task_struct *p;
+	unsigned long cookie;
+	struct pid *grp;
+	int err = 0;
+
+	if (type > PIDTYPE_PGID || flags > PR_SCHED_CORE_SHARE_TO || pid < 0 ||
+	    (flags == PR_SCHED_CORE_SHARE_FROM && type != PIDTYPE_PID))
+		return -EINVAL;
+
+	rcu_read_lock();
+
+	if (pid == 0) {
+		task = current;
+	} else {
+		task = find_task_by_vpid(pid);
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+	}
+
+	get_task_struct(task);
+
+	/* Check if this process has the right to modify the specified
+	 * process. Use the regular "ptrace_may_access()" checks.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		rcu_read_unlock();
+		err = -EPERM;
+		goto out;
+	}
+	rcu_read_unlock();
+
+	mutex_lock(&sched_core_tasks_mutex);
+	if (type == PIDTYPE_PID) {
+		if (flags == PR_SCHED_CORE_CREATE) {
+			err = sched_core_create_cookie(task);
+
+		} else if (flags == PR_SCHED_CORE_CLEAR) {
+			sched_core_clear_cookie(task);
+
+		} else if (flags == PR_SCHED_CORE_SHARE_FROM) {
+			sched_core_copy_cookie_frm_to(task, current);
+
+		} else if (flags == PR_SCHED_CORE_SHARE_TO) {
+			sched_core_copy_cookie_frm_to(current, task);
+
+		} else {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+	} else {
+		if (flags == PR_SCHED_CORE_CREATE) {
+			cookie = sched_core_alloc_task_cookie();
+			if (!cookie) {
+				err = -ENOMEM;
+				goto out_unlock;
+			}
+
+		} else if (flags == PR_SCHED_CORE_CLEAR) {
+			cookie = 0;
+		} else if (flags == PR_SCHED_CORE_SHARE_TO) {
+			cookie = sched_core_get_copy_cookie(current);
+		}  else {
+			err = -EINVAL;
+			goto out_unlock;
+		}
+
+		rcu_read_lock();
+		if (type == PIDTYPE_TGID) {
+			grp = task_tgid(task);
+		} else if (type == PIDTYPE_PGID) {
+			grp = task_pgrp(task);
+		} else {
+			err = -EINVAL;
+			rcu_read_unlock();
+			goto out_unlock;
+		}
+
+		do_each_pid_thread(grp, type, p) {
+			/* if not allowed, don't do it, but indicate to caller. */
+			if (ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS)) {
+				if (cookie)
+					sched_core_get_task_cookie(cookie);
+				if (p->core_cookie.task_cookie)
+					sched_core_put_task_cookie_async(p->core_cookie.task_cookie);
+				sched_core_update_task_cookie(p, cookie);
+			} else {
+				err = -EACCES;
+			}
+		} while_each_pid_thread(grp, type, p);
+
+		rcu_read_unlock();
+
+		/*
+		 * Remove the extra reference we took to the cookie
+		 * (ie. via alloc/copy).
+		 */
+		if (cookie)
+			sched_core_put_task_cookie(cookie);
+	}
+out_unlock:
+	mutex_unlock(&sched_core_tasks_mutex);
+
+out:
+	put_task_struct(task);
+	return err;
+}
+
 /* CGroup core-scheduling interface support. */
 #ifdef CONFIG_CGROUP_SCHED
 /*
@@ -371,20 +537,35 @@ int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 }
 #endif
 
-/*
- * Called from sched_fork().
- *
- * NOTE: This might race with a concurrent cgroup cookie update. That's
- * ok; sched_core_change_group() will handle this post-fork, once the
- * task is visible.
- */
+int sched_core_exec(void)
+{
+	int ret = 0;
+
+	/* absent a policy mech, if task had a cookie, give it a new one */
+	if (READ_ONCE(current->core_cookie.task_cookie)) {
+		mutex_lock(&sched_core_tasks_mutex);
+		if (current->core_cookie.task_cookie)
+			ret = sched_core_create_cookie(current);
+		mutex_unlock(&sched_core_tasks_mutex);
+	}
+	return ret;
+}
+
+/* Called from sched_fork() */
 int sched_core_fork(struct task_struct *p, unsigned long clone_flags)
 {
 	/*
 	 * Task cookie is ref counted; avoid an uncounted reference.
+	 * If p should have a task cookie, it will be set below.
 	 */
 	__sched_core_set_task_cookie(&p->core_cookie, 0);
 
+	if (READ_ONCE(current->core_cookie.task_cookie)) {
+		mutex_lock(&sched_core_tasks_mutex);
+		if (current->core_cookie.task_cookie)
+			sched_core_copy_cookie_frm_to(current, p);
+		mutex_unlock(&sched_core_tasks_mutex);
+	}
 	return 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5ad494459be1..862a25e709e3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1238,6 +1238,8 @@ void sched_core_dequeue(struct rq *rq, struct task_struct *p);
 void sched_core_get(void);
 void sched_core_put(void);
 
+int sched_core_share_pid(unsigned long flags, pid_t pid, enum pid_type type);
+
 #ifdef CONFIG_CGROUP_SCHED
 u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css,
 			  struct cftype *cft);
diff --git a/kernel/sys.c b/kernel/sys.c
index a730c03ee607..d594b2e37aa0 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2530,6 +2530,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 
 		error = (current->flags & PR_IO_FLUSHER) == PR_IO_FLUSHER;
 		break;
+#ifdef CONFIG_SCHED_CORE
+	case PR_SCHED_CORE_SHARE:
+		if (arg5)
+			return -EINVAL;
+		error = sched_core_share_pid(arg2, arg3, arg4);
+		break;
+#endif
 	default:
 		error = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 7f0827705c9a..73fee4dc3590 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -247,4 +247,11 @@ struct prctl_mm_map {
 #define PR_SET_IO_FLUSHER		57
 #define PR_GET_IO_FLUSHER		58
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE_SHARE		59
+# define PR_SCHED_CORE_CLEAR		0  /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_CREATE		1  /* get core_sched cookie from pid */
+# define PR_SCHED_CORE_SHARE_FROM	2  /* get core_sched cookie from pid */
+# define PR_SCHED_CORE_SHARE_TO		3  /* push core_sched cookie to pid */
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.31.0.rc2.261.g7f71774620-goog

