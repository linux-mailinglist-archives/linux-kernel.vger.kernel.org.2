Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB142319FE8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhBLNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbhBLNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 08:31:17 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1831C06178C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:29:59 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n10so1009665wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 05:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2V4M08K4U8B1wzSwmoXL8xs/JdGtwKipngDHkz34hSM=;
        b=m+DU+/sfHEQRrv5OCEU/xowICz7Q9mXp2pM+Ex4LfmL1doXMRgvKw/AfDg4TSTkNib
         6JCtxa2kqN0asIXcNttf5Bgiv5WHZKCfEqTp1fpR51Gd6PQilRLb13v3HODatWQSk7wb
         0sheMKoZTm5XBsL/DFLbKRdVA0YDJ+95vNqxdVJzWYA5ICDeAcQlT1+VDpjGrCNDRY4T
         JJbLHcx7BGdW8jpOrLUKpRbgZWi5xsZvEvg7KlL52WqcE3hfvf+xhWTsSjba/b6CVX4p
         G7P/oQNnUosNyQ4HVZxXsL2ySVG4lFpeDbJTXSg1nmyeVScpq84/ArXDPqGPebyIrIym
         cEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2V4M08K4U8B1wzSwmoXL8xs/JdGtwKipngDHkz34hSM=;
        b=d+1EG/ugGMQYuGmW3WXTXiBugrDSFnnjH92yfNwLVANy7LpJvGOjC5xwQHmL8VkulE
         UsR0oiGCeNxUX2rBinQtRkkQLsr48/OCaHuT1Igc1CtMoeC13PCEpM0EP0/MczEg26RP
         TeaMbA6mct2Pn/E2Zm/jcUo80B4o+7uGPMDv0vVBWt1/bef88wVY/egppWHtGQ8oMaGW
         qXS0b4jjQ8o6IeNK1p5Hr3cC2m1P4WNjeGlS7Msl9jfx3qdQbH2FCpKbrgCw/lWDi67R
         nluWCFudYFXRB4aJEXrxNOCpfgCirOVsKG5S7d0m509qlVBWU3gulphI6cnZxN0Be4KL
         vLKw==
X-Gm-Message-State: AOAM533QL6rzFYXGgr60wN4rsLUh9y2AwmKAafKgq7RWmhI9Yjk3d0KB
        1aLuI30BNBbjns1zEyMuMOS4Iw==
X-Google-Smtp-Source: ABdhPJx7cxbKjRoIuvSTAhW3yhd6uljGaqmgcHk0ymv4OvAtrJRbt3gfw1gV5/NGaD2eWIwFgWQm0w==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr2718872wmk.188.1613136598625;
        Fri, 12 Feb 2021 05:29:58 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id h13sm10470773wrv.20.2021.02.12.05.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:57 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/7 v2] sched/fair: remove unused return of _nohz_idle_balance
Date:   Fri, 12 Feb 2021 14:28:44 +0100
Message-Id: <20210212132849.32515-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212132849.32515-1-vincent.guittot@linaro.org>
References: <20210212132849.32515-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return of _nohz_idle_balance() is not used anymore so we can remove
it

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfe1e235fe01..f3f0f8cca061 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10354,10 +10354,8 @@ void nohz_balance_enter_idle(int cpu)
  * Internal function that runs load balance for all idle cpus. The load balance
  * can be a simple update of blocked load or a complete load balance with
  * tasks movement depending of flags.
- * The function returns false if the loop has stopped before running
- * through all idle CPUs.
  */
-static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
+static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 			       enum cpu_idle_type idle)
 {
 	/* Earliest time when we have to do rebalance again */
@@ -10367,7 +10365,6 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	int update_next_balance = 0;
 	int this_cpu = this_rq->cpu;
 	int balance_cpu;
-	int ret = false;
 	struct rq *rq;
 
 	SCHED_WARN_ON((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
@@ -10447,15 +10444,10 @@ static bool _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
-	/* The full idle balance loop has been done */
-	ret = true;
-
 abort:
 	/* There is still blocked load, enable periodic update */
 	if (has_blocked_load)
 		WRITE_ONCE(nohz.has_blocked, 1);
-
-	return ret;
 }
 
 /*
-- 
2.17.1

