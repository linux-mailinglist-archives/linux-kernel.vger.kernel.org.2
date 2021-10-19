Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D793433611
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhJSMiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhJSMh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:37:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDCC06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o24-20020a05600c511800b0030d9da600aeso2871488wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VbpSYYhmqSApsIZymBiS9kQ5AGKVcFL0cEBHXXx/c/g=;
        b=al+tSTDHoXlry3+FtxyhMGAW3vvkEHur8y0NBhQ5vvE7J8+D3fekzzada/dvZSqVyY
         prFm/zyno2djtaUN+SIW0d3f1aowuExTreRAyN1I5xruIVC40q5KScp8Ryn9EvrasN/m
         mruE1JnI3Nwt+vf6eKzb/NqH1R33WssipYNOBd9lS1taNxhgUTQw+7o0Tq0ztTvu4urn
         6hAsoJYLsTkgiUmbGcH3Mvc0AWbYxMo97hfGDdNXiWHzNSnivbvQ8cQLhYDWgmaKlglz
         tRNbgoIcHDqXVB/ZOR5wYih9phWxWRLdYXaHCFdscJr1BHZXFKDmghe2OYAvBthvTQ87
         zTeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VbpSYYhmqSApsIZymBiS9kQ5AGKVcFL0cEBHXXx/c/g=;
        b=k3b2SYplWnu2AAYcRF/rpxZwGxH5pJII1bupoeZizvUkemxkj2eTOGyd14hB6gRv6V
         jTIJQU0KIF0StoRx1kSV2n2Qm8v8oOiVJsKAi1cUxJm8ibYYHeIvFVMjyyBG8aEinKeA
         eQCQl3h2jA4zNPEew6vsBKEPL/ilcVZe45jkKpgWGimuGAUYnAzzqqrfJHXMFxdUHzEt
         HRMj5lxMFkck0XEczMYUJ+njBcWLXp/n22hOZjljkUDnNx4X8mL+8+sV3rBwkqp/9boA
         CaWQs+NQ5lvHVh6FF8ZGkYN0bpEQG/u0y1VZdFGXe3o/gw1sPwijwT1E6uKebNbN9pMf
         idJw==
X-Gm-Message-State: AOAM531ns53AXar+CGPHC1tH43boE6OWJvYbCG2Fiq1JlTFI4D/CCT04
        ye4Nm9RrAiZP3ITHNP/HiPjCu5Ql/1+rHg==
X-Google-Smtp-Source: ABdhPJxaSVhRJ9gd1EcYJ76L8tpP0hrqEmOMWyioEik9uwiv+MGHA+f+LDyNji+Oi7wTb70/DVBZGw==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr5915739wmc.94.1634646944360;
        Tue, 19 Oct 2021 05:35:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6dc7:9883:a79c:5be9])
        by smtp.gmail.com with ESMTPSA id p18sm15263683wrn.41.2021.10.19.05.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:35:43 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 1/5] sched/fair: Account update_blocked_averages in newidle_balance cost
Date:   Tue, 19 Oct 2021 14:35:33 +0200
Message-Id: <20211019123537.17146-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time spent to update the blocked load can be significant depending of
the complexity fo the cgroup hierarchy. Take this time into account in
the cost of the 1st load balance of a newly idle cpu.

Also reduce the number of call to sched_clock_cpu() and track more actual
work.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 87db481e8a56..c0145677ee99 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10840,9 +10840,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
+	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
 	int pulled_task = 0;
-	u64 curr_cost = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10887,11 +10887,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_rq_unlock(this_rq);
 
+	t0 = sched_clock_cpu(this_cpu);
 	update_blocked_averages(this_cpu);
+
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
-		u64 t0, domain_cost;
+		u64 domain_cost;
 
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
 			update_next_balance(sd, &next_balance);
@@ -10899,17 +10901,18 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
-			t0 = sched_clock_cpu(this_cpu);
 
 			pulled_task = load_balance(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
 						   &continue_balancing);
 
-			domain_cost = sched_clock_cpu(this_cpu) - t0;
+			t1 = sched_clock_cpu(this_cpu);
+			domain_cost = t1 - t0;
 			if (domain_cost > sd->max_newidle_lb_cost)
 				sd->max_newidle_lb_cost = domain_cost;
 
 			curr_cost += domain_cost;
+			t0 = t1;
 		}
 
 		update_next_balance(sd, &next_balance);
-- 
2.17.1

