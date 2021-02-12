Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AFE31A07F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhBLOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhBLOSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:18:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964BC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v15so8111481wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2V4M08K4U8B1wzSwmoXL8xs/JdGtwKipngDHkz34hSM=;
        b=ZoPQPVpT+dk/LmXrz/MvhbA0ixo8MtJWf+660r1d8mgNcy7mUZaGdaxOz9xBtUnQA6
         3goyGl81E/GmY7dDQD2Djmqt6matYyCzLLb4hTtFrCd3Dthzxci/UXRMv3Ds+mgaG7lP
         KFdn4KOAKfAvbz52gROWs9+lwkZpklk73fvdW4GybJHDiepoiNpe7i6VSRLMNc7rIWHH
         kufI95qwQ8eRXx3Zc3YOxx8FJq9QdsMO7amNsUW1ny0ALRZhW5nnpyL5E+tnbBfXG1tx
         zmQ1AQCGf/thMJ/Bgnd8Ksd06k2fJEKZh7y3vjBnc+Uta/KNDN6iR3vrmpYMNzg5Mr96
         BO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2V4M08K4U8B1wzSwmoXL8xs/JdGtwKipngDHkz34hSM=;
        b=cVWKA80/vo6IDeZ9dAWdRxFHdfzOwhetdVfVk1PDawnZmCfpIvrdly4I0aUBy12c2n
         ilHvvkEGxfEnU8UxQYjbNH6079/HkOrH4/+6z9BNZ1iul8a+7/BnM/Sx1bVSJhnFbDA4
         VTAi9fhRpsSAwJrvNF+jz0nEEOj0zEPoMbw+9hwN73khZpkIvDiuh17XgagulqEhy4Vz
         i5sDbVHdZ7o1ATNtZWMrhEBqqLGASZtwmRnHLPJ97n3D3DD6diJWCXbndiJIIXHEBfyG
         bqWbDCTYjyVdZnVB/xtEb2dmR44J+sWD563yNEld5sweuqd1n7dbA4Olv3PDK7E0SqPg
         Y5mw==
X-Gm-Message-State: AOAM530q1mWebfp/tKDoDMLSNSSatRNKLMx4Kys7m+PwQLxkcdAMbepH
        rPhdexEuN+oxPVECWfDHKegzKQ==
X-Google-Smtp-Source: ABdhPJz+pgAzfSrhT0Fset/M8Oqpt7WMGDehP5m5Exh5YR8OfThaWwklkRdBLDNVPftvN4VAXGe/lA==
X-Received: by 2002:adf:b342:: with SMTP id k2mr3717557wrd.264.1613139472127;
        Fri, 12 Feb 2021 06:17:52 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id f14sm14254156wmj.30.2021.02.12.06.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:17:51 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/7 v3] sched/fair: remove unused return of _nohz_idle_balance
Date:   Fri, 12 Feb 2021 15:17:39 +0100
Message-Id: <20210212141744.24284-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212141744.24284-1-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
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

