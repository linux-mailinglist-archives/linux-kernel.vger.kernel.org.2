Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001A8367FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbhDVMC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:02:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236244AbhDVMCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:02:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4C246145E;
        Thu, 22 Apr 2021 12:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619092940;
        bh=YjbQ6faKUTBpcNjujmfpcQ+mwYGnB7kuNtVcFYwO6eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K60ceKmUSbnwaq/tTdePZr+dax0QcFK+IA+1F6INr1a6YnkTpIGXTXthiqIkjmhRQ
         VL3RD+dhkh2fRjngGJxGIPohEP6UyS85whiSFufrEKHAxv+LGJSMIOudWHudiwrbg0
         qTrrDo1Q2druOZxjJbWnE4xJJffPF1W16rJhA0XElj/UZUkPJs3Sb21eBHz6YFweVo
         LYjv1npSlPLWgKBwLduez7vGnopV5U65OVfJ/63lxjNbLhKGvHoKSwN6hxxjNoFX4q
         vQFqW2e9sm+cehTyMXjcNflv/4ANXpVLXXg8AVIEcphQormQS0iXzqD1IJepuYdbP1
         7ln5S1YlgqG7w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 7/8] tick/nohz: Change signal tick dependency to wakeup CPUs of member tasks
Date:   Thu, 22 Apr 2021 14:01:57 +0200
Message-Id: <20210422120158.33629-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210422120158.33629-1-frederic@kernel.org>
References: <20210422120158.33629-1-frederic@kernel.org>
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
index 2258984a0e8a..0bb80a7f05b9 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -211,7 +211,7 @@ extern void tick_nohz_dep_set_task(struct task_struct *tsk,
 				   enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
-extern void tick_nohz_dep_set_signal(struct signal_struct *signal,
+extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
@@ -256,11 +256,11 @@ static inline void tick_dep_clear_task(struct task_struct *tsk,
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
@@ -288,7 +288,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
-static inline void tick_dep_set_signal(struct signal_struct *signal,
+static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit) { }
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 9abe15255bc4..127255a73ea6 100644
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
index 45d9a4ea3ee0..ad5c3905196a 100644
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

