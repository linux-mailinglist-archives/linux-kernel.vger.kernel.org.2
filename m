Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB26387539
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348025AbhERJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347967AbhERJeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:37 -0400
Message-Id: <20210518093118.699566062@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TxzviiHdKr5GcZxP2Hy06b5VhRlYn5Pd4CPUH0jcSHw=;
        b=q1uMFjL8Pp+jo+EY1h1Yn7RO9uCKR6RGG2bmNfrqJX9zRjZnzxExgNfvmO54KtoODpHbPl
        8efOcmDYQyxHBm6OAuwnsJVSoGZ86UXz3SYMRotLuFhPvd0sqc+y+15gUWUXheMYGywgEK
        w3jukRi/Nf228gyLb1uKicWnsDqJrk/ctM2BrFGMXwNI0s1OQfuftRi9YVCK75dV5eRQwZ
        H9Wey70e0l12Q9yVxTIgS71mx76v8E4nSu+6uhpL9EX2NJI1foaX339OKZd7/q43jeHbyJ
        vmoLlouzMR2O5hNLmUbCFjzbIJRxWpDUim2vFGZSLZvUM/jBBH8s6rdMmiA8Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TxzviiHdKr5GcZxP2Hy06b5VhRlYn5Pd4CPUH0jcSHw=;
        b=ZtwtvuZER4Wm1N0oYn1RTnBbDn9aB3aZp1G26MqOM90/mqw0gmH0fnM98R0tprPGMebwrA
        Hm46mfRcuf5+zrAQ==
Date:   Tue, 18 May 2021 11:17:32 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>, Frank Li <Frank.li@nxp.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [patch 7/8] perf/imx_ddr: Use irq_set_affinity()
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
Cc: Frank Li <Frank.li@nxp.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/perf/fsl_imx8_ddr_perf.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -674,7 +674,7 @@ static int ddr_perf_offline_cpu(unsigned
 	perf_pmu_migrate_context(&pmu->pmu, cpu, target);
 	pmu->cpu = target;
 
-	WARN_ON(irq_set_affinity_hint(pmu->irq, cpumask_of(pmu->cpu)));
+	WARN_ON(irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)));
 
 	return 0;
 }
@@ -749,7 +749,7 @@ static int ddr_perf_probe(struct platfor
 	}
 
 	pmu->irq = irq;
-	ret = irq_set_affinity_hint(pmu->irq, cpumask_of(pmu->cpu));
+	ret = irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu));
 	if (ret) {
 		dev_err(pmu->dev, "Failed to set interrupt affinity!\n");
 		goto ddr_perf_err;
@@ -777,7 +777,6 @@ static int ddr_perf_remove(struct platfo
 
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
 	cpuhp_remove_multi_state(pmu->cpuhp_state);
-	irq_set_affinity_hint(pmu->irq, NULL);
 
 	perf_pmu_unregister(&pmu->pmu);
 

