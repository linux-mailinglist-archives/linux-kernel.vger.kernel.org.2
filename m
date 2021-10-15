Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB642F166
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239162AbhJOMwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239115AbhJOMwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:52:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAADC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id o20so26396286wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UPOdXwC1kuNdyAL0bf/AY2eNEz9jvw3Kld7w4EKJpxM=;
        b=CVS0a1oceUmEd+Kx09zCyhBzMhQzLhie+p8zNt/jDyo/wVLe/igIW4TfWAw7629FDf
         +MFPKKfOR0HKyh9QsJ+TmRCnTbGPEipU7oh+ZdfybdDXTnPP7iJhxaaiYQBbMpDbgiNC
         XkJMZps0dWQapa0Q5TtEhttPRnPP4PmItqVP090GPE5QZKEQ7B5TGa5mcs2dYpc+HY7U
         wZiuFx5ugcRASNmE5FZ5aveTj76PjSwPIUe5ErzXCZKx7Pe/hQaNknXsRtfQP+cZuGjI
         ZmsggSbWPP0T+C4sWoSAWkrAPr/96yiOujJ3s4mx/P/le8y5Zw+mchZayp1EdAsgtXY3
         yPig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UPOdXwC1kuNdyAL0bf/AY2eNEz9jvw3Kld7w4EKJpxM=;
        b=stqLB3I+zJ1vS+lJWzlTz7cHoVGotEwfyQGNX1pvKV6UzE4BlIie9lT/LKnYcHefGv
         /q6GTLtF/bmP3ByKbbM2LyucTyLfOkPoGgE4DF3qp9V1GNV3yzto3a4yNYZnVLq+lI97
         7iXxSL0kJYzOHYo7eW6bM0Db9x0S7EIrTG/C33YRQPWvapZyJYiFSFW9QxylPELyzZUj
         pGYTD5Cwr0h+NcpEpx4YMUCot/AvDd4usOgfR58rA99OmJ7mE1uEZRwV2YVk8athwhLg
         NzDAkxGLoFmSzr2ucjBnY3O4LdnKq480U9cfdz6VZlihVY2IPPRsz34Er0eB9Vaw5nW2
         5vlA==
X-Gm-Message-State: AOAM53132KG2V+4Yd9BFsxwDrj4gJnYcPfEmtl04qLABD5/SRuyuiYjB
        ZyzNEYjFAkJN9eSjJJ8b2i9uVg==
X-Google-Smtp-Source: ABdhPJyIj3fDaYmUIQX/uw8tcvHB9NzVYpyZzpFcI/AI2ErDnN54sQMR/ofEq2b8Q3Wv/FT5h9L0AA==
X-Received: by 2002:adf:e60a:: with SMTP id p10mr13905554wrm.306.1634302235499;
        Fri, 15 Oct 2021 05:50:35 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7ce7:a27f:aba7:bb9d])
        by smtp.gmail.com with ESMTPSA id a2sm5468403wrq.9.2021.10.15.05.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:50:34 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/4] sched/fair: Wait before decaying max_newidle_lb_cost
Date:   Fri, 15 Oct 2021 14:46:53 +0200
Message-Id: <20211015124654.18093-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015124654.18093-1-vincent.guittot@linaro.org>
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decay max_newidle_lb_cost only when it has not been updated for a while
and ensure to not decay a recently changed value.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/topology.h | 2 +-
 kernel/sched/fair.c            | 8 +++++---
 kernel/sched/topology.c        | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 8f0f778b7c91..9c8878f201ab 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -98,7 +98,7 @@ struct sched_domain {
 
 	/* idle_balance() stats */
 	u64 max_newidle_lb_cost;
-	unsigned long next_decay_max_lb_cost;
+	unsigned long last_decay_max_lb_cost;
 
 	u64 avg_scan_cost;		/* select_idle_sibling */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6b8065b72847..2967d13737b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10265,10 +10265,10 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains. Decay ~1% per second.
 		 */
-		if (time_after(jiffies, sd->next_decay_max_lb_cost)) {
+		if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
 			sd->max_newidle_lb_cost =
 				(sd->max_newidle_lb_cost * 253) / 256;
-			sd->next_decay_max_lb_cost = jiffies + HZ;
+			sd->last_decay_max_lb_cost = jiffies;
 			need_decay = 1;
 		}
 		max_cost += sd->max_newidle_lb_cost;
@@ -10912,8 +10912,10 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			if (domain_cost > sd->max_newidle_lb_cost)
+			if (domain_cost > sd->max_newidle_lb_cost) {
 				sd->max_newidle_lb_cost = domain_cost;
+				sd->last_decay_max_lb_cost = jiffies;
+			}
 
 			curr_cost += domain_cost;
 			t0 = t1;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c56faae461d9..edd71649d579 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1572,7 +1572,7 @@ sd_init(struct sched_domain_topology_level *tl,
 		.last_balance		= jiffies,
 		.balance_interval	= sd_weight,
 		.max_newidle_lb_cost	= 0,
-		.next_decay_max_lb_cost	= jiffies,
+		.last_decay_max_lb_cost	= jiffies,
 		.child			= child,
 #ifdef CONFIG_SCHED_DEBUG
 		.name			= tl->name,
-- 
2.17.1

