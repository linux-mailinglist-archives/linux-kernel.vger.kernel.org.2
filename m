Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425C0319FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhBLNce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbhBLNbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E12C0617AA
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:03 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v1so4321734wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q/i534zCK8jIQpyL/YsIMBewYqAEAvO94Tf9FpRS/q8=;
        b=g1hDGaMrril++HoK/cQvJ+7jIxKUauCi5v/pwg3Hv9oNrXoXyImfriVtdExaH/7GN5
         RefTO3hieb8GJXzXqQ7AbBmaargmCXq6xi5TZoXjiLlRJuvMewSkYW8Kl3Bfoenw0fOQ
         18gnRWmjN+eIc5WEsHZZu7k0VFC+KNWNIugT9+4n6n0PR46SHmTIrv4ZXGb6TmJY8eeh
         8HJERWHuXDBt1dFDAZNk9xyrozxBH8Gmjdb7LvxDR1m3vIJfFk52nn1l2uHkHuU2Yp+s
         QiKVxPx66g7x5hEzMNwvHS9/hyf8IRzt09HrfpzmKrhmsgeoVeSuKGo6Y0K58BmQYzwv
         trvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q/i534zCK8jIQpyL/YsIMBewYqAEAvO94Tf9FpRS/q8=;
        b=eSFDX9enkAzQyGFsfOkqqAiNMV8JX4yi5Y3K8myazzMhz0Br6OCfiaa8I7YTHgxHV3
         I5WIKly2Z7bj08rKkWEgiM4zZVpYk8FXqKEEQZDXm8MJwwqaNaqK+B0sNbUXicX31MPy
         XsYxgh5NJm8DV2DT1BRxAqgs8otGVUDfaNJm2fe4wHYhNWjRM/adfjvxJTlcHJRfoXfN
         w/Bp2dd/TP1NxSBTFuncg4Yf4VYeb57gpeaTV8k99/jPstxbnDNEnYxgyshOxDOJIBwM
         qrgM968fzrhkLat+D5rwcWgij6n1IyllqfKy1T4oMakv2jZzxCEtBlG5Forzycnkw8J2
         CVeg==
X-Gm-Message-State: AOAM531jn/wm85220i5ImWswfyyD2BaOhiN/IsqHTADQPeBNgDwNtbd7
        3e23ig/CPLeKHdJxA4Pc/E9Xzw==
X-Google-Smtp-Source: ABdhPJxnPNz/u3qeSdUvVbF/4Hp2Hjgg4ZyojzcDpvDuXC4jhqssvCUVUEkbb8K0tRurZsLUtjbF2Q==
X-Received: by 2002:adf:fe0d:: with SMTP id n13mr3421937wrr.258.1613136602408;
        Fri, 12 Feb 2021 05:30:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id h13sm10470773wrv.20.2021.02.12.05.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/7 v2] sched/fair: merge for each idle cpu loop of ILB
Date:   Fri, 12 Feb 2021 14:28:46 +0100
Message-Id: <20210212132849.32515-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212132849.32515-1-vincent.guittot@linaro.org>
References: <20210212132849.32515-1-vincent.guittot@linaro.org>
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
index 4573a0abd38a..ac4add026f32 100644
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

