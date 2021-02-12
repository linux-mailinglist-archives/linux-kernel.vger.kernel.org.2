Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50631A08A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhBLOUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhBLOTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:19:16 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97255C06178C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:18:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v1so4514807wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bD9E9b1Ta0WtlxCIIuEIVw1AsToI23KFAwziLn7mPc0=;
        b=YZtxP2bhSlotEdVFhYbct9EjC/DlgpAbUOxDOU+SXXs5+5Trt51qpO2EuxK5ypJu3a
         PKV+6KWhWnFYz5GCWX2MMCIhsMVBvkTHcSdw3z1fOjHr4pmue7p+QybgaN1qzS3Mq3BJ
         DQ8oGVxT7sfHoyeeYRlfcQfJCptN7gLAXxHGXL+ITaJkgd5Pp0hkyx6Hun+l0MTNt1+t
         qZ4TA8Ar0cBgwzvcm05ngzX8ATSftIhvVHeCSVdsKg91Qf6Wts9EW+Vls9EcMQUS+XRL
         dHwnwrXLfQczoDimMw33r0ak0GZfCz21MCcnUfIDovtmOU8eBPWkNdHcn59chdkV3Svh
         2aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bD9E9b1Ta0WtlxCIIuEIVw1AsToI23KFAwziLn7mPc0=;
        b=bTIJiIHklQpcODuiVduQI0LPobgP+84qSUvCvh14jJywoqT5vAB87PtiuXLgRwzfgg
         GTrK0ZHMcTNJlzcikJIZfzlZEa8mkazTmkrC/FanTD7EgmXNU5tynC4rJn7/4aQ12UkF
         YXlsEFCOL7yiR26H88sxzA6IWB38nGLySmUC3frVOO28t7uOODouFXABayoLGN93EMBf
         3y0sH8LN0NumiV/WHsigslJ2XGPRhN6sN5E3gnirsqVfW05iUqKMAGC5SJDx0Eo9WHcS
         3lui/ROtb+XFw6oLdAEXMbSsiuO4u+xX2A0OwFSyCHJIYMRzl8IsqmdGZpGaE3/xSc28
         Tz6A==
X-Gm-Message-State: AOAM532d9l1QtaI/8cWz6sQrp3bsGnnuNkxsOzmrqi06Ic3iP+iOpDwx
        +LVmEocWWugo9VsCQW4FDUvGBkS00vERnQ==
X-Google-Smtp-Source: ABdhPJz9CII998LRrNkTvdOHT5DsiJARMUqHcSQIzzIU3TglNhxqo24lHjiWuePsRykOXPgq41lFHQ==
X-Received: by 2002:adf:cf06:: with SMTP id o6mr3641278wrj.169.1613139480254;
        Fri, 12 Feb 2021 06:18:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id f14sm14254156wmj.30.2021.02.12.06.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:17:59 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 7/7 v3] sched/fair: reduce the window for duplicated update
Date:   Fri, 12 Feb 2021 15:17:44 +0100
Message-Id: <20210212141744.24284-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212141744.24284-1-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start to update last_blocked_load_update_tick to reduce the possibility
of another cpu starting the update one more time

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cd0ea635225e..7ef0911529ee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7852,16 +7852,20 @@ static inline bool others_have_blocked(struct rq *rq)
 	return false;
 }
 
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+static inline void update_blocked_load_tick(struct rq *rq)
 {
-	rq->last_blocked_load_update_tick = jiffies;
+	WRITE_ONCE(rq->last_blocked_load_update_tick, jiffies);
+}
 
+static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
+{
 	if (!has_blocked)
 		rq->has_blocked_load = 0;
 }
 #else
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
 static inline bool others_have_blocked(struct rq *rq) { return false; }
+static inline void update_blocked_load_tick(struct rq *rq) {}
 static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
 #endif
 
@@ -8022,6 +8026,7 @@ static void update_blocked_averages(int cpu)
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
+	update_blocked_load_tick(rq);
 	update_rq_clock(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
@@ -8363,7 +8368,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
 		return false;
 
-	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
+	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
 		return true;
 
 	update_blocked_averages(cpu);
-- 
2.17.1

