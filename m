Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C745338753A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348035AbhERJey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347946AbhERJei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:38 -0400
Message-Id: <20210518093118.813375875@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QqG76h/Zci9cwUUh2Wp3E6jP7nye6WKjTjjUQ/ncg4E=;
        b=oTbxvY6m5tSxVH9aJGcTgY2+nr4OSMnYvHyN87wNjKFWyeKrHd4aSGsmI2UJPWy7b46gUj
        bVkzWON99BsgcTLoxrxfks7e63g99dLGHcRusYD9xPgoOD32Jv66S6LYWFasLwf/vCaTCZ
        6clqlpHFpIohwIt9s84Dx5ypMVYBVhljQYGgJRHrFpdMdqk9I276wyww+Om62yQeS1NLVY
        hYfnlQjp4fpwUXddDAonH8TtlRvfjW+hdNxCcz8MAFj+HBpV9wmuDWaOa8fr2P/bQJEpYH
        GVlbiO475MRLI//yT1/pfIxU8qT1ddfpZCyE6tHoNIYwlXbaP65jckl5RgUs3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=QqG76h/Zci9cwUUh2Wp3E6jP7nye6WKjTjjUQ/ncg4E=;
        b=+NspJCeUOiY1S0smlg/ldI84M2Fto/3KQbXGD6Hl4/X88iYgX5WqozhxICac7B0k/KXfmo
        liChmOEownTb+FBQ==
Date:   Tue, 18 May 2021 11:17:33 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [patch 8/8] perf/hisi: Use irq_set_affinity()
References: <20210518091725.046774792@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These drivers use irq_set_affinity_hint() to set the affinity for the PMU
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
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |    3 ---
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |    3 ---
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |    3 ---
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c   |    3 ---
 drivers/perf/hisilicon/hisi_uncore_pmu.c      |    4 ++--
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c |    3 ---
 6 files changed, 2 insertions(+), 17 deletions(-)

--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -537,7 +537,6 @@ static int hisi_ddrc_pmu_probe(struct pl
 		dev_err(ddrc_pmu->dev, "DDRC PMU register failed!\n");
 		cpuhp_state_remove_instance_nocalls(
 			CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE, &ddrc_pmu->node);
-		irq_set_affinity_hint(ddrc_pmu->irq, NULL);
 	}
 
 	return ret;
@@ -550,8 +549,6 @@ static int hisi_ddrc_pmu_remove(struct p
 	perf_pmu_unregister(&ddrc_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_DDRC_ONLINE,
 					    &ddrc_pmu->node);
-	irq_set_affinity_hint(ddrc_pmu->irq, NULL);
-
 	return 0;
 }
 
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -540,7 +540,6 @@ static int hisi_hha_pmu_probe(struct pla
 		dev_err(hha_pmu->dev, "HHA PMU register failed!\n");
 		cpuhp_state_remove_instance_nocalls(
 			CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE, &hha_pmu->node);
-		irq_set_affinity_hint(hha_pmu->irq, NULL);
 	}
 
 	return ret;
@@ -553,8 +552,6 @@ static int hisi_hha_pmu_remove(struct pl
 	perf_pmu_unregister(&hha_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_HHA_ONLINE,
 					    &hha_pmu->node);
-	irq_set_affinity_hint(hha_pmu->irq, NULL);
-
 	return 0;
 }
 
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -578,7 +578,6 @@ static int hisi_l3c_pmu_probe(struct pla
 		dev_err(l3c_pmu->dev, "L3C PMU register failed!\n");
 		cpuhp_state_remove_instance_nocalls(
 			CPUHP_AP_PERF_ARM_HISI_L3_ONLINE, &l3c_pmu->node);
-		irq_set_affinity_hint(l3c_pmu->irq, NULL);
 	}
 
 	return ret;
@@ -591,8 +590,6 @@ static int hisi_l3c_pmu_remove(struct pl
 	perf_pmu_unregister(&l3c_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_L3_ONLINE,
 					    &l3c_pmu->node);
-	irq_set_affinity_hint(l3c_pmu->irq, NULL);
-
 	return 0;
 }
 
--- a/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pa_pmu.c
@@ -436,7 +436,6 @@ static int hisi_pa_pmu_probe(struct plat
 		dev_err(pa_pmu->dev, "PMU register failed, ret = %d\n", ret);
 		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
 					    &pa_pmu->node);
-		irq_set_affinity_hint(pa_pmu->irq, NULL);
 		return ret;
 	}
 
@@ -451,8 +450,6 @@ static int hisi_pa_pmu_remove(struct pla
 	perf_pmu_unregister(&pa_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_PA_ONLINE,
 					    &pa_pmu->node);
-	irq_set_affinity_hint(pa_pmu->irq, NULL);
-
 	return 0;
 }
 
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -488,7 +488,7 @@ int hisi_uncore_pmu_online_cpu(unsigned
 	hisi_pmu->on_cpu = cpu;
 
 	/* Overflow interrupt also should use the same CPU */
-	WARN_ON(irq_set_affinity_hint(hisi_pmu->irq, cpumask_of(cpu)));
+	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
 
 	return 0;
 }
@@ -521,7 +521,7 @@ int hisi_uncore_pmu_offline_cpu(unsigned
 	perf_pmu_migrate_context(&hisi_pmu->pmu, cpu, target);
 	/* Use this CPU for event counting */
 	hisi_pmu->on_cpu = target;
-	WARN_ON(irq_set_affinity_hint(hisi_pmu->irq, cpumask_of(target)));
+	WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
 
 	return 0;
 }
--- a/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c
@@ -465,7 +465,6 @@ static int hisi_sllc_pmu_probe(struct pl
 		dev_err(sllc_pmu->dev, "PMU register failed, ret = %d\n", ret);
 		cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
 					    &sllc_pmu->node);
-		irq_set_affinity_hint(sllc_pmu->irq, NULL);
 		return ret;
 	}
 
@@ -481,8 +480,6 @@ static int hisi_sllc_pmu_remove(struct p
 	perf_pmu_unregister(&sllc_pmu->pmu);
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_HISI_SLLC_ONLINE,
 					    &sllc_pmu->node);
-	irq_set_affinity_hint(sllc_pmu->irq, NULL);
-
 	return 0;
 }
 

