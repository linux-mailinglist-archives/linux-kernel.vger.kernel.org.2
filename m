Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1699744E453
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 11:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbhKLKH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 05:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbhKLKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:07:54 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C56EC061766
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:05:04 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id d24so14593699wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 02:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=24qJHcfmdUUc/HGsQ2S/13SApuEaslQ6pjsG/nxLLt4=;
        b=wRVieX4Qao3EC4JRg3no8OUT1PdKiHCwGD0OWXZu2yWgIhAniGSqhZcgQWydRfX12l
         oGGcnyXHbt+mXpWzc6EPYDpnX2UnOWgif+7QH1nzz354umrPGBnGpVj55BkH4bKTogmd
         hT97aRPEbUOgythwKU8StK5PY9qfJkkoDabWb+p7unsiTP7jcFKp9LwdxsRBcAS3eN4p
         fNdDEwSryb/tYwYg/8VDUGdqO+P1IyQdb2kea2/b+UjiRZzc/ASu7Zbrbrtu9OkFDjST
         I302SSXjlOMh5rEpQNEN9BjC1oze9hhMxjzwVmlhF1RRoHnae5pqJREQRYsfzHewNDY3
         FFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=24qJHcfmdUUc/HGsQ2S/13SApuEaslQ6pjsG/nxLLt4=;
        b=aTtRuzOiNcC10M2ByY2s2jQ2jVcFAia2si9U512fWi06MwITNR40SdaAdNqQZHVT9b
         wv5WniIv3rhF2KMh/g4VxrR9We3YZcl9q+YHv2opZjsk4pgjdWoyrr/QBaBOGELWSYjI
         /V0BaRtCS0TzDsl8yVVuYPHIyTWc3CJAuyAZDKb22HSi6cDzLSL9wEKFRS3Fb0FgoHaK
         MyV8xxFqbmpCStJnhrCZ3j1c+SkcCt8oVZjnss+BWLRng1oOuWlEcPMCVkWKPxObgDmq
         4tGkBdFVvGSaUDBvkzO0BMnU+23ZUU986oVYIEQZMRzcM5bKB79kHV1Ie/hpKcbu4iiK
         dUdA==
X-Gm-Message-State: AOAM5309sNjn8VD1lWfZk1cJjDenwGjclwK5DpZwYz1yPuxNKfMIfQj6
        iqu/Sr6NqsFsyDP2TO8Gzd+B8w==
X-Google-Smtp-Source: ABdhPJxrTxobtIr/ubi4iFGmqgbScStUgSJiXKUqvGPoP0SSQx7958B3nB8wPU4C2rFdeF1BJnDEZQ==
X-Received: by 2002:a5d:6781:: with SMTP id v1mr16590163wru.239.1636711502459;
        Fri, 12 Nov 2021 02:05:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:a45a:ef8:912:ffbb])
        by smtp.gmail.com with ESMTPSA id t8sm4637258wmn.44.2021.11.12.02.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 02:05:01 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] sched: sched: Fix rq->next_balance time updated to earlier than current time
Date:   Fri, 12 Nov 2021 11:04:58 +0100
Message-Id: <20211112100458.7958-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tim Chen <tim.c.chen@linux.intel.com>

In traces on newidle_balance(), this_rq->next_balance
time goes backward and earlier than current time jiffies, e.g.

11.602 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb739
11.624 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb739
13.856 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73b
13.910 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73b
14.637 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb76c jiffies=0x1004fb73c
14.666 (         ): probe:newidle_balance:(ffffffff810d2470) this_rq=0xffff88fe7f8aae00 next_balance=0x1004fb731 jiffies=0x1004fb73c

It doesn't make sense to have a next_balance in the past.
Fix newidle_balance() and update_next_balance() so the next
balance time is at least jiffies+1.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
[Rebase]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a162b0ec8963..1050037578a9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10138,7 +10138,10 @@ update_next_balance(struct sched_domain *sd, unsigned long *next_balance)
 
 	/* used by idle balance, so cpu_busy = 0 */
 	interval = get_sd_balance_interval(sd, 0);
-	next = sd->last_balance + interval;
+	if (time_after(jiffies+1, sd->last_balance + interval))
+		next = jiffies+1;
+	else
+		next = sd->last_balance + interval;
 
 	if (time_after(*next_balance, next))
 		*next_balance = next;
@@ -10974,6 +10977,8 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 
 out:
 	/* Move the next balance forward */
+	if (time_after(jiffies+1, this_rq->next_balance))
+		this_rq->next_balance = jiffies+1;
 	if (time_after(this_rq->next_balance, next_balance))
 		this_rq->next_balance = next_balance;
 
-- 
2.17.1

