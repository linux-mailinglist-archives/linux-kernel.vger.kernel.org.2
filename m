Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D2535EAC1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241565AbhDNCXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhDNCXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:23:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FEFC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:22:54 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id l131so14035632oih.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bUWQOMJ96PoYWOLH0fkfiPVKgABX0K+anxlEDeI/Qg=;
        b=fALajJhCjE651tZQn4n8kZ0nCYCn7m9uuoIUFn2aRTN8ihjoiH+sUfnWPgDPEaCzec
         sdI5Gxt8sIQwVH6CHxDhimR0Wgujf/INZA4TNZ5ZqwmThe3yATwb0DyGj6Ec9VELK16Z
         JML8l0h1gt36tV4dna877lE4WvUnbqzORoQgEwtjq2J2waZjfuhBCJcyccPJJYLLHNTp
         4I6kBVd2yeJEEJBsH6P6U8QUebkFiPr3/nyk0saa6pOy+JXrlpeoCYFLL1I+2U/Umwnv
         A3N0sc97howmVDQ2cXjf6m4uCIOy7mE0XDxEBw3PI1d2ana6QtrLuuBjhfI7VKFczX2W
         QojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bUWQOMJ96PoYWOLH0fkfiPVKgABX0K+anxlEDeI/Qg=;
        b=QW8ZPFJwbHQutex53cgIVceC6RcgnRNehfAS3cI38SfEqP+HJp4qGEfe0GYtSQ8JG2
         wwIYqg3TyZPjbYntYrBxiWR3RM/vBQkoR4WeHFj/gJFurm5lZfCGoj3SSrcRn0jwlwR3
         3/9ygSHQUpc7n4vFvttIRwdsuL9x1wECfC8nnbq9Ha655YIw2lXEg5oRc9hBONr7AF/y
         RFJkayLEMbWFhZHVDrZ558sAhsfuC+juXB35lmWJoWZC13UpynMF42OV/hrJYK5IgeuQ
         O61abbUXg5JYz6ZEMjyemXaIae8vswYwxGKOA3VIfLet/S5Jo9xGp+eaQ7HuVmTDKNZ7
         bbhg==
X-Gm-Message-State: AOAM531c0T6J8rrsJKrbJ1+1fwxM3rBeIy9mAS1hZsUiB7AXkppIGvgk
        lGMsVwJcHO7AoSQPSf32d3ClAnaXldgbRf0n
X-Google-Smtp-Source: ABdhPJzCOho9gR1xs9yKINv72Nw0HQmbucdL2Qk3sdFZ54orn4/Z3RP6rE9UmM3b/G8IACw1MkmjBQ==
X-Received: by 2002:aca:b807:: with SMTP id i7mr642266oif.98.1618366973543;
        Tue, 13 Apr 2021 19:22:53 -0700 (PDT)
Received: from localhost.localdomain ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id j20sm3196627ooc.29.2021.04.13.19.22.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Apr 2021 19:22:53 -0700 (PDT)
From:   qianjun.kernel@gmail.com
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, jun qian <qianjun.kernel@gmail.com>
Subject: [PATCH V2 1/1] sched/fair:Reduce unnecessary check preempt in the sched tick
Date:   Wed, 14 Apr 2021 10:22:29 +0800
Message-Id: <20210414022229.5469-1-qianjun.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: jun qian <qianjun.kernel@gmail.com>

As you are already set the TIF_NEED_RESCHED, there is no need
to check resched again.

Signed-off-by: jun qian <qianjun.kernel@gmail.com>
---
 kernel/sched/fair.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 794c2cb945f8..1a69b5fffe4a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4360,19 +4360,26 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	unsigned long ideal_runtime, delta_exec;
 	struct sched_entity *se;
+	struct rq *rq = rq_of(cfs_rq);
 	s64 delta;
 
 	ideal_runtime = sched_slice(cfs_rq, curr);
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
 	if (delta_exec > ideal_runtime) {
-		resched_curr(rq_of(cfs_rq));
+		if (!test_tsk_need_resched(rq->curr))
+			resched_curr(rq_of(cfs_rq));
 		/*
 		 * The current task ran long enough, ensure it doesn't get
 		 * re-elected due to buddy favours.
 		 */
 		clear_buddies(cfs_rq, curr);
 		return;
-	}
+	/*
+	 * If here with TIF_NEED_RESCHED already set from the early entity_tick,
+	 * there is no need to check again.
+	 */
+	} else if (test_tsk_need_resched(rq->curr))
+		return;
 
 	/*
 	 * Ensure that a task that missed wakeup preemption by a
-- 
2.18.2

