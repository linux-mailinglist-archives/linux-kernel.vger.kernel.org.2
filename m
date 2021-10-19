Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D992D433614
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhJSMiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbhJSMiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:38:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891F0C061765
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y3so47646013wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BDhXeFZOEER6fzhifbvaPju9Ij73EweA3xek0ZW9GxM=;
        b=O/3N4FBblQXfYumsJFu0xnxZUEiNNfCAcDn5FUIfZN/ZOMf2qzlRE2RGnp01DUT5DG
         hsOmrTrA0EvNcuO6R7qDARn5Vegp7Qq0MKgQtrVy0y15ya7kTrml9OXt07T73O/NhFEB
         fVZLGipffqJ3LEkkGsc36QHqS98wDTmf/7nEY0NR3eJfNMtiM91oq5PAVo7iHzjkR223
         4Qtnc7dPHi0jQIj89c73f+uNmzV1tgaLozBXZsf5aslVckc0q4qlAENM2pUNHsqXGulh
         VodH1RYZdZqBzVaR2cMHVAoqaVkBKoTr3b/T3UwoNdXyEXryq1sXTdi33ADhLZRj87lf
         nHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BDhXeFZOEER6fzhifbvaPju9Ij73EweA3xek0ZW9GxM=;
        b=LxGcKmvR9RKjVsFQsx3uhz5x3g8GySgS7nC59dTZ8aWVTXSohm81kcLI/g3bt6JDWH
         W72Jo6sMeaHQQebpk6HVB51YuVky6xNHGmj/KEBmeUb2vgWuR6lGrPEOS7em4d+1SOf+
         YjXjfbLQ0+NN2HUEs8u5RU0LeVc5yBxfKeYEDaKlC7zTD1+8w5UxiJdIl0enG5K4B3Pi
         cNtIVknwz9BBSism8fxHhs7chna96jiWrsdueZl24q8b5QvNAlahxYgbge+celBKxPRP
         UOl9FRL5a0OhiKqN2VWxSt7Ec+/XLPGwPoGmqT0spLmCTCnSKIxFjiQBQ1SvJWhhBqMF
         ONxA==
X-Gm-Message-State: AOAM531phUoG22fjqn+bCWgUut8i7F+XkUdBS6n9cBcUMrCwGId6WD3w
        Nh0CWz+PI+9aH/X03xaLjGeQvw==
X-Google-Smtp-Source: ABdhPJzyI+krcd8CVtMGy1wsY1GLwHlRQmTklHSHxZqdroSNUurxswgnd5isuVimQAojcHJtQ73ccA==
X-Received: by 2002:adf:ffc1:: with SMTP id x1mr39889861wrs.97.1634646951154;
        Tue, 19 Oct 2021 05:35:51 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6dc7:9883:a79c:5be9])
        by smtp.gmail.com with ESMTPSA id p18sm15263683wrn.41.2021.10.19.05.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:35:50 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 5/5] sched/fair: cleanup newidle_balance
Date:   Tue, 19 Oct 2021 14:35:37 +0200
Message-Id: <20211019123537.17146-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_next_balance() uses sd->last_balance which is not modified by
load_balance() so we can merge the 2 calls in one place.

No functional change

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57eae0ebc492..13950beb01a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10916,10 +10916,10 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 		int continue_balancing = 1;
 		u64 domain_cost;
 
-		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
-			update_next_balance(sd, &next_balance);
+		update_next_balance(sd, &next_balance);
+
+		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost)
 			break;
-		}
 
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
 
@@ -10935,8 +10935,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 			t0 = t1;
 		}
 
-		update_next_balance(sd, &next_balance);
-
 		/*
 		 * Stop searching for tasks to pull if there are
 		 * now runnable tasks on this rq.
-- 
2.17.1

