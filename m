Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735DA30D85E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhBCLSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:18:42 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12388 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbhBCLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:18:39 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DVzds4QS3z7fJ0;
        Wed,  3 Feb 2021 19:16:33 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.87) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Wed, 3 Feb 2021 19:17:44 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <valentin.schneider@arm.com>, <vincent.guittot@linaro.org>,
        <mgorman@suse.de>, <mingo@kernel.org>, <peterz@infradead.org>,
        <dietmar.eggemann@arm.com>, <morten.rasmussen@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@openeuler.org>, <xuwei5@huawei.com>,
        <liguozhu@hisilicon.com>, <tiantao6@hisilicon.com>,
        <wanghuiqiang@huawei.com>, <prime.zeng@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <guodong.xu@linaro.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Meelis Roos <mroos@linux.ee>
Subject: [PATCH v2] sched/topology: fix the issue groups don't span domain->span for NUMA diameter > 2
Date:   Thu, 4 Feb 2021 00:12:01 +1300
Message-ID: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as NUMA diameter > 2, building sched_domain by sibling's child
domain will definitely create a sched_domain with sched_group which will
span out of the sched_domain:

               +------+         +------+        +-------+       +------+
               | node |  12     |node  | 20     | node  |  12   |node  |
               |  0   +---------+1     +--------+ 2     +-------+3     |
               +------+         +------+        +-------+       +------+

domain0        node0            node1            node2          node3

domain1        node0+1          node0+1          node2+3        node2+3
                                                 +
domain2        node0+1+2                         |
             group: node0+1                      |
               group:node2+3 <-------------------+

when node2 is added into the domain2 of node0, kernel is using the child
domain of node2's domain2, which is domain1(node2+3). Node 3 is outside
the span of the domain including node0+1+2.

This will make load_balance() run based on screwed avg_load and group_type
in the sched_group spanning out of the sched_domain, and it also makes
select_task_rq_fair() pick an idle CPU out of the sched_domain.

Real servers which suffer from this problem include Kunpeng920 and 8-node
Sun Fire X4600-M2, at least.

Here we move to use the *child* domain of the *child* domain of node2's
domain2 as the new added sched_group. At the same time, we re-use the
lower level sgc directly.

               +------+         +------+        +-------+       +------+
               | node |  12     |node  | 20     | node  |  12   |node  |
               |  0   +---------+1     +--------+ 2     +-------+3     |
               +------+         +------+        +-------+       +------+

domain0        node0            node1          +- node2          node3
                                               |
domain1        node0+1          node0+1        | node2+3        node2+3
                                               |
domain2        node0+1+2                       |
             group: node0+1                    |
               group:node2 <-------------------+

Tested by the below topology:
qemu-system-aarch64  -M virt -nographic \
 -smp cpus=8 \
 -numa node,cpus=0-1,nodeid=0 \
 -numa node,cpus=2-3,nodeid=1 \
 -numa node,cpus=4-5,nodeid=2 \
 -numa node,cpus=6-7,nodeid=3 \
 -numa dist,src=0,dst=1,val=12 \
 -numa dist,src=0,dst=2,val=20 \
 -numa dist,src=0,dst=3,val=22 \
 -numa dist,src=1,dst=2,val=22 \
 -numa dist,src=2,dst=3,val=12 \
 -numa dist,src=1,dst=3,val=24 \
 -m 4G -cpu cortex-a57 -kernel arch/arm64/boot/Image

w/o patch, we get lots of "groups don't span domain->span":
[    0.802139] CPU0 attaching sched-domain(s):
[    0.802193]  domain-0: span=0-1 level=MC
[    0.802443]   groups: 0:{ span=0 cap=1013 }, 1:{ span=1 cap=979 }
[    0.802693]   domain-1: span=0-3 level=NUMA
[    0.802731]    groups: 0:{ span=0-1 cap=1992 }, 2:{ span=2-3 cap=1943 }
[    0.802811]    domain-2: span=0-5 level=NUMA
[    0.802829]     groups: 0:{ span=0-3 cap=3935 }, 4:{ span=4-7 cap=3937 }
[    0.802881] ERROR: groups don't span domain->span
[    0.803058]     domain-3: span=0-7 level=NUMA
[    0.803080]      groups: 0:{ span=0-5 mask=0-1 cap=5843 }, 6:{ span=4-7 mask=6-7 cap=4077 }
[    0.804055] CPU1 attaching sched-domain(s):
[    0.804072]  domain-0: span=0-1 level=MC
[    0.804096]   groups: 1:{ span=1 cap=979 }, 0:{ span=0 cap=1013 }
[    0.804152]   domain-1: span=0-3 level=NUMA
[    0.804170]    groups: 0:{ span=0-1 cap=1992 }, 2:{ span=2-3 cap=1943 }
[    0.804219]    domain-2: span=0-5 level=NUMA
[    0.804236]     groups: 0:{ span=0-3 cap=3935 }, 4:{ span=4-7 cap=3937 }
[    0.804302] ERROR: groups don't span domain->span
[    0.804520]     domain-3: span=0-7 level=NUMA
[    0.804546]      groups: 0:{ span=0-5 mask=0-1 cap=5843 }, 6:{ span=4-7 mask=6-7 cap=4077 }
[    0.804677] CPU2 attaching sched-domain(s):
[    0.804687]  domain-0: span=2-3 level=MC
[    0.804705]   groups: 2:{ span=2 cap=934 }, 3:{ span=3 cap=1009 }
[    0.804754]   domain-1: span=0-3 level=NUMA
[    0.804772]    groups: 2:{ span=2-3 cap=1943 }, 0:{ span=0-1 cap=1992 }
[    0.804820]    domain-2: span=0-5 level=NUMA
[    0.804836]     groups: 2:{ span=0-3 mask=2-3 cap=3991 }, 4:{ span=0-1,4-7 mask=4-5 cap=5985 }
[    0.804944] ERROR: groups don't span domain->span
[    0.805108]     domain-3: span=0-7 level=NUMA
[    0.805134]      groups: 2:{ span=0-5 mask=2-3 cap=5899 }, 6:{ span=0-1,4-7 mask=6-7 cap=6125 }
[    0.805223] CPU3 attaching sched-domain(s):
[    0.805232]  domain-0: span=2-3 level=MC
[    0.805249]   groups: 3:{ span=3 cap=1009 }, 2:{ span=2 cap=934 }
[    0.805319]   domain-1: span=0-3 level=NUMA
[    0.805336]    groups: 2:{ span=2-3 cap=1943 }, 0:{ span=0-1 cap=1992 }
[    0.805383]    domain-2: span=0-5 level=NUMA
[    0.805399]     groups: 2:{ span=0-3 mask=2-3 cap=3991 }, 4:{ span=0-1,4-7 mask=4-5 cap=5985 }
[    0.805458] ERROR: groups don't span domain->span
[    0.805605]     domain-3: span=0-7 level=NUMA
[    0.805626]      groups: 2:{ span=0-5 mask=2-3 cap=5899 }, 6:{ span=0-1,4-7 mask=6-7 cap=6125 }
[    0.805712] CPU4 attaching sched-domain(s):
[    0.805721]  domain-0: span=4-5 level=MC
[    0.805738]   groups: 4:{ span=4 cap=984 }, 5:{ span=5 cap=924 }
[    0.805787]   domain-1: span=4-7 level=NUMA
[    0.805803]    groups: 4:{ span=4-5 cap=1908 }, 6:{ span=6-7 cap=2029 }
[    0.805851]    domain-2: span=0-1,4-7 level=NUMA
[    0.805867]     groups: 4:{ span=4-7 cap=3937 }, 0:{ span=0-3 cap=3935 }
[    0.805915] ERROR: groups don't span domain->span
[    0.806108]     domain-3: span=0-7 level=NUMA
[    0.806130]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=5985 }, 2:{ span=0-3 mask=2-3 cap=3991 }
[    0.806214] CPU5 attaching sched-domain(s):
[    0.806222]  domain-0: span=4-5 level=MC
[    0.806240]   groups: 5:{ span=5 cap=924 }, 4:{ span=4 cap=984 }
[    0.806841]   domain-1: span=4-7 level=NUMA
[    0.806866]    groups: 4:{ span=4-5 cap=1908 }, 6:{ span=6-7 cap=2029 }
[    0.806934]    domain-2: span=0-1,4-7 level=NUMA
[    0.806953]     groups: 4:{ span=4-7 cap=3937 }, 0:{ span=0-3 cap=3935 }
[    0.807004] ERROR: groups don't span domain->span
[    0.807312]     domain-3: span=0-7 level=NUMA
[    0.807386]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=5985 }, 2:{ span=0-3 mask=2-3 cap=3991 }
[    0.807686] CPU6 attaching sched-domain(s):
[    0.807710]  domain-0: span=6-7 level=MC
[    0.807750]   groups: 6:{ span=6 cap=1017 }, 7:{ span=7 cap=1012 }
[    0.807840]   domain-1: span=4-7 level=NUMA
[    0.807870]    groups: 6:{ span=6-7 cap=2029 }, 4:{ span=4-5 cap=1908 }
[    0.807952]    domain-2: span=0-1,4-7 level=NUMA
[    0.807985]     groups: 6:{ span=4-7 mask=6-7 cap=4077 }, 0:{ span=0-5 mask=0-1 cap=5843 }
[    0.808045] ERROR: groups don't span domain->span
[    0.808257]     domain-3: span=0-7 level=NUMA
[    0.808571]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=6125 }, 2:{ span=0-5 mask=2-3 cap=5899 }
[    0.808848] CPU7 attaching sched-domain(s):
[    0.808860]  domain-0: span=6-7 level=MC
[    0.808880]   groups: 7:{ span=7 cap=1012 }, 6:{ span=6 cap=1017 }
[    0.808953]   domain-1: span=4-7 level=NUMA
[    0.808974]    groups: 6:{ span=6-7 cap=2029 }, 4:{ span=4-5 cap=1908 }
[    0.809034]    domain-2: span=0-1,4-7 level=NUMA
[    0.809055]     groups: 6:{ span=4-7 mask=6-7 cap=4077 }, 0:{ span=0-5 mask=0-1 cap=5843 }
[    0.809128] ERROR: groups don't span domain->span
[    0.810361]     domain-3: span=0-7 level=NUMA
[    0.810400]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=5961 }, 2:{ span=0-5 mask=2-3 cap=5903 }

w/ patch, we don't get "groups don't span domain->span" any more:
[    1.486271] CPU0 attaching sched-domain(s):
[    1.486820]  domain-0: span=0-1 level=MC
[    1.500924]   groups: 0:{ span=0 cap=980 }, 1:{ span=1 cap=994 }
[    1.515717]   domain-1: span=0-3 level=NUMA
[    1.515903]    groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3 cap=1989 }
[    1.516989]    domain-2: span=0-5 level=NUMA
[    1.517124]     groups: 0:{ span=0-3 cap=3963 }, 4:{ span=4-5 cap=1949 }
[    1.517369]     domain-3: span=0-7 level=NUMA
[    1.517423]      groups: 0:{ span=0-5 mask=0-1 cap=5912 }, 6:{ span=4-7 mask=6-7 cap=4054 }
[    1.520027] CPU1 attaching sched-domain(s):
[    1.520097]  domain-0: span=0-1 level=MC
[    1.520184]   groups: 1:{ span=1 cap=994 }, 0:{ span=0 cap=980 }
[    1.520429]   domain-1: span=0-3 level=NUMA
[    1.520487]    groups: 0:{ span=0-1 cap=1974 }, 2:{ span=2-3 cap=1989 }
[    1.520687]    domain-2: span=0-5 level=NUMA
[    1.520744]     groups: 0:{ span=0-3 cap=3963 }, 4:{ span=4-5 cap=1949 }
[    1.520948]     domain-3: span=0-7 level=NUMA
[    1.521038]      groups: 0:{ span=0-5 mask=0-1 cap=5912 }, 6:{ span=4-7 mask=6-7 cap=4054 }
[    1.522068] CPU2 attaching sched-domain(s):
[    1.522348]  domain-0: span=2-3 level=MC
[    1.522606]   groups: 2:{ span=2 cap=1003 }, 3:{ span=3 cap=986 }
[    1.522832]   domain-1: span=0-3 level=NUMA
[    1.522885]    groups: 2:{ span=2-3 cap=1989 }, 0:{ span=0-1 cap=1974 }
[    1.523043]    domain-2: span=0-5 level=NUMA
[    1.523092]     groups: 2:{ span=0-3 mask=2-3 cap=4037 }, 4:{ span=4-5 cap=1949 }
[    1.523302]     domain-3: span=0-7 level=NUMA
[    1.523352]      groups: 2:{ span=0-5 mask=2-3 cap=5986 }, 6:{ span=0-1,4-7 mask=6-7 cap=6102 }
[    1.523748] CPU3 attaching sched-domain(s):
[    1.523774]  domain-0: span=2-3 level=MC
[    1.523825]   groups: 3:{ span=3 cap=986 }, 2:{ span=2 cap=1003 }
[    1.524009]   domain-1: span=0-3 level=NUMA
[    1.524086]    groups: 2:{ span=2-3 cap=1989 }, 0:{ span=0-1 cap=1974 }
[    1.524281]    domain-2: span=0-5 level=NUMA
[    1.524331]     groups: 2:{ span=0-3 mask=2-3 cap=4037 }, 4:{ span=4-5 cap=1949 }
[    1.524534]     domain-3: span=0-7 level=NUMA
[    1.524586]      groups: 2:{ span=0-5 mask=2-3 cap=5986 }, 6:{ span=0-1,4-7 mask=6-7 cap=6102 }
[    1.524847] CPU4 attaching sched-domain(s):
[    1.524873]  domain-0: span=4-5 level=MC
[    1.524954]   groups: 4:{ span=4 cap=958 }, 5:{ span=5 cap=991 }
[    1.525105]   domain-1: span=4-7 level=NUMA
[    1.525153]    groups: 4:{ span=4-5 cap=1949 }, 6:{ span=6-7 cap=2006 }
[    1.525368]    domain-2: span=0-1,4-7 level=NUMA
[    1.525428]     groups: 4:{ span=4-7 cap=3955 }, 0:{ span=0-1 cap=1974 }
[    1.532726]     domain-3: span=0-7 level=NUMA
[    1.532811]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=6003 }, 2:{ span=0-3 mask=2-3 cap=4037 }
[    1.534125] CPU5 attaching sched-domain(s):
[    1.534159]  domain-0: span=4-5 level=MC
[    1.534303]   groups: 5:{ span=5 cap=991 }, 4:{ span=4 cap=958 }
[    1.534490]   domain-1: span=4-7 level=NUMA
[    1.534572]    groups: 4:{ span=4-5 cap=1949 }, 6:{ span=6-7 cap=2006 }
[    1.534734]    domain-2: span=0-1,4-7 level=NUMA
[    1.534783]     groups: 4:{ span=4-7 cap=3955 }, 0:{ span=0-1 cap=1974 }
[    1.536057]     domain-3: span=0-7 level=NUMA
[    1.536430]      groups: 4:{ span=0-1,4-7 mask=4-5 cap=6003 }, 2:{ span=0-3 mask=2-3 cap=3896 }
[    1.536815] CPU6 attaching sched-domain(s):
[    1.536846]  domain-0: span=6-7 level=MC
[    1.536934]   groups: 6:{ span=6 cap=1005 }, 7:{ span=7 cap=1001 }
[    1.537144]   domain-1: span=4-7 level=NUMA
[    1.537262]    groups: 6:{ span=6-7 cap=2006 }, 4:{ span=4-5 cap=1949 }
[    1.537553]    domain-2: span=0-1,4-7 level=NUMA
[    1.537613]     groups: 6:{ span=4-7 mask=6-7 cap=4054 }, 0:{ span=0-1 cap=1805 }
[    1.537872]     domain-3: span=0-7 level=NUMA
[    1.537998]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=6102 }, 2:{ span=0-5 mask=2-3 cap=5845 }
[    1.538448] CPU7 attaching sched-domain(s):
[    1.538505]  domain-0: span=6-7 level=MC
[    1.538586]   groups: 7:{ span=7 cap=1001 }, 6:{ span=6 cap=1005 }
[    1.538746]   domain-1: span=4-7 level=NUMA
[    1.538798]    groups: 6:{ span=6-7 cap=2006 }, 4:{ span=4-5 cap=1949 }
[    1.539048]    domain-2: span=0-1,4-7 level=NUMA
[    1.539111]     groups: 6:{ span=4-7 mask=6-7 cap=4054 }, 0:{ span=0-1 cap=1805 }
[    1.539571]     domain-3: span=0-7 level=NUMA
[    1.539610]      groups: 6:{ span=0-1,4-7 mask=6-7 cap=6102 }, 2:{ span=0-5 mask=2-3 cap=5845 }

Reported-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2:
 merged Valentin's edit on v1, thus fixed two issues
 * "one cpu in one numa" was not supported
 * the capacity of groups from grandchild couldn't be updated
 Thanks for Valentin's nice edit!

 And also added some comments in build_balance_mask

 kernel/sched/topology.c | 85 +++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5d3675c7a76b..964ed89001fe 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -723,35 +723,6 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
 	for (tmp = sd; tmp; tmp = tmp->parent)
 		numa_distance += !!(tmp->flags & SD_NUMA);
 
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
@@ -908,6 +879,17 @@ build_balance_mask(struct sched_domain *sd, struct sched_group *sg, struct cpuma
 	for_each_cpu(i, sg_span) {
 		sibling = *per_cpu_ptr(sdd->sd, i);
 
+		/*
+		 * for NUMA diameter >= 3, while sibling->child spans out of
+		 * the domain being built, we are using the grandchild;
+		 * build_overlap_sched_groups includes words on how this could
+		 * happen
+		 */
+		while (sibling->child &&
+			!cpumask_subset(sched_domain_span(sibling->child),
+					sched_domain_span(sd)))
+			sibling = sibling->child;
+
 		/*
 		 * Can happen in the asymmetric case, where these siblings are
 		 * unused. The mask will not be empty because those CPUs that
@@ -955,10 +937,11 @@ build_group_from_child_sched_domain(struct sched_domain *sd, int cpu)
 }
 
 static void init_overlap_sched_group(struct sched_domain *sd,
-				     struct sched_group *sg)
+				     struct sched_group *sg,
+				     struct sched_domain *grandchild)
 {
 	struct cpumask *mask = sched_domains_tmpmask2;
-	struct sd_data *sdd = sd->private;
+	struct sd_data *sdd = grandchild ? grandchild->private : sd->private;
 	struct cpumask *sg_span;
 	int cpu;
 
@@ -996,6 +979,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 
 	for_each_cpu_wrap(i, span, cpu) {
 		struct cpumask *sg_span;
+		bool from_grandchild = false;
 
 		if (cpumask_test_cpu(i, covered))
 			continue;
@@ -1015,6 +999,43 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		if (!cpumask_test_cpu(i, sched_domain_span(sibling)))
 			continue;
 
+		/*
+		 * for NUMA diameter >= 3, building sched_domain by sibling's
+		 * child's child domain to prevent sched_group from spanning
+		 * out of sched_domain
+		 * if we don't do this, Diameter >=3 is misrepresented:
+		 *
+		 * Smallest diameter=3 topology is:
+		 *
+		 *   node   0   1   2   3
+		 *     0:  10  20  30  40
+		 *     1:  20  10  20  30
+		 *     2:  30  20  10  20
+		 *     3:  40  30  20  10
+		 *
+		 *   0 --- 1 --- 2 --- 3
+		 *
+		 * NUMA-3       0-3             N/A             N/A             0-3
+		 *  groups:     {0-2},{1-3}                                     {1-3},{0-2}
+		 *
+		 * NUMA-2       0-2             0-3             0-3             1-3
+		 *  groups:     {0-1},{1-3}     {0-2},{2-3}     {1-3},{0-1}     {2-3},{0-2}
+		 *
+		 * NUMA-1       0-1             0-2             1-3             2-3
+		 *  groups:     {0},{1}         {1},{2},{0}     {2},{3},{1}     {3},{2}
+		 *
+		 * NUMA-0       0               1               2               3
+		 *
+		 * The NUMA-2 groups for nodes 0 and 3 are obviously buggered, as the
+		 * group span isn't a subset of the domain span.
+		 */
+		while (sibling->child &&
+		       !cpumask_subset(sched_domain_span(sibling->child),
+				       span)) {
+			sibling = sibling->child;
+			from_grandchild = true;
+		}
+
 		sg = build_group_from_child_sched_domain(sibling, cpu);
 		if (!sg)
 			goto fail;
@@ -1022,7 +1043,7 @@ build_overlap_sched_groups(struct sched_domain *sd, int cpu)
 		sg_span = sched_group_span(sg);
 		cpumask_or(covered, covered, sg_span);
 
-		init_overlap_sched_group(sd, sg);
+		init_overlap_sched_group(sd, sg, from_grandchild ? sibling : NULL);
 
 		if (!first)
 			first = sg;
-- 
2.25.1

