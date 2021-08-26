Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70433F891D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbhHZNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:38:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbhHZNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:38:28 -0400
Date:   Thu, 26 Aug 2021 15:37:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629985059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6KKIsy+VNSNCkJS29DwC5EEGaQjlJ9+X5HNh+t7xyKY=;
        b=yNpO8R0BKd6T417cNFvJC2omDdFLqqgohPWtjRZTaPk/TV/em8uxQ8Ni1U82Ov1cOcHzhv
        YdhZqoPUqlHuTvDHasWuLuNP6WBFValNfKvNjqVe10CgomdqKrMHQ1TFFmTahkUHHACU6l
        5OvoanKMAulg3JnW7I6KULqJ4DVyCOBMuKWcLNjlds7YlrW0DYrCCYwyUJmLr3QiriYonL
        8CdJPrUOekSMPaCF4oRQwD/571d7zT9PJgKAvyxq3ulTQ8OiQONJhHRvJAYOlR4G49T8lx
        GXTZGm+DDITPYBhBMg+ZirQm+BvZidoapUMufZi9fL+QtgUEXB/PxnfegAV77g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629985059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=6KKIsy+VNSNCkJS29DwC5EEGaQjlJ9+X5HNh+t7xyKY=;
        b=U1u7iwswsWiidNgdbhsGYKceZMXHMdTydtgkTKhoS0bhNdhufAmlG2toHykdAnAai5UD5p
        BJtDtyZK6QeKu0Bg==
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
Subject: [PATCH] sched: Fix get_push_task() vs migrate_disable()
Message-ID: <20210826133738.yiotqbtdaxzjsnfj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

push_rt_task() attempts to move the currently running task away if the
next runnable task has migration disabled and therefore is pinned on the
current CPU.

The current task is retrieved via get_push_task() which only checks for
nr_cpus_allowed == 1, but does not check whether the task has migration
disabled and therefore cannot be moved either. The consequence is a
pointless invocation of the migration thread which correctly observes
that the task cannot be moved.

Return NULL if the task has migration disabled and cannot be moved to
another CPU.

Fixes: a7c81556ec4d3 ("sched: Fix migrate_disable() vs rt/dl balancing")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/sched.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e205b63d6db07..32a4945730a9b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2259,6 +2259,9 @@ static inline struct task_struct *get_push_task(struct rq *rq)
 	if (p->nr_cpus_allowed == 1)
 		return NULL;
 
+	if (p->migration_disabled)
+		return NULL;
+
 	rq->push_busy = true;
 	return get_task_struct(p);
 }
-- 
2.33.0

