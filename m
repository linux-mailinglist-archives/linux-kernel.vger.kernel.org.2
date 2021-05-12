Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC237F005
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbhELXmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243629AbhELXav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:30:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2DCA361404;
        Wed, 12 May 2021 23:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862182;
        bh=MlnjlfDWU8WjcXYxH4r3Kr4foTTcI7rnl2+3Ou9at1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eFfXvkcSO0t0h16mCL8tdC+/Chsn5h/xi2jXH3N56+hkG28F8EcOEMqHEpo75P0Vo
         l8XT4uuAX19gEQTp9KevHTwqomDhNnjyggPKCgSscLs9xCtm2SQMQ6i7GSizerh1zA
         mKcV80HtEy6Slz6vmULx4JsAv7goOVUG0u+IxziQfMjJCPqOBjoAy+pPAw/+9vuCJM
         Vy+CU/wBOt4/Q9wDajmqdWEXFLhLqdj0HTvSuIqxCKLJlxrSPl/sd9q8JDoI/8/l7O
         h91xzXG8CCMmNDQLfVCGwhblPNfmCkSxiqBbQvREOS5mFFO6qsewXru0SL2g/YgP3D
         nSn1BFaX18LwA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 02/10] tick/nohz: Conditionally restart tick on idle exit
Date:   Thu, 13 May 2021 01:29:16 +0200
Message-Id: <20210512232924.150322-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

In nohz_full mode, switching from idle to a task will unconditionally
issue a tick restart. If the task is alone in the runqueue or is the
highest priority, the tick will fire once then eventually stop. But that
alone is still undesired noise.

Therefore, only restart the tick on idle exit when it's strictly
necessary.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 46 +++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091501ca..05c1ce1034d6 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -926,24 +926,30 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	tick_nohz_restart(ts, now);
 }
 
-static void tick_nohz_full_update_tick(struct tick_sched *ts)
+static void __tick_nohz_full_update_tick(struct tick_sched *ts,
+					 ktime_t now)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	int cpu = smp_processor_id();
 
-	if (!tick_nohz_full_cpu(cpu))
-		return;
-
-	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
-		return;
-
 	if (can_stop_full_tick(cpu, ts))
 		tick_nohz_stop_sched_tick(ts, cpu);
 	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
+		tick_nohz_restart_sched_tick(ts, now);
 #endif
 }
 
+static void tick_nohz_full_update_tick(struct tick_sched *ts)
+{
+	if (!tick_nohz_full_cpu(smp_processor_id()))
+		return;
+
+	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
+		return;
+
+	__tick_nohz_full_update_tick(ts, ktime_get());
+}
+
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 {
 	/*
@@ -1209,18 +1215,24 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #endif
 }
 
-static void __tick_nohz_idle_restart_tick(struct tick_sched *ts, ktime_t now)
-{
-	tick_nohz_restart_sched_tick(ts, now);
-	tick_nohz_account_idle_ticks(ts);
-}
-
 void tick_nohz_idle_restart_tick(void)
 {
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
-	if (ts->tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, ktime_get());
+	if (ts->tick_stopped) {
+		tick_nohz_restart_sched_tick(ts, ktime_get());
+		tick_nohz_account_idle_ticks(ts);
+	}
+}
+
+static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
+{
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		__tick_nohz_full_update_tick(ts, now);
+	else
+		tick_nohz_restart_sched_tick(ts, now);
+
+	tick_nohz_account_idle_ticks(ts);
 }
 
 /**
@@ -1252,7 +1264,7 @@ void tick_nohz_idle_exit(void)
 		tick_nohz_stop_idle(ts, now);
 
 	if (tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, now);
+		tick_nohz_idle_update_tick(ts, now);
 
 	local_irq_enable();
 }
-- 
2.25.1

