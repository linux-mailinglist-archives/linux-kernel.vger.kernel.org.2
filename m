Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBAC42F164
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbhJOMwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbhJOMwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:52:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CE8C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r18so26368896wrg.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2rHh65qr9eE9/Ond3Z5wrAABiGrbvVxaB7H025dIVC0=;
        b=DgFpL7u41eXJn83vm6e13iIAZhl6VI/xYMtyPbY1brsGGRXEZENQja7iwvlxbb5n4Q
         CDGSFY6WjFFZN3nFfADt0KL/F3LWg7/mXyFDKK5uhcKTygZK22jhFH3Jw1BsDTyX7Aia
         zWS4o4gZ2Tyw66qkeEZ5RRSJIydVQxlowzYiKHTcYJ2PBOFGqvDnDpXI3Wbg70yA5gWJ
         G68bv4ADOO5CltN2AujqK0ZtyU1bRzz89/v0YBt7QlwPjOTlcZDmNVE+an9LEaqGlaOP
         U5mpH941K6j+f3QYNCWoU0x16wSA6jfaVnVUGVwG/Z+WExiVnOSjc58fyx2Ae0FWcw5S
         quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2rHh65qr9eE9/Ond3Z5wrAABiGrbvVxaB7H025dIVC0=;
        b=pBfvtYYu0FEZPPD3M1ltLapfr7xNMcYVpieD1Lix2u5ESQxEk9L1gs38c8wWA8CNX/
         JodDMlRIsvo0cJxFII6Z8e5RdWb4NfJ4NkqtvOESQbuw7as7zEuUG4Ea8C8dXTAQVzbH
         iBF6QCqTrxPyjOrJFNAd5xv7JlfLFqqVKuwoPNLO3Syfva0LdAjeQ1U0/wJMgJHss0E+
         1R0+vtqPfl9nX2s9K2K4S8ZP7k3Rmis5+ighBIWZcSBedzhiibIExtgDnY6F+JWxl65b
         AnS9CoSi6RcBKzdL03PkTVXxNo3ENLB2gJraS7DvxIsYD30pYOezBzi8EEj7qinO6cFw
         tCng==
X-Gm-Message-State: AOAM532rYlBMDY0ACcnt/7Wz7iTg62jDMZQq2qSFyOcMNMx8RD8v90vX
        DEGvODZYYGlcrEMoaoeFZvp6Vg==
X-Google-Smtp-Source: ABdhPJw9ZcFIplRj2reC5Xtjbj+WbOcn0174+tc2/x51L3gxNmLROPjLRjMo/Wg6VAsjm/iAJxr+qw==
X-Received: by 2002:adf:bc52:: with SMTP id a18mr14319470wrh.245.1634302232258;
        Fri, 15 Oct 2021 05:50:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:7ce7:a27f:aba7:bb9d])
        by smtp.gmail.com with ESMTPSA id a2sm5468403wrq.9.2021.10.15.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:50:31 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 1/4] sched/fair: Account update_blocked_averages in newidle_balance cost
Date:   Fri, 15 Oct 2021 14:46:51 +0200
Message-Id: <20211015124654.18093-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211015124654.18093-1-vincent.guittot@linaro.org>
References: <20211015124654.18093-1-vincent.guittot@linaro.org>
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
index 2468d1d1edef..a7429dec8e2f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10841,9 +10841,9 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 {
 	unsigned long next_balance = jiffies + HZ;
 	int this_cpu = this_rq->cpu;
+	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
 	int pulled_task = 0;
-	u64 curr_cost = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10888,11 +10888,13 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
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
@@ -10900,17 +10902,18 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
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

