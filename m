Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2037F006
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 01:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240913AbhELXmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 19:42:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243702AbhELXa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 19:30:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 822AF61406;
        Wed, 12 May 2021 23:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620862187;
        bh=vgzOPxwF5J/8yoVDAAypxpfOWPQl3HfscfXeSAQl7GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anY51Jm4O5o4vUAWpQz4H9PPrJNqqqhjrTpDh06hgkrOCk7QEJBbFeGthc69x969H
         1quwbdZ1x4DAdc1nsRo1wMEPulDdvl+GQqBjpC5hB45A25NvLYZoE0dmnOMwvoMPzG
         GBUKKeXrQk4XxkkvICg8lrLq18q8GZei0dY7oZoQe1STmQ72e1FqwNiIddX+UbBMAV
         TPQTdc2MGIztF7zko1ufwVu31bW3YxY6vxp2l1knpwyLJpMC166FiTyCasi3ICngpa
         NFwMrnMOBOzS6KrNlC/bUx7+i3GLwJ3fUfXVT+E+4rvJMFWWxizSkMDldMr0b7I9fr
         72cO3wsG9Tx5A==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 04/10] tick/nohz: Update idle_exittime on actual idle exit
Date:   Thu, 13 May 2021 01:29:18 +0200
Message-Id: <20210512232924.150322-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210512232924.150322-1-frederic@kernel.org>
References: <20210512232924.150322-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

The idle_exittime field of tick_sched is used to record the time when
the idle state was left. but currently the idle_exittime is updated in
the function tick_nohz_restart_sched_tick(), which is not always in idle
state when nohz_full is configured:

  tick_irq_exit
    tick_nohz_irq_exit
      tick_nohz_full_update_tick
        tick_nohz_restart_sched_tick
          ts->idle_exittime = now;

It's thus overwritten by mistake on nohz_full tick restart. Move the
update to the appropriate idle exit path instead.

Acked-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 1afa7595d1e0..89ec0abcd62b 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -921,8 +921,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	 * Cancel the scheduled timer and restore the tick
 	 */
 	ts->tick_stopped  = 0;
-	ts->idle_exittime = now;
-
 	tick_nohz_restart(ts, now);
 }
 
@@ -1194,10 +1192,13 @@ unsigned long tick_nohz_get_idle_calls(void)
 	return ts->idle_calls;
 }
 
-static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
+static void tick_nohz_account_idle_time(struct tick_sched *ts,
+					ktime_t now)
 {
 	unsigned long ticks;
 
+	ts->idle_exittime = now;
+
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
@@ -1218,8 +1219,9 @@ void tick_nohz_idle_restart_tick(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (ts->tick_stopped) {
-		tick_nohz_restart_sched_tick(ts, ktime_get());
-		tick_nohz_account_idle_ticks(ts);
+		ktime_t now = ktime_get();
+		tick_nohz_restart_sched_tick(ts, now);
+		tick_nohz_account_idle_time(ts, now);
 	}
 }
 
@@ -1230,7 +1232,7 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 	else
 		tick_nohz_restart_sched_tick(ts, now);
 
-	tick_nohz_account_idle_ticks(ts);
+	tick_nohz_account_idle_time(ts, now);
 }
 
 /**
-- 
2.25.1

