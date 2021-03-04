Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D870B32DD31
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbhCDWgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:36:11 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13859 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCDWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:36:11 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ds5Jf3Zllz8snL;
        Fri,  5 Mar 2021 06:34:26 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.82) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 06:35:59 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] sched/topology: remove redundant cpumask_and in init_overlap_sched_group
Date:   Fri, 5 Mar 2021 11:29:44 +1300
Message-ID: <20210304222944.32504-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.82]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mask is built in build_balance_mask() by for_each_cpu(i, sg_span), so
it must be a subset of sched_group_span(sg). Though cpumask_first_and
doesn't lead to a wrong result of balance cpu, it is pointless to do
cpumask_and again.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 12f8058..45f3db2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -934,7 +934,7 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	int cpu;
 
 	build_balance_mask(sd, sg, mask);
-	cpu = cpumask_first_and(sched_group_span(sg), mask);
+	cpu = cpumask_first(mask);
 
 	sg->sgc = *per_cpu_ptr(sdd->sgc, cpu);
 	if (atomic_inc_return(&sg->sgc->ref) == 1)
-- 
1.8.3.1

