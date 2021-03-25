Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C34F348702
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 03:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbhCYCiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 22:38:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14888 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbhCYCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 22:38:30 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5Tl62kmrzkfNh;
        Thu, 25 Mar 2021 10:36:50 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.38) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 10:38:19 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <vincent.guittot@linaro.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>
CC:     <valentin.schneider@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, Barry Song <song.bao.hua@hisilicon.com>,
        "Valentin Schneider" <Valentin.Schneider@arm.com>
Subject: [PATCH v2] sched/topology: remove redundant cpumask_and in init_overlap_sched_group
Date:   Thu, 25 Mar 2021 15:31:40 +1300
Message-ID: <20210325023140.23456-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.38]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mask is built in build_balance_mask() by for_each_cpu(i, sg_span), so
it must be a subset of sched_group_span(sg). Though cpumask_first_and
doesn't lead to a wrong result of balance cpu, it is pointless to do
cpumask_and again.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Valentin Schneider <Valentin.Schneider@arm.com>
---
 -v2: add reviewed-by of Valentin, thanks!

 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f2066d682cd8..d1aec244c027 100644
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
2.25.1

