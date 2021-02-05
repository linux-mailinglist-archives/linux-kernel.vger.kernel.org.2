Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC3310AAF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 12:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhBELyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 06:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhBELtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 06:49:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567B2C0617A7
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 03:48:44 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q7so7299612wre.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 03:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=R1k/G9W4vMVpJnpVB5SgdsbnWzbf5VfOkK8aj7ieetU=;
        b=VL8qh9wwj+URZ5yzW89Jcfthj5sOKKy7MuWnX0hN+xL7l28eNVmdCIqEbAYbpODw2h
         9C/kkBEiArBR0MBW1kUGTrGIG7C8oVYBiFqobNEC0Z9aOKOeAn+YGLHPHe5kJRjA9+yf
         K/VT7FAxIwXMHIp3/ZC1mL90I2nfzOPBgJMwdxh6VPXeh7NrBgdUmE6mSRuAvEQ98Tok
         zWYQYA+rumNBrdEMQKdG0WtmUo5juRq1k/fEdqx/xR1Yb8vXDOK6qJmfEnTjUsVyViQs
         KoLlAbsRQhvVHDIpjoj4vWCt8QwbL6bNOm/vPxv9OY6r/hQbgjor8bvrzcS3IEcuOqXC
         THSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=R1k/G9W4vMVpJnpVB5SgdsbnWzbf5VfOkK8aj7ieetU=;
        b=Oxfk/t258O15yR1KQ355APipB+Fdd8leRPiGnp+mAHFqMVYOz4V8rPSBmzdmDie7an
         vEloUcZRJvho1M42RkNas2wQf511U7eimATYrVSZyI7eNVJ/UlqIvmSbOvjbAivx7kL4
         9MeYnzBNb8ie/HYIv6jhM+hAB+6N44p99ewDsp2P595zDWnWhJib+AvsuY4O6iWwp50V
         f/puXMgprwfDhnLpvD8+uzH42fGmCcLJ1oosxYDtGlFMSb5/oEhFfzaK2sydBF2dOQR9
         nKE5htgPM0pCrLdSf+p1jpn6P40vB7Y2bNgw3nAJDg3WUKG0qsImeEn9GdQSzxSVkWe4
         7y6w==
X-Gm-Message-State: AOAM532ybTtsEh1rd/I47/3klkA1BQ8jnHtcDGlPZK1ooDfFFkUqzt0j
        eWbZblIg1stimN68tHV3Qo1gBw==
X-Google-Smtp-Source: ABdhPJzErVCq2EcNUJ/V5jC47wV+N069sR8h6Plwz7ZqfjvZjTQNWhqsVEc8BbeIXhS7hfuzHlChcQ==
X-Received: by 2002:a5d:4a09:: with SMTP id m9mr4667225wrq.122.1612525723097;
        Fri, 05 Feb 2021 03:48:43 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:442a:8956:28be:e500])
        by smtp.gmail.com with ESMTPSA id z4sm11647586wrw.38.2021.02.05.03.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:48:42 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, fweisbec@gmail.com, tglx@linutronix.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org
Cc:     qais.yousef@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 4/6] sched/fair: reorder newidle_balance pulled_task test
Date:   Fri,  5 Feb 2021 12:48:28 +0100
Message-Id: <20210205114830.781-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210205114830.781-1-vincent.guittot@linaro.org>
References: <20210205114830.781-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the tests and skip prevent useless test when no load balance has
been performed.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c587af230010..935594cd5430 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10592,7 +10592,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
-out:
 	/*
 	 * While browsing the domains, we released the rq lock, a task could
 	 * have been enqueued in the meantime. Since we're not going idle,
@@ -10601,14 +10600,15 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->cfs.h_nr_running && !pulled_task)
 		pulled_task = 1;
 
-	/* Move the next balance forward */
-	if (time_after(this_rq->next_balance, next_balance))
-		this_rq->next_balance = next_balance;
-
 	/* Is there a task of a high priority class? */
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
+out:
+	/* Move the next balance forward */
+	if (time_after(this_rq->next_balance, next_balance))
+		this_rq->next_balance = next_balance;
+
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
 	else
-- 
2.17.1

