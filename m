Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4023B39B7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhFDLeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230207AbhFDLd6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:33:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF8BD6143C;
        Fri,  4 Jun 2021 11:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622806332;
        bh=ZGPSl0rtuIsFTTwz7Y4VHvVmhKstD6YjuuRg0hrelgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uCgm9GFX4blmZDW1qwvT7vdwaijAMa/85SzzGRi25ucPw7kTcX4quRtavaYfZ9opP
         BuF7/hBqgLr+k1k+S5GIYj1X+GSMIkQ/VnylzE6czNvImn4IuI0ryDlYW05LT52gGB
         ixSbcpqPZiLUFswAmzZL6VYANdW8S5CM6+WgMCA3X/Uhy70JrPkSKSlb7k+ztsojoP
         9ZI9nUzbSZLDyJhbqztvdGs5slXHFyQCCIiIyySro2KLIIS2lXicr7zrsh5aUq65xW
         IGKKHZcyo1uU+DAB8bQx+rWwj1R7AoLi2ebtfRuAi6oHfo/VuD/04SQWUW0z0ERsRk
         aF/P7sS0dJdVQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4/6] posix-cpu-timers: Force next_expiration recalc after timer reset
Date:   Fri,  4 Jun 2021 13:31:57 +0200
Message-Id: <20210604113159.26177-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604113159.26177-1-frederic@kernel.org>
References: <20210604113159.26177-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A timer reset only dequeues the timer but it doesn't shutdown
the related costly process wide cputimer counter and the tick dependency.

The following code snippet keeps this overhead around for one week after
the timer reset:

            void trigger_process_counter(void)
            {
                    timer_t id;
                    struct itimerspec val = { };

                    val.it_value.tv_sec = 1;
                    timer_create(CLOCK_PROCESS_CPUTIME_ID, NULL, &id);
                    timer_settime(id, 0, &val, NULL);
                    val.it_value.tv_sec = 0;
                    timer_settime(id, 0, &val, NULL);
            }

Make sure the next target's tick recalculates the nearest expiration and
clears the process wide counter and tick dependency if necessary.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index bb1f862c785e..0b5715c8db04 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -414,10 +414,14 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 old_expires = cpu_timer_getexpires(ctmr);
 	struct posix_cputimer_base *base;
+	bool queued;
 	int clkidx;
 
-	if (!cpu_timer_dequeue(ctmr))
+	queued = cpu_timer_dequeue(ctmr);
+	cpu_timer_setexpires(ctmr, 0);
+	if (!queued)
 		return;
 
 	clkidx = CPUCLOCK_WHICH(timer->it_clock);
@@ -427,7 +431,7 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 	else
 		base = p->signal->posix_cputimers.bases + clkidx;
 
-	if (cpu_timer_getexpires(ctmr) == base->nextevt)
+	if (old_expires == base->nextevt)
 		base->nextevt = 0;
 }
 
@@ -647,8 +651,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	if (unlikely(timer->it.cpu.firing)) {
 		timer->it.cpu.firing = -1;
 		ret = TIMER_RETRY;
-	} else {
-		cpu_timer_dequeue(ctmr);
 	}
 
 	/*
@@ -713,9 +715,13 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 	 * For a timer with no notification action, we don't actually
 	 * arm the timer (we'll just fake it for timer_gettime).
 	 */
-	cpu_timer_setexpires(ctmr, new_expires);
-	if (new_expires != 0 && val < new_expires) {
-		arm_timer(timer, p);
+	if (new_expires != 0) {
+		cpu_timer_dequeue(ctmr);
+		cpu_timer_setexpires(ctmr, new_expires);
+		if (val < new_expires)
+			arm_timer(timer, p);
+	} else {
+		disarm_timer(timer, p);
 	}
 
 	unlock_task_sighand(p, &flags);
-- 
2.25.1

