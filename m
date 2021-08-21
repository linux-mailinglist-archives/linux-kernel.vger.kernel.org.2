Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC9E3F39A7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 11:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhHUJF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 05:05:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14309 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhHUJF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 05:05:26 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GsCHk4hr6z87pp;
        Sat, 21 Aug 2021 17:04:34 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:04:45 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:04:42 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     <song.bao.hua@hisilicon.com>, <valentin.schneider@arm.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>
Subject: [PATCH] sched/topology: Remove unused numa_distance in cpu_attach_domain()
Date:   Sat, 21 Aug 2021 13:41:11 +0800
Message-ID: <20210821054111.63181-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema772-chm.china.huawei.com (10.1.198.214)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

numa_distance in cpu_attach_domain() is introduced in
commit b5b217346de8 ("sched/topology: Warn when NUMA diameter > 2")
to warn user when NUMA diameter > 2 as we'll misrepresent
the scheduler topology structures at that time. This is
fixed by Barry in commit 585b6d2723dc ("sched/topology: fix the issue
groups don't span domain->span for NUMA diameter > 2") and
numa_distance is unused now. So remove it.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/topology.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b77ad49dc14f..ccbb141df8c8 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -688,7 +688,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
-	int numa_distance = 0;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
@@ -720,9 +719,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			sd->child = NULL;
 	}
 
-	for (tmp = sd; tmp; tmp = tmp->parent)
-		numa_distance += !!(tmp->flags & SD_NUMA);
-
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
-- 
2.17.1

