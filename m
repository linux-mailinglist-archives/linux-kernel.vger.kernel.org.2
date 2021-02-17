Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C965731D93A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbhBQMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:10:32 -0500
Received: from z11.mailgun.us ([104.130.96.11]:47330 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232427AbhBQMK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:10:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613563807; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=znSz74cIT/XDBLYTbfGeuRihA8uDYq9KOTdfC9YsQ1Q=; b=WM51pBdILVFhGw0QHOH7Q0/vZrQgdRXClqjIRBiIeGog0Ivv0vE5YSqAX/eLGs5A57O2HnKg
 pCoGK14uP3A5eGyXU0QIEWNRn7plB+7M+jiDE/wAqP1mV3FGGgf5lQ7484H8YoWuS7aSB1EN
 OxtHs0u3lRknp11H56dTZPzxCVY=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 602d078366a058a0ecd2df5b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Feb 2021 12:09:39
 GMT
Sender: clingutla=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F23BC433ED; Wed, 17 Feb 2021 12:09:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from lingutla-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clingutla)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BAABDC433ED;
        Wed, 17 Feb 2021 12:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BAABDC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=clingutla@codeaurora.org
From:   Lingutla Chandrasekhar <clingutla@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        pkondeti@codeaurora.org, peterz@infradead.org, mingo@kernel.org,
        Lingutla Chandrasekhar <clingutla@codeaurora.org>
Subject: [PATCH] sched/fair: Ignore percpu threads for imbalance pulls
Date:   Wed, 17 Feb 2021 17:38:54 +0530
Message-Id: <20210217120854.1280-1-clingutla@codeaurora.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In load balancing, when balancing group is unable to pull task
due to ->cpus_ptr constraints from busy group, then it sets
LBF_SOME_PINNED to lb env flags, as a consequence, sgc->imbalance
is set for its parent domain level. which makes the group
classified as imbalance to get help from another balancing cpu.

Consider a 4-CPU big.LITTLE system with CPUs 0-1 as LITTLEs and
CPUs 2-3 as Bigs with below scenario:
- CPU0 doing newly_idle balancing
- CPU1 running percpu kworker and RT task (small tasks)
- CPU2 running 2 big tasks
- CPU3 running 1 medium task

While CPU0 is doing newly_idle load balance at MC level, it fails to
pull percpu kworker from CPU1 and sets LBF_SOME_PINNED to lb env flag
and set sgc->imbalance at DIE level domain. As LBF_ALL_PINNED not cleared,
it tries to redo the balancing by clearing CPU1 in env cpus, but it don't
find other busiest_group, so CPU0 stops balacing at MC level without
clearing 'sgc->imbalance' and restart the load balacing at DIE level.

And CPU0 (balancing cpu) finds LITTLE's group as busiest_group with group
type as imbalance, and Bigs that classified the level below imbalance type
would be ignored to pick as busiest, and the balancing would be aborted
without pulling any tasks (by the time, CPU1 might not have running tasks).

It is suboptimal decision to classify the group as imbalance due to
percpu threads. So don't use LBF_SOME_PINNED for per cpu threads.

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..44a05ad8c96b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7560,7 +7560,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 		schedstat_inc(p->se.statistics.nr_failed_migrations_affine);
 
-		env->flags |= LBF_SOME_PINNED;
+		/* Ignore percpu threads for imbalance pulls. */
+		if (p->nr_cpus_allowed > 1)
+			env->flags |= LBF_SOME_PINNED;
 
 		/*
 		 * Remember if this task can be migrated to any other CPU in
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
 a Linux Foundation Collaborative Project.

