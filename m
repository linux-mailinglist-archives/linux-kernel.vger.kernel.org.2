Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E75319FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhBLNdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbhBLNbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DD9C06121F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:10 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id r21so7896945wrr.9
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jyEYGkDt5gPUVMK38qagrHQ6BngdE0rtcgUgW178gvU=;
        b=V9Al5DT347ErlT4FWX3ZngnHW5dEmNwOqFT8fDY8WxFmDFFzC7YTrKioernZW822IJ
         4CK9p5LnlikjtpMmFzwgif+pbs72J8qhR7lClKrmQ9qNGIspnI1JKOlI+uiFaYcl/3Vc
         MjfZf781HUl9WA67/S9msjIATMGiR+KMeW+gLiUAxDY3B67lLCuRGVQT5AlqFe+UH/oO
         Ptuq5v2QYXDcYuYD5m9OrVnux+KxZ/YVWAwwXBfcZ7x1u/A7A7cFSUWmNoAEZEaqXLVG
         tV0PVIz9714G+c0ckpRpyZgfgnb7G00caRO2O0U9shR41oSTd7cUUUTubv0WpDdLGwWG
         b7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jyEYGkDt5gPUVMK38qagrHQ6BngdE0rtcgUgW178gvU=;
        b=txKu6wyG9EtM0LNozEtIKgr/TDp2niKipbiDfv2YzC92G68XvpuZMcMCBuQgbGXkxU
         kOw1px+WtTEa6t7IMrkChFLfB2WMGRUmAi/NQK8qX9bJGwn1j2BCqfkl8WuFOnJU9wr8
         ZMvOj26GgMf5EVZU5r9JLEk9I3ervcgPSgVm/qMbf7Sh/ya2oIPmpbEOJhf/iqRPW8N0
         5qdUrnaQIGlF5scMPGdFQEG8xH/zyxmV+0Vr+UysJeG4BNe+zDaw6rTl+EsaVu4RWjgP
         JlFp5/K4TcKF3TkoaOzBiy+qfd9RBn4+2EzdImRQnvE+2C6h+xhlNqXmYxzE5UKC6PiD
         G2rQ==
X-Gm-Message-State: AOAM531ZgCxYw/u/ii5leusQJeiCgNEWuB9XkylIGxBXwMDZx4zwZ3V2
        Rx/2fKxSE9GbtzdGMLEWZHnooQ==
X-Google-Smtp-Source: ABdhPJxE/owEfqMulVXBLxSJNI55U5p8aLO2UX0FtsesjEcZdyk8+61NIvSLFWiS5fwmebdlPyHPzg==
X-Received: by 2002:adf:f544:: with SMTP id j4mr3355093wrp.318.1613136608827;
        Fri, 12 Feb 2021 05:30:08 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id h13sm10470773wrv.20.2021.02.12.05.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:07 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 7/7 v2] sched/fair: reduce the window for duplicated update
Date:   Fri, 12 Feb 2021 14:28:49 +0100
Message-Id: <20210212132849.32515-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212132849.32515-1-vincent.guittot@linaro.org>
References: <20210212132849.32515-1-vincent.guittot@linaro.org>
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
index d11a632ea276..df127b64edf6 100644
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

