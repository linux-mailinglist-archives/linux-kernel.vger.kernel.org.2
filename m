Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B685239B7F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 13:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFDLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 07:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhFDLdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 07:33:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 324B7613FE;
        Fri,  4 Jun 2021 11:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622806326;
        bh=UWTB2JFFGx0hcRAEvHxRwyTX7+TIbdrCudgu0abih/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cq9TMtMHx0mYceKQb9ptwNprxG0ZFt5uFO26KIYexU9b5z4f0wu0f2viwiEMXjUiV
         4iU4gogV+Y5kZE7beYbv60i3Aotp2VGzICptpE1FRRfU2M2CZj+LzjKcMLOddartIV
         8jnz+1fHahJQVrxolHNdoui7E5232hYJz/ha+DsNkNUYrbti4Y4ST5OefKIRkoxLCl
         IRCjS27wL0uyFEU1P/Z+o6NrZ72Bsm1JZhmRmG3HIL/6aRYYatMB17J3ADUfpnbeR7
         gWpclEjsw2x9lZx10gODV7iLxEwgfLreHP8Qtqi+cNB9BXNu0c5VFVGcluVdn2HEoF
         cVzqycb+py4mQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 1/6] posix-cpu-timers: Fix rearm racing against process tick
Date:   Fri,  4 Jun 2021 13:31:54 +0200
Message-Id: <20210604113159.26177-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604113159.26177-1-frederic@kernel.org>
References: <20210604113159.26177-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the process wide cputime counter is started locklessly from
posix_cpu_timer_rearm(), it can be concurrently stopped by operations
on other timers from the same thread group, such as in the following
unlucky scenario:

         CPU 0                                CPU 1
         -----                                -----
                                           timer_settime(TIMER B)
   posix_cpu_timer_rearm(TIMER A)
       cpu_clock_sample_group()
           (pct->timers_active already true)

                                           handle_posix_cpu_timers()
                                               check_process_timers()
                                                   stop_process_timers()
                                                       pct->timers_active = false
       arm_timer(TIMER A)

   tick -> run_posix_cpu_timers()
       // sees !pct->timers_active, ignore
       // our TIMER A

Fix this with simply locking process wide cputime counting start and
timer arm in the same block.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
---
 kernel/time/posix-cpu-timers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 3bb96a8b49c9..aa52fc85dbcb 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -991,6 +991,11 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 	if (!p)
 		goto out;
 
+	/* Protect timer list r/w in arm_timer() */
+	sighand = lock_task_sighand(p, &flags);
+	if (unlikely(sighand == NULL))
+		goto out;
+
 	/*
 	 * Fetch the current sample and update the timer's expiry time.
 	 */
@@ -1001,11 +1006,6 @@ static void posix_cpu_timer_rearm(struct k_itimer *timer)
 
 	bump_cpu_timer(timer, now);
 
-	/* Protect timer list r/w in arm_timer() */
-	sighand = lock_task_sighand(p, &flags);
-	if (unlikely(sighand == NULL))
-		goto out;
-
 	/*
 	 * Now re-arm for the new expiry time.
 	 */
-- 
2.25.1

