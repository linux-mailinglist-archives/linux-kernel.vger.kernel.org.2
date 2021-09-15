Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FE440C31A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbhIOJ5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:57:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9050 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbhIOJ5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:57:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8bDB0HK8zVmg7;
        Wed, 15 Sep 2021 17:54:50 +0800 (CST)
Received: from dggema772-chm.china.huawei.com (10.1.198.214) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Wed, 15 Sep 2021 17:55:50 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema772-chm.china.huawei.com (10.1.198.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 17:55:50 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <valentin.schneider@arm.com>, <21cnbao@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <song.bao.hua@hisilicon.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>
Subject: [RESEND PATCH] sched/topology: Remove unused numa_distance in cpu_attach_domain()
Date:   Wed, 15 Sep 2021 14:31:58 +0800
Message-ID: <20210915063158.80639-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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
index 4e8698e62f07..690bd1ab86f3 100644
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
2.33.0

