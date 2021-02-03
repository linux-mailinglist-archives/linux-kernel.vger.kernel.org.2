Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC14630DEE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbhBCP5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:57:46 -0500
Received: from foss.arm.com ([217.140.110.172]:42554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234610AbhBCPz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:55:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DF8411FB;
        Wed,  3 Feb 2021 07:55:02 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CE9A3F719;
        Wed,  3 Feb 2021 07:55:00 -0800 (PST)
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
Subject: [RFC PATCH 1/2] sched/topology: Get rid of NUMA overlapping groups
Date:   Wed,  3 Feb 2021 15:54:30 +0000
Message-Id: <20210203155432.10293-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210203155432.10293-1-valentin.schneider@arm.com>
References: <20210203155432.10293-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out in commit

  b5b217346de8 ("sched/topology: Warn when NUMA diameter > 2")

overlapping groups result in broken topology data structures whenever the
underlying system has a NUMA diameter greater than 2. This stems from
overlapping groups being built from sibling domain's spans, yielding bogus
transitivity relations the like of:

  distance(A, B) <= 30 && distance(B, C) <= 20
    =>
  distance(A, C) <= 30

As discussed with Barry, a feasible approach is to catch bogus overlapping
groups and fix them after the fact [1].

A more proactive approach would be to prevent aforementioned bogus
relations from being built altogether, implies departing from the
"group span is sibling domain child's span" strategy. Said strategy only
works for diameter <= 2, which fortunately or unfortunately is currently
the most common case.

The chosen approach is, for NUMA domains:
a) have the local group be the child domain's span, as before
b) have all remote groups span only their respective node

This boils down to getting rid of overlapping groups.

Note that b) requires introducing cross sched_domain_topology_level
references for sched_group_capacity. This is a somewhat prickly matter as
we need to ensure whichever group we hook into won't see its domain
degenerated (which was never an issue when such references were bounded
within a single topology level).

This lifts the NUMA diameter restriction, although yields more groups in
the NUMA domains. As an example, here is the distance matrix for
an AMD Epyc:

  node   0   1   2   3   4   5   6   7
    0:  10  16  16  16  32  32  32  32
    1:  16  10  16  16  32  32  32  32
    2:  16  16  10  16  32  32  32  32
    3:  16  16  16  10  32  32  32  32
    4:  32  32  32  32  10  16  16  16
    5:  32  32  32  32  16  10  16  16
    6:  32  32  32  32  16  16  10  16
    7:  32  32  32  32  16  16  16  10

Emulating this on QEMU yields, before the patch:
  [    0.386745] CPU0 attaching sched-domain(s):
  [    0.386969]  domain-0: span=0-3 level=NUMA
  [    0.387708]   groups: 0:{ span=0 cap=1008 }, 1:{ span=1 cap=1007 }, 2:{ span=2 cap=1007 }, 3:{ span=3 cap=998 }
  [    0.388505]   domain-1: span=0-7 level=NUMA
  [    0.388700]    groups: 0:{ span=0-3 cap=4020 }, 4:{ span=4-7 cap=4014 }
  [    0.389861] CPU1 attaching sched-domain(s):
  [    0.390020]  domain-0: span=0-3 level=NUMA
  [    0.390200]   groups: 1:{ span=1 cap=1007 }, 2:{ span=2 cap=1007 }, 3:{ span=3 cap=998 }, 0:{ span=0 cap=1008 }
  [    0.390701]   domain-1: span=0-7 level=NUMA
  [    0.390874]    groups: 0:{ span=0-3 cap=4020 }, 4:{ span=4-7 cap=4014 }
  [    0.391460] CPU2 attaching sched-domain(s):
  [    0.391664]  domain-0: span=0-3 level=NUMA
  [    0.392750]   groups: 2:{ span=2 cap=1007 }, 3:{ span=3 cap=998 }, 0:{ span=0 cap=1008 }, 1:{ span=1 cap=1007 }
  [    0.393672]   domain-1: span=0-7 level=NUMA
  [    0.393961]    groups: 0:{ span=0-3 cap=4020 }, 4:{ span=4-7 cap=4014 }
  [    0.394645] CPU3 attaching sched-domain(s):
  [    0.394792]  domain-0: span=0-3 level=NUMA
  [    0.394961]   groups: 3:{ span=3 cap=998 }, 0:{ span=0 cap=1008 }, 1:{ span=1 cap=1007 }, 2:{ span=2 cap=1007 }
  [    0.395749]   domain-1: span=0-7 level=NUMA
  [    0.396098]    groups: 0:{ span=0-3 cap=4020 }, 4:{ span=4-7 cap=4014 }
  [    0.396455] CPU4 attaching sched-domain(s):
  [    0.396603]  domain-0: span=4-7 level=NUMA
  [    0.396771]   groups: 4:{ span=4 cap=1001 }, 5:{ span=5 cap=1004 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=1006 }
  [    0.397274]   domain-1: span=0-7 level=NUMA
  [    0.397454]    groups: 4:{ span=4-7 cap=4014 }, 0:{ span=0-3 cap=4020 }
  [    0.397801] CPU5 attaching sched-domain(s):
  [    0.397945]  domain-0: span=4-7 level=NUMA
  [    0.398110]   groups: 5:{ span=5 cap=1004 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=1006 }, 4:{ span=4 cap=1001 }
  [    0.398605]   domain-1: span=0-7 level=NUMA
  [    0.398773]    groups: 4:{ span=4-7 cap=4014 }, 0:{ span=0-3 cap=4020 }
  [    0.399109] CPU6 attaching sched-domain(s):
  [    0.399253]  domain-0: span=4-7 level=NUMA
  [    0.399418]   groups: 6:{ span=6 cap=1003 }, 7:{ span=7 cap=1006 }, 4:{ span=4 cap=1001 }, 5:{ span=5 cap=1004 }
  [    0.400562]   domain-1: span=0-7 level=NUMA
  [    0.400741]    groups: 4:{ span=4-7 cap=4020 }, 0:{ span=0-3 cap=4020 }
  [    0.401083] CPU7 attaching sched-domain(s):
  [    0.401231]  domain-0: span=4-7 level=NUMA
  [    0.401395]   groups: 7:{ span=7 cap=1006 }, 4:{ span=4 cap=1004 }, 5:{ span=5 cap=1007 }, 6:{ span=6 cap=1003 }
  [    0.401906]   domain-1: span=0-7 level=NUMA
  [    0.402076]    groups: 4:{ span=4-7 cap=4020 }, 0:{ span=0-3 cap=4020 }
  [    0.402437] root domain span: 0-7 (max cpu_capacity = 1024)

with the patch:
  [    0.367436] CPU0 attaching sched-domain(s):
  [    0.368064]  domain-0: span=0-3 level=NUMA
  [    0.368614]   groups: 0:{ span=0 cap=1012 }, 1:{ span=1 cap=1002 }, 2:{ span=2 cap=1000 }, 3:{ span=3 cap=993 }
  [    0.369490]   domain-1: span=0-7 level=NUMA
  [    0.369682]    groups: 0:{ span=0-3 cap=4007 }, 4:{ span=4 cap=991 }, 5:{ span=5 cap=1003 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=998 }
  [    0.371132] CPU1 attaching sched-domain(s):
  [    0.371290]  domain-0: span=0-3 level=NUMA
  [    0.371462]   groups: 1:{ span=1 cap=1002 }, 2:{ span=2 cap=1000 }, 3:{ span=3 cap=993 }, 0:{ span=0 cap=1012 }
  [    0.372720]   domain-1: span=0-7 level=NUMA
  [    0.372906]    groups: 0:{ span=0-3 cap=4007 }, 4:{ span=4 cap=991 }, 5:{ span=5 cap=1003 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=998 }
  [    0.373678] CPU2 attaching sched-domain(s):
  [    0.373833]  domain-0: span=0-3 level=NUMA
  [    0.374006]   groups: 2:{ span=2 cap=1000 }, 3:{ span=3 cap=993 }, 0:{ span=0 cap=1012 }, 1:{ span=1 cap=1002 }
  [    0.374516]   domain-1: span=0-7 level=NUMA
  [    0.374689]    groups: 0:{ span=0-3 cap=4007 }, 4:{ span=4 cap=991 }, 5:{ span=5 cap=1003 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=998 }
  [    0.375337] CPU3 attaching sched-domain(s):
  [    0.375491]  domain-0: span=0-3 level=NUMA
  [    0.375666]   groups: 3:{ span=3 cap=993 }, 0:{ span=0 cap=1012 }, 1:{ span=1 cap=1002 }, 2:{ span=2 cap=1000 }
  [    0.376639]   domain-1: span=0-7 level=NUMA
  [    0.376818]    groups: 0:{ span=0-3 cap=4007 }, 4:{ span=4 cap=991 }, 5:{ span=5 cap=1003 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=998 }
  [    0.377465] CPU4 attaching sched-domain(s):
  [    0.377616]  domain-0: span=4-7 level=NUMA
  [    0.377844]   groups: 4:{ span=4 cap=991 }, 5:{ span=5 cap=1003 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=998 }
  [    0.378445]   domain-1: span=0-7 level=NUMA
  [    0.378622]    groups: 4:{ span=4-7 cap=3995 }, 0:{ span=0 cap=1012 }, 1:{ span=1 cap=1001 }, 2:{ span=2 cap=1000 }, 3:{ span=3 cap=993 }
  [    0.379296] CPU5 attaching sched-domain(s):
  [    0.379453]  domain-0: span=4-7 level=NUMA
  [    0.379629]   groups: 5:{ span=5 cap=1003 }, 6:{ span=6 cap=1003 }, 7:{ span=7 cap=998 }, 4:{ span=4 cap=991 }
  [    0.380499]   domain-1: span=0-7 level=NUMA
  [    0.380800]    groups: 4:{ span=4-7 cap=4001 }, 0:{ span=0 cap=1012 }, 1:{ span=1 cap=1001 }, 2:{ span=2 cap=1000 }, 3:{ span=3 cap=998 }
  [    0.381475] CPU6 attaching sched-domain(s):
  [    0.381641]  domain-0: span=4-7 level=NUMA
  [    0.381882]   groups: 6:{ span=6 cap=1003 }, 7:{ span=7 cap=998 }, 4:{ span=4 cap=997 }, 5:{ span=5 cap=1003 }
  [    0.382419]   domain-1: span=0-7 level=NUMA
  [    0.382594]    groups: 4:{ span=4-7 cap=4001 }, 0:{ span=0 cap=1012 }, 1:{ span=1 cap=1001 }, 2:{ span=2 cap=1004 }, 3:{ span=3 cap=998 }
  [    0.383253] CPU7 attaching sched-domain(s):
  [    0.383407]  domain-0: span=4-7 level=NUMA
  [    0.383584]   groups: 7:{ span=7 cap=998 }, 4:{ span=4 cap=997 }, 5:{ span=5 cap=1003 }, 6:{ span=6 cap=1003 }
  [    0.384089]   domain-1: span=0-7 level=NUMA
  [    0.384516]    groups: 4:{ span=4-7 cap=4001 }, 0:{ span=0 cap=1012 }, 1:{ span=1 cap=1001 }, 2:{ span=2 cap=1004 }, 3:{ span=3 cap=998 }
  [    0.385503] root domain span: 0-7 (max cpu_capacity = 1024)

IOW, this does more than double the number of groups at higher domains, the
impact of which has yet to be measured.

XXX: this only changes the group generation; actually removing SD_OVERLAP
and all the related fluff is yet to be done.

[1]: http://lore.kernel.org/r/20210201033830.15040-1-song.bao.hua@hisilicon.com

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/topology.c | 44 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 09d35044bd88..a8f69f234258 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -982,6 +982,41 @@ static void init_overlap_sched_group(struct sched_domain *sd,
 	sg->sgc->max_capacity = SCHED_CAPACITY_SCALE;
 }
 
+static struct sched_domain *find_node_domain(struct sched_domain *sd)
+{
+	struct sched_domain *parent;
+
+	BUG_ON(!(sd->flags & SD_NUMA));
+
+	/* Get to the level above NODE */
+	while (sd && sd->child) {
+		parent = sd;
+		sd = sd->child;
+
+		if (!(sd->flags & SD_NUMA))
+			break;
+	}
+	/*
+	 * We're going to create cross topology level sched_group_capacity
+	 * references. This can only work if the domains resulting from said
+	 * levels won't be degenerated, as we need said sgc to be periodically
+	 * updated: it needs to be attached to the local group of a domain
+	 * that didn't get degenerated.
+	 *
+	 * Of course, groups aren't available yet, so we can't call the usual
+	 * sd_degenerate(). Checking domain spans is the closest we get.
+	 * Start from NODE's parent, and keep going up until we get a domain
+	 * we're sure won't be degenerated.
+	 */
+	while (sd->parent &&
+	       cpumask_equal(sched_domain_span(sd), sched_domain_span(parent))) {
+		sd = parent;
+		parent = sd->parent;
+	}
+
+	return parent;
+}
+
 static int
 build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 {
@@ -1015,6 +1050,13 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
 			continue;
 
+		/*
+		 * Local group is child domain's span, as is tradition.
+		 * Non-local groups will only span remote nodes.
+		 */
+		if (first)
+			sibling = find_node_domain(sibling);
+
 		sg = build_group_from_child_sched_domain(sibling, cpu);
 		if (!sg)
 			goto fail;
@@ -1022,7 +1064,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
-		init_overlap_sched_group(sd, sg);
+		init_overlap_sched_group(sibling, sg);
 
 		if (!first)
 			first = sg;
-- 
2.27.0

