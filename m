Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEEB307E76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhA1StM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:49:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232222AbhA1SqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611859486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=5vne8wHUq5hbUZWHYRODtXy1278qohKUG5a1mgyB57Q=;
        b=ZWmIqxDjepU7gb0ORP9yTfFgbHbHtIVpIhYF46Oh5Rrc508NDIcQSvmgqWHG8gD7q3oUVd
        OV5YVqUVpLvis5XZDPmBYV0fWSjkbTTZXoIGBk1iXP0fHKHkzdiAbeSTBFf8Wlzlab6RTw
        9c5fflh3HzNrkg7Lj7W4OQr5Wj+c5xg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-3mUEV99JOU2B8Sm7kA9n-Q-1; Thu, 28 Jan 2021 13:44:45 -0500
X-MC-Unique: 3mUEV99JOU2B8Sm7kA9n-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E61FF1005504;
        Thu, 28 Jan 2021 18:44:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3D076064B;
        Thu, 28 Jan 2021 18:44:42 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id EB8394178902; Thu, 28 Jan 2021 15:44:20 -0300 (-03)
Message-ID: <20210128184346.813609683@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 28 Jan 2021 15:40:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 3/3] nohz: tick_nohz_kick_task: only IPI if remote task is running
References: <20210128184048.287626221@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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


