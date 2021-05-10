Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD3379167
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbhEJOxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 10:53:43 -0400
Received: from foss.arm.com ([217.140.110.172]:60154 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233479AbhEJOvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 10:51:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 038461691;
        Mon, 10 May 2021 07:50:50 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CA893F719;
        Mon, 10 May 2021 07:50:48 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Tejun Heo <tj@kernel.org>, Quentin Perret <qperret@google.com>,
        Wei Wang <wvw@google.com>, Yun Hsiang <hsiang023167@gmail.com>,
        linux-kernel@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>
Subject: [PATCH RESEND 2/2] sched/uclamp: Fix locking around cpu_util_update_eff()
Date:   Mon, 10 May 2021 15:50:32 +0100
Message-Id: <20210510145032.1934078-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210510145032.1934078-1-qais.yousef@arm.com>
References: <20210510145032.1934078-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_cgroup_css_online() calls cpu_util_update_eff() without holding the
uclamp_mutex or rcu_read_lock() like other call sites, which is
a mistake.

The uclamp_mutex is required to protect against concurrent reads and
writes that could update the cgroup hierarchy.

The rcu_read_lock() is required to traverse the cgroup data structures
in cpu_util_update_eff().

Surround the caller with the required locks and add some asserts to
better document the dependency in cpu_util_update_eff().

Fixes: 7226017ad37a ("sched/uclamp: Fix a bug in propagating uclamp value in new cgroups")
Reported-by: Quentin Perret <qperret@google.com>
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
---

There was no real failure observed because of this. Quentin just observed the
oddity and reported it.

 kernel/sched/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b61329299379..efa15287d09e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8690,7 +8690,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Propagate the effective uclamp value for the new group */
+	mutex_lock(&uclamp_mutex);
+	rcu_read_lock();
 	cpu_util_update_eff(css);
+	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 #endif
 
 	return 0;
@@ -8780,6 +8784,9 @@ static void cpu_util_update_eff(struct cgroup_subsys_state *css)
 	enum uclamp_id clamp_id;
 	unsigned int clamps;
 
+	lockdep_assert_held(&uclamp_mutex);
+	SCHED_WARN_ON(!rcu_read_lock_held());
+
 	css_for_each_descendant_pre(css, top_css) {
 		uc_parent = css_tg(css)->parent
 			? css_tg(css)->parent->uclamp : NULL;
-- 
2.25.1

