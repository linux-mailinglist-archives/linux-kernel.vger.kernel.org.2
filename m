Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B431A082
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbhBLOS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhBLOSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:18:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63FC061786
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:55 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v1so4514306wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5FMZt+MTAYB3ypX1WpOEwa6GS+zB61x+jEY1Y9CRBw0=;
        b=oSt3vWZWm9MamI8GQw3/wiMqMes6AaTTKJ6PwBX/MqhyDn2bHLqMX94V0gpLLlXaiG
         kF40t2hJBIy1HKBmtgfGhBIlv+RGw6m8KuCCpM1RiXvUyxzzVEq5Qxm/zaHHJqg2pBhr
         +xix9lm/z4q1wfj+dASZn9i/g6zZcj9mZaGTJeUeEtXb7D8x+MHquJzIdZmW6RUFeEgK
         ZSnRQ+OJbm1/wDcaGRaJhoP43Og+2qzBxwq57A9hquBf3feVTDIct9uCelYQB1Z822Mq
         TK5xni9euPQKGoldkManhLURQ0MqlqVA7ZWACmMnjI1BbUrCPDlKPxJViH4NHlUGyDUv
         pkTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5FMZt+MTAYB3ypX1WpOEwa6GS+zB61x+jEY1Y9CRBw0=;
        b=WpHa9z9yUGStrvYE2pJKAtRSq5Nptz+gR3CgSQ5aO31QLdvwX1/OGbLEA1/+l7asnh
         SZmixv8awa9OpPfmXVJyAiu9WOD8FNTIx2fQq5VJprSGayDT4G8piC1wFhAnuBnthKgk
         Z7pK5wT6JB+7ftu6JS+np3J6j2rzRw+leQbSgrrKhKnbEBOhP2m/D8NCXPFPDa4n3MVb
         Z8AU0+IXqbjJBi73WTT0DaqWL9r7aT2Kz7+JdTuPD6/dH6Pu6YkdJov7yhBwBpyGbNbD
         tC+MpTw0DI4evHaeQLtn/TUxbDYTgDcXXVRNEZ3G3T0/wKm/34pywF4CpsFiv9hqXzYB
         IRFg==
X-Gm-Message-State: AOAM533TosLPEgDrds/6Ddf7QBO0vHdFSZztDLHTx+IpV4jxZG9+p/Xw
        YYC+BjD2IigJQRLSxTmIWtVmgw==
X-Google-Smtp-Source: ABdhPJyIHoWbhPvCLUbkAf36b/WKUi366dfChZz1XZkff37Cf+Rz5J+dmTqINgvx5hlXNcD5jFr0CQ==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr3683852wru.394.1613139473740;
        Fri, 12 Feb 2021 06:17:53 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id f14sm14254156wmj.30.2021.02.12.06.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:17:52 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/7 v3] sched/fair: remove unused parameter of update_nohz_stats
Date:   Fri, 12 Feb 2021 15:17:40 +0100
Message-Id: <20210212141744.24284-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212141744.24284-1-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idle load balance is the only user of update_nohz_stats and doesn't use
force parameter. Remove it

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f3f0f8cca061..4573a0abd38a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8352,7 +8352,7 @@ group_type group_classify(unsigned int imbalance_pct,
 	return group_has_spare;
 }
 
-static bool update_nohz_stats(struct rq *rq, bool force)
+static bool update_nohz_stats(struct rq *rq)
 {
 #ifdef CONFIG_NO_HZ_COMMON
 	unsigned int cpu = rq->cpu;
@@ -8363,7 +8363,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
 	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
 		return false;
 
-	if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
+	if (!time_after(jiffies, rq->last_blocked_load_update_tick))
 		return true;
 
 	update_blocked_averages(cpu);
@@ -10401,7 +10401,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 
 		rq = cpu_rq(balance_cpu);
 
-		has_blocked_load |= update_nohz_stats(rq, true);
+		has_blocked_load |= update_nohz_stats(rq);
 
 		/*
 		 * If time for next balance is due,
-- 
2.17.1

