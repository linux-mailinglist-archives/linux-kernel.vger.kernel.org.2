Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E79D3372D7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhCKMiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:38:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhCKMhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 042A964FE7;
        Thu, 11 Mar 2021 12:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466251;
        bh=8ELDtlVQiqEuL1suAV+av1PZS+HMDd8m28xNQesUPg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8SgpFKlTs70Z1OIaiCAJpQO+kVAv0X/ccL4B04KkwdtPZ5WdN5coqwMHcyxZfa3z
         a72oi9VPWEmfTOoedO0ERZf1T7QUqh4GlVGACE9dQbev53XYWhxbLJ/u7kIse250mx
         ftMJr9nfnYhXrTw2n1Mw0AisfZtBAoRa9UBStmgsh4O4V4ls4Y5yu3pXNcSeXvbQsI
         ed5pmSWM0Vt+AtEs6xTnKWg91ytAf0wPmYawfMdYPaqT9otZk83xkSF3nj+TpHyLUL
         eJc6w1eZBfAq86mBOeO5jriJENM/rWuEFL7uiHQ9pJunedTlMFak0oxddRBlzyzjLw
         WlnUfzz0jJBfA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 06/10] timer: Report ignored local enqueue in nohz mode
Date:   Thu, 11 Mar 2021 13:37:04 +0100
Message-Id: <20210311123708.23501-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enqueuing a local timer after the tick has been stopped will result in
the timer being ignored until the next random interrupt.

Perform sanity checks to report these situations.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ca2bb629595f..24552911f92b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -674,6 +674,22 @@ int get_nohz_timer_target(void)
 	return cpu;
 }
 
+/* Make sure the timer won't be ignored in dynticks-idle case */
+static void wake_idle_assert_possible(void)
+{
+#ifdef CONFIG_SCHED_DEBUG
+	/*
+	 * Timers are re-evaluated after idle IRQs. In case of softirq,
+	 * we assume IRQ tail. Ksoftirqd shouldn't reach here as the
+	 * timer base wouldn't be idle. And inline softirq processing
+	 * after a call to local_bh_enable() within idle loop sound too
+	 * fun to be considered here.
+	 */
+	WARN_ONCE(in_task(),
+		  "Late timer enqueue may be ignored\n");
+#endif
+}
+
 /*
  * When add_timer_on() enqueues a timer into the timer wheel of an
  * idle CPU then this timer might expire before the next timer event
@@ -688,8 +704,10 @@ static void wake_up_idle_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (cpu == smp_processor_id())
+	if (cpu == smp_processor_id()) {
+		wake_idle_assert_possible();
 		return;
+	}
 
 	if (set_nr_and_not_polling(rq->idle))
 		smp_send_reschedule(cpu);
-- 
2.25.1

