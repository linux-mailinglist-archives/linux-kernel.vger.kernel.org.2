Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DDC324049
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbhBXOsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbhBXNek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:34:40 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED649C06121D
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b3so1901730wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLFEI/Kp7iKjAmKkKRnhlxgvK81SjpVSsncewURdRkY=;
        b=c5SoQTDQudyi0BVCVPK7JStPJRJGB1/pvR0bTthbht3C7GpLeem2f1fLV0dP4GFdMJ
         OUW3qYSL7Qg2vNIb5kRdc+bxMhMn7i45UZTw616JSaSv16oQJ6PZ+VNitH1gQcNy6INm
         YPfcDUUFBT/6wKQXXO86i1Fu5ZXiFiDeKcVEv/dxWC2IlpgYDuRf1vTnIe6TywhqS4HS
         TU/4imkoDfWEugmMXAVh2atG8U86Ky5A8TQhX46uxQPgyz3JJG8OoYxEgnurBoxZBwlt
         3BdoIG4sr1ElitIA0vIuMTq0uKRM9Y7jPyYkJL4S5JsnAIBMixC8Wi3tkJJQtHi1Ku6U
         MVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eLFEI/Kp7iKjAmKkKRnhlxgvK81SjpVSsncewURdRkY=;
        b=RgAULbMok5hxRYgAPbncfF7mPvlNZ7twhtNklnROne3vlv6rccm4+UjHCf9XAY7Onp
         QVwlK7bMbFV+E9ueMFQDysWwKJ7Jh7WAwe1WW3GF/V2UtMO/yyNnXbKd08l74wL6I3wB
         UWJrl9b8Hw7rRipPgS9iMczynrqIHfMGD5STptQYxq9mOrjz6deSIz4ccG2fm2WuO/sl
         nKptIo2h8eUnaK55Ad/jtBNDRb0QcjNEce2wSJ97MwZgAMGFHtOyuoGUlycd/pKkpMjw
         30s4XrYS9Fl/o3sAMd6SFG8spMw0BET8HE8IuJg6Y8+A5tuWl35Ltvpp9hMJJPwCQDnH
         9vhw==
X-Gm-Message-State: AOAM533GzMQ4xHFiJ2v8MrVddohqkinrTLNrr5+WrP0Mlx2LCbJaK/s5
        sbISyh23aaCfsLlOMhAG+gXJ+A==
X-Google-Smtp-Source: ABdhPJzRvpLanpIWMKdj55U1iIs+ym8Dnk4kyPUYE+tpt2LMJEBjqFw0Ayxjod9n1Ihf+MBL78K6tA==
X-Received: by 2002:adf:edcb:: with SMTP id v11mr10185613wro.358.1614173435734;
        Wed, 24 Feb 2021 05:30:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:35 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 7/7 v4] sched/fair: reduce the window for duplicated update
Date:   Wed, 24 Feb 2021 14:30:07 +0100
Message-Id: <20210224133007.28644-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
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
index 46c220a4f7ed..38a1297edd76 100644
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

