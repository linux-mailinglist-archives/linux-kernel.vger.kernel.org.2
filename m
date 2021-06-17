Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A577A3AB9F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFQQyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 12:54:10 -0400
Received: from foss.arm.com ([217.140.110.172]:56566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231176AbhFQQyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 12:54:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0B6413D5;
        Thu, 17 Jun 2021 09:52:00 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (unknown [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5950E3F694;
        Thu, 17 Jun 2021 09:51:59 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH v2] sched/uclamp: Fix uclamp_tg_restrict()
Date:   Thu, 17 Jun 2021 17:51:55 +0100
Message-Id: <20210617165155.3774110-1-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now cpu.uclamp.min acts as a protection, we need to make sure that the
uclamp request of the task is within the allowed range of the cgroup,
that is it is clamp()'ed correctly by tg->uclamp[UCLAMP_MIN] and
tg->uclamp[UCLAMP_MAX].

As reported by Xuewen [1] we can have some corner cases where there's
inversion between uclamp requested by task (p) and the uclamp values of
the taskgroup it's attached to (tg). Following table demonstrates
2 corner cases:

	           |  p  |  tg  |  effective
	-----------+-----+------+-----------
	CASE 1
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   |  60%
	-----------+-----+------+-----------
	uclamp_max | 80% | 50%  |  50%
	-----------+-----+------+-----------
	CASE 2
	-----------+-----+------+-----------
	uclamp_min | 0%  | 30%  |  30%
	-----------+-----+------+-----------
	uclamp_max | 20% | 50%  |  20%
	-----------+-----+------+-----------

With this fix we get:

	           |  p  |  tg  |  effective
	-----------+-----+------+-----------
	CASE 1
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   |  50%
	-----------+-----+------+-----------
	uclamp_max | 80% | 50%  |  50%
	-----------+-----+------+-----------
	CASE 2
	-----------+-----+------+-----------
	uclamp_min | 0%  | 30%  |  30%
	-----------+-----+------+-----------
	uclamp_max | 20% | 50%  |  30%
	-----------+-----+------+-----------

Additionally uclamp_update_active_tasks() must now unconditionally
update both UCLAMP_MIN/MAX because changing the tg's UCLAMP_MAX for
instance could have an impact on the effective UCLAMP_MIN of the tasks.

	           |  p  |  tg  |  effective
	-----------+-----+------+-----------
	old
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   |  50%
	-----------+-----+------+-----------
	uclamp_max | 80% | 50%  |  50%
	-----------+-----+------+-----------
	*new*
	-----------+-----+------+-----------
	uclamp_min | 60% | 0%   | *60%*
	-----------+-----+------+-----------
	uclamp_max | 80% |*70%* | *70%*
	-----------+-----+------+-----------

[1] https://lore.kernel.org/lkml/CAB8ipk_a6VFNjiEnHRHkUMBKbA+qzPQvhtNjJ_YNzQhqV_o8Zw@mail.gmail.com/

Reported-by: Xuewen Yan <xuewen.yan94@gmail.com>
Fixes: 0c18f2ecfcc2 ("sched/uclamp: Fix wrong implementation of cpu.uclamp.min")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

Changes in v2:

	* Fixed a typo in commit message (Diemtar).
	* Renamed uc_eff back to uc_req (Dietmar).
	* Move the loop to update clamp_id to be done once inside the
	  task_rq_lock() (Dietmar).


 kernel/sched/core.c | 49 +++++++++++++++++----------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9e9a5be35cde..fdb9a109fd68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1403,8 +1403,10 @@ static void uclamp_sync_util_min_rt_default(void)
 static inline struct uclamp_se
 uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 {
+	/* Copy by value as we could modify it */
 	struct uclamp_se uc_req = p->uclamp_req[clamp_id];
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+	unsigned int tg_min, tg_max, value;
 
 	/*
 	 * Tasks in autogroups or root task group will be
@@ -1415,23 +1417,11 @@ uclamp_tg_restrict(struct task_struct *p, enum uclamp_id clamp_id)
 	if (task_group(p) == &root_task_group)
 		return uc_req;
 
-	switch (clamp_id) {
-	case UCLAMP_MIN: {
-		struct uclamp_se uc_min = task_group(p)->uclamp[clamp_id];
-		if (uc_req.value < uc_min.value)
-			return uc_min;
-		break;
-	}
-	case UCLAMP_MAX: {
-		struct uclamp_se uc_max = task_group(p)->uclamp[clamp_id];
-		if (uc_req.value > uc_max.value)
-			return uc_max;
-		break;
-	}
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
+	tg_min = task_group(p)->uclamp[UCLAMP_MIN].value;
+	tg_max = task_group(p)->uclamp[UCLAMP_MAX].value;
+	value = uc_req.value;
+	value = clamp(value, tg_min, tg_max);
+	uclamp_se_set(&uc_req, value, false);
 #endif
 
 	return uc_req;
@@ -1630,8 +1620,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 }
 
 static inline void
-uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
+uclamp_update_active(struct task_struct *p)
 {
+	enum uclamp_id clamp_id;
 	struct rq_flags rf;
 	struct rq *rq;
 
@@ -1651,9 +1642,11 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 	 * affecting a valid clamp bucket, the next time it's enqueued,
 	 * it will already see the updated clamp bucket value.
 	 */
-	if (p->uclamp[clamp_id].active) {
-		uclamp_rq_dec_id(rq, p, clamp_id);
-		uclamp_rq_inc_id(rq, p, clamp_id);
+	for_each_clamp_id(clamp_id) {
+		if (p->uclamp[clamp_id].active) {
+			uclamp_rq_dec_id(rq, p, clamp_id);
+			uclamp_rq_inc_id(rq, p, clamp_id);
+		}
 	}
 
 	task_rq_unlock(rq, p, &rf);
@@ -1661,20 +1654,14 @@ uclamp_update_active(struct task_struct *p, enum uclamp_id clamp_id)
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 static inline void
-uclamp_update_active_tasks(struct cgroup_subsys_state *css,
-			   unsigned int clamps)
+uclamp_update_active_tasks(struct cgroup_subsys_state *css)
 {
-	enum uclamp_id clamp_id;
 	struct css_task_iter it;
 	struct task_struct *p;
 
 	css_task_iter_start(css, 0, &it);
-	while ((p = css_task_iter_next(&it))) {
-		for_each_clamp_id(clamp_id) {
-			if ((0x1 << clamp_id) & clamps)
-				uclamp_update_active(p, clamp_id);
-		}
-	}
+	while ((p = css_task_iter_next(&it)))
+		uclamp_update_active(p);
 	css_task_iter_end(&it);
 }
 
@@ -9626,7 +9613,7 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 		}
 
 		/* Immediately update descendants RUNNABLE tasks */
-		uclamp_update_active_tasks(css, clamps);
+		uclamp_update_active_tasks(css);
 	}
 }
 
-- 
2.25.1

