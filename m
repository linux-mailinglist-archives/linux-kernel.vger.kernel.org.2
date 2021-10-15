Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7916242E8D0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 08:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhJOGTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 02:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbhJOGTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 02:19:15 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC4CC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 23:17:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id gn3so996672pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=Orm3UeNHwghzj3N/xisLRG+91t3d+f7m71sow6oNdJA=;
        b=CKkg/YiO3XvCr+Zcpr88QGN42HIvqQgz+W9kRXFsHty6eTR9KbfoTy6YQHZ6php8AQ
         B1rDsUpraLSi7qP6UzJ+ycyNzDvgp2JJ5ZkD8DAhuhobKmgkE0m4j/kcasnp23uVnlo8
         t4ah4M8lA0CJQSoovEbY0VrX7QWSkLXI7o1tRTkvmCarTmhUhvLmJBzo5vUsOHcMmZpq
         eR4xx1me6mUAhv3/jAvb0OVzoGWbkkMKUJUxGDRm6fu40NvWitVxvASwdhtzSX35nS/9
         hhkUNPOab3Z/kD0HYNGZPJf35u/q6yI9/TpfNEHFgPirNf+Gg/0orVfkEKbbyCDGpKwO
         qQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Orm3UeNHwghzj3N/xisLRG+91t3d+f7m71sow6oNdJA=;
        b=tBrpfPPQ7VFVIhfeSQOz5IYs8WQRnQJm9lCLj4XzSjnRkKgZ/1IfR9OJaFx9/dg/tH
         SL1Lyi9gOqExqZe5RirPtTCj0wple4zLUBFj3y6wVzES8tKl/NouGWrX8hszefUacZR5
         Gz5Cso6U7JktgmZLkXJna9UlZl+BI7C1STE5L4fPATeWBvYafGFVmLvezNOAZNGJHDuY
         w+hk/cMQnORhRL8I2fqVSwaxl9xBe3GC1+XmAg9YvQpkdM1zkXW3SrpVwRy+xkghPqJn
         S+QgMTGA41o0oQm2wAJIU0nBTeoyfd7cxvFvSh1qxh3PLF3jfukK/2xMIvGozl4ETAad
         wMXg==
X-Gm-Message-State: AOAM532FoAAWyfgTgegeaoILwOyh25Ob/ny6p0eGFE0slHaaxJEt9dgh
        T3mDussKKdCjdaTj2BPh98MGOi/GiCk=
X-Google-Smtp-Source: ABdhPJzDLnq2OQWwwG/BVEjydEFPwpwL3SFgrjNa/2TKCLqyjwYcM8yEYoPrycVYPeTWEhQuFD/inA==
X-Received: by 2002:a17:902:9303:b029:12c:29c:43f9 with SMTP id bc3-20020a1709029303b029012c029c43f9mr9418992plb.5.1634278628867;
        Thu, 14 Oct 2021 23:17:08 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 197sm4056947pfv.6.2021.10.14.23.17.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Oct 2021 23:17:08 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [Resend PATCH] psi : calc cfs task memstall time more precisely
Date:   Fri, 15 Oct 2021 14:16:52 +0800
Message-Id: <1634278612-17055-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

In an EAS enabled system, there are two scenarios discordant to current design,

1. workload used to be heavy uneven among cores for sake of scheduler policy.
RT task usually preempts CFS task in little core.
2. CFS task's memstall time is counted as simple as exit - entry so far, which
ignore the preempted time by RT, DL and Irqs.

With these two constraints, the percpu nonidle time would be mainly consumed by
none CFS tasks and couldn't be averaged. Eliminating them by calc the time growth
via the proportion of cfs_rq's utilization on the whole rq.

eg.
Here is the scenario which this commit want to fix, that is the rt and irq consume
some utilization of the whole rq. This scenario could be typical in a core
which is assigned to deal with all irqs. Furthermore, the rt task used to run on
little core under EAS.

Binder:305_3-314    [002] d..1   257.880195: psi_memtime_fixup: original:30616,adjusted:25951,se:89,cfs:353,rt:139,dl:0,irq:18
droid.phone-1525    [001] d..1   265.145492: psi_memtime_fixup: original:61616,adjusted:53492,se:55,cfs:225,rt:121,dl:0,irq:15

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 kernel/sched/psi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..754a836 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -182,6 +182,8 @@ struct psi_group psi_system = {
 
 static void psi_avgs_work(struct work_struct *work);
 
+static unsigned long psi_memtime_fixup(u32 growth);
+
 static void group_init(struct psi_group *group)
 {
 	int cpu;
@@ -492,6 +494,21 @@ static u64 window_update(struct psi_window *win, u64 now, u64 value)
 	return growth;
 }
 
+static unsigned long psi_memtime_fixup(u32 growth)
+{
+	struct rq *rq = task_rq(current);
+	unsigned long growth_fixed = (unsigned long)growth;
+
+	if (!(current->policy == SCHED_NORMAL || current->policy == SCHED_BATCH))
+		return growth_fixed;
+
+	if (current->in_memstall)
+		growth_fixed = div64_ul((1024 - rq->avg_rt.util_avg - rq->avg_dl.util_avg
+					- rq->avg_irq.util_avg + 1) * growth, 1024);
+
+	return growth_fixed;
+}
+
 static void init_triggers(struct psi_group *group, u64 now)
 {
 	struct psi_trigger *t;
@@ -658,6 +675,7 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 	}
 
 	if (groupc->state_mask & (1 << PSI_MEM_SOME)) {
+		delta = psi_memtime_fixup(delta);
 		groupc->times[PSI_MEM_SOME] += delta;
 		if (groupc->state_mask & (1 << PSI_MEM_FULL))
 			groupc->times[PSI_MEM_FULL] += delta;
@@ -928,8 +946,8 @@ void psi_memstall_leave(unsigned long *flags)
 	 */
 	rq = this_rq_lock_irq(&rf);
 
-	current->in_memstall = 0;
 	psi_task_change(current, TSK_MEMSTALL, 0);
+	current->in_memstall = 0;
 
 	rq_unlock_irq(rq, &rf);
 }
-- 
1.9.1

