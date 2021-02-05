Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F12310ABD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:58:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhBEL47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhBELtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:20 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C44CC061794
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:48:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id 7so7426344wrz.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FKkOyX/FmM9A+zjskvjZN+umn7ZLvkJus3S3g3q7MnQ=;
        b=lkHgSczR0bFUz+SXYfEr/SsOcvD6EG5FwWcUEXl9tTlk57lMD/gqHGeIFgek02vvRh
         3XvdWhiGtmMRF+GxOH4gUx53k8hQGoiRm7gv6F/IkLXGwr+CFfr6BjNbqECQk6SRyxEf
         MXTqSfGjQgNC5Im4Q3pIhf8uqcaqcHm1w5+HLH1XUvGQeJ9BUMbFJLSCqpDXMU0fHLzb
         g3xuBZtW8/anV7T7yBwGrBWNgTk4vAkdyzofT0qzXQmmIHv867/JXQKBn56Wtla2qFJr
         9mPLVjqd3qtEOzCX0pPwCUeNHM27QHpI/3D9TxBGKZX9X00BGjrcmMfiGyT4srmn512e
         AhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FKkOyX/FmM9A+zjskvjZN+umn7ZLvkJus3S3g3q7MnQ=;
        b=pzXSqqtzVfLj48x7G0/Pq/5LWfHveNe47sbQrOf+VZoERVQoqY50Vm5eghVmKEbJlk
         I77IXEAaZ0eLyaMQIyJagaeDc2Z87r3h7IZSzw97SrEiNlhETdbhzxA2/VXxyzSfsNB6
         Q3fbkwdxbJw6Kq2mAUojmYyuLgwK5eCkOfeIOkbtRglPv8GQhWOh3KpUk6hMa0IuoBXf
         0fcuQadRwq/JazHpDcZgTXXK/5XeLz0Bjk5CAqGJzuOuFp6hBKQ9JxonS1KpqaBzd1g0
         6httzTLsszcX1OiXuUWDdCwih/IK5pSICBw2nsv+Nv3KU7qlJhmQz0GIHBq4iK+0Nyuh
         /jSQ==
X-Gm-Message-State: AOAM533XtIwKjy6SzgO8DaAuZNZt6qKICDcwZ+v5ZmvkE43XwVEBs8ek
        YZrWUtHoWK2QX6zh5jHEGQz+jQ==
X-Google-Smtp-Source: ABdhPJw2BBeykY0csKwFifV40UpMguaNt/IbkgcvHsarZadPPgUySKkWgWM0gVsUrw/FZdeaY1GvTg==
X-Received: by 2002:a5d:55cc:: with SMTP id i12mr4692866wrw.24.1612525719140;
        Fri, 05 Feb 2021 03:48:39 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id z4sm11647586wrw.38.2021.02.05.03.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:48:38 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/6] sched/fair: remove unused parameter of update_nohz_stats
Date:   Fri,  5 Feb 2021 12:48:26 +0100
Message-Id: <20210205114830.781-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205114830.781-1-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org>
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
index bfe1e235fe01..60b8c1c68ab9 100644
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
@@ -10404,7 +10404,7 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 
 		rq = cpu_rq(balance_cpu);
 
-		has_blocked_load |= update_nohz_stats(rq, true);
+		has_blocked_load |= update_nohz_stats(rq);
 
 		/*
 		 * If time for next balance is due,
-- 
2.17.1

