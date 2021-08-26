Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677763F8CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243202AbhHZRFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:05:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33340 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhHZRE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:04:58 -0400
Date:   Thu, 26 Aug 2021 19:04:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629997450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dkZj13Jo0VKYnHOQS16fbhVTunVOmCAhR5rF/H/28DI=;
        b=ZMu8pqywonNw49cVn76Jp6NH6qLcWBBNNYT308KlFj63DC/MFFh6u440KlmFEyq4qMci4F
        yiAoZv+StbLkm1UyJ5Coj9KsLetKxpjE+ypPLLq27UqoDduIxRYjNdTX7jNGhh8G9Ydn8n
        MN1bT8tPO8JJIS/1STkVoynbGZpms/Q5udSeMrQijdlEcwze9rAXIFTAAzhHu8IbJAEX+0
        2KTpxhdPtn+JV93RhB7Mbm3B8KEu/u/Iy/r4kBQklLzDdR9GRUik3IRmDS3KX66MZunCyQ
        D2H+OZ5hNFqL0ZpJuBpTTkV6A88U8dUjqwW8MIVugAzlCt2CBeDfIc2fQkLBIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629997450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dkZj13Jo0VKYnHOQS16fbhVTunVOmCAhR5rF/H/28DI=;
        b=jB3A7cGpUVRrWbFMTl0EHat/Fr8UeLZ7OdELRUhR9rCPcOy8F/5auuAIUB7M6VKqVamgJy
        ueZFxGpWXzkjmtCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] sched: Switch wait_task_inactive to HRTIMER_MODE_REL_HARD
Message-ID: <20210826170408.vm7rlj7odslshwch@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With PREEMPT_RT enabled all hrtimers callbacks will be invoked in
softirq mode unless they are explicitly marked as HRTIMER_MODE_HARD.
During boot kthread_bind() is used for the creation of per-CPU threads
and then hangs in wait_task_inactive() if the ksoftirqd is not
yet up and running.
The hang disappeared since commit
   26c7295be0c5e ("kthread: Do not preempt current task if it is going to call schedule()")

but enabling function trace on boot reliably leads to the freeze on boot
behaviour again.
The timer in wait_task_inactive() can not be directly used by a user
interface to abuse it and create a mass wake up of several tasks at the
same time leading to long sections with disabled interrupts.
Therefore it is safe to make the timer HRTIMER_MODE_REL_HARD.

Switch the timer to HRTIMER_MODE_REL_HARD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 02718b6c7732d..3fbde6bc21bb2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3081,7 +3081,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 			ktime_t to = NSEC_PER_SEC / HZ;
 
 			set_current_state(TASK_UNINTERRUPTIBLE);
-			schedule_hrtimeout(&to, HRTIMER_MODE_REL);
+			schedule_hrtimeout(&to, HRTIMER_MODE_REL_HARD);
 			continue;
 		}
 
-- 
2.33.0

