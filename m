Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B306B310AB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhBELzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbhBELtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667DDC061797
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:48:42 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id i9so5686295wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hOP3rq3zGKSecQaHMq8WrAbaEPuRsVYJ642DAIJXZ0U=;
        b=aMx2so61pcBb6wHd7tICmAhSr7P2Sdh2eBMkjIFBk+bKQ/qS+vSqLsndEAvgJWaZ2l
         w4OOLSWATgLnnPhAldTfJCTssCu98a++L55c82244OsbtU6qaFO9sXFnDQbbLneo80fS
         yMAfHJDPEZBX2oSbQwm+jvQU0Njk10qH8LqvbNsgExv1qCc8+cFDwPZFEznqTgO6zWWQ
         F3OyVAKlDgPZHHx75/MYAMBzPpGRM4xRQCAkl2iUPGfpts1h58bczOsq07LhsqOS5RX5
         iwIwrsV8MljGqvFYfsFJTgS2/g/PE8wKnXDoY3WiqBfioevp4k5SaPwxF8NPbARlFL+/
         SK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hOP3rq3zGKSecQaHMq8WrAbaEPuRsVYJ642DAIJXZ0U=;
        b=Qmd7c/8iAFQQX/fwCQ/3Hez70r4X9cBMzahYqB1BtW513kIGj83uXlqB0wQt8ZYaTB
         ZOsKmEy302+NPvzubu6gE+8etbzxn8XIAuWkDCzKFa1F2onbe3Dsz/OSGsTrb2MXiiFc
         qG5256i7jllgXrkq735meeX+vLfz1d2dr0DxLfaSK1zyaQw9BD4Cyabxq+UggpYb6yAt
         JhAAoZ8/5uE/b3lOOFCWY/Tpg23KwvVlh/lcUjZlfz5ueW9pgeMmdjVDZQmRNO8Lqqxc
         Ti1+4AZ1w8x00eP3Oz2oYLxztgJ6zRza3sMgzp7JUN+QOpXYyjtFuXYx0KbCDn2GYxUl
         0YwA==
X-Gm-Message-State: AOAM532cCYiL8boYFKPqSmx3dL4UQCck5cTuQhmFkbqveWX2/6isoFpy
        ijESYjXK2ILzVS1jtpObyDV3GQ==
X-Google-Smtp-Source: ABdhPJwruKeriyAO3G4vRjqxN4q1Kk228nU0WRQQGsn+qybMhq29FeiWoGo1ngPN7xJaM8IJKtvIOQ==
X-Received: by 2002:a05:600c:4105:: with SMTP id j5mr3346944wmi.0.1612525721070;
        Fri, 05 Feb 2021 03:48:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id z4sm11647586wrw.38.2021.02.05.03.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:48:40 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/6] sched/fair: merge for each idle cpu loop of ILB
Date:   Fri,  5 Feb 2021 12:48:27 +0100
Message-Id: <20210205114830.781-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205114830.781-1-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org>
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
index 60b8c1c68ab9..c587af230010 100644
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
@@ -10388,8 +10375,12 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
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
@@ -10435,15 +10426,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
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

