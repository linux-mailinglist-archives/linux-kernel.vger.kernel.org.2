Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D495441AD11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240213AbhI1Khe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240200AbhI1Khd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:37:33 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DFC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:35:53 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so2357466wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=pU6YxNaw0GTgII4fD3nhe0fYGdqImBr40bZJ7n4xVVA=;
        b=pZWIFbxnwPooY4cEem3tUYhych5LZKZmOLXmp6XPyimZGPpJVkAB74HA81pOiLVtk2
         1BFlJvolqlcVDSRy82AB7Tuw54E7x15U4WNCt8Lq92TG+h5y2FZJz52HCFhlKhtRGQGL
         q1eswahCLatuLMV1/t2OeAsc6FaXu1p8fd/bNXYYHF91OofVz/JfavJfl93joCmtpTeN
         onpZGinY1jD/MuPIMwmt+5Qk5KZC7MLO1bFq2gOKF6rYjZ4wtzCucxbQQGkUxMC966px
         I6pUQxGYNpE7ibGs3kY6DAH6svfV6vlZAMgWN8Y6WsxuoBK2q02+teFskATAjszzTL3N
         U53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pU6YxNaw0GTgII4fD3nhe0fYGdqImBr40bZJ7n4xVVA=;
        b=l25I18j8SzYh9lrMFf/eXNmJ4LNIO2+ZtfHLc0PEvW7q6xbF+1HkouvV+M2tMb67wj
         LFwvoqO+lKVgFaLnHY0yfMLSeMyEfhHqlOdaMSrR6VuaTydPgmoKv9Try9S+q5rXybGI
         HeP5n/MxJLt+eedAeXWrRdl9fTV2Sjk8wsEbvhKpl5/QWXNIXle6GbcU3t8Cbmlb6qb6
         6lXl8tD1Npi65VdHFMblTHPrDGeZl4J9sKtqQYoguUi34p/ahl9lF+y5zzhqRxxgt29E
         fOLQmcCC+evPhFk5fzfJw3Q+DICGh7yVbEfgj6jZ7McNfcmdeZabgVd1m1TLqws0bq/I
         if/g==
X-Gm-Message-State: AOAM5319ucTUZxX8zYsdOXiwyfAvf86+pUdzlZOnTJPiITlZQ/Z/4apz
        2lCqZDF48klvVjC6fVU3Iw9CBA==
X-Google-Smtp-Source: ABdhPJz+iiEMsJPfR+CGi+VvP1ElzUauW+k60cDA6pUGjEEONzNEAOH6qHIW8B8WK9IHXA6lrF5z8g==
X-Received: by 2002:a05:600c:ac1:: with SMTP id c1mr2407217wmr.99.1632825352411;
        Tue, 28 Sep 2021 03:35:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f026:b003:87f0:38a7])
        by smtp.gmail.com with ESMTPSA id y18sm18791971wrq.6.2021.09.28.03.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:35:52 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: removed useless update of p->recent_used_cpu
Date:   Tue, 28 Sep 2021 12:35:44 +0200
Message-Id: <20210928103544.27489-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu"),
p->recent_used_cpu is unconditionnaly set with prev.


Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e26d622762a9..bcb7617741c3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6380,11 +6380,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu = prev;
 		return recent_used_cpu;
 	}
 
-- 
2.17.1

