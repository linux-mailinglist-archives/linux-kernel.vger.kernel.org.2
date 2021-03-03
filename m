Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156A132C31F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbhCDAAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377246AbhCCTu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:50:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2859A64EBA;
        Wed,  3 Mar 2021 19:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614800986;
        bh=2wCTT0trV7CMjh58rRXKgJ7GpVI2VVAowjvnTfisdOU=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=b+8oZ4Fk8Pl7CUZi4mYb4jrUG9cWajmBsi5ca8v9B1JU5itny5YAJTdl54SW32DvY
         5bl7VsezXy7jZU4jXsbF5/KpCP5TGOLw9tg9VupHvNcrbGibi8t1kFwUW1ibdAic59
         +w7VraJ10BTvNb9nnSB5lBVQj5heF1za+fiQhK6TyJEBW+aOaiPdNlVNzGoPYjtyPE
         jxGuSI+Q/oS++qNbXTmvH2mzljzLZ7HIx7ZMpxR2apno0WFE+v2s08EA9x1C5fu17s
         InyEMQClT6U/YR7leKer2/dY5AU+0Kd3wT3LYX5eJpwf1SqPYR4ReZWdIPY1xB9ZHW
         vL5RUfCtc4qzg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E8BD635237A1; Wed,  3 Mar 2021 11:49:45 -0800 (PST)
Date:   Wed, 3 Mar 2021 11:49:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     frederic@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@kernel.org
Subject: timer: Report ignored local enqueue in nohz mode?
Message-ID: <20210303194945.GA20866@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Frederic!

I don't see the following commit in mainline, but figured I should
check with you guys to see if the problem got solved in some other way.
Unless I hear otherwise, I will continue to carry this patch in -rcu
and will send it along for the v5.13 merge window.

							Thanx, Paul

------------------------------------------------------------------------

commit 650c433b46ca9601378c9d170d5dc0e24dd42822
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Fri Jan 8 13:50:12 2021 +0100

    timer: Report ignored local enqueue in nohz mode
    
    Enqueuing a local timer after the tick has been stopped will result in
    the timer being ignored until the next random interrupt.
    
    Perform sanity checks to report these situations.
    
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Ingo Molnar<mingo@kernel.org>
    Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca2bb62..4822371 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -674,6 +674,26 @@ int get_nohz_timer_target(void)
 	return cpu;
 }
 
+static void wake_idle_assert_possible(void)
+{
+#ifdef CONFIG_SCHED_DEBUG
+	/* Timers are re-evaluated after idle IRQs */
+	if (in_hardirq())
+		return;
+	/*
+	 * Same as hardirqs, assuming they are executing
+	 * on IRQ tail. Ksoftirqd shouldn't reach here
+	 * as the timer base wouldn't be idle. And inline
+	 * softirq processing after a call to local_bh_enable()
+	 * within idle loop sound too fun to be considered here.
+	 */
+	if (in_serving_softirq())
+		return;
+
+	WARN_ON_ONCE("Late timer enqueue may be ignored\n");
+#endif
+}
+
 /*
  * When add_timer_on() enqueues a timer into the timer wheel of an
  * idle CPU then this timer might expire before the next timer event
@@ -688,8 +708,10 @@ static void wake_up_idle_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (cpu == smp_processor_id())
+	if (cpu == smp_processor_id()) {
+		wake_idle_assert_possible();
 		return;
+	}
 
 	if (set_nr_and_not_polling(rq->idle))
 		smp_send_reschedule(cpu);
