Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A95131A089
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhBLOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbhBLOTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:19:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666C6C06178A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:58 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m1so1149468wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 06:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EB0vWuO0TwMb5w0PVSL7dksbpRwSfKMcD0GtLsZEkro=;
        b=LeGMsSJS7JAdCGGBWgD/VFq3U6LqUuxprHVEyHeHW5HqIXuaOQLypk1iR38jmArGbw
         VH3xuA+jaD7ItUzlnfYnYjbntIfO/0zG6oMVaSvMEXTjfomvfDaLebO4T0NoDoTCGWSE
         Z5ggbMRs5tJL5s+/v1Pl0mkIw9fZzYw8kUJCwartki1l/ZcsVUhwR4fCe+2Czr70Dex/
         EO4SzxHedZEvu2RJmH8v8mtzhy5Qzge1QrFYOr2J2TqOsnAitBe+B39P2S3HE7fkP+D7
         5tox8/riFD95iXmeRik79STo3Xjc4nXIqcyhSb/ClJLU1x2WB0ZClmpQ6YPJPjYfTXma
         tdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EB0vWuO0TwMb5w0PVSL7dksbpRwSfKMcD0GtLsZEkro=;
        b=OGscnDgdYmxjs5WKjz7zkb+WnkOEUqxrsMhPb7t9kcpwVRyukWjULfmuhUzDz2Nm1r
         eUGJxAf91Z+a+8s7V4LzQeGf4cTkhtVJXO4sAvldEwD5qn+dMT0qq8zNW4rWe0rCborK
         sYj3BsPznINJLDMaGGHdMjEsav4R05BQW8IrHl45fqxnkiwcel1gVdwkYvEWk0Xqp9iX
         USgY3k9/zzbo3aQj13ySbgpn1TcTpaYmiu399f4FVn1K/zBN3OkS/oPP6946sERHdmTu
         vihUNFf+uazZepIUqEfNiAE/iOuBvxmCmkyHUAlaqI6tfSI6X2V5RPC2d3oK1mGH4Isf
         VNuA==
X-Gm-Message-State: AOAM530wUtjdZgqGrIi3PSuaODR9sZzVd6CIeLfSr4UPdtSnbUfohl9j
        rRtbUQACAIQK6c6OdmlO5wNWzg==
X-Google-Smtp-Source: ABdhPJyYimEaGdvJKIFBkEbDn2KRcsw1XcOeh5lWlozNOGO4rAZh5L2wuBOpiW4Eu9I6Ur2lXZQp2g==
X-Received: by 2002:a7b:c77a:: with SMTP id x26mr2953394wmk.143.1613139477114;
        Fri, 12 Feb 2021 06:17:57 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ad4e:cdb3:8eaf:6329])
        by smtp.gmail.com with ESMTPSA id f14sm14254156wmj.30.2021.02.12.06.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 06:17:56 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, valentin.schneider@arm.com
Cc:     fweisbec@gmail.com, tglx@linutronix.de, qais.yousef@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 5/7 v3] sched/fair: reorder newidle_balance pulled_task tests
Date:   Fri, 12 Feb 2021 15:17:42 +0100
Message-Id: <20210212141744.24284-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210212141744.24284-1-vincent.guittot@linaro.org>
References: <20210212141744.24284-1-vincent.guittot@linaro.org>
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

