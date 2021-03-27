Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A21434B56E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 09:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbhC0ITd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 04:19:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14932 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhC0ITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 04:19:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F6sC42WDBzklrN;
        Sat, 27 Mar 2021 16:17:20 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 27 Mar 2021 16:18:49 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <song.bao.hua@hisilicon.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/fair: Remove the redundant check in numa_id_core
Date:   Sat, 27 Mar 2021 16:19:21 +0800
Message-ID: <1616833161-64375-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the numa_idle_core() function have a little redundant. then this patch
move the "idle_core >= 0" check in numa_idle_core() to its caller in
update_numa_stats() and then remove the redundant check in
!static_branch_likely(&sched_smt_present) check in numa_idle_core.

This patch is based on the following discussion:
https://lore.kernel.org/lkml/20210322101556.GK15768@suse.de/

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6d73bdbb..fbff7f1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1569,8 +1569,7 @@ numa_type numa_classify(unsigned int imbalance_pct,
 static inline bool test_idle_cores(int cpu, bool def);
 static inline int numa_idle_core(int idle_core, int cpu)
 {
-	if (!static_branch_likely(&sched_smt_present) ||
-	    idle_core >= 0 || !test_idle_cores(cpu, false))
+	if (!test_idle_cores(cpu, false))
 		return idle_core;
 
 	/*
@@ -1622,7 +1621,8 @@ static void update_numa_stats(struct task_numa_env *env,
 			if (ns->idle_cpu == -1)
 				ns->idle_cpu = cpu;
 
-			idle_core = numa_idle_core(idle_core, cpu);
+			if (idle_core >= 0)
+				idle_core = numa_idle_core(idle_core, cpu);
 		}
 	}
 	rcu_read_unlock();
-- 
2.7.4

