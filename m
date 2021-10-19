Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A3B433613
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbhJSMiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235692AbhJSMiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:38:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22A0C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:48 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i12so47374171wrb.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6CK6/+q8aXew5IcuMz3Fih447x496rJhBuuR5ERVtjA=;
        b=cM1lXfg/BqvlHfxKBgTeMk2o7A1TNb9l1hrJdj7WsrlhIR9Se5nK6Kej6fMlponRvJ
         GeViIauxTio4qYLbGPTLiJsZqOflSk+CRXoFuzpIdFk3y52A5YFjAYov6XKthYyTAxvv
         35Af7SjKhni/3PllPbdQGcT0OV/gGO4rzmasLpGTdmcfCuc94y5POodStoOPCOV1tIs7
         8SeteFpW6AgRvqaQubxduuJZq1eQsplvOxck8LEMGE703inHLsrRA0ubKum2LVYtbhzT
         +gJLJASM3tFsnFPg3t6YviL3ghYsSG9YPyvTZeipD8YwlSFzeLIgMlgZazUszwEstGCl
         W+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6CK6/+q8aXew5IcuMz3Fih447x496rJhBuuR5ERVtjA=;
        b=npWyD793zSOzwh8uA7USWdlpuGQkDuhwiRm4nL3FP5r0s21ukAU6gvLpQcb233GT2h
         NKh0eNyYVOvmTwTig30Q0U+lPyXhXkGRm+kBDlR2GW9F9S3cmtZ16PqO3RZPtBBZDa/j
         UCedowD40xBfYjDc4PIN1vp328HsNrWORo5AO6JzL6lGpk+5rcMBjYzbyqVpdv11bG4c
         YJJ+LdChpJmxwfaPfl9R1sqBwUKzYwRyqeTh8SmnN+/tRfaRllMPu64I5KgplYOdSXdO
         jIHvRCmbVY4s8QaR0/jldssyUs4bbYdjmxh4q8SqSIXuzv8V9H6fpkPtTXBUaBf/SvfH
         FnKw==
X-Gm-Message-State: AOAM532caVmqFhU6aoDnm92AJ3gwSrOerqV7/xMeh2/BHw6e/vFsv7Mr
        BwT1oN4JbTLHHej4vplVgv3Pfg==
X-Google-Smtp-Source: ABdhPJy7bzusnyxXHXIH1HMj1OhGds/LOIDwnHs4SAv08y3hlqsgbVHkwgOXFCWCp8KZYjP11niXuA==
X-Received: by 2002:adf:f812:: with SMTP id s18mr6562620wrp.347.1634646947552;
        Tue, 19 Oct 2021 05:35:47 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6dc7:9883:a79c:5be9])
        by smtp.gmail.com with ESMTPSA id p18sm15263683wrn.41.2021.10.19.05.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:35:46 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/5] sched/fair: Wait before decaying max_newidle_lb_cost
Date:   Tue, 19 Oct 2021 14:35:35 +0200
Message-Id: <20211019123537.17146-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decay max_newidle_lb_cost only when it has not been updated for a while
and ensure to not decay a recently changed value.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/topology.h |  2 +-
 kernel/sched/fair.c            | 36 +++++++++++++++++++++++++---------
 kernel/sched/topology.c        |  2 +-
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 2f9166f6dec8..c07bfa2d80f2 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -105,7 +105,7 @@ struct sched_domain {
 
 	/* idle_balance() stats */
 	u64 max_newidle_lb_cost;
-	unsigned long next_decay_max_lb_cost;
+	unsigned long last_decay_max_lb_cost;
 
 	u64 avg_scan_cost;		/* select_idle_sibling */
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c4c36865321b..e50fd751e1df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10239,6 +10239,30 @@ void update_max_interval(void)
 	max_load_balance_interval = HZ*num_online_cpus()/10;
 }
 
+static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
+{
+	if (cost > sd->max_newidle_lb_cost) {
+		/*
+		 * Track max cost of a domain to make sure to not delay the
+		 * next wakeup on the CPU.
+		 */
+		sd->max_newidle_lb_cost = cost;
+		sd->last_decay_max_lb_cost = jiffies;
+	} else if (time_after(jiffies, sd->last_decay_max_lb_cost + HZ)) {
+		/*
+		 * Decay the newidle max times by ~1% per second to ensure that
+		 * it is not outdated and the current max cost is actually
+		 * shorter.
+		 */
+		sd->max_newidle_lb_cost = (sd->max_newidle_lb_cost * 253) / 256;
+		sd->last_decay_max_lb_cost = jiffies;
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
@@ -10262,14 +10286,9 @@ static void rebalance_domains(struct rq *rq, enum cpu_idle_type idle)
 	for_each_domain(cpu, sd) {
 		/*
 		 * Decay the newidle max times here because this is a regular
-		 * visit to all the domains. Decay ~1% per second.
+		 * visit to all the domains.
 		 */
-		if (time_after(jiffies, sd->next_decay_max_lb_cost)) {
-			sd->max_newidle_lb_cost =
-				(sd->max_newidle_lb_cost * 253) / 256;
-			sd->next_decay_max_lb_cost = jiffies + HZ;
-			need_decay = 1;
-		}
+		need_decay = update_newidle_cost(sd, 0);
 		max_cost += sd->max_newidle_lb_cost;
 
 		/*
@@ -10911,8 +10930,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 			t1 = sched_clock_cpu(this_cpu);
 			domain_cost = t1 - t0;
-			if (domain_cost > sd->max_newidle_lb_cost)
-				sd->max_newidle_lb_cost = domain_cost;
+			update_newidle_cost(sd, domain_cost);
 
 			curr_cost += domain_cost;
 			t0 = t1;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e81246787560..30169c7685b6 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1568,7 +1568,7 @@ sd_init(struct sched_domain_topology_level *tl,
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

