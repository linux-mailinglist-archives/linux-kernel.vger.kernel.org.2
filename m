Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2C34A032
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 04:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhCZDSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 23:18:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14611 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhCZDSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 23:18:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F66Yw38sTz19K0s;
        Fri, 26 Mar 2021 11:16:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 11:17:58 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <linuxarm@huawei.com>, Zeng Tao <prime.zeng@hisilicon.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched/cpupri: fix the task priority BUG_ON checks
Date:   Fri, 26 Mar 2021 11:15:11 +0800
Message-ID: <1616728512-54749-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG_ON checks are intended to check if the task priotity is valid,
but in the function convert_prio, if the task priority is not valid, it
will be converted to an uninitialized stack variable. Fix it by moving
the BUG_ON checks to the default branch of convert_prio.

Fixes: 934fc3314b39 ("sched/cpupri: Remap CPUPRI_NORMAL to MAX_RT_PRIO-1")
Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 kernel/sched/cpupri.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index ec9be78..c5a0e6e 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -60,6 +60,8 @@ static int convert_prio(int prio)
 	case MAX_RT_PRIO:
 		cpupri = CPUPRI_HIGHER;		/* 100 */
 		break;
+	default:
+		BUG();
 	}
 
 	return cpupri;
@@ -148,8 +150,6 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 	int task_pri = convert_prio(p->prio);
 	int idx, cpu;
 
-	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
-
 	for (idx = 0; idx < task_pri; idx++) {
 
 		if (!__cpupri_find(cp, p, lowest_mask, idx))
@@ -215,8 +215,6 @@ void cpupri_set(struct cpupri *cp, int cpu, int newpri)
 
 	newpri = convert_prio(newpri);
 
-	BUG_ON(newpri >= CPUPRI_NR_PRIORITIES);
-
 	if (newpri == oldpri)
 		return;
 
-- 
2.8.1

