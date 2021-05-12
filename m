Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C5937F00C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbhELXnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:43:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243859AbhELXbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:31:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 649F161422;
        Wed, 12 May 2021 23:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862198;
        bh=3fz5BofiLwGklpy95vjpqa7LwyP+2JMCDTjmeNg+bzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4SUztFxNadOOIonV+DrtoU85gNWMtFO1qL+luodfz9uOAfSUnZ6rkd6synM3NNzz
         kGXmV9yI+QubrG7I3HNjo7JueYMEaTeWurtp2AwB+sxHcNEUnl76QChgyidwMjtGex
         +df+t29CQ8KrXIaQHU2gIPeFtlGj2rsrQpJj05lFQy6GwQmQbxu7P3q83GFTY8bSCx
         Scl6FPzx/bJPaSSoM1d4KLi2hkWYA4zjtV8NQ+6LxxKaFdnyTjMwE31SB3O3fsBwek
         IRRNA3QcE/cdmscWSuBbxdVJT99w+R5bKMQBn8aeAzKIY3G78CVHR9FCHEUgLAQA+j
         ler6ZvqGOYkFw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 09/10] tick/nohz: Call tick_nohz_task_switch() with interrupts disabled
Date:   Thu, 13 May 2021 01:29:23 +0200
Message-Id: <20210512232924.150322-10-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Call tick_nohz_task_switch() slightly earlier after the context switch
to benefit from disabled IRQs. This way the function doesn't need to
disable them once more.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/sched/core.c      | 2 +-
 kernel/time/tick-sched.c | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 78e480f7881a..8f86ac28877e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4212,6 +4212,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
+	tick_nohz_task_switch();
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
@@ -4257,7 +4258,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		put_task_struct_rcu_user(prev);
 	}
 
-	tick_nohz_task_switch();
 	return rq;
 }
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index d370a04deaa8..b748a71d8040 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -487,13 +487,10 @@ void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bi
  */
 void __tick_nohz_task_switch(void)
 {
-	unsigned long flags;
 	struct tick_sched *ts;
 
-	local_irq_save(flags);
-
 	if (!tick_nohz_full_cpu(smp_processor_id()))
-		goto out;
+		return;
 
 	ts = this_cpu_ptr(&tick_cpu_sched);
 
@@ -502,8 +499,6 @@ void __tick_nohz_task_switch(void)
 		    atomic_read(&current->signal->tick_dep_mask))
 			tick_nohz_full_kick();
 	}
-out:
-	local_irq_restore(flags);
 }
 
 /* Get the boot-time nohz CPU list from the kernel parameters. */
-- 
2.25.1

