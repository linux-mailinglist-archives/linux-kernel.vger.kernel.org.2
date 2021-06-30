Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE723B84C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbhF3OO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbhF3OO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:14:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DBAC061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:12:26 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g22so2386024pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBaTAQqR7nDwYS0MXpOPgUttYyrZis4U5ju7P9HsmNQ=;
        b=LR+8V/6CUNRykQYoy+He1U74MGbrdhgqcrHcyYxc+DqZTlFrKgpYUwEeVNp9K543Rv
         Frsx0TqsRve4R+xjXnrVTmdKlMc2jHGt+jEzhQkd8Yq/vtnfqyMM0CuTJrxLvDMMk51k
         Pn4SpkgDwqTxZsc2auTERqlnNQtxZ5KrVKn/aCYiOMkb+SE3KiaLBzoCe2yx0Su2EJrV
         7iOjVM76bD+B9jx9126rhqhc6pyJUveoJ2Py3FtJ/3smIyhWu3BAJTXkiC61LifIAJVl
         hFfnMg8isNs4xzwYblixq2A+DZUwRt7n3ecuxUKAb3Gr2vTuAXTduws9GSKpqd3KPd5e
         63Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eBaTAQqR7nDwYS0MXpOPgUttYyrZis4U5ju7P9HsmNQ=;
        b=dZnYyuFN2AQID02R9Eyx05qlCJyKIcFO/fwXXePeRNlPpm+68niUfNib/ZyzB9wn7r
         /g7PiGHJ3KY+wN/owfnBwGaa9s2k8DB1XeHDY5aZo3VG0+5wvgZSiKRtbIPZ73+5ISDv
         yWCFH1lbP5RrvHFAlVkTwxc2X1yTwawTKcn5yMyH5dBWY5FYubyF3Q9uddHOkgGwkhr0
         P91c8RIEVIJPMKijNkFo/dLDFqgMKoklpjShMIbbW2Y2WUbptECrQDYBwtSIVAqM4ScJ
         W4WVtp6nX5AZnzAhVS4i8yc/treAgsYCi89ON6p1TxHNSHMC1VSaNUE7xK6pr4yA6UDM
         YdpQ==
X-Gm-Message-State: AOAM532DbImxBAlXk1XlmIAYimbENUoJ+PPZUksKP0snG6JQoaiamdiY
        qV5mMyycwu3ZBi/I+gR5CKw=
X-Google-Smtp-Source: ABdhPJzh7W5OTRBxYDLIFy+l8qBCqX/qrf7Izc97fUwxg8FWPy4smzPKqKrHu0lpWaYV/V8WCuH0cA==
X-Received: by 2002:a05:6a00:9a5:b029:30d:fad7:4515 with SMTP id u37-20020a056a0009a5b029030dfad74515mr11151446pfg.28.1625062346386;
        Wed, 30 Jun 2021 07:12:26 -0700 (PDT)
Received: from BJ10918PCW.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i3sm24416536pgc.92.2021.06.30.07.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 07:12:25 -0700 (PDT)
From:   Xuewen Yan <xuewen.yan94@gmail.com>
To:     valentin.schneider@arm.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, qperret@google.com
Subject: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value when rq is idle
Date:   Wed, 30 Jun 2021 22:12:04 +0800
Message-Id: <20210630141204.8197-1-xuewen.yan94@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xuewen Yan <xuewen.yan@unisoc.com>

Now in uclamp_rq_util_with(), when the task != NULL, the uclamp_max as following:
uc_rq_max = rq->uclamp[UCLAMP_MAX].value;
uc_eff_max = uclamp_eff_value(p, UCLAMP_MAX);
uclamp_max = max{uc_rq_max, uc_eff_max};

Consider the following scenario:
(1)the rq is idle, the uc_rq_max is last runnable task's UCLAMP_MAX;
(2)the p's uc_eff_max < uc_rq_max.

As a result, the uclamp_max = uc_rq_max instead of uc_eff_max, it is unreasonable.

The scenario often happens in find_energy_efficient_cpu(), when the task has smaller UCLAMP_MAX.

When rq has UCLAMP_FLAG_IDLE flag, enqueuing the task will lift UCLAMP_FLAG_IDLE
and set the rq clamp as the task's via uclamp_idle_reset(). It doesn't need
to read the rq clamp. And it can also avoid the problems described above.

Fixes: 9d20ad7dfc9a ("sched/uclamp: Add uclamp_util_with()")

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

---
change v2:
	*add Fixes(Valentin Schneider);
	*ignore all rq clamp when idle (Valentin Schneider)
---
 kernel/sched/sched.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c80d42e9589b..14a41a243f7b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2818,20 +2818,27 @@ static __always_inline
 unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
 				  struct task_struct *p)
 {
-	unsigned long min_util;
-	unsigned long max_util;
+	unsigned long min_util = 0;
+	unsigned long max_util = 0;
 
 	if (!static_branch_likely(&sched_uclamp_used))
 		return util;
 
-	min_util = READ_ONCE(rq->uclamp[UCLAMP_MIN].value);
-	max_util = READ_ONCE(rq->uclamp[UCLAMP_MAX].value);
-
 	if (p) {
-		min_util = max(min_util, uclamp_eff_value(p, UCLAMP_MIN));
-		max_util = max(max_util, uclamp_eff_value(p, UCLAMP_MAX));
+		min_util = uclamp_eff_value(p, UCLAMP_MIN);
+		max_util = uclamp_eff_value(p, UCLAMP_MAX);
+
+		/*
+		 * Ignore last runnable task's max clamp, as this task will
+		 * reset it. Similarly, no need to read the rq's min clamp.
+		 */
+		if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)
+			goto out;
 	}
 
+	min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
+	max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
+out:
 	/*
 	 * Since CPU's {min,max}_util clamps are MAX aggregated considering
 	 * RUNNABLE tasks with _different_ clamps, we can end up with an
-- 
2.25.1

