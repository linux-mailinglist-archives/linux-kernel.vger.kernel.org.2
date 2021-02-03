Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406230DEF5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhBCP7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:59:35 -0500
Received: from foss.arm.com ([217.140.110.172]:42574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234643AbhBCPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:55:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CA3A1396;
        Wed,  3 Feb 2021 07:55:05 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 59F1B3F719;
        Wed,  3 Feb 2021 07:55:03 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     vincent.guittot@linaro.org, mgorman@suse.de, mingo@kernel.org,
        peterz@infradead.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, linuxarm@openeuler.org,
        xuwei5@huawei.com, liguozhu@hisilicon.com, tiantao6@hisilicon.com,
        wanghuiqiang@huawei.com, prime.zeng@hisilicon.com,
        jonathan.cameron@huawei.com, guodong.xu@linaro.org,
        Barry Song <song.bao.hua@hisilicon.com>,
        Meelis Roos <mroos@linux.ee>
Subject: [RFC PATCH 2/2] Revert "sched/topology: Warn when NUMA diameter > 2"
Date:   Wed,  3 Feb 2021 15:54:31 +0000
Message-Id: <20210203155432.10293-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203155432.10293-1-valentin.schneider@arm.com>
References: <20210203155432.10293-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler topology code can now figure out what to do with such
topologies.

This reverts commit b5b217346de85ed1b03fdecd5c5076b34fbb2f0b.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index a8f69f234258..0fa41aab74e0 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -688,7 +688,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct sched_domain *tmp;
-	int numa_distance = 0;
 
 	/* Remove the sched domains which do not contribute to scheduling. */
 	for (tmp = sd; tmp; ) {
@@ -720,38 +719,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 			sd->child = NULL;
 	}
 
-	for (tmp = sd; tmp; tmp = tmp->parent)
-		numa_distance += !!(tmp->flags & SD_NUMA);
-
-	/*
-	 * FIXME: Diameter >=3 is misrepresented.
-	 *
-	 * Smallest diameter=3 topology is:
-	 *
-	 *   node   0   1   2   3
-	 *     0:  10  20  30  40
-	 *     1:  20  10  20  30
-	 *     2:  30  20  10  20
-	 *     3:  40  30  20  10
-	 *
-	 *   0 --- 1 --- 2 --- 3
-	 *
-	 * NUMA-3	0-3		N/A		N/A		0-3
-	 *  groups:	{0-2},{1-3}					{1-3},{0-2}
-	 *
-	 * NUMA-2	0-2		0-3		0-3		1-3
-	 *  groups:	{0-1},{1-3}	{0-2},{2-3}	{1-3},{0-1}	{2-3},{0-2}
-	 *
-	 * NUMA-1	0-1		0-2		1-3		2-3
-	 *  groups:	{0},{1}		{1},{2},{0}	{2},{3},{1}	{3},{2}
-	 *
-	 * NUMA-0	0		1		2		3
-	 *
-	 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
-	 * group span isn't a subset of the domain span.
-	 */
-	WARN_ONCE(numa_distance > 2, "Shortest NUMA path spans too many nodes\n");
-
 	sched_domain_debug(sd, cpu);
 
 	rq_attach_root(rq, rd);
-- 
2.27.0

