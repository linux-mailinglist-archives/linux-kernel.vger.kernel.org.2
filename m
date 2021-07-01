Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B171F3B8F9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 11:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbhGAJRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 05:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235608AbhGAJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 05:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625130907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qYmLVSwQsoxW/LI3Jca9mE/i73rECB8RDmqgSdom1UE=;
        b=ROoWGAOFq7e2p7nS5c7BfX9OhQPobI/Y27/h+lo/OAguWpaSSqqmg5peitCUM8dqAwCcL4
        a7IGMASlJA/F6aPDufZj0mEvrDwHRk5P2cRLcBeCzLDrKpR96A4++ImCmkApM5GftGNTxT
        xuj4DOF2snjHeD+CK/0QtK1Xc+nzSLM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-pM5rK0DHP56gvHPM-u5OzA-1; Thu, 01 Jul 2021 05:15:06 -0400
X-MC-Unique: pM5rK0DHP56gvHPM-u5OzA-1
Received: by mail-wm1-f70.google.com with SMTP id 13-20020a1c010d0000b02901eca51685daso4292739wmb.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 02:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qYmLVSwQsoxW/LI3Jca9mE/i73rECB8RDmqgSdom1UE=;
        b=elLAtAatSficEgrpLruTfsfGvwg17AULfDYr87hYXfIxaj7uEntYg4oZnO19YTm4AL
         BxhxQxHrThPiVvHAWDcgYMZXGG+4loVhOcM8O5qL+H4z0AhSEMC2+MVAmOrH4xnqNG6h
         zgUrkM/M/f1SqgdTd6MCKvdq3gJ4SyYs7YocOuM29UYVjOCfUtGYMx5hPWdX8OCPbDzG
         zt5t4b8DmB292+FYs7t+NxlSdPv6nZBzqBfNMR3dvGZdlfNHqtwfN6cHW3iSILlMD3qT
         UcQcNssuCtAgvlB54zVBwtJxZHuy7G+EVjZrv7U3REPOuZHvx37MP8059T2jGe8XGXKs
         j9Xg==
X-Gm-Message-State: AOAM530q3LC6i75lByF61nk5txKxt5a4sTb842DlXwKeORgNkQXy13Nz
        o6NXkhyGC6NGmb9JvLndCXHNT8KAQC1wZiMYWoZ8kPbw5k4s1QpGwzuRtt0SXXbXrbanBtSAHgq
        zuVY0NzEXSia7Gv6HqSi4pF3e
X-Received: by 2002:a7b:c214:: with SMTP id x20mr7427331wmi.171.1625130902908;
        Thu, 01 Jul 2021 02:15:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySulriKhU2SRdcOItkxJvd8lG9zKgG0U4limY4EbmizTLpOibSwwhXZD6403DTxehbmDE7mg==
X-Received: by 2002:a7b:c214:: with SMTP id x20mr7427306wmi.171.1625130902597;
        Thu, 01 Jul 2021 02:15:02 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.51.230])
        by smtp.gmail.com with ESMTPSA id a16sm21340424wrx.72.2021.07.01.02.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 02:15:02 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, dietmar.eggemann@arm.com, bristot@redhat.com,
        bsegall@google.com, mgorman@suse.de,
        Juri Lelli <juri.lelli@redhat.com>,
        Mark Simmons <msimmons@redhat.com>
Subject: [PATCH] sched/rt: Fix double enqueue caused by rt_effective_prio
Date:   Thu,  1 Jul 2021 11:14:31 +0200
Message-Id: <20210701091431.256457-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Double enqueues in rt runqueues (list) have been reported while running
a simple test that spawns a number of threads doing a short sleep/run
pattern while being concurrently setscheduled between rt and fair class.

 ------------[ cut here ]------------
 WARNING: CPU: 3 PID: 2825 at kernel/sched/rt.c:1294 enqueue_task_rt+0x355/0x360
 ...
 CPU: 3 PID: 2825 Comm: setsched__13 Tainted: G S                5.12.0-rc3-rt3 #16
 Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/17/2018
 RIP: 0010:enqueue_task_rt+0x355/0x360
 Code: ...
 RSP: 0018:ffffa63209203e08 EFLAGS: 00010002
 RAX: 0000000000000031 RBX: ffff9867cb6298c0 RCX: ffff98679fc67ca0
 RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff98679fc67980
 RBP: ffff98679fc67740 R08: ffffffff85dcb3a8 R09: 0000000000000001
 R10: 0000000000000000 R11: ffffffff86268838 R12: ffff98679fc67740
 R13: ffff98679fc67740 R14: ffff9867cb629b40 R15: 000000000000000e
 FS:  00007f0ce9dbb500(0000) GS:ffff98679f8c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f0ce98ba650 CR3: 0000000240250003 CR4: 00000000001706e0
 Call Trace:
  __sched_setscheduler+0x581/0x9d0
  _sched_setscheduler+0x63/0xa0
  do_sched_setscheduler+0xa0/0x150
  __x64_sys_sched_setscheduler+0x1a/0x30
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f0ce98ba65b
 Code: ...
 RSP: 002b:00007ffea795ab88 EFLAGS: 00000217 ORIG_RAX: 0000000000000090
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0ce98ba65b
 RDX: 00007ffea795aba4 RSI: 0000000000000002 RDI: 0000000000000b08
 RBP: 00007ffea795abb0 R08: 00007ffea795c216 R09: 0000000000000000
 R10: 0000000000000003 R11: 0000000000000217 R12: 0000000000400500
 R13: 00007ffea795ac90 R14: 0000000000000000 R15: 0000000000000000
 ---[ end trace 0000000000000002 ]---

 list_add double add: new=ffff9867cb629b40, prev=ffff9867cb629b40, next=ffff98679fc67ca0.
 ------------[ cut here ]------------
 kernel BUG at lib/list_debug.c:31!
 invalid opcode: 0000 [#1] PREEMPT_RT SMP PTI
 CPU: 3 PID: 2825 Comm: setsched__13 Tainted: G S      W         5.12.0-rc3-rt3 #16
 Hardware name: HP ProLiant BL460c Gen9, BIOS I36 10/17/2018
 RIP: 0010:__list_add_valid+0x41/0x50
 Code: ...
 RSP: 0018:ffffa63209203e00 EFLAGS: 00010046
 RAX: 0000000000000058 RBX: ffff9867cb6298c0 RCX: 0000000000000003
 RDX: 0000000000000000 RSI: ffffffff85d4ff42 RDI: 00000000ffffffff
 RBP: ffff98679fc67740 R08: ffffffff86270480 R09: 00080000000000ff
 R10: 0000000079157392 R11: 0000000000000033 R12: ffff98679fc67740
 R13: ffff98679fc67740 R14: ffff9867cb629b40 R15: 0000000000000000
 FS:  00007f0ce9dbb500(0000) GS:ffff98679f8c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f0ce98ba650 CR3: 0000000240250003 CR4: 00000000001706e0
 Call Trace:
  enqueue_task_rt+0x291/0x360
  __sched_setscheduler+0x581/0x9d0
  _sched_setscheduler+0x63/0xa0
  do_sched_setscheduler+0xa0/0x150
  __x64_sys_sched_setscheduler+0x1a/0x30
  do_syscall_64+0x33/0x40
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f0ce98ba65b
 Code: ...
 RSP: 002b:00007ffea795ab88 EFLAGS: 00000217 ORIG_RAX: 0000000000000090
 RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0ce98ba65b
 RDX: 00007ffea795aba4 RSI: 0000000000000002 RDI: 0000000000000b08
 RBP: 00007ffea795abb0 R08: 00007ffea795c216 R09: 0000000000000000
 R10: 0000000000000003 R11: 0000000000000217 R12: 0000000000400500
 R13: 00007ffea795ac90 R14: 0000000000000000 R15: 0000000000000000
 ...
 ---[ end trace 0000000000000003 ]---

__sched_setscheduler() uses rt_effective_prio() to handle proper queuing
of priority boosted tasks that are setscheduled while being boosted.
rt_effective_prio() is however called twice per each
__sched_setscheduler() call: first directly by __sched_setscheduler()
before dequeuing the task and then by __setscheduler() to actually do
the priority change. If the priority of the pi_top_task is concurrently
being changed however, it might happen that the two calls return
different results. If, for example, the first call returned the same rt
priority the task was running at and the second one a fair priority, the
task won't be removed by the rt list (on_list still set) and then
enqueued in the fair runqueue. When eventually setscheduled back to rt
it will be seen as enqueued already and the WARNING/BUG be issued.

Fix this by calling rt_effective_prio() only once and then reusing the
return value. Concurrent priority inheritance handling is still safe and
will eventually converge to a new state by following the inheritance
chain(s).

Fixes: ff77e46853598 ("sched/rt: Fix PI handling vs. sched_setscheduler()")
Reported-by: Mark Simmons <msimmons@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
Hi,

Looks like this survives the test case (and regression testing), but I'm
still not fully convinced that the above statement "Concurrent priority
inheritance handling is still safe and will eventually converge to a new
state by following the inheritance chain(s)" is actually sound.

Please take a thorough look.

Best,
Juri
---
 kernel/sched/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0c22cd026440..c84ac1d675f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6823,7 +6823,8 @@ static void __setscheduler_params(struct task_struct *p,
 
 /* Actually do priority change: must hold pi & rq lock. */
 static void __setscheduler(struct rq *rq, struct task_struct *p,
-			   const struct sched_attr *attr, bool keep_boost)
+			   const struct sched_attr *attr, bool keep_boost,
+			   int new_effective_prio)
 {
 	/*
 	 * If params can't change scheduling class changes aren't allowed
@@ -6840,7 +6841,7 @@ static void __setscheduler(struct rq *rq, struct task_struct *p,
 	 */
 	p->prio = normal_prio(p);
 	if (keep_boost)
-		p->prio = rt_effective_prio(p, p->prio);
+		p->prio = new_effective_prio;
 
 	if (dl_prio(p->prio))
 		p->sched_class = &dl_sched_class;
@@ -6873,7 +6874,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int newprio = dl_policy(attr->sched_policy) ? MAX_DL_PRIO - 1 :
 		      MAX_RT_PRIO - 1 - attr->sched_priority;
 	int retval, oldprio, oldpolicy = -1, queued, running;
-	int new_effective_prio, policy = attr->sched_policy;
+	int new_effective_prio = newprio, policy = attr->sched_policy;
 	const struct sched_class *prev_class;
 	struct callback_head *head;
 	struct rq_flags rf;
@@ -7072,6 +7073,9 @@ static int __sched_setscheduler(struct task_struct *p,
 	oldprio = p->prio;
 
 	if (pi) {
+		newprio = fair_policy(attr->sched_policy) ?
+			NICE_TO_PRIO(attr->sched_nice) : newprio;
+
 		/*
 		 * Take priority boosted tasks into account. If the new
 		 * effective priority is unchanged, we just store the new
@@ -7093,7 +7097,7 @@ static int __sched_setscheduler(struct task_struct *p,
 
 	prev_class = p->sched_class;
 
-	__setscheduler(rq, p, attr, pi);
+	__setscheduler(rq, p, attr, pi, new_effective_prio);
 	__setscheduler_uclamp(p, attr);
 
 	if (queued) {
-- 
2.31.1

