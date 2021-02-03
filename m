Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684FE30DEDB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhBCP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:56:54 -0500
Received: from foss.arm.com ([217.140.110.172]:42594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234684AbhBCP4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:56:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E733143B;
        Wed,  3 Feb 2021 07:55:09 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6DDA53F719;
        Wed,  3 Feb 2021 07:55:07 -0800 (PST)
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
Subject: [RFC PATCH 3/2] sched/topology: Alternative diameter >= 2 fixup
Date:   Wed,  3 Feb 2021 15:54:32 +0000
Message-Id: <20210203155432.10293-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203155432.10293-1-valentin.schneider@arm.com>
References: <20210203155432.10293-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This follows Barry's approach, which yields fewer groups in the higher domains.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 42 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0fa41aab74e0..e1bb97c06f53 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -949,20 +949,21 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
 }
 
-static struct sched_domain *find_node_domain(struct sched_domain *sd)
+static struct sched_domain *
+find_sibling_domain(struct sched_domain *sd, struct sched_domain *sibling)
 {
-	struct sched_domain *parent;
-
 	BUG_ON(!(sd->flags & SD_NUMA));
 
-	/* Get to the level above NODE */
-	while (sd && sd->child) {
-		parent = sd;
-		sd = sd->child;
+	/* Find a subset sibling */
+	while (sibling->child &&
+	       !cpumask_subset(sched_domain_span(sibling->child),
+			       sched_domain_span(sd)))
+		sibling = sibling->child;
+
+	/* If the above loop was a no-op, we're done */
+	if (sd->private == sibling->private)
+		return sibling;
 
-		if (!(sd->flags & SD_NUMA))
-			break;
-	}
 	/*
 	 * We're going to create cross topology level sched_group_capacity
 	 * references. This can only work if the domains resulting from said
@@ -972,16 +973,14 @@ static struct sched_domain *find_node_domain(struct sched_domain *sd)
 	 *
 	 * Of course, groups aren't available yet, so we can't call the usual
 	 * sd_degenerate(). Checking domain spans is the closest we get.
-	 * Start from NODE's parent, and keep going up until we get a domain
-	 * we're sure won't be degenerated.
+	 * We can't go up as per the above subset check, so keep going down
+	 * until we get a domain we're sure won't be degenerated.
 	 */
-	while (sd->parent &&
-	       cpumask_equal(sched_domain_span(sd), sched_domain_span(parent))) {
-		sd = parent;
-		parent = sd->parent;
-	}
+	while (sibling->child &&
+	       cpumask_equal(sched_domain_span(sibling->child), sched_domain_span(sibling)))
+		sibling = sibling->child;
 
-	return parent;
+	return sibling;
 }
 
 static int
@@ -1017,12 +1016,9 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
 			continue;
 
-		/*
-		 * Local group is child domain's span, as is tradition.
-		 * Non-local groups will only span remote nodes.
-		 */
+		/* Ensure sibling domain's span is a subset of this domain */
 		if (first)
-			sibling = find_node_domain(sibling);
+			sibling = find_sibling_domain(sd, sibling);
 
 		sg = build_group_from_child_sched_domain(sibling, cpu);
 		if (!sg)
-- 
2.27.0

