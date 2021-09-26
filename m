Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D694185FC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 05:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhIZD3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 23:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhIZD3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 23:29:36 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B91C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:28:01 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id me1so9802191pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=Orm3UeNHwghzj3N/xisLRG+91t3d+f7m71sow6oNdJA=;
        b=X6SLIpTlDoVQDM/NHlvsid9wBtoz7sfRJSazyL4YgTj8NZvWjoOHq8Zn8uKIo6VVcn
         nlqlumjDWwIiEb418ovlhqFNX2pl7ePJZO/UBcTq8FPmHlKD4rpGxufedADsMh3wRGZU
         M1J4gOlXpuwdn+639U1RVk/NmMaQAhhbKbqawA+eQXR6F/U/ZKxR+X4TL6e0cTi7UH3m
         Z5Jz2EO0czdnIcIB9RCP/7dzSMMJFrql6eI7g+oBRbnggh59OUg7yvdkvg7J4M14U/vR
         YfP1bNnQ+73Yam1VqRgCxiKDhl/o7TUzCOCgU8yvMYey9D2+p9vZrZvbYrpbILu0M7NI
         Qknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Orm3UeNHwghzj3N/xisLRG+91t3d+f7m71sow6oNdJA=;
        b=MOiFT1cZnUE5F8AOM829CJ1hwweieChvS5A17SBE2ccq0wyZGWCyW0/AEB5esUMsbt
         Z/DHrjGmTzXhHQu04UuZ2ga3o4w91+vFoaCA4kpH684p2balq0M3r40r1HN8TjDq8lF8
         N0AgdcyjA0eolBaS9PNsJJTvs/8zHNi1lj4UUhgRYpL8Tc3Y/bQEbLZe4b1pHE6IIyRV
         mfoGbYR0+I2FEWpvKe5WUDmRQVrCwnPW/keZZpGTGotLvOSycNWqBp+BZLvdEF/jcn4P
         BeABOeZAb8ErGCzRMoB9gbaRZmA6T0Vr7XImvpLOXvM1Z9Y9IBP4jHw58SWTguPpIrYd
         ZzrQ==
X-Gm-Message-State: AOAM532MC/9DEeCsT4LUn0+phZCzBGlAPPMpUO2z6n0BoeoxiHjzWKfy
        dRYGfDww0JBrtXo+aGwIfWs=
X-Google-Smtp-Source: ABdhPJxURf/JddHBdbheKzORXay3uy/+T9lHFyy2OH2d4SKLBor1vDh2/Wi3QbWP681YSvbDtjbhAg==
X-Received: by 2002:a17:90a:1942:: with SMTP id 2mr11561511pjh.36.1632626880873;
        Sat, 25 Sep 2021 20:28:00 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id x16sm14537878pgc.49.2021.09.25.20.27.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 20:28:00 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com
Subject: [Resend PATCH] psi : calc cfs task memstall time more precisely
Date:   Sun, 26 Sep 2021 11:27:16 +0800
Message-Id: <1632626836-27923-1-git-send-email-huangzhaoyang@gmail.com>
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

