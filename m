Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7003680AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbhDVMjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbhDVMiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:38:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39454C06138F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 05:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+Ye2wvkCXO4SqQwbREkBBu6KXQLaEFWz7IIPlCakk5g=; b=o5PTcVfuDe9UOVII4zicchJ6rL
        gwkG55ut2clmyOh3nXI2CHY149NmuwMXAEFLIIyFUTR1vlFIxuvJszHrNh/t8qhe/a58V3mbDwm8j
        8Rye4SvDPTPgyNkGsN+CJ3gX3p8fAzofFZOicmfx91q5N11fwlyno+0E6kNGfN0ycPAUxSFTkBfC/
        TNcUii8c5DRU/9GXOpBvA2OOqjF/Ewc1wikh8O5MrDZp0JstpRS2QEbl+F8u/G686ePwyzLpeBqBW
        Vw5lhaiG72d9b1MJ+OIzWB5STVFGpFte4GlKqQIIKY3rkbY3unjLQbwY1RZGmt2d7bSWfPtxGFXCA
        gOojyLvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lZYZM-000IDc-TA; Thu, 22 Apr 2021 12:36:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8300030032B;
        Thu, 22 Apr 2021 14:35:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7E2612C67A907; Thu, 22 Apr 2021 14:35:20 +0200 (CEST)
Message-ID: <20210422123309.039845339@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Apr 2021 14:05:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     joel@joelfernandes.org, chris.hyser@oracle.com, joshdon@google.com,
        mingo@kernel.org, vincent.guittot@linaro.org,
        valentin.schneider@arm.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: [PATCH 18/19] sched: prctl() core-scheduling interface
References: <20210422120459.447350175@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Hyser <chris.hyser@oracle.com>

This patch provides support for setting and copying core scheduling
'task cookies' between threads (PID), processes (TGID), and process
groups (PGID).

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

With this in mind, subcommands to CREATE/SHARE (TO/FROM) provide a
mechanism to create and share cookies. CREATE/SHARE_TO specify a
target pid with enum pidtype used to specify the scope of the targeted
tasks. For example, PIDTYPE_TGID will share the cookie with the
process and all of it's threads as typically desired in a security
scenario.

API:

  prctl(PR_SCHED_CORE, PR_SCHED_CORE_GET, tgtpid, pidtype, &cookie)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_CREATE, tgtpid, pidtype, NULL)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_TO, tgtpid, pidtype, NULL)
  prctl(PR_SCHED_CORE, PR_SCHED_CORE_SHARE_FROM, srcpid, pidtype, NULL)

where 'tgtpid/srcpid == 0' implies the current process and pidtype is
kernel enum pid_type {PIDTYPE_PID, PIDTYPE_TGID, PIDTYPE_PGID, ...}.

For return values, EINVAL, ENOMEM are what they say. ESRCH means the
tgtpid/srcpid was not found. EPERM indicates lack of PTRACE permission
access to tgtpid/srcpid. ENODEV indicates your machines lacks SMT.

[peterz: complete rewrite]
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h            |    2 
 include/uapi/linux/prctl.h       |    8 ++
 kernel/sched/core_sched.c        |  114 +++++++++++++++++++++++++++++++++++++++
 kernel/sys.c                     |    5 +
 tools/include/uapi/linux/prctl.h |    8 ++
 5 files changed, 137 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2173,6 +2173,8 @@ const struct cpumask *sched_trace_rd_spa
 #ifdef CONFIG_SCHED_CORE
 extern void sched_core_free(struct task_struct *tsk);
 extern void sched_core_fork(struct task_struct *p);
+extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
+				unsigned long uaddr);
 #else
 static inline void sched_core_free(struct task_struct *tsk) { }
 static inline void sched_core_fork(struct task_struct *p) { }
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -255,4 +255,12 @@ struct prctl_mm_map {
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE			60
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		4
+
 #endif /* _LINUX_PRCTL_H */
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/prctl.h>
 #include "sched.h"
 
 /*
@@ -110,3 +111,116 @@ void sched_core_free(struct task_struct
 {
 	sched_core_put_cookie(p->core_cookie);
 }
+
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
@@ -255,4 +255,12 @@ struct prctl_mm_map {
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
 
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE			60
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		4
+
 #endif /* _LINUX_PRCTL_H */


