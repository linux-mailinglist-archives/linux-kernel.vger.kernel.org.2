Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34BB324047
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbhBXOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237018AbhBXNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:33:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C767C061356
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t15so1872660wrx.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nmdj7HExKKLHZh7fCMth8tcKoMXKbV3mej6JN8TxnLQ=;
        b=aPeqnr1o854ZRbctr+oJP68VqImfcqt2FpickfEodXsEBCjN64Xtqh4HIewXbDxHdU
         kTPS5zuxf0V03meM+MPQmB18BdVoTco7Kv3AQo+3+I082Udskrw4BoZOdHQdhyIJP1gQ
         KdxypkWCM+y/D7EB9mQGOQVTiRXwbw1EQO5yGzWywQF/wJttTmDbEmgQIN2ApqMdsEFY
         GWgmuUJPNdHPC0JSM1E7PLBlzf5oiwiy0UxzDjQVeFlYeQZuO5ER1Efa4M+jTo8ZDCQW
         /4MCp+Xy6o5kpsA2LEXhB9/vM2LuSwsuKF8RD2SUW7Y2BtmJsGHexj+XudA0wD684wlO
         JGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nmdj7HExKKLHZh7fCMth8tcKoMXKbV3mej6JN8TxnLQ=;
        b=qqHkiSb3eyi3Pv5wZ705oLSUyf3SioazuVziDRuYY6j8l4+SjVbvdzPAB23HfyKgnq
         L2xvbSFle7g21ITNPX1ZQlhUS0D3DDESMyi9r9Cwgbv73COXiuMQIZ5vAcUGHjP5dafz
         p2Mqw/9FQgJaG7QUNO/hFM6L/+O1uNCbFd9rsIFLGmJl7wNfpiuAPBQF/FALZzGA5OJa
         0m3pjB58fJLEy18FHhwspPGKfMb/1XQXAbxhClgqciKhT1wcKDlRM98qAY+2d3yLiHyz
         gP8b1Dzib4Wqe+2QucW/DRS11ArlaEUBOQAG5PnnVrmcoHUM1dVYrV8d4ksZ4e9XGqRS
         AB/g==
X-Gm-Message-State: AOAM532uSRZr0gvaYQWkYIR2pAWINjmwAm2ljj7sdv2fzecxb8/AgjiI
        KSvCgo68dX1AVsuAUrbYNslOiA==
X-Google-Smtp-Source: ABdhPJxe+zRWwW/6T+527Mj/5MN1E+bM39qdWMfdeuZ2wO0zg6OmbjWMPM03cH3Vq6Gm5bmhpvSWtw==
X-Received: by 2002:a5d:4e50:: with SMTP id r16mr31272356wrt.127.1614173432401;
        Wed, 24 Feb 2021 05:30:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:31 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/7 v4] sched/fair: reorder newidle_balance pulled_task tests
Date:   Wed, 24 Feb 2021 14:30:05 +0100
Message-Id: <20210224133007.28644-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the tests and skip useless ones when no load balance has been
performed and rq lock has not been released.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0323fda07682..586f6ce0d302 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10584,7 +10584,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
-out:
 	/*
 	 * While browsing the domains, we released the rq lock, a task could
 	 * have been enqueued in the meantime. Since we're not going idle,
@@ -10593,14 +10592,15 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
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

