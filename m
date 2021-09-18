Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774A5410430
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 07:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbhIRF1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 01:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbhIRF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 01:27:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAA7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 22:26:07 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bg1so7509490plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 22:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id;
        bh=ud5nsy3x4vqodFGp3SJ1jgpGgfjSxfFrO/uXGKOTbO8=;
        b=HOLthhOpTFT7y8IqRwj6Us4XSuVF06cSOw8AOrqP2DRwUVvubqGuEf7tNY7w3ijPQe
         b93UVnhvy6iDRHpHjKjGEWA7ROLoRA4RWFRJB+hvlbWzQYQBtj51A/CnLZYwspfVdcvQ
         yQXK+KwX5+PQQVeUWKOOwChy1jicg9MF+aRkRZiGb9urIvRXz3x8g/GLFVdeXo151rsz
         iBpEO+nazfqVb0IR+Hb883UBZJ6imoOOeeEwgfZlDm5omZPfidnS8FZJ35ATZ+N0Y/a7
         mMKLAZIhjWif9TiZJrpEjcLpkZ9Ng2Rpak7DgDManeNssUYw8/1yhL5Q8fj/V5R0X71z
         yV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ud5nsy3x4vqodFGp3SJ1jgpGgfjSxfFrO/uXGKOTbO8=;
        b=OHk6q2OIaW4ov6RC8n32Y+eo0zmMbIEGlzwoe8mKnBosoiN2c+FmjQTenVPKvdKYlf
         p5xKznWEK8T2GmK20pVXDiVtn7rWfOxX2fuBKwmTfxc8ZTcZTrxkXsuaOe9c1T7nztqW
         ENKJi1+L7+2rGD5kmlKZeJWqtgWYw5vGydb8WxNWebcdIauESo0JIzKFnBt7TYFUGTD0
         F23NE5VDYsXUQnugOlphq/JHky6ZvRLIP529Ru+VvtUMYgt0wo8gzrYr01lggRjdGxph
         Qh+na9n1evn/nU5OamFFhr0D79M8J+QFhuDDuIgzHuOl397JFwlAHF4YtBdcL6gnLEXa
         SnWA==
X-Gm-Message-State: AOAM533h3iIHDiC2nU9PFrcphff2L1lh8fimMZVs0fdmL9mCVHrqor/N
        iuy2t+7BaVjepnsNCu9lPQJsvx227gc=
X-Google-Smtp-Source: ABdhPJz5MFEu00uw8Rb0cW81i5zlhFL0k90ZtYwyzQjurSBmAPQf4Auqd3yHfX0tbz5+K4lnZsC2gw==
X-Received: by 2002:a17:902:7882:b0:131:2e12:c928 with SMTP id q2-20020a170902788200b001312e12c928mr12925227pll.74.1631942767088;
        Fri, 17 Sep 2021 22:26:07 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id u12sm6774909pjx.31.2021.09.17.22.26.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Sep 2021 22:26:06 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        ke.wang@unisoc.com
Subject: [Resend PATCH] psi : calc cfs task  memstall time more precisely
Date:   Sat, 18 Sep 2021 13:25:49 +0800
Message-Id: <1631942749-5495-1-git-send-email-huangzhaoyang@gmail.com>
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

