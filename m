Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DE8319FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhBLNcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhBLNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:19 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF67C061797
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:01 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v7so2803345wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5FMZt+MTAYB3ypX1WpOEwa6GS+zB61x+jEY1Y9CRBw0=;
        b=U1AbhNTok5NI6DcX50/kTgAf4uqmGnh/fYUjaz26Ac/7f/Z31lMvz2Clu8gxKHFzx/
         wa/3WgpwbQ9Nd3RTQo8fK1vtPtRR2ovUMt3ggURDD7NdSAhYlppg1Vm194S0efrMumzw
         pX1B+vAiKiXosD/Qped0cms86koV9a+BioHhNVNtljV/P4FyxpBV/7576WTLMqt75Alv
         D1rS2xmY9tULbuWCk/8NyXe09KpcdPdLMJgvd9mcy6hGwU2NG+QhFB7C3bpYW9zNpnvs
         5IHkIB3L6s77o4ZAGFC4+/Z68GXQKMrt8PmRYvf5AsQ5mU3bqDhmYgPVRkL8NV10aQD6
         qQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5FMZt+MTAYB3ypX1WpOEwa6GS+zB61x+jEY1Y9CRBw0=;
        b=jZOhexCtMMtNFd8ZjTKA6kPKGoEcBcZqjYvaDNJ1BlOrasJN1Ff8dU6iHEKZKXqsqd
         TgkBSv2rU+B0a6ddq0C7K9YGEcLXgM1F3+/5mpWIme4F9AuEBLd0j5QFDujDMIB16qaV
         jHqVW9WESRis4NYkDucVpaE/XTNI8AMsShOhC32+n4K2pcXBeqkHpq1nrNB32mhsXFJF
         ZZ5Hkyoo6Gfj2zuBJII3eou3qjLNK8HxI1Tv/znWjo0zxvuUGiiz93Y3YojxDMxZHHxO
         17uBUaw7ubN41RSZ86Ri+tcGIJyx1nE0oew0QtBgh9J4F06Rrm0wV+FssMZnrzxvQxKq
         pRhA==
X-Gm-Message-State: AOAM5329+IuT5oUroQjLVNEcXuS+kzDfN669wL2+mvLOrzKI7Bfr5NzN
        CQVul99XTMqviAo/EkoN33VIgoGSHZ7i0A==
X-Google-Smtp-Source: ABdhPJyWu5HQRHVS7a67HfRIrfGzzBgW2vHQQeV2ZHyy6zVmhT2MLAb2H5ynhLnAk0gTVbqarpvPgw==
X-Received: by 2002:a05:6000:c1:: with SMTP id q1mr3068178wrx.114.1613136600482;
        Fri, 12 Feb 2021 05:30:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id h13sm10470773wrv.20.2021.02.12.05.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:59 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/7 v2] sched/fair: remove unused parameter of update_nohz_stats
Date:   Fri, 12 Feb 2021 14:28:45 +0100
Message-Id: <20210212132849.32515-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212132849.32515-1-vincent.guittot@linaro.org>
References: <20210212132849.32515-1-vincent.guittot@linaro.org>
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

