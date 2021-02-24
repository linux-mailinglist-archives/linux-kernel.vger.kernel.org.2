Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC84324045
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhBXOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbhBXNcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:47 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B75C0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:30 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id j187so1804017wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lJwZCO3QOOgF4/um8n6NOJjeObHLLe3xvQI4uks0DXQ=;
        b=OGZCbcZscYWMJecGX1Pl2WoGR0I3ylSqVlzktQtFPcFnWBhQpv7N+VcYmHjQ3bUwXB
         k6xW12Ll4jxJI8BAOcmoy8SwJ+6x4d16xx+KlSxjomfFS/LDRVhVRdlxtirYKZ0GFX5c
         YGgkQ1NgGdbCvNovCTfLROF8hf5Jl/sBHCdhH5fglyts8OHo/mEZrYohRQkD+c9sDf50
         LqAnHjlH1TREwRA8zVnGXretENxb2KgXB6iDzQoQgmi/Dex1DtrbPYsxT6RQrx+CEjWn
         BQHmvX2xn+bXs0GQBnWS4kEa3t9z7CFvmN/IRfH9fbDe+yvIXIpLyco88ajPFG05nish
         w20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lJwZCO3QOOgF4/um8n6NOJjeObHLLe3xvQI4uks0DXQ=;
        b=Sj+LDQS6d2qAnpFcowJBHLH0kXvbOve6FwUfxxYtvPGXsGCXPduQZgtYIFd6e+O76i
         m2d4bmDGW3n5mXQ4vB5NYT+xnMXcqKY+iUiAAUwVUpklEab58uqX6m2e6ivFrhDfm4K/
         /XLi6Q83cuA2gZm2B1H4z7CPjqeaE7LuMjidBSogZlF8oN8JUTB7TeCGKgn/vhxLq/sH
         U34N4oDTuz0e7rodNalUqPCDGpuKdDveJYaB7Sy+PC8HQu1p4LrX+MzZz/LCqFEn8P/0
         jCePBpvKjs+lVTEmiimbL8loEt/QBXk8s7PyBkRzr1nRcA4uuC+myvRHyM+1rxxVb6LJ
         kYyA==
X-Gm-Message-State: AOAM530/3Dh3n3JqP4q9kCBPxUlEswc5oUW8sDNCqaiwnzvcZTPV+S+P
        7/SJVO0VfWClrA/INKvAgeWVjQ==
X-Google-Smtp-Source: ABdhPJzCOIX/D7bjqZQpGSxp/oWvTCFrHa5IeGBRSSTKpwMybc3GEpFHiiO9pO6qW9ebu3P4x8plVA==
X-Received: by 2002:a1c:5584:: with SMTP id j126mr3859694wmb.153.1614173428845;
        Wed, 24 Feb 2021 05:30:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:28 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/7 v4] sched/fair: remove unused parameter of update_nohz_stats
Date:   Wed, 24 Feb 2021 14:30:03 +0100
Message-Id: <20210224133007.28644-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
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
index e23709f6854b..f52f4dd3fb9e 100644
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

