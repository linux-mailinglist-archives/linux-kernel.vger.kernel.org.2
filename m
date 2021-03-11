Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8A23372DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbhCKMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:38:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:59978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233362AbhCKMhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:37:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 538A164F8E;
        Thu, 11 Mar 2021 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615466259;
        bh=YhT4ZfDfikximjWV+HMU1tA5rnHSe7venEiAncjtcTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFPislG3zw00Fxk1C6+UQQy0SiTC2R1xeI1I4upL1Vut6jSdB4hPLcZna7sIeh0T2
         eMlSIb/0lAEiyFdp/NjNeDWhvMcmzyuPhFCra6dsS7STGNtOCuk6Fcx+6+4P0udZ69
         yNfN45adVTzZNBa1mpBbNEksRBzlOtqf53d6vCeWtHIgzdyV3dqGjMLkuIi82HmBBt
         rgaaSTG1OJxw2jMRjuGujZlTsBCFcnp2m0Av6Cd2MRwD6fGLo4bJQexIf2wrldpw/O
         Z+LSmvYKv5HB2tyc44jYAjMFfkO+V7Zkf2VZj6I1PWdjq/thfcF6KU/s9D15dFrIcE
         5S4EIZGqDzAWA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 09/10] tick/nohz: Change signal tick dependency to wakeup CPUs of member tasks
Date:   Thu, 11 Mar 2021 13:37:07 +0100
Message-Id: <20210311123708.23501-10-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311123708.23501-1-frederic@kernel.org>
References: <20210311123708.23501-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcelo Tosatti <mtosatti@redhat.com>

Rather than waking up all nohz_full CPUs on the system, only wakeup
the target CPUs of member threads of the signal.

Reduces interruptions to nohz_full CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h           |  8 ++++----
 kernel/time/posix-cpu-timers.c |  4 ++--
 kernel/time/tick-sched.c       | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index bfc96cbe955c..9e71ab1889aa 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -215,7 +215,7 @@ extern void tick_nohz_dep_set_task(struct task_struct *tsk,
 				   enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
-extern void tick_nohz_dep_set_signal(struct signal_struct *signal,
+extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
@@ -260,11 +260,11 @@ static inline void tick_dep_clear_task(struct task_struct *tsk,
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
-static inline void tick_dep_set_signal(struct signal_struct *signal,
+static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
-		tick_nohz_dep_set_signal(signal, bit);
+		tick_nohz_dep_set_signal(tsk, bit);
 }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit)
@@ -293,7 +293,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
-static inline void tick_dep_set_signal(struct signal_struct *signal,
+static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit) { }
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index a71758e34e45..932e0cb4b57b 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -523,7 +523,7 @@ static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
 	else
-		tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
+		tick_dep_set_signal(p, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 /*
@@ -1358,7 +1358,7 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 	if (*newval < *nextevt)
 		*nextevt = *newval;
 
-	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
+	tick_dep_set_signal(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 8457f15a5073..a866fd8e7bb5 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -444,9 +444,20 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_task);
  * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
  * per process timers.
  */
-void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits bit)
+void tick_nohz_dep_set_signal(struct task_struct *tsk,
+			      enum tick_dep_bits bit)
 {
-	tick_nohz_dep_set_all(&sig->tick_dep_mask, bit);
+	int prev;
+	struct signal_struct *sig = tsk->signal;
+
+	prev = atomic_fetch_or(BIT(bit), &sig->tick_dep_mask);
+	if (!prev) {
+		struct task_struct *t;
+
+		lockdep_assert_held(&tsk->sighand->siglock);
+		__for_each_thread(sig, t)
+			tick_nohz_kick_task(t);
+	}
 }
 
 void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bit)
-- 
2.25.1

