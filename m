Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F0D307FA9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhA1U0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:26:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59991 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231154AbhA1UZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611865442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=09rgXsilTnae6yAI2+7X50tmB4yjigjLFKTbsUMux9E=;
        b=FP77sg8k1DJmCD6VkmYjyFY8o9s0GLqDiNtGmcch/pQIyCiM8J+EWZ5vP4Cw8N61mxsTvN
        uEOze99h09Zqnfw/k2U13STHD9sRN9dGg6gHUcvx9/GH8CrtfAUFGxTWKMiHODItn1WAlp
        ZQRMuDmQtI/fTNbeiCh1vlKPVseNXBg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-ERh-iRLwPrKqEYWt_23fTg-1; Thu, 28 Jan 2021 15:24:00 -0500
X-MC-Unique: ERh-iRLwPrKqEYWt_23fTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74B03107ACE3;
        Thu, 28 Jan 2021 20:23:59 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B1425D9EF;
        Thu, 28 Jan 2021 20:23:59 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 122924178900; Thu, 28 Jan 2021 17:23:35 -0300 (-03)
Message-ID: <20210128202235.818590134@fuller.cnet>
User-Agent: quilt/0.66
Date:   Thu, 28 Jan 2021 17:21:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/3] nohz: only wakeup a single target cpu when kicking a task
References: <20210128202134.608115362@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a tick dependency to a task, its necessary to
wakeup the CPU where the task resides to reevaluate tick
dependencies on that CPU.

However the current code wakes up all nohz_full CPUs, which 
is unnecessary.

Switch to waking up a single CPU, by using ordering of writes
to task->cpu and task->tick_dep_mask.

From: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

Index: linux-2.6/kernel/time/tick-sched.c
===================================================================
--- linux-2.6.orig/kernel/time/tick-sched.c
+++ linux-2.6/kernel/time/tick-sched.c
@@ -322,6 +322,31 @@ void tick_nohz_full_kick_cpu(int cpu)
 	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
 }
 
+static void tick_nohz_kick_task(struct task_struct *tsk)
+{
+	int cpu = task_cpu(tsk);
+
+	/*
+	 * If the task concurrently migrates to another cpu,
+	 * we guarantee it sees the new tick dependency upon
+	 * schedule.
+	 *
+	 *
+	 * set_task_cpu(p, cpu);
+	 *   STORE p->cpu = @cpu
+	 * __schedule() (switch to task 'p')
+	 *   LOCK rq->lock
+	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
+	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
+	 *      LOAD p->tick_dep_mask           LOAD p->cpu
+	 */
+
+	preempt_disable();
+	if (cpu_online(cpu))
+		tick_nohz_full_kick_cpu(cpu);
+	preempt_enable();
+}
+
 /*
  * Kick all full dynticks CPUs in order to force these to re-evaluate
  * their dependency on the tick and restart it if necessary.
@@ -404,19 +429,8 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_cp
  */
 void tick_nohz_dep_set_task(struct task_struct *tsk, enum tick_dep_bits bit)
 {
-	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask)) {
-		if (tsk == current) {
-			preempt_disable();
-			tick_nohz_full_kick();
-			preempt_enable();
-		} else {
-			/*
-			 * Some future tick_nohz_full_kick_task()
-			 * should optimize this.
-			 */
-			tick_nohz_full_kick_all();
-		}
-	}
+	if (!atomic_fetch_or(BIT(bit), &tsk->tick_dep_mask))
+		tick_nohz_kick_task(tsk);
 }
 EXPORT_SYMBOL_GPL(tick_nohz_dep_set_task);
 


