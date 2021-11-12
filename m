Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC9C44E44D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 10:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhKLKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbhKLKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:02:21 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B32C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:59:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id v127so7202295wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 01:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hCgvDN8Ngaw/jszbWnAVkwtCYSGkPh/0woc9A8CagfA=;
        b=LU0JP1NMJCfP07A2uxfq+Qk0bG5Z27Yr20leufVN3r+jV6xfAJ3cNv8KbHTCpty+qd
         mzRIJ3gJr0Hg449ouHwMIeoCRVMklbKUWOtu2qaRqMzvRnPhO9wam2X9DKazz4Ey8p7a
         ZyEJl0O27J56yvNlb1k8eHH4+pVGhLT4+yDnM/N9o24G3Wn96PfmMpmVRx8HLiIfbzh7
         yjIwBdD2JmKxvBWA0M++QDt0zBSbOeeqDEWbITD/O/MwpT4TmfCXu+93jhOqF4VBonck
         5v3dYLBx3RXTssPoGtzYUQ+qYEMmqcfMsZ+/0/7VA0EPofoEFmPPMNzpUwzLbvuok33N
         pQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hCgvDN8Ngaw/jszbWnAVkwtCYSGkPh/0woc9A8CagfA=;
        b=scZn2Uucq6iLTSB70r5ap1zS9okbbYpeKb+RNoDQUsHqv6pkuT1kRfeHTHt47dGQuC
         aZm9utAmxuyKzBjRHuoQB1NiLdVRzwFvPJXd5bcj+C0sUgGl0C2kWAk3KERe7/Ve3UPs
         9oAsf3ueJ4IsVFhazjZw+cANUToQcUfJThvvvc7AJzCYTQENdcekDV2mwcUJ1j7QkSv9
         GdYigaOhM6PwCECVzpu7QKXhNtDJ/pjCq73Y97vriA9f1esOUwG1197atVSEhJzhGrYX
         IQYYPpWxElwY9UKGrjCkl3lkwhbRKxejQJFahCewsyPmzyXiVvTeVKuQ7YyG0xs/NbY4
         QpEA==
X-Gm-Message-State: AOAM533YtOLrnTZI4G5pEycEl9AwjtihnnUixbZKoIa1lxbC183eNRFS
        NtFx7W3vGTD6vUC2mBQ0Ouvzlg==
X-Google-Smtp-Source: ABdhPJylWNnkwJwK3kaTpJAFMb5tvDju3UPxYCGHSHExVuHUPywGw49gT2IgCP1cJiokMnbTBt2l8g==
X-Received: by 2002:a05:600c:1e1c:: with SMTP id ay28mr3616667wmb.131.1636711169667;
        Fri, 12 Nov 2021 01:59:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a45a:ef8:912:ffbb])
        by smtp.gmail.com with ESMTPSA id f7sm11589859wmg.6.2021.11.12.01.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 01:59:28 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] sched/fair: skip newidle update stats
Date:   Fri, 12 Nov 2021 10:58:56 +0100
Message-Id: <20211112095857.7016-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211112095857.7016-1-vincent.guittot@linaro.org>
References: <20211112095857.7016-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case we skip the newly idle LB entirely or we abort it because we are
going to exceed the avg_idle, we have to make sure to not start an update
of the blocked load when entering idle

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13950beb01a2..a162b0ec8963 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10861,7 +10861,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int this_cpu = this_rq->cpu;
 	u64 t0, t1, curr_cost = 0;
 	struct sched_domain *sd;
-	int pulled_task = 0;
+	int pulled_task = 0, early_stop = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10898,8 +10898,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		if (sd)
+		if (sd) {
 			update_next_balance(sd, &next_balance);
+
+			/*
+			 * We skip new idle LB because there is not enough
+			 * time before next wake up. Make sure that we will
+			 * not kick NOHZ_NEWILB_KICK
+			 */
+			early_stop = 1;
+		}
 		rcu_read_unlock();
 
 		goto out;
@@ -10918,8 +10926,10 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 		update_next_balance(sd, &next_balance);
 
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
+		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
+			early_stop = 1;
 			break;
+		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 
@@ -10969,7 +10979,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
-	else
+	else if (!early_stop)
 		nohz_newidle_balance(this_rq);
 
 	rq_repin_lock(this_rq, rf);
-- 
2.17.1

