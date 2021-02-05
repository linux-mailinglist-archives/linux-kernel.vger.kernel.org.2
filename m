Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A875311695
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhBEXGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbhBEOfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:35:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489CFC061356
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 08:13:40 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id a16so8159095wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dHVMl08+l+vQ9YTnNVwDAnHzpCOjuY39SKyRirVjzTQ=;
        b=MCBkq1BK3C9cA2RW+EmyDl8CeISL9odl4N5W4TR0GpuZmma9Mse3aRqxEZ7P/1JXA6
         9YKUpEKgB2Di3mwhWcegq90fM9c+jscu2yZPG+SITTc1pSTrWGR5/DlQ7kJChDNlb114
         lIYWvLdUtEBxMt3bwxid63+YTiR/An/07k41Yh1ICV2EmRsJunC8C22CzO1LbpAocHb4
         EAZzor8h0Tqq0x1Bf7BjK2InRyH7GZ9brLOOvKjDV2B5SRDtIVkGXANDBVOQMAtsrfQ7
         KND082sYmKm8TiobhlmsyveBC5zSsxKhLic+DTaY7GcATnP9/uEO3w+MJnbO4FrCGt4k
         /oVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dHVMl08+l+vQ9YTnNVwDAnHzpCOjuY39SKyRirVjzTQ=;
        b=IMctva5RbHgW29T4ywHfxzYwrNoIkjIbQuQj1qXIRt5m+kwJurbVkrbJQVmCRIovQz
         ZB7EFBiLUxH8tcaRuHB4PADSmCcT0kzqyq8yprjeunGbFoGjsmOfUdA+/3A2RQf2WE/F
         IWFPKJbjJmByOtjJppmdX2eP/Weu2fLH3WSqfOs94ZnLkbt9L6nfKisy//l7/fuT6Rgn
         XTVQiZ+vkF52LEWzr2yj1LVE2OAP6Qxb1HNdRnF4LsXEd2l619dtxvGmrIsyHw3sEAc0
         fEocsbYCEnwbD4nNlRPLWmLc2HN4SrDRfgv53Hc0D9ISB59eQRIJv84e5qMbJvebBCbU
         +gDA==
X-Gm-Message-State: AOAM531DnVb659AS9ylcbXz34BxztsBDM5hpzTZE4YOyzYcxPgL4mLmX
        1192N5Cwj9dQyrZdz3RfajL7WA==
X-Google-Smtp-Source: ABdhPJwp98oEt2udHD4SXf3NcqGc4V4s5RQ2QlyJFwFjWt2pfFIVuN7fqc4mpcEYGBB2RoYRhxZ84Q==
X-Received: by 2002:a1c:9692:: with SMTP id y140mr4270306wmd.128.1612541618991;
        Fri, 05 Feb 2021 08:13:38 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id v1sm9326402wmj.31.2021.02.05.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:13:37 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 6/6 v2] sched/fair: reduce the window for duplicated update
Date:   Fri,  5 Feb 2021 17:13:29 +0100
Message-Id: <20210205161329.22497-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205114830.781-7-vincent.guittot@linaro.org>
References: <20210205114830.781-7-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start to update last_blocked_load_update_tick to reduce the possibility
of another cpu starting the update one more time

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

v2:
- fixed compilation error for !CONFIG_NO_HZ_COMMON reported by 
  kernel test robot <lkp@intel.com>
  
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d2ab28d5736..f939a1faa014 100644
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

