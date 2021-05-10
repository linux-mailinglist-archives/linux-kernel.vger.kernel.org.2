Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D292B37916A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhEJOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:53:57 -0400
Received: from foss.arm.com ([217.140.110.172]:60138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239089AbhEJOvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 495521688;
        Mon, 10 May 2021 07:50:47 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D214D3F719;
        Mon, 10 May 2021 07:50:45 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH RESEND 1/2] sched/uclamp: Fix wrong implementation of cpu.uclamp.min
Date:   Mon, 10 May 2021 15:50:31 +0100
Message-Id: <20210510145032.1934078-2-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210510145032.1934078-1-qais.yousef@arm.com>
References: <20210510145032.1934078-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu.uclamp.min is a protection as described in cgroup-v2 Resource
Distribution Model

	Documentation/admin-guide/cgroup-v2.rst

which means we try our best to preserve the minimum performance point of
tasks in this group. See full description of cpu.uclamp.min in the
cgroup-v2.rst.

But the current implementation makes it a limit, which is not what was
intended.

For example:

	tg->cpu.uclamp.min = 20%

	p0->uclamp[UCLAMP_MIN] = 0
	p1->uclamp[UCLAMP_MIN] = 50%

	Previous Behavior (limit):

		p0->effective_uclamp = 0
		p1->effective_uclamp = 20%

	New Behavior (Protection):

		p0->effective_uclamp = 20%
		p1->effective_uclamp = 50%

Which is inline with how protections should work.

With this change the cgroup and per-task behaviors are the same, as
expected.

Additionally, we remove the confusing relationship between cgroup and
!user_defined flag.

We don't want for example RT tasks that are boosted by default to max to
change their boost value when they attach to a cgroup. If a cgroup wants
to limit the max performance point of tasks attached to it, then
cpu.uclamp.max must be set accordingly.

Or if they want to set different boost value based on cgroup, then
sysctl_sched_util_clamp_min_rt_default must be used to NOT boost to max
and set the right cpu.uclamp.min for each group to let the RT tasks
obtain the desired boost value when attached to that group.

As it stands the dependency on !user_defined flag adds an extra layer of
complexity that is not required now cpu.uclamp.min behaves properly as
a protection.

The propagation model of effective cpu.uclamp.min in child cgroups as
implemented by cpu_util_update_eff() is still correct. The parent
protection sets an upper limit of what the child cgroups will
effectively get.

Fixes: 3eac870a3247 (sched/uclamp: Use TG's clamps to restrict TASK's clamps)
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---
 kernel/sched/core.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95bd6ab8115d..b61329299379 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1057,7 +1057,6 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
 	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
-	struct uclamp_se uc_max;
 
 	/*
 	 * Tasks in autogroups or root task group will be
@@ -1068,9 +1067,23 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 	if (task_group(p) == &root_task_group)
 		return uc_req;
 
-	uc_max = task_group(p)->uclamp[clamp_id];
-	if (uc_req.value > uc_max.value || !uc_req.user_defined)
-		return uc_max;
+	switch (clamp_id) {
+	case UCLAMP_MIN: {
+		struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
+		if (uc_req.value < uc_min.value)
+			return uc_min;
+		break;
+	}
+	case UCLAMP_MAX: {
+		struct uclamp_se uc_max = task_group(p)->uclamp[clamp_id];
+		if (uc_req.value > uc_max.value)
+			return uc_max;
+		break;
+	}
+	default:
+		WARN_ON_ONCE(1);
+		break;
+	}
 #endif
 
 	return uc_req;
-- 
2.25.1

