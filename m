Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5759A40680A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 09:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhIJH4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 03:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJH4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 03:56:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:55:06 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g184so1090951pgc.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 00:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=ud5nsy3x4vqodFGp3SJ1jgpGgfjSxfFrO/uXGKOTbO8=;
        b=H7Qdh1t61VM/XfXYYNmKrQCNhpOCzsrJJyDL6qjqXx2xRIrLnfrSgiGkuDnZ9DHuz3
         g/z2YGwsmkROS4UVwIG4JIE1DuDmzrTGiL18EyLzPHermX1BjBxo9vGmoHyw2QE0je1k
         8BqfVyBDb7NxEPl6x+5D1Smvb11+46A7al4Y2EaIQqSe0WCq8p23AnYgxJEFSqBX6cG3
         mQtzLWZpMzsOurjbs1z+KRtpnbzObNdkyE5V/tfbuTgH00V7bshTVU08aN9BSzY01vRo
         f93ksIOFJ+t6NkGvYZHXi3BdRDbN7C72NBFTaxPb3Yj4pil8GRSjmD5tdmBoPkTW7eIY
         Ahvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ud5nsy3x4vqodFGp3SJ1jgpGgfjSxfFrO/uXGKOTbO8=;
        b=SsvbmQl1TEWVX4HIY/aAIHFCuM+m9YljeVWhFbRnK4ZrG++87qwv6vLEFZMFFflxQj
         eGPKdU86ZN4ixqq9uE3eh5O/CRsvSaXcLWDlNOp4+yjnA6oaXlHlQdxPjNMp6N3jBApS
         CLOU6Tkas/+0W5DwaU9ySdWOj2faxQ/kvjbQ9jGI49YPAXo+fyq9wBniaWLuRXXJGvRH
         prUkKkhArLjKQtf5+NAZyhP5intNNQnwIFZf7CpC2N7goc+/MYo64DgN0p4o3PPtgZIZ
         c5+tU89bSX2H+LfVSmxFKNuOm9mc90IH31VdK+KBM1B0b/7kqUlmqstdzzlsGRffJHIy
         hj/A==
X-Gm-Message-State: AOAM531j6ZsCyaTR2BMFaezgp0PVnxQNEFchHbVpVjk98YpLTPRWnD1Z
        5cN2MNDxn/y3AQhTCSChoqod9yBNKlA=
X-Google-Smtp-Source: ABdhPJyZwLFdg34fD6CkmHFOd9FXUuEp+2y9uaeg5ptzP3xaY8Nqq93emkw4qAmSySPpa3BGIPOZ0Q==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr6257498pgl.198.1631260506172;
        Fri, 10 Sep 2021 00:55:06 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i10sm4367098pfk.87.2021.09.10.00.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Sep 2021 00:55:05 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com
Subject: [PATCH] psi : calc cfs task  memstall time more precisely
Date:   Fri, 10 Sep 2021 15:54:46 +0800
Message-Id: <1631260486-6735-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

cfs task's memstall time is counted as simple as exit - entry so far, which
ignore the preempted time by rt, dl and irq time. Eliminating them by calc the
time growth via the proportion of cfs_rq's utilization on the whole rq.

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

