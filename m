Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EDA319FEC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhBLNdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhBLNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:32:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69F6C06121C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m1so1006828wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EB0vWuO0TwMb5w0PVSL7dksbpRwSfKMcD0GtLsZEkro=;
        b=d+G0Wb3aC1cbCYDY8IzxdAhAPezB0mlZlkiREe/ePPd2MB5th3qCYAtv5KhAFTvjHI
         MzTsDc73h1Y+GHepfOvIvazxU/6IuR6czLvXuiVUgFX+gMxaWJLG4Q0UrwspjCgT7FmT
         XrpbpLN8B6h6n/cNB+brKePkwVCx9529wrzh/OMH3CEfFBgEedPNMdaU6Ae9udRa/rXu
         KM/PDnRL9cUygqJhd2yKfCF/g09LT8m1toR0XrqFdKXKfis0Y/d1X3Kcf6EoK+izPfo1
         ibiOSeSF4WbR7Tvmd0HSDeW2KJLSHKqe4LBgmBWrLQbuOYGm0kuW4gSAilw8HzFFZBLS
         uq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EB0vWuO0TwMb5w0PVSL7dksbpRwSfKMcD0GtLsZEkro=;
        b=PV85XO7hKvS8DVixtzzWvhvmKpdLI75HEJvTkvFg2axh5e53oC2wOuLxpsOFJXvCcZ
         yKfp7JHKz3K+Z8/x0x/1a8bqqvzMEXIkvEAGiWAQASUGz10e2jsqyATdF3ef/9V5pqwE
         FMix1jpgqunzuXyEy0Wumj7NcIOLr0h+3KdcEqpHSC1nxkPCbffTIaMxafZdbY42EX2g
         5PcS+nCd/Fueb2BnXyHnJwc/BCwEZCcInrx+9IpHiLyNjsqvh03n5skqiryMXFN/0uSZ
         Z3/4nH8aNNhM3Qq2Fh/kN+imJqvMRUv6V8+EOemFDr2W3XX5Z5VtaSCGkSTGzgGF6NJP
         XgCw==
X-Gm-Message-State: AOAM531foIUmrEfkcKGDYjKanljvLYxPykTUtsnRXxDqohuYZQpSUFkp
        ceWnnnCHwcU42a/T4zwvkkmSvA==
X-Google-Smtp-Source: ABdhPJwrTaBFL/XY6/UF8jydOA+GHC+SlhFXRkIBUBIm/Y3nipyXukrBuwSwYhaIrozkfIIy1aMtVw==
X-Received: by 2002:a1c:c903:: with SMTP id f3mr2693476wmb.69.1613136604354;
        Fri, 12 Feb 2021 05:30:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id h13sm10470773wrv.20.2021.02.12.05.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:30:03 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/7 v2] sched/fair: reorder newidle_balance pulled_task tests
Date:   Fri, 12 Feb 2021 14:28:47 +0100
Message-Id: <20210212132849.32515-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212132849.32515-1-vincent.guittot@linaro.org>
References: <20210212132849.32515-1-vincent.guittot@linaro.org>
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
index ac4add026f32..5d285d93e433 100644
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

