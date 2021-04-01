Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40906351920
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 19:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhDARvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 13:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbhDARk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:40:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FBCC08EBB3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 06:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=EIKZHheC/gmiqphmmeFgU7k/kQi7/MnMK5jDVtTSnNw=; b=p1p8AqNy7trZP3oK1xM+xINFLO
        +q1ovAxKKUIUqiieWQ35L/lPsB4XGszI6PySLjjoLikjncfMahPY8T/rCj2wmP3/awX1sJYqG/yMX
        lL51JiWtq9g7fkbahJlJOZYNft2jBo2Ufo7arPKLeQXlN6YpWSa0P4yeghwBOcryEmKee6CmYoSpU
        a7pEAwk5+W2h4MVl+GwTerUHRVWkEY92qN3qGmUSZp2DMbyR6BFqAzZ5AJ6ififdr2TesFuO9nEib
        ke57sPqULL5GS7vLtwgzmODVLC2HFMVA8endQ9ERR6Uo8Zk19o/L9kNytVGl7UpUtqZXTmc5FllLi
        c/uqarpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRxah-006BoJ-EG; Thu, 01 Apr 2021 13:42:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 38340307062;
        Thu,  1 Apr 2021 15:42:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D541724C1A500; Thu,  1 Apr 2021 15:42:29 +0200 (CEST)
Message-ID: <20210401133917.350276562@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 01 Apr 2021 15:10:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [PATCH 5/9] sched: prctl() core-scheduling interface
References: <20210401131012.395311786@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Hyser <chris.hyser@oracle.com>

This patch provides support for setting, clearing and copying core
scheduling 'task cookies' between threads (PID), processes (TGID), and
process groups (PGID).

The value of core scheduling isn't that tasks don't share a core,
'nosmt' can do that. The value lies in exploiting all the sharing
opportunities that exist to recover possible lost performance and that
requires a degree of flexibility in the API.

>From a security perspective (and there are others), the thread,
process and process group distinction is an existent hierarchal
categorization of tasks that reflects many of the security concerns
about 'data sharing'. For example, protecting against cache-snooping
by a thread that can just read the memory directly isn't all that
useful.

With this in mind, subcommands to CLEAR/CREATE/SHARE (TO/FROM) provide
a mechanism to create, clear and share cookies. CLEAR/CREATE/SHARE_TO
specify a target pid with enum pidtype used to specify the scope of
the targeted tasks. For example, PIDTYPE_TGID will share the cookie
with the process and all of it's threads as typically desired in a
security scenario.

API:

  prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, tgtpid, pidtype, &cookie)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_CLEAR, tgtpid, pidtype, NULL)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, tgtpid, pidtype, NULL)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, tgtpid, pidtype, NULL)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, srcpid, pidtype, NULL)

where 'tgtpid/srcpid == 0' implies the current process and pidtype is
kernel enum pid_type {PIDTYPE_PID, PIDTYPE_TGID, PIDTYPE_PGID, ...}.
PIDTYPE_SID, sharing a cookie with an entire session, was considered
less useful given the choice to create a new cookie on task exec().

For return values, EINVAL, ENOMEM are what they say. ESRCH means the
tgtpid/srcpid was not found. EPERM indicates lack of PTRACE permission
access to tgtpid/srcpid. EACCES indicates that a task in the target
pidtype group was not updated due to permission.

Current hard-coded policies are:

 - a user can clear the cookie of any process they can set a cookie for.
   Lack of a cookie *might* be a security issue if cookies are being used
   for that.

[peterz: complete rewrite]
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210324214020.34142-4-joel@joelfernandes.org
---
 include/linux/sched.h            |    2 
 include/uapi/linux/prctl.h       |    9 +++
 kernel/sched/core_sched.c        |  117 +++++++++++++++++++++++++++++++++++++++
 kernel/sys.c                     |    5 +
 tools/include/uapi/linux/prctl.h |    9 +++
 5 files changed, 142 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2173,6 +2173,8 @@ const struct cpumask *sched_trace_rd_spa
 extern void sched_core_free(struct task_struct *tsk);
 extern int sched_core_exec(void);
 extern void sched_core_fork(struct task_struct *p);
+extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
+				unsigned long uaddr);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline int sched_core_exec(void) { return 0; }
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -255,4 +255,13 @@ struct prctl_mm_map {
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE			60
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CLEAR		1 /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_CREATE		2 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		3 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	4 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		5
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/prctl.h>
 #include "sched.h"
 
 /*
@@ -125,3 +126,119 @@ int sched_core_exec(void)
 	return 0;
 }
 
+static void __sched_core_set(struct task_struct *p, unsigned long cookie)
+{
+	cookie = sched_core_get_cookie(cookie);
+	cookie = sched_core_update_cookie(p, cookie);
+	sched_core_put_cookie(cookie);
+}
+
+/* Called from prctl interface: PR_SCHED_CORE */
+int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
+			 unsigned long uaddr)
+{
+	unsigned long cookie = 0, id = 0;
+	struct task_struct *task, *p;
+	struct pid *grp;
+	int err = 0;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -ENODEV;
+
+	if (type > PIDTYPE_PGID || cmd >= PR_SCHED_CORE_MAX || pid < 0 ||
+	    (cmd != PR_SCHED_CORE_GET && uaddr))
+		return -EINVAL;
+
+	rcu_read_lock();
+	if (pid == 0) {
+		task = current;
+	} else {
+		task = find_task_by_vpid(pid);
+		if (!task) {
+			rcu_read_unlock();
+			return -ESRCH;
+		}
+	}
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	/*
+	 * Check if this process has the right to modify the specified
+	 * process. Use the regular "ptrace_may_access()" checks.
+	 */
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
+		err = -EPERM;
+		goto out;
+	}
+
+	switch (cmd) {
+	case PR_SCHED_CORE_GET:
+		if (type != PIDTYPE_PID || uaddr & 7) {
+			err = -EINVAL;
+			goto out;
+		}
+		cookie = sched_core_clone_cookie(task);
+		if (cookie) {
+			/* XXX improve ? */
+			ptr_to_hashval((void *)cookie, &id);
+		}
+		err = put_user(id, (u64 __user *)uaddr);
+		goto out;
+
+	case PR_SCHED_CORE_CLEAR:
+		cookie = 0;
+		break;
+
+	case PR_SCHED_CORE_CREATE:
+		cookie = sched_core_alloc_cookie();
+		if (!cookie) {
+			err = -ENOMEM;
+			goto out;
+		}
+		break;
+
+	case PR_SCHED_CORE_SHARE_TO:
+		cookie = sched_core_clone_cookie(current);
+		break;
+
+	case PR_SCHED_CORE_SHARE_FROM:
+		if (type != PIDTYPE_PID) {
+			err = -EINVAL;
+			goto out;
+		}
+		cookie = sched_core_clone_cookie(task);
+		__sched_core_set(current, cookie);
+		goto out;
+
+	default:
+		err = -EINVAL;
+		goto out;
+	};
+
+	if (type == PIDTYPE_PID) {
+		__sched_core_set(task, cookie);
+		goto out;
+	}
+
+	read_lock(&tasklist_lock);
+	grp = task_pid_type(task, type);
+
+	do_each_pid_thread(grp, type, p) {
+		if (!ptrace_may_access(p, PTRACE_MODE_READ_REALCREDS)) {
+			err = -EPERM;
+			goto out_tasklist;
+		}
+	} while_each_pid_thread(grp, type, p);
+
+	do_each_pid_thread(grp, type, p) {
+		__sched_core_set(p, cookie);
+	} while_each_pid_thread(grp, type, p);
+out_tasklist:
+	read_unlock(&tasklist_lock);
+
+out:
+	sched_core_put_cookie(cookie);
+	put_task_struct(task);
+	return err;
+}
+
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2534,6 +2534,11 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 		error = set_syscall_user_dispatch(arg2, arg3, arg4,
 						  (char __user *) arg5);
 		break;
+#ifdef CONFIG_SCHED_CORE
+	case PR_SCHED_CORE:
+		error = sched_core_share_pid(arg2, arg3, arg4, arg5);
+		break;
+#endif
 	default:
 		error = -EINVAL;
 		break;
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -255,4 +255,13 @@ struct prctl_mm_map {
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE			60
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CLEAR		1 /* clear core_sched cookie of pid */
+# define PR_SCHED_CORE_CREATE		2 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		3 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	4 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		5
+
 #endif /* _LINUX_PRCTL_H */


