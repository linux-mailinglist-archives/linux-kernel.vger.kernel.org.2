Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B264324033
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhBXOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbhBXNcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:32:25 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6479EC0617A9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id x16so1790995wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2ZZxllJAAoS3T93z62IqzkafPxDUkrU3uf6dCXB6yRw=;
        b=Udbpx7ag/9R2s+aggjsfpYUxUW2sh8H7OopIjcj374ixzMO9vqhOuTq3VVunRlcBKc
         TwIspf59sUkz/oIwsLurB6CFaU+2erweekkp+nMQYFooAODK9K2WXy4JemHGc4wYsXlA
         QW4SlSSwjqFLoV63XtVvqLyTptigJvCIJKQcaY1PFO7FkawypQXyOnno/ZbAJqpfAbXF
         FM7rKMQm7K+Ws3vCh8dvRT42d5GHTA3GK4g7V02dfPkNmAOVIXcBV9KzGdkCybqRgHnc
         qyBO3OMwhQzMwaPXXVH3jTCWK8xq47mxOp9k2oNQbTYoOOvKal20XWLXIXlUINo73to9
         ytrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2ZZxllJAAoS3T93z62IqzkafPxDUkrU3uf6dCXB6yRw=;
        b=ShMGCRz/ZNHY99k9dsG2rnkc2sXSREK6HkNtUg18F9Xhu/17Wd/SX2SwdeWs1NiSLm
         ZgH6BO4tg6SQ0es+zWCOqvCXfor0jEwtkcOMBfshh9rjA1whWwukqSi3wJZHfJXhr2QW
         T9KZHJQa8t8JfIAeVtTMZMzEiaIllKrWdO1mMB1KGDjObuLsLlwX/IUuDhCxPQ0jWe17
         EIzeewQyzLFrJRskWtSASxXzojs51qmLbbf/Zy+Y77OwxXhsVnUSUWvUPgkFXhl7CpCw
         ZH7cjYPIbZ7pX3i6TJfCiuxjZR9DC9PtQQr2xuJgQ2USZ5kycyxC0WAwf3mY2i5vuAR5
         FWMA==
X-Gm-Message-State: AOAM532FT2/nynXf+xiEcj/b+31FqzAgM0RrLgm7M4gfAWOFDBBx8St2
        u5hZ3omFoivGz1NqClrohkxAJnoyfUUHKA==
X-Google-Smtp-Source: ABdhPJxAV8DUrqLn/td9G39RHmNMHi3uqPVgDWqe9CCWCv5bw9eeapLnkbqrY9WiFzNsw303N5M/uA==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr3773010wml.62.1614173427157;
        Wed, 24 Feb 2021 05:30:27 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:58e9:8af9:3cd4:ded2])
        by smtp.gmail.com with ESMTPSA id h10sm552611wrp.22.2021.02.24.05.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:30:26 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/7 v4] sched/fair: remove unused return of _nohz_idle_balance
Date:   Wed, 24 Feb 2021 14:30:02 +0100
Message-Id: <20210224133007.28644-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210224133007.28644-1-vincent.guittot@linaro.org>
References: <20210224133007.28644-1-vincent.guittot@linaro.org>
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
index 0d45b7716384..e23709f6854b 100644
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

