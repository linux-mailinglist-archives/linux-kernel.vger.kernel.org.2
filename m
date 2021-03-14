Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5084E33A8BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 00:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhCNXQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 19:16:55 -0400
Received: from mx1.riseup.net ([198.252.153.129]:51836 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhCNXQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 19:16:17 -0400
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DzFmK1bpqzDr6T;
        Sun, 14 Mar 2021 16:16:17 -0700 (PDT)
X-Riseup-User-ID: 2BA932BD4AD7061A7967E835CA3D4C1B2276A99E66A3DC7B1CD18DB2797B0CB8
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4DzFmJ30plz1y6k;
        Sun, 14 Mar 2021 16:16:16 -0700 (PDT)
From:   Jim Newsome <jnewsome@torproject.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, Jim Newsome <jnewsome@torproject.org>
Subject: [PATCH v7] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Date:   Sun, 14 Mar 2021 18:15:44 -0500
Message-Id: <20210314231544.9379-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a special-case when waiting on a pid (via waitpid,
waitid, wait4, etc) to avoid doing an O(n) scan of children and tracees,
and instead do an O(1) lookup. This improves performance when waiting on
a pid from a thread group with many children and/or tracees.

Time to fork and then call waitpid on the child, from a task that
already has N children [1]:

N    | Before  | After
-----|---------|------
1    | 74 us   | 74 us
20   | 72 us   | 75 us
100  | 83 us   | 77 us
500  | 99 us   | 74 us
1000 | 179 us  | 75 us
5000 | 804 us  | 79 us
8000 | 1268 us | 78 us

[1]: https://lkml.org/lkml/2021/3/12/1567

This can make a substantial performance improvement for applications
with a thread that has many children or tracees and frequently needs to
wait on them. Tools that use ptrace to intercept syscalls for a large
number of processes are likely to fall into this category. In particular
this patch was developed while building a ptrace-based second generation
of the Shadow emulator [2], for which it allows us to avoid quadratic
scaling (without having to use a workaround that introduces a ~40%
performance penalty) [3]. Other examples of tools that fall into this
category which this patch may help include User Mode Linux [4] and
DetTrace [5].

[2]: https://shadow.github.io/
[3]: https://github.com/shadow/shadow/issues/1134#issuecomment-798992292
[4]: https://en.wikipedia.org/wiki/User-mode_Linux
[5]: https://github.com/dettrace/dettrace

Signed-off-by: James Newsome <jnewsome@torproject.org>
---

v5: https://lkml.org/lkml/2021/3/12/1134
v6 accidentally dropped a commit in the rebase + squash.

Since v5:
* Switched back to explicitly looking up by tgid and then pid.
* Added further motivation and context in the patch description.

 kernel/exit.c | 67 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e35e69a..65809fac3038 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1439,9 +1439,48 @@ void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
 			   TASK_INTERRUPTIBLE, p);
 }
 
+static bool is_effectively_child(struct wait_opts *wo, bool ptrace,
+				 struct task_struct *target)
+{
+	struct task_struct *parent =
+		!ptrace ? target->real_parent : target->parent;
+
+	return current == parent || (!(wo->wo_flags & __WNOTHREAD) &&
+				     same_thread_group(current, parent));
+}
+
+/*
+ * Optimization for waiting on PIDTYPE_PID. No need to iterate through child
+ * and tracee lists to find the target task.
+ */
+static int do_wait_pid(struct wait_opts *wo)
+{
+	bool ptrace;
+	struct task_struct *target;
+	int retval;
+
+	ptrace = false;
+	target = pid_task(wo->wo_pid, PIDTYPE_TGID);
+	if (target && is_effectively_child(wo, ptrace, target)) {
+		retval = wait_consider_task(wo, ptrace, target);
+		if (retval)
+			return retval;
+	}
+
+	ptrace = true;
+	target = pid_task(wo->wo_pid, PIDTYPE_PID);
+	if (target && target->ptrace &&
+	    is_effectively_child(wo, ptrace, target)) {
+		retval = wait_consider_task(wo, ptrace, target);
+		if (retval)
+			return retval;
+	}
+
+	return 0;
+}
+
 static long do_wait(struct wait_opts *wo)
 {
-	struct task_struct *tsk;
 	int retval;
 
 	trace_sched_process_wait(wo->wo_pid);
@@ -1463,19 +1502,27 @@ static long do_wait(struct wait_opts *wo)
 
 	set_current_state(TASK_INTERRUPTIBLE);
 	read_lock(&tasklist_lock);
-	tsk = current;
-	do {
-		retval = do_wait_thread(wo, tsk);
-		if (retval)
-			goto end;
 
-		retval = ptrace_do_wait(wo, tsk);
+	if (wo->wo_type == PIDTYPE_PID) {
+		retval = do_wait_pid(wo);
 		if (retval)
 			goto end;
+	} else {
+		struct task_struct *tsk = current;
+
+		do {
+			retval = do_wait_thread(wo, tsk);
+			if (retval)
+				goto end;
 
-		if (wo->wo_flags & __WNOTHREAD)
-			break;
-	} while_each_thread(current, tsk);
+			retval = ptrace_do_wait(wo, tsk);
+			if (retval)
+				goto end;
+
+			if (wo->wo_flags & __WNOTHREAD)
+				break;
+		} while_each_thread(current, tsk);
+	}
 	read_unlock(&tasklist_lock);
 
 notask:
-- 
2.30.1

