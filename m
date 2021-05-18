Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1144A387538
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348018AbhERJeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347961AbhERJeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:36 -0400
Message-Id: <20210518093118.603636289@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=llqiZZOpujTFGvfM7I86v3/lISoIngOGifb8EaNbJmk=;
        b=g4WPw7BFA2Un46jknT1BruVtJka+olrBbvzPETf4eW8E6VKHOPmlUg/NiVpImVk/xKpNcJ
        S3eYYkCJOZ1G6DCw891G3BXApTZ6HnUyzgzSJWQ2wOcXYNbsUqXauU4vW2rpUI8uW2bBiu
        YZSShOJtESAfokYWne7nWk93ue8YpQ7MvcmdZcEp+hX2WjVHnTLHgsT/4ykiBH6TA26nFN
        PTwMDh3cWc6eIKo+8Ficiw5eQkOK6LrqPP/KuCxS2RwNu31xF1X9WkAk6cYby0Q5IHlzfg
        TB2BpiA2c6DjcxI6nljybqaIiqotbX8j28vqNvnJG9wTvEobOl2P2VH6uzakuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=llqiZZOpujTFGvfM7I86v3/lISoIngOGifb8EaNbJmk=;
        b=VIe+CsBTI0rLK2aPQMKFDPakGpP+dpkiWj/B0hUfnrWDhpAUeIr08pJ2oAItFhDg1G0bk6
        tVCsrMnP62K2GaCg==
Date:   Tue, 18 May 2021 11:17:31 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [patch 6/8] perf/arm-smmuv3: Use irq_set_affinity()
References: <20210518091725.046774792@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses irq_set_affinity_hint() to set the affinity for the PMU
interrupts, which relies on the undocumented side effect that this function
actually sets the affinity under the hood.

Setting an hint is clearly not a guarantee and for these PMU interrupts an
affinity hint, which is supposed to guide userspace for setting affinity,
is beyond pointless, because the affinity of these interrupts cannot be
modified from user space.

Aside of that the error checks are bogus because the only error which is
returned from irq_set_affinity_hint() is when there is no irq descriptor
for the interrupt number, but not when the affinity set fails. That's on
purpose because the hint can point to an offline CPU.

Replace the mindless abuse with irq_set_affinity().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/perf/arm_smmuv3_pmu.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -628,7 +628,7 @@ static int smmu_pmu_offline_cpu(unsigned
 
 	perf_pmu_migrate_context(&smmu_pmu->pmu, cpu, target);
 	smmu_pmu->on_cpu = target;
-	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq, cpumask_of(target)));
+	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
 
 	return 0;
 }
@@ -839,15 +839,14 @@ static int smmu_pmu_probe(struct platfor
 
 	/* Pick one CPU to be the preferred one to use */
 	smmu_pmu->on_cpu = raw_smp_processor_id();
-	WARN_ON(irq_set_affinity_hint(smmu_pmu->irq,
-				      cpumask_of(smmu_pmu->on_cpu)));
+	WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
 
 	err = cpuhp_state_add_instance_nocalls(cpuhp_state_num,
 					       &smmu_pmu->node);
 	if (err) {
 		dev_err(dev, "Error %d registering hotplug, PMU @%pa\n",
 			err, &res_0->start);
-		goto out_clear_affinity;
+		return err;
 	}
 
 	err = perf_pmu_register(&smmu_pmu->pmu, name, -1);
@@ -866,8 +865,6 @@ static int smmu_pmu_probe(struct platfor
 
 out_unregister:
 	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
-out_clear_affinity:
-	irq_set_affinity_hint(smmu_pmu->irq, NULL);
 	return err;
 }
 
@@ -877,7 +874,6 @@ static int smmu_pmu_remove(struct platfo
 
 	perf_pmu_unregister(&smmu_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &smmu_pmu->node);
-	irq_set_affinity_hint(smmu_pmu->irq, NULL);
 
 	return 0;
 }

