Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7D307E46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhA1SlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 13:41:24 -0500
Received: from foss.arm.com ([217.140.110.172]:37448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232088AbhA1SfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 13:35:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188901509;
        Thu, 28 Jan 2021 10:32:19 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FA0C3F719;
        Thu, 28 Jan 2021 10:32:17 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Quentin Perret <qperret@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 8/8] sched/fair: Relax task_hot() for misfit tasks
Date:   Thu, 28 Jan 2021 18:31:41 +0000
Message-Id: <20210128183141.28097-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210128183141.28097-1-valentin.schneider@arm.com>
References: <20210128183141.28097-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Misfit tasks can and will be preempted by the stopper to migrate them over
to a higher-capacity CPU. However, when runnable but not current misfit
tasks are scanned by the load balancer (i.e. detach_tasks()), the
task_hot() ratelimiting logic may prevent us from enqueuing said task onto
a higher-capacity CPU.

Align detach_tasks() with the active-balance logic and let it pick a
cache-hot misfit task when the destination CPU can provide a capacity
uplift.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/fair.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cba9f97d9beb..c2351b87824f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7484,6 +7484,17 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
 	if (env->sd->flags & SD_SHARE_CPUCAPACITY)
 		return 0;
 
+	/*
+	 * On a (sane) asymmetric CPU capacity system, the increase in compute
+	 * capacity should offset any potential performance hit caused by a
+	 * migration.
+	 */
+	if (sd_has_asym_cpucapacity(env->sd) &&
+	    env->idle != CPU_NOT_IDLE &&
+	    !task_fits_capacity(p, capacity_of(env->src_cpu)) &&
+	    cpu_capacity_greater(env->dst_cpu, env->src_cpu))
+		return 0;
+
 	/*
 	 * Buddy candidates are cache hot:
 	 */
-- 
2.27.0

