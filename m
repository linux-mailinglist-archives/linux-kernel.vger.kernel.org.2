Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F52387535
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347971AbhERJei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347951AbhERJed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D1EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:33:15 -0700 (PDT)
Message-Id: <20210518093118.277228577@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0u7O17lOlO7a60AQ00/ZHxfxJ4t1mHRtYZeKj7baKX0=;
        b=RXK/Bhnu0T+YSoFk6r2VQA+DFKrq23LtpsAd10sMCLHsMUkLPdkFC2UnwFuslnIljlix12
        q+ZkMkCBGdvsOgvWdHhFXpHzixACkKYxvXBvjhtCpuIkO2gu6/AtyilmDS0Fc6A1alRvPg
        K81PV8fDvuTU1Urd4J7NZSfyvi53nXB4YTGjBwYBX7/BdBvTNvwIU522pdoDVsIegGbRT+
        TmNFC9gqHIJeaDKtdNGODLNN8faiGyEPz5k+cvbpHR+mnJooBPUkUwtJxk3IhDYHZzrx0R
        pDfHr0aIktY4tgiJ95g7MZg47Pclv/GsNui6gYn8pOXZm5eKOkg20FPOKh4IEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0u7O17lOlO7a60AQ00/ZHxfxJ4t1mHRtYZeKj7baKX0=;
        b=iWvw/RKda4AV095lztmg4ZYtY46kua4IG2iJNaPQF35qaFiKjzPP9qdJKbrTf/W5m0ZDhL
        wduuumExnovrInCQ==
Date:   Tue, 18 May 2021 11:17:28 +0200
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
Subject: [patch 3/8] perf/arm-cmn: Use irq_set_affinity()
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
 drivers/perf/arm-cmn.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -1162,7 +1162,7 @@ static int arm_cmn_pmu_offline_cpu(unsig
 
 	perf_pmu_migrate_context(&cmn->pmu, cpu, target);
 	for (i = 0; i < cmn->num_dtcs; i++)
-		irq_set_affinity_hint(cmn->dtc[i].irq, cpumask_of(target));
+		irq_set_affinity(cmn->dtc[i].irq, cpumask_of(target));
 	cmn->cpu = target;
 	return 0;
 }
@@ -1222,7 +1222,7 @@ static int arm_cmn_init_irqs(struct arm_
 		if (err)
 			return err;
 
-		err = irq_set_affinity_hint(irq, cpumask_of(cmn->cpu));
+		err = irq_set_affinity(irq, cpumask_of(cmn->cpu));
 		if (err)
 			return err;
 	next:
@@ -1568,16 +1568,11 @@ static int arm_cmn_probe(struct platform
 static int arm_cmn_remove(struct platform_device *pdev)
 {
 	struct arm_cmn *cmn = platform_get_drvdata(pdev);
-	int i;
 
 	writel_relaxed(0, cmn->dtc[0].base + CMN_DT_DTC_CTL);
 
 	perf_pmu_unregister(&cmn->pmu);
 	cpuhp_state_remove_instance(arm_cmn_hp_state, &cmn->cpuhp_node);
-
-	for (i = 0; i < cmn->num_dtcs; i++)
-		irq_set_affinity_hint(cmn->dtc[i].irq, NULL);
-
 	return 0;
 }
 

