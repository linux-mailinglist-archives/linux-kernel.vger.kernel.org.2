Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6481A307FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhA1U0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:26:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35322 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231454AbhA1UZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611865442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5vne8wHUq5hbUZWHYRODtXy1278qohKUG5a1mgyB57Q=;
        b=czpHzuU+U0vQoxCKUwEaiF9Cm+dqVW0k7jF4Znaa1nsrtFSmuKwUrT2kdjRl7jryKhB02D
        KF1qaVmyv0FmzMxtB6qAZ6Ven72nwLhgJoC9/g3MVLjzXKkIeKsRDKLEwKQ2nBQpwVRWn2
        NTUPJ3PgdCHBWTlxFHZY+PKLaNsOMb8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-571-Gt1NiJkjMYavYzDaaYfY-w-1; Thu, 28 Jan 2021 15:24:00 -0500
X-MC-Unique: Gt1NiJkjMYavYzDaaYfY-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74C0D18C9F42;
        Thu, 28 Jan 2021 20:23:59 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27D125C1B4;
        Thu, 28 Jan 2021 20:23:59 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 19B7B4178902; Thu, 28 Jan 2021 17:23:35 -0300 (-03)
Message-ID: <20210128202235.881301644@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 28 Jan 2021 17:21:37 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 3/3] nohz: tick_nohz_kick_task: only IPI if remote task is running
References: <20210128202134.608115362@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the task is not running, run_posix_cpu_timers has nothing
to elapsed, so spare IPI in that case.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/kernel/sched/core.c
===================================================================
--- linux-2.6.orig/kernel/sched/core.c
+++ linux-2.6/kernel/sched/core.c
@@ -9182,3 +9182,9 @@ void call_trace_sched_update_nr_running(
 {
         trace_sched_update_nr_running_tp(rq, count);
 }
+
+bool task_on_rq(struct task_struct *p)
+{
+	return p->on_rq == TASK_ON_RQ_QUEUED;
+}
+
Index: linux-2.6/include/linux/sched.h
===================================================================
--- linux-2.6.orig/include/linux/sched.h
+++ linux-2.6/include/linux/sched.h
@@ -232,6 +232,8 @@ extern void io_schedule_finish(int token
 extern long io_schedule_timeout(long timeout);
 extern void io_schedule(void);
 
+extern bool task_on_rq(struct task_struct *p);
+
 /**
  * struct prev_cputime - snapshot of system and user cputime
  * @utime: time spent in user mode
Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -324,8 +324,6 @@ void tick_nohz_full_kick_cpu(int cpu)
 
 static void tick_nohz_kick_task(struct task_struct *tsk)
 {
-	int cpu = task_cpu(tsk);
-
 	/*
 	 * If the task concurrently migrates to another cpu,
 	 * we guarantee it sees the new tick dependency upon
@@ -340,6 +338,23 @@ static void tick_nohz_kick_task(struct t
 	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
 	 *      LOAD p->tick_dep_mask           LOAD p->cpu
 	 */
+	int cpu = task_cpu(tsk);
+
+	/*
+	 * If the task is not running, run_posix_cpu_timers
+	 * has nothing to elapsed, can spare IPI in that
+	 * case.
+	 *
+	 * activate_task()                      STORE p->tick_dep_mask
+	 * STORE p->task_on_rq
+	 * __schedule() (switch to task 'p')    smp_mb() (atomic_fetch_or())
+	 * LOCK rq->lock                        LOAD p->task_on_rq
+	 * smp_mb__after_spin_lock()
+	 * tick_nohz_task_switch()
+	 *	LOAD p->tick_dep_mask
+	 */
+	if (!task_on_rq(tsk))
+		return;
 
 	preempt_disable();
 	if (cpu_online(cpu))


