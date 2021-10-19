Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D9E433619
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbhJSMiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbhJSMiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:38:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69C8C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t2so47574720wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 05:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GKeqtyt+VcXzBRj8DiTOhd1jyE3xv/NmT0/rl+CXxbc=;
        b=hKh1dG87UpuKxRy9IkMWb1qDrB3mxqqnhTemw4yiNvsxUMyawQDO1X+KLhIBgzhjg7
         Nldr6fl2OfkHF6dd+sNdQQsNvDU4M76Ox71A+/gEvgpmtrn/OCBV2uypPEEyS9SL9ivd
         naa/rAfLZNyxdwNLSWsD6kxA7VlJEeaJvrWwkzEZPkicm/zfCMpf863jUt/GcTn5JEBm
         yUmiKecdIYdPz4VYb4LEB2cEc9uqIM2xxI45Fl4Nca/gNFpwOHGUkrgCVOhZKETM+sF4
         hk23Lc9SwS1tyWp7AnoMHXI23PINQ4XVYlCKETJd5N6Hr4Xt6KO1MnPqfL1HsrYUfSBB
         gnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GKeqtyt+VcXzBRj8DiTOhd1jyE3xv/NmT0/rl+CXxbc=;
        b=ZS3HhN8/aDPh4yyKKfM+DG6Do+cMFBwLJ53wcUZJ6ca1P7W9cWCeflGKuhUOvaXZFz
         0Vgs4/8FYgd7C/wDyAWIzXOE+IB3x+CUP/viBJweKkS4nEZDq+tMPuN+f+XCUQmhtTaJ
         CGpbjXHeTOekYe/2a1x6y2y0JnCuMYnSF8JOrrVBuJadz24AqsdKCUdaGn/ASMM8OJxg
         oeOKH2C9eMXKi2i8CPwtnmpFd2MDHMfntnWbc/cbSgBQkMHnGETeeRMlJ0tbQbWppV7H
         pa2enjxzte3d7IlBP142dvnZdsjXLhCHSGVBOr1uCiKAwr9QNXpurZ02SQs0K2V3RZCC
         KybA==
X-Gm-Message-State: AOAM532oJd6+oF0EWl12XcE+Tp8rgzzjWF0Q5PqIOTnxG5ofiHkFyd+t
        zat5Hok2PPlU5sY8+MXz8CHVtQ==
X-Google-Smtp-Source: ABdhPJyQq5FyxpDSNd4jCsZ8IX6+ntc6Bnf/oEw7w4KsleGuFTjMLxB5sCXXO2voXhxpgud2At740Q==
X-Received: by 2002:adf:a29c:: with SMTP id s28mr41943232wra.116.1634646948889;
        Tue, 19 Oct 2021 05:35:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6dc7:9883:a79c:5be9])
        by smtp.gmail.com with ESMTPSA id p18sm15263683wrn.41.2021.10.19.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:35:48 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 4/5] sched/fair: Remove sysctl_sched_migration_cost condition
Date:   Tue, 19 Oct 2021 14:35:36 +0200
Message-Id: <20211019123537.17146-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019123537.17146-1-vincent.guittot@linaro.org>
References: <20211019123537.17146-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With a default value of 500us, sysctl_sched_migration_cost is
significanlty higher than the cost of load_balance. Remove the
condition and rely on the sd->max_newidle_lb_cost to abort
newidle_balance.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e50fd751e1df..57eae0ebc492 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10895,8 +10895,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload) ||
+	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
-- 
2.17.1

