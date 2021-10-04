Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226FD4214FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbhJDRQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbhJDRQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:16:50 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F30C061746
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:15:00 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so20307097wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w4xSNSmjSiSpLpmEvXVjq/Q7CMBDgmpwY5Ujo1bRLNY=;
        b=eIkQTySCilRaXBSVPj6vUNX7MmKwqFsTMt1Lg3nnJGTCd+SZS8qR6mdBizoroIDc91
         jZtSMl/IQudXVwW7i7SFQRXNaGLja8As6ayhzsZdr2lSfVExcFZSOLz10x6mLDj7OVGH
         1IAbtnHtBY3FphmzV4zMzrM2A+NXHEXB//3P7m6T5WF99r1AqkMOtViV9scAF2foiuus
         iRYZXXTKgXV27+dzg1JmDQDIvf/RGjN46E1DMbty1OUYjK97LlGfArhOb+kb6tDfha8Y
         PXQ8ixfpJt57YH6K13N9qMMZGStFJuBp/3LdJSJ9kPi94rbkmd6ok4ZCsbqQo2obF0Dw
         VIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w4xSNSmjSiSpLpmEvXVjq/Q7CMBDgmpwY5Ujo1bRLNY=;
        b=GF16Kk2+fDQDhzCqa9yoXselWwUJqKGQAdwSpDQKY87Bddi6ljuoOtbzpmQnlgUMOV
         MJyGIXXOSfIYBiLvs/wnftmsgLu414w4ia38OXXOAssG73By54ZqigI0ylWM095P72Sf
         YTV53wFUXlQDs6ous4Mp34uVaKxoSrbO0ZYUSHT9wEuOJoiWtakeAL+dMjr0V7E60pDi
         C1j1qM7EMmesDpkjZplzNy+r7X2UxFJaKvT8izo/qwz662C66+SbcFZEMWWnveW1FrQX
         phMPnRpRF5BV/G4bFNhSA3+c+55RwoFDfr+/zlj0gmCBXvh5/9DxvK9HOAuyE5eVNyMe
         1WfQ==
X-Gm-Message-State: AOAM530xcM8zpWAVlPMrYSEUmOg27RBBCq3V9TuslVQdN+zp8a99Zyyw
        dzY8BLOy5LyjDfW8O7QUgmGrSPy6SgMMlQ==
X-Google-Smtp-Source: ABdhPJxRKTg+KE/nvLFM6MkiYU9eIveHM+yLM/0SRVKJ3/WbcqG1XSZgMvo7dB63VT63lO2tfrMdbQ==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr19831660wma.75.1633367699582;
        Mon, 04 Oct 2021 10:14:59 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:9c40:6a4a:bd46:e324])
        by smtp.gmail.com with ESMTPSA id g25sm14833116wrc.88.2021.10.04.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:14:59 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/2] sched/fair: account update_blocked_averages in newidle_balance cost
Date:   Mon,  4 Oct 2021 19:14:50 +0200
Message-Id: <20211004171451.24090-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004171451.24090-1-vincent.guittot@linaro.org>
References: <20211004171451.24090-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The time spent to update the blocked load can be significant depending of
the complexity fo the cgroup hierarchy. Take this time into account when
deciding to stop newidle_balance() because it exceeds the expected idle
time.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8943dbb94365..1f78b2e3b71c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10810,7 +10810,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	int this_cpu = this_rq->cpu;
 	struct sched_domain *sd;
 	int pulled_task = 0;
-	u64 curr_cost = 0;
+	u64 t0, domain_cost, curr_cost = 0;
 
 	update_misfit_status(NULL, this_rq);
 
@@ -10855,11 +10855,14 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 	raw_spin_rq_unlock(this_rq);
 
+	t0 = sched_clock_cpu(this_cpu);
 	update_blocked_averages(this_cpu);
+	domain_cost = sched_clock_cpu(this_cpu) - t0;
+	curr_cost += domain_cost;
+
 	rcu_read_lock();
 	for_each_domain(this_cpu, sd) {
 		int continue_balancing = 1;
-		u64 t0, domain_cost;
 
 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
 			update_next_balance(sd, &next_balance);
-- 
2.17.1

