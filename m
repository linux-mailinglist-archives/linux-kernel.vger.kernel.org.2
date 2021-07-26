Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52CE3D59E8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhGZMPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:15:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234253AbhGZMPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:15:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67F9560F5A;
        Mon, 26 Jul 2021 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627304134;
        bh=XhUXPxfVOF86A5OSbHxe04kZCLxiI82+xaSaIBr5W0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RrlEdi/kvE3z3UwNLh0lIGqYBXXsorn+WBeFRwBhsEa9a+gxFTSM5i+G+1enFyExa
         ij8tY4tINvXnFmlHj9UQ36//YPC+hWVGWh0ObwnWxlq5yM3vuhWrKM4QnpNQ7L3oIY
         t0/0IAsun4dOTzimzh1Gp2i10IQ54Jc2XySQwRo+WyLt72UNsQFYgRalAMpGmGxCS1
         r+x3l7q2GN2RR9Nt/ooj65Mjc90vuI8aqOlNj0VYpFrPUZ3g7hJxHl6FG1ZRZhjm0c
         CLb1UGPH1Bu11XjenvoZ8sRwfElcJODyU3VxqK7SpVci65htTdvy42bvGlx/MhLUZd
         yJS9GSwL9bqEA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH 5/6] posix-cpu-timers: Consolidate timer base accessor
Date:   Mon, 26 Jul 2021 14:55:12 +0200
Message-Id: <20210726125513.271824-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726125513.271824-1-frederic@kernel.org>
References: <20210726125513.271824-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the ad-hoc timer base accessors and provide a consolidated one.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 4fbbbc89ac4a..0d918117a3e0 100644
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

