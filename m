Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3945338196
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 00:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhCKXii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 18:38:38 -0500
Received: from mx1.riseup.net ([198.252.153.129]:57120 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhCKXig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 18:38:36 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DxQPR5ltyzDxcb;
        Thu, 11 Mar 2021 15:38:35 -0800 (PST)
X-Riseup-User-ID: 41B6C3767CFEB344B7CC4F280A24931C1154974A1CA218C3551CA99ED0AF1D68
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4DxQPQ5gYQz1y6h;
        Thu, 11 Mar 2021 15:38:34 -0800 (PST)
From:   Jim Newsome <jnewsome@torproject.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, Jim Newsome <jnewsome@torproject.org>
Subject: [PATCH v4] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Date:   Thu, 11 Mar 2021 17:38:23 -0600
Message-Id: <20210311233823.20325-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_wait is an internal function used to implement waitpid, waitid,
wait4, etc. To handle the general case, it does an O(n) linear scan of
the thread group's children and tracees.

This patch adds a special-case when waiting on a pid to skip these scans
and instead do an O(1) lookup. This improves performance when waiting on
a pid from a thread group with many children and/or tracees.

Signed-off-by: James Newsome <jnewsome@torproject.org>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---

v3: https://lkml.org/lkml/2021/3/9/1134

Oleg - I kept your "reviewed-by", but LMK if I should drop it; wasn't
sure whether these changes were enough to have to drop it or not. Also
while making the other requested changes I found the code was cleaner
with a helper function after all, which I named `is_effectively_child`.

 kernel/exit.c | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e35e69a..e0fd782463c5 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1439,9 +1439,54 @@ void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
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
+
+	/* A non-ptrace wait can only be performed on a thread group leader. */
+	target = pid_task(wo->wo_pid, PIDTYPE_TGID);
+
+	if (target && is_effectively_child(wo, ptrace, target)) {
+		retval = wait_consider_task(wo, ptrace, target);
+		if (retval)
+			return retval;
+	}
+
+	ptrace = true;
+
+	/* A ptrace wait can be done on non-thread-group-leaders. */
+	if (!target)
+		target = pid_task(wo->wo_pid, PIDTYPE_PID);
+
+	if (target && is_effectively_child(wo, ptrace, target)) {
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
@@ -1463,19 +1508,27 @@ static long do_wait(struct wait_opts *wo)
 
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

