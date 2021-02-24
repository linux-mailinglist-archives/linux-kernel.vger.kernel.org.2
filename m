Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC871324046
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbhBXOsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbhBXNcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:47 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDF2C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:32 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b3so1901521wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fAbWdFY6DYzN+++zeWPYuMwDEhyxBpMHbQVhnizHst4=;
        b=dO5U1Ewm0zUCNnPPEXHQuviaijLYeenKQ+ACeXU449GtzJ0rAx9Tmzu+zdo0+Dg2G3
         ccIQAiy6ZgD60SuZJ79EI3jIHo6Os3+Ts7v68SPk+Z4I6xxguYmmmVU0VdKE88b9Bfbf
         6Ic9J5RPiH7tg0dgsugOn8X34TW1bor2vgECeSzoXRZESi1JzRLjmL9FG9V/EughDua1
         iutEjhCnxcZfhuNewAqH0oyGARwhcyuA2TlfmQrN1AdMFU+cOv1YBEHsa2BM0RMlAD/M
         bUs+7HS/RX+d8UPOcFQcKgmiya3ohnCS4yp/zIMXc5ccns/az+6gJoHLEiDOchesYOzh
         POTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fAbWdFY6DYzN+++zeWPYuMwDEhyxBpMHbQVhnizHst4=;
        b=NEEsZOuT/FIpaxoF8oQ+QCbiVeMmeCOnl1+8PPF1DShhpPyQgQQtSGE3DzQeCuwVsC
         9si+rCkTKDDRTPfYzLdbZgVrE/n8m92rD3X0soDYWJH4g6QlmpVQM7UXodqID1KMBWgY
         ruphCgeCn1P9M/nnH37w1wX6PYO01gsJG+eR92QUnEJQgiTuQoa8DJQBhM5AZwR9bEEx
         53cF90xCurGt37ytwCfTsWlcuK7HstDnDZlo9V0Ry7n5eJ5zeAtJS0oGAOB7T6lW46q5
         3RJUBRuv+cbtghU4IBZ7uwhPS5q5SXEynL1IEEC8eeTb9ogwx4EW4wuNIkmjknGoTF8v
         0OlQ==
X-Gm-Message-State: AOAM5314N4ujuhyoOk8M8WPNIuWaqph5LdHralwV0B/W0mrBMnM4w4hP
        XJ7x/yNcz9uNOdrxmhUzlju4KnZ+8NyIKw==
X-Google-Smtp-Source: ABdhPJymMQeWbROYbWMTVArGEeE106K60M/Bgjzj+l5wEoTs43QgpTsCa4ZTZ02FLSS93ec1DVDiXg==
X-Received: by 2002:a05:6000:1542:: with SMTP id 2mr32095000wry.356.1614173430983;
        Wed, 24 Feb 2021 05:30:30 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:30 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/7 v4] sched/fair: merge for each idle cpu loop of ILB
Date:   Wed, 24 Feb 2021 14:30:04 +0100
Message-Id: <20210224133007.28644-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the specific case for handling this_cpu outside for_each_cpu() loop
when running ILB. Instead we use for_each_cpu_wrap() and start with the
next cpu after this_cpu so we will continue to finish with this_cpu.

update_nohz_stats() is now used for this_cpu too and will prevents
unnecessary update. We don't need a special case for handling the update of
nohz.next_balance for this_cpu anymore because it is now handled by the
loop like others.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f52f4dd3fb9e..0323fda07682 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10043,22 +10043,9 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	 * When the cpu is attached to null domain for ex, it will not be
 	 * updated.
 	 */
-	if (likely(update_next_balance)) {
+	if (likely(update_next_balance))
 		rq->next_balance = next_balance;
 
-#ifdef CONFIG_NO_HZ_COMMON
-		/*
-		 * If this CPU has been elected to perform the nohz idle
-		 * balance. Other idle CPUs have already rebalanced with
-		 * nohz_idle_balance() and nohz.next_balance has been
-		 * updated accordingly. This CPU is now running the idle load
-		 * balance for itself and we need to update the
-		 * nohz.next_balance accordingly.
-		 */
-		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
-			nohz.next_balance = rq->next_balance;
-#endif
-	}
 }
 
 static inline int on_null_domain(struct rq *rq)
@@ -10385,8 +10372,12 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 */
 	smp_mb();
 
-	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
-		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
+	/*
+	 * Start with the next CPU after this_cpu so we will end with this_cpu and let a
+	 * chance for other idle cpu to pull load.
+	 */
+	for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
+		if (!idle_cpu(balance_cpu))
 			continue;
 
 		/*
@@ -10432,15 +10423,6 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (likely(update_next_balance))
 		nohz.next_balance = next_balance;
 
-	/* Newly idle CPU doesn't need an update */
-	if (idle != CPU_NEWLY_IDLE) {
-		update_blocked_averages(this_cpu);
-		has_blocked_load |= this_rq->has_blocked_load;
-	}
-
-	if (flags & NOHZ_BALANCE_KICK)
-		rebalance_domains(this_rq, CPU_IDLE);
-
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
-- 
2.17.1

