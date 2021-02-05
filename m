Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0ED8310AAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhBELwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbhBELtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:33 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447E4C0617AA
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:48:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id m1so5685604wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=csGZBCFb7RcKF2F89/cpf6XMRqeh6GOKlg6YlOqAkGU=;
        b=RcN8N5SJeMiko1IrT+djDc6FnSDzjSIZiZJ6YwiIhlIyw3vMoOTwRKcnztO4mAXW6e
         Q7TmstDcCd8xWctPsYBTURaS5+tEh1XKLrlcZccQzSpjRefUm/aGDETinC/h+j20nSnr
         SExYqGmmGaYH+eaycRPZyppCbKsg2dUdQf2qb50qxx1ASiOrEpqn33u6wI6N0AzneqX+
         CbHtHUZjUQZfP9SE3uJFj7Y764kWQREQ0lQjcx7wosl/yjks50usPQocqTDoBs1pifT1
         99lz/G9S8sHgjQCmykMU2RTUQZ77l0z7CixPPFm0Zc25yvj4iK2RmG6x18ncMNGoJI16
         N4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=csGZBCFb7RcKF2F89/cpf6XMRqeh6GOKlg6YlOqAkGU=;
        b=KShRcyrL8sFzTpKDez5s1jG9mYpxZPqL6CrCatBwDvRLkIj8zzrvwt7NTitO3yGfYh
         JQtafmj4CepNJLMxJglgBLp6wTi3+QV82z5aRI7F1I4hnNpaDV6komxrSisEa11pGvCQ
         BvjEK+TWZXJLCc1YSRWG7W1EhqE8W6nk+sGbRjsOPcP1yshEpIZCxHLFw/B9yTzMG8Bh
         s4QynRdEhnP+dvvCMCJ3IYzArkb9Ii24CClPNlPx3QEBVC+9gEHwiiyMdZDVKcj5pnNo
         1Yq/fvTDLzFlTmFkPZ+aIredu4JmN4yQ2OcAAnBsGZ78Dqygh2sjVG964R3fFtA7WPp7
         SDsQ==
X-Gm-Message-State: AOAM530wLX3U2ZB2Y84wcfDYWoSZ8udgUoDydQBiwNg1Ks0cV4RkEHxV
        cNTmydXFXsBXIPp1PEOZ/uXX9g==
X-Google-Smtp-Source: ABdhPJwtCI5HglgYqF53hd3FbPt5Xx0Sylp6etX5Wyhn9sHYWtMghujGLlDgnwITBHIwqdAsSWKSaA==
X-Received: by 2002:a05:600c:3515:: with SMTP id h21mr3240023wmq.179.1612525726984;
        Fri, 05 Feb 2021 03:48:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id z4sm11647586wrw.38.2021.02.05.03.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:48:45 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/6] sched/fair: reduce the window for duplicated update
Date:   Fri,  5 Feb 2021 12:48:30 +0100
Message-Id: <20210205114830.781-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205114830.781-1-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start to update last_blocked_load_update_tick to reduce the possibility
of another cpu starting the update one more time

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d2ab28d5736..968808c2c022 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7852,17 +7852,9 @@ static inline bool others_have_blocked(struct rq *rq)
 	return false;
 }
 
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocked)
-{
-	rq->last_blocked_load_update_tick = jiffies;
-
-	if (!has_blocked)
-		rq->has_blocked_load = 0;
-}
 #else
 static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false; }
 static inline bool others_have_blocked(struct rq *rq) { return false; }
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocked) {}
 #endif
 
 static bool __update_blocked_others(struct rq *rq, bool *done)
@@ -8022,12 +8014,16 @@ static void update_blocked_averages(int cpu)
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
+	WRITE_ONCE(rq->last_blocked_load_update_tick, jiffies);
+
 	update_rq_clock(rq);
 
 	decayed |= __update_blocked_others(rq, &done);
 	decayed |= __update_blocked_fair(rq, &done);
 
-	update_blocked_load_status(rq, !done);
+	if (done)
+		rq->has_blocked_load = 0;
+
 	if (decayed)
 		cpufreq_update_util(rq, 0);
 	rq_unlock_irqrestore(rq, &rf);
@@ -8363,7 +8359,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
 		return false;
 
-	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
+	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
 		return true;
 
 	update_blocked_averages(cpu);
-- 
2.17.1

