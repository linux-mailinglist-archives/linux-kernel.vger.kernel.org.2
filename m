Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA833B4E5A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 13:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhFZLEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Jun 2021 07:04:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5771 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbhFZLEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 07:04:36 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GBrRG2D4hzXlHg;
        Sat, 26 Jun 2021 18:56:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:12 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 19:02:12 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH RFC 8/8] iommu/arm-smmu-v3: Add support for less than one ECMDQ per core
Date:   Sat, 26 Jun 2021 19:01:30 +0800
Message-ID: <20210626110130.2416-9-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210626110130.2416-1-thunder.leizhen@huawei.com>
References: <20210626110130.2416-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to limited hardware resources, the number of ECMDQs may be less than
the number of cores. If the number of ECMDQs is greater than the number of
numa nodes, ensure that each node has at least one ECMDQ. This is because
ECMDQ queue memory is requested from the NUMA node where it resides, which
may result in better command filling and insertion performance.

The current ECMDQ implementation reuses the command insertion function
arm_smmu_cmdq_issue_cmdlist() of the normal CMDQ. This function already
supports multiple cores concurrent insertion commands.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 101 ++++++++++++++++++--
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a088f2479fc6223..55f651ce42e7a51 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3636,14 +3636,15 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
 {
-	int cpu;
-	struct arm_smmu_ecmdq *ecmdq;
+	int cpu, node, nr_remain, nr_nodes = 0;
+	int *nr_ecmdqs;
+	struct arm_smmu_ecmdq *ecmdq, **ecmdqs;
 
-	if (num_possible_cpus() <= smmu->nr_ecmdq) {
-		ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
-		if (!ecmdq)
-			return -ENOMEM;
+	ecmdq = devm_alloc_percpu(smmu->dev, *ecmdq);
+	if (!ecmdq)
+		return -ENOMEM;
 
+	if (num_possible_cpus() <= smmu->nr_ecmdq) {
 		for_each_possible_cpu(cpu)
 			*per_cpu_ptr(smmu->ecmdq, cpu) = per_cpu_ptr(ecmdq, cpu);
 
@@ -3653,7 +3654,79 @@ static int arm_smmu_ecmdq_layout(struct arm_smmu_device *smmu)
 		return 0;
 	}
 
-	return -ENOSPC;
+	for_each_node(node)
+		if (nr_cpus_node(node))
+			nr_nodes++;
+
+	if (nr_nodes >= smmu->nr_ecmdq) {
+		dev_err(smmu->dev, "%d ECMDQs is less than %d nodes\n", smmu->nr_ecmdq, nr_nodes);
+		return -ENOSPC;
+	}
+
+	nr_ecmdqs = kcalloc(MAX_NUMNODES, sizeof(int), GFP_KERNEL);
+	if (!nr_ecmdqs)
+		return -ENOMEM;
+
+	ecmdqs = kcalloc(smmu->nr_ecmdq, sizeof(*ecmdqs), GFP_KERNEL);
+	if (!ecmdqs) {
+		kfree(nr_ecmdqs);
+		return -ENOMEM;
+	}
+
+	/* [1] Ensure that each node has at least one ECMDQ */
+	nr_remain = smmu->nr_ecmdq - nr_nodes;
+	for_each_node(node) {
+		/*
+		 * Calculate the number of ECMDQs to be allocated to this node.
+		 * NR_ECMDQS_PER_CPU = nr_remain / num_possible_cpus();
+		 * When nr_cpus_node(node) is not zero, less than one ECMDQ
+		 * may be left due to truncation rounding.
+		 */
+		nr_ecmdqs[node] = nr_cpus_node(node) * nr_remain / num_possible_cpus();
+		nr_remain -= nr_ecmdqs[node];
+	}
+
+	/* Divide the remaining ECMDQs */
+	while (nr_remain) {
+		for_each_node(node) {
+			if (!nr_remain)
+				break;
+
+			if (nr_ecmdqs[node] >= nr_cpus_node(node))
+				continue;
+
+			nr_ecmdqs[node]++;
+			nr_remain--;
+		}
+	}
+
+	for_each_node(node) {
+		int i, round, shared = 0;
+
+		if (!nr_cpus_node(node))
+			continue;
+
+		/* An ECMDQ has been reserved for each node at above [1] */
+		nr_ecmdqs[node]++;
+
+		if (nr_ecmdqs[node] < nr_cpus_node(node))
+			shared = 1;
+
+		i = 0;
+		for_each_cpu(cpu, cpumask_of_node(node)) {
+			round = i % nr_ecmdqs[node];
+			if (i++ < nr_ecmdqs[node]) {
+				ecmdqs[round] = per_cpu_ptr(ecmdq, cpu);
+				ecmdqs[round]->cmdq.shared = shared;
+			}
+			*per_cpu_ptr(smmu->ecmdq, cpu) = ecmdqs[round];
+		}
+	}
+
+	kfree(nr_ecmdqs);
+	kfree(ecmdqs);
+
+	return 0;
 }
 
 static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
@@ -3718,10 +3791,20 @@ static int arm_smmu_ecmdq_probe(struct arm_smmu_device *smmu)
 		struct arm_smmu_queue *q;
 
 		ecmdq = *per_cpu_ptr(smmu->ecmdq, cpu);
-		ecmdq->base = cp_base + addr;
-
 		q = &ecmdq->cmdq.q;
 
+		/*
+		 * The boot option "maxcpus=" can limit the number of online
+		 * CPUs. The CPUs that are not selected are not showed in
+		 * cpumask_of_node(node), their 'ecmdq' may be NULL.
+		 *
+		 * (q->ecmdq_prod & ECMDQ_PROD_EN) indicates that the ECMDQ is
+		 * shared by multiple cores and has been initialized.
+		 */
+		if (!ecmdq || (q->ecmdq_prod & ECMDQ_PROD_EN))
+			continue;
+		ecmdq->base = cp_base + addr;
+
 		q->llq.max_n_shift = ECMDQ_MAX_SZ_SHIFT + shift_increment;
 		ret = arm_smmu_init_one_queue(smmu, q, ecmdq->base, ARM_SMMU_ECMDQ_PROD,
 				ARM_SMMU_ECMDQ_CONS, CMDQ_ENT_DWORDS, "ecmdq");
-- 
2.26.0.106.g9fadedd


