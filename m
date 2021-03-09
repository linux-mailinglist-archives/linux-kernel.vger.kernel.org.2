Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD09333013
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 21:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhCIUjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 15:39:44 -0500
Received: from mx1.riseup.net ([198.252.153.129]:42002 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231808AbhCIUjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 15:39:40 -0500
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Dw6Ws4dPBzDsZK;
        Tue,  9 Mar 2021 12:39:37 -0800 (PST)
X-Riseup-User-ID: AE255FD18F480507363915D2831290FBD05F26D3B88E602C6B93B21A0BF6B213
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Dw6Wr570mz5vNG;
        Tue,  9 Mar 2021 12:39:36 -0800 (PST)
From:   Jim Newsome <jnewsome@torproject.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, Jim Newsome <jnewsome@torproject.org>
Subject: [PATCH v3] do_wait: make PIDTYPE_PID case O(1) instead of O(n)
Date:   Tue,  9 Mar 2021 14:39:19 -0600
Message-Id: <20210309203919.15920-1-jnewsome@torproject.org>
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
---
 kernel/exit.c | 53 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 04029e35e69a..c2438d4ba262 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1439,9 +1439,34 @@ void __wake_up_parent(struct task_struct *p, struct task_struct *parent)
 			   TASK_INTERRUPTIBLE, p);
 }
 
+// Optimization for waiting on PIDTYPE_PID. No need to iterate through child
+// and tracee lists to find the target task.
+static int do_wait_pid(struct wait_opts *wo)
+{
+	struct task_struct *target = pid_task(wo->wo_pid, PIDTYPE_PID);
+	int retval;
+
+	if (!target)
+		return 0;
+	if (current == target->real_parent ||
+	    (!(wo->wo_flags & __WNOTHREAD) &&
+	     same_thread_group(current, target->real_parent))) {
+		retval = wait_consider_task(wo, /* ptrace= */ 0, target);
+		if (retval)
+			return retval;
+	}
+	if (target->ptrace && (current == target->parent ||
+			       (!(wo->wo_flags & __WNOTHREAD) &&
+				same_thread_group(current, target->parent)))) {
+		retval = wait_consider_task(wo, /* ptrace= */ 1, target);
+		if (retval)
+			return retval;
+	}
+	return 0;
+}
+
 static long do_wait(struct wait_opts *wo)
 {
-	struct task_struct *tsk;
 	int retval;
 
 	trace_sched_process_wait(wo->wo_pid);
@@ -1463,19 +1488,27 @@ static long do_wait(struct wait_opts *wo)
 
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
 
-		if (wo->wo_flags & __WNOTHREAD)
-			break;
-	} while_each_thread(current, tsk);
+		do {
+			retval = do_wait_thread(wo, tsk);
+			if (retval)
+				goto end;
+
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

