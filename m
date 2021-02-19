Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3F31F94C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhBSMRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:17:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229681AbhBSMRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:17:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70E7464E4B;
        Fri, 19 Feb 2021 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613737010;
        bh=ef9ld/jUIIITmvNh9Iwq7dWVJqG4UovRPT/9I/w+vzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Amtc2gmUW+ggX56i8J7yZ23KQBjPdd4/Pwy5DVkrNzQBWHui0E6Cv+wxCC9WQapgt
         Rwwux56cpSBaHb0dApsZTTPLr5xvFtkYyBt6dSahgtyy5tpYlicasnIBBV337Q8cKi
         cyvC2Edar7ea7mfJNK0c+9PIaLDUumgpQ0KQU/E6C7CGrz69bW2fPOKoZzzE5ktOyz
         4RD1IwGIId+ypWDB3bpf2NgkJa1d/k2F905yAwpiJ06QnC061MpNtc9VeJ66TQUamr
         7ikg+IcyVm2nV4t9uuMvqF339NYQdcXZI9J4Y/NkoXvA3iBQI9BgVDRsC7bZMPFS7V
         7URBFSnPOwOYw==
Date:   Fri, 19 Feb 2021 13:16:47 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: nohz: Update tick instead of restarting tick in
 tick_nohz_idle_exit()
Message-ID: <20210219121647.GB51281@lothringen>
References: <66014fea-7b84-358b-137d-d15190241528@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66014fea-7b84-358b-137d-d15190241528@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 09:22:08PM +0800, Yunfeng Ye wrote:
> In realtime scenarios, the "nohz_full" parameter is configured. Tick
> interference is not expected when there is only one realtime thread.
> But when the idle thread is switched to the realtime thread, the tick
> timer is restarted always.
> 
> So on the nohz full mode, it is unnecessary to restart the tick timer
> when there is only one realtime thread. Adding can_stop_full_tick()
> before restarting the tick, if it return true, keep tick stopped.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Hi,

After reworking the codebase a bit, I've edited your patch and
changelog and then queued it. I'll post it in a series after the
merge window. See the result:

---
From: Yunfeng Ye <yeyunfeng@huawei.com>
Date: Tue, 9 Feb 2021 23:59:19 +0100
Subject: [PATCH] tick/nohz: Conditionally restart tick on idle exit

In nohz_full mode, switching from idle to a task will unconditionally
issue a tick restart. If the task is alone in the runqueue or is the
highest priority, the tick will fire once then eventually stop. But that
alone is still undesired noise.

Therefore, only restart the tick on idle exit when it's strictly
necessary.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 3e272490fe2e..79796286a4ba 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -923,24 +923,28 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	tick_nohz_restart(ts, now);
 }
 
-static void tick_nohz_full_update_tick(struct tick_sched *ts)
+static void __tick_nohz_full_update_tick(struct tick_sched *ts,
+					 ktime_t now)
 {
 #ifdef CONFIG_NO_HZ_FULL
-	int cpu;
+	int cpu = smp_processor_id();
 
+	if (can_stop_full_tick(cpu, ts))
+		tick_nohz_stop_sched_tick(ts, cpu);
+	else if (ts->tick_stopped)
+		tick_nohz_restart_sched_tick(ts, now);
+#endif
+}
+
+static void tick_nohz_full_update_tick(struct tick_sched *ts)
+{
 	if (!tick_nohz_full_this_cpu())
 		return;
 
 	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
-	cpu = smp_processor_id();
-
-	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, cpu);
-	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
-#endif
+	__tick_nohz_full_update_tick(ts, ktime_get());
 }
 
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
@@ -1210,18 +1214,24 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #endif
 }
 
-static void __tick_nohz_idle_restart_tick(struct tick_sched *ts, ktime_t now)
+void tick_nohz_idle_restart_tick(void)
 {
-	tick_nohz_restart_sched_tick(ts, now);
-	tick_nohz_account_idle_ticks(ts);
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	if (ts->tick_stopped) {
+		tick_nohz_restart_sched_tick(ts, ktime_get());
+		tick_nohz_account_idle_ticks(ts);
+	}
 }
 
-void tick_nohz_idle_restart_tick(void)
+static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 {
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	if (tick_nohz_full_this_cpu())
+		__tick_nohz_full_update_tick(ts, now);
+	else
+		tick_nohz_restart_sched_tick(ts, now);
 
-	if (ts->tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, ktime_get());
+	tick_nohz_account_idle_ticks(ts);
 }
 
 /**
@@ -1253,7 +1263,7 @@ void tick_nohz_idle_exit(void)
 		tick_nohz_stop_idle(ts, now);
 
 	if (tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, now);
+		tick_nohz_idle_update_tick(ts, now);
 
 	local_irq_enable();
 }
-- 
2.25.1

