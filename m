Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA8387537
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347951AbhERJet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58958 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347957AbhERJef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:35 -0400
Message-Id: <20210518093118.505110632@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b90nAbK3k34HRbQdysTkS+rhjrqZti7oDbJBBGxuaqQ=;
        b=yr6O4dW4S4G3cbaz5ArdzyFx8YFFGxQwLHqbkXHEudPgeKL/9b6rhieARNz8hD/1Kt+ctE
        3InNUuinKLGd8H8uFdB8b8P1JnUpuum513+NGCXn0jAlRJ6K8ebKrfjbUaq0A+rQZh3OLh
        99uBASD3/oOZhdhq/LYSASRZhLzXPBhdQNyTUSgT7ZnoPbmw94jLozCkN4QoV+owwACAXW
        xVqGfEuZmvTygx5Vpt06GUryDeT0tnJLI+w/jcfhSOKrsGceGhn90Hn/KX9pIZoXQ64ekN
        Ix+AJ6ybkvmyG3lCx7B0+VXSxdPJWo/6qrEp07Zf+yueW1BNkPftwXczlP93qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=b90nAbK3k34HRbQdysTkS+rhjrqZti7oDbJBBGxuaqQ=;
        b=0EEEwQglpRuWfTVVpNXrIb7wKLg6twfA8+Umf09EkeIwowpCOd332t/fHLCSXhKcz0mKBZ
        6oRPVquysbQmDqBQ==
Date:   Tue, 18 May 2021 11:17:30 +0200
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
Subject: [patch 5/8] perf/arm-dsu: Use irq_set_affinity()
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
 drivers/perf/arm_dsu_pmu.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -687,7 +687,7 @@ static void dsu_pmu_probe_pmu(struct dsu
 static void dsu_pmu_set_active_cpu(int cpu, struct dsu_pmu *dsu_pmu)
 {
 	cpumask_set_cpu(cpu, &dsu_pmu->active_cpu);
-	if (irq_set_affinity_hint(dsu_pmu->irq, &dsu_pmu->active_cpu))
+	if (irq_set_affinity(dsu_pmu->irq, &dsu_pmu->active_cpu))
 		pr_warn("Failed to set irq affinity to %d\n", cpu);
 }
 
@@ -769,7 +769,6 @@ static int dsu_pmu_device_probe(struct p
 	if (rc) {
 		cpuhp_state_remove_instance(dsu_pmu_cpuhp_state,
 						 &dsu_pmu->cpuhp_node);
-		irq_set_affinity_hint(dsu_pmu->irq, NULL);
 	}
 
 	return rc;
@@ -781,7 +780,6 @@ static int dsu_pmu_device_remove(struct
 
 	perf_pmu_unregister(&dsu_pmu->pmu);
 	cpuhp_state_remove_instance(dsu_pmu_cpuhp_state, &dsu_pmu->cpuhp_node);
-	irq_set_affinity_hint(dsu_pmu->irq, NULL);
 
 	return 0;
 }
@@ -840,10 +838,8 @@ static int dsu_pmu_cpu_teardown(unsigned
 
 	dst = dsu_pmu_get_online_cpu_any_but(dsu_pmu, cpu);
 	/* If there are no active CPUs in the DSU, leave IRQ disabled */
-	if (dst >= nr_cpu_ids) {
-		irq_set_affinity_hint(dsu_pmu->irq, NULL);
+	if (dst >= nr_cpu_ids)
 		return 0;
-	}
 
 	perf_pmu_migrate_context(&dsu_pmu->pmu, cpu, dst);
 	dsu_pmu_set_active_cpu(dst, dsu_pmu);

