Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9DA3B10B9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 01:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbhFVXoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 19:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230004AbhFVXoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 19:44:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05D4761358;
        Tue, 22 Jun 2021 23:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624405334;
        bh=x14DBQuHi8zrg6SqxN0JvwP+Xd4ClaKj2rXfH3FJyZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dlli9HAzgWkyRhHDYsH6p1rjeJXv4B4ELwGsYXsyJ3yu9p4PyfmeCDyZ9GoB684Rq
         mrnIfNx4dtGpcxRcWkVpiMz2IweyLMcESck1cgHx1EHBkdV1VSzUSxxQ+2nKpGRIeW
         l1K2OisdWVMFUswZ0+qOzy2t5iTJKVhyE/Pv0dqVdpMpoa0ZMCUoB714/e13HUusbR
         ywKLfUfgv7OEnmTJ3SPl8/P/ciZnxaiYLPghjXaVCUmaDVEgxhyw+QDkfCfiNBE4QT
         WiZ95KtKTbB+FYMxUm7ea7Ny6cZ+NrONzCf453WC1G/ivg20RAigbisuxIEA+dJwxv
         dPWR0L07iBKqA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6/7] posix-cpu-timers: Consolidate timer base accessor
Date:   Wed, 23 Jun 2021 01:41:54 +0200
Message-Id: <20210622234155.119685-7-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210622234155.119685-1-frederic@kernel.org>
References: <20210622234155.119685-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ad-hoc timer base accessors and provide a consolidated one.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 1ac36e6ca6d6..acc6843d4b31 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -407,6 +407,17 @@ static int posix_cpu_timer_create(struct k_itimer *new_timer)
 	return 0;
 }
 
+static struct posix_cputimer_base *timer_base(struct k_itimer *timer,
+					      struct task_struct *tsk)
+{
+	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+
+	if (CPUCLOCK_PERTHREAD(timer->it_clock))
+		return tsk->posix_cputimers.bases + clkidx;
+	else
+		return tsk->signal->posix_cputimers.bases + clkidx;
+}
+
 /*
  * Dequeue the timer and reset the base if it was its earliest expiration.
  * It makes sure the next tick recalculates the base next expiration so we
@@ -421,18 +432,11 @@ static void disarm_timer(struct k_itimer *timer, struct task_struct *p)
 {
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	struct posix_cputimer_base *base;
-	int clkidx;
 
 	if (!cpu_timer_dequeue(ctmr))
 		return;
 
-	clkidx = CPUCLOCK_WHICH(timer->it_clock);
-
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		base = p->posix_cputimers.bases + clkidx;
-	else
-		base = p->signal->posix_cputimers.bases + clkidx;
-
+	base = timer_base(timer, p);
 	if (cpu_timer_getexpires(ctmr) == base->nextevt)
 		base->nextevt = 0;
 }
@@ -531,15 +535,9 @@ void posix_cpu_timers_exit_group(struct task_struct *tsk)
  */
 static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 {
-	int clkidx = CPUCLOCK_WHICH(timer->it_clock);
+	struct posix_cputimer_base *base = timer_base(timer, p);
 	struct cpu_timer *ctmr = &timer->it.cpu;
 	u64 newexp = cpu_timer_getexpires(ctmr);
-	struct posix_cputimer_base *base;
-
-	if (CPUCLOCK_PERTHREAD(timer->it_clock))
-		base = p->posix_cputimers.bases + clkidx;
-	else
-		base = p->signal->posix_cputimers.bases + clkidx;
 
 	if (!cpu_timer_enqueue(&base->tqhead, ctmr))
 		return;
-- 
2.25.1

