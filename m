Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F18F334946
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 22:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhCJU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:59:42 -0500
Received: from mx1.riseup.net ([198.252.153.129]:48952 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231293AbhCJU73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:59:29 -0500
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4DwkwJ32WJzDxYw;
        Wed, 10 Mar 2021 12:59:28 -0800 (PST)
X-Riseup-User-ID: 0B9311A4F9ADE25606E5341B9A10FF603FD168CAF999532FD0036A1D703775AD
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4DwkwH67qMz1y6Q;
        Wed, 10 Mar 2021 12:59:27 -0800 (PST)
From:   Jim Newsome <jnewsome@torproject.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jim Newsome <jnewsome@torproject.org>
Subject: [PATCH] ptrace: Allow other threads to access tracee
Date:   Wed, 10 Mar 2021 14:59:08 -0600
Message-Id: <20210310205908.23447-1-jnewsome@torproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the tracing thread can call ptrace on a given pid. This
patch allows any task in the tracing thread's thread group to also call
ptrace. This makes it easier and more performant to write multi-threaded
applications that use ptrace.

In our ptrace-based simulator, we currently work-around this limitation
by stopping and detaching inactive tracees, so that any thread in our
worker thread pool can later re-attach and resume control of the tracee.
This detaching and reattaching carries with it a significant performance
overhead. With this patch, detaching and reattaching is no longer
necessary.

Signed-off-by: James Newsome <jnewsome@torproject.org>
---
 kernel/ptrace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 821cf1723814..bd9968a35784 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -50,7 +50,7 @@ int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
 		return 0;
 
 	if (!tsk->ptrace ||
-	    (current != tsk->parent) ||
+	    !same_thread_group(current, tsk->parent) ||
 	    ((get_dumpable(mm) != SUID_DUMP_USER) &&
 	     !ptracer_capable(tsk, mm->user_ns))) {
 		mmput(mm);
@@ -193,7 +193,7 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
 	if (task->state != __TASK_TRACED)
 		return;
 
-	WARN_ON(!task->ptrace || task->parent != current);
+	WARN_ON(!task->ptrace || !same_thread_group(task->parent, current));
 
 	/*
 	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
@@ -238,7 +238,7 @@ static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
 	 * be changed by us so it's not changing right after this.
 	 */
 	read_lock(&tasklist_lock);
-	if (child->ptrace && child->parent == current) {
+	if (child->ptrace && same_thread_group(child->parent, current)) {
 		WARN_ON(child->state == __TASK_TRACED);
 		/*
 		 * child->sighand can't be NULL, release_task()
-- 
2.30.1

