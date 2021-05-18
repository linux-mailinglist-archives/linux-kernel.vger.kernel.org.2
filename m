Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B646387534
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbhERJeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347946AbhERJeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FAFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:33:14 -0700 (PDT)
Message-Id: <20210518093118.128250213@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xgxWrmDeDwFcZVosRdGu2aXTryt71ywlqfvU/UpOvTE=;
        b=lmUWDic0xKRoYIFopWB7A5EyT7AMa3perXn0V85VCgBB73ufYcJ/Yf+/54p+dH/0pvTxtI
        TKkCRirJG8MnweUAwIaEtGZI43VM9X6VGJQZxHIZ+K+ntMWkSaXMj2BxrgQ1pL4lLo/F5B
        u+rKiXKD2RBdlxFEhuAWqQsHKkmCow/4D0R/nnnf29NXWH2sIFyuHzYb5rdqmPJL+HmQW+
        wEm6xwK3y/9R9c8b/Xvzocj9+8wZVYTds68/GU+DQPevBWytHE+2xJqmtZDq+iMRLfqp1W
        h/GsxctofoVUccyFxL58Q/YhKmzBXYdxT/Byzwzj5Dtnr3bYkEr17BfMSabQ3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=xgxWrmDeDwFcZVosRdGu2aXTryt71ywlqfvU/UpOvTE=;
        b=fL0TTVh71wwKJteJdTCRD0y/xcTIiGkv9htd38SnVIvvPjjjrMBXdS440T5gGl0PYVPS2h
        KCEYGC15Tb77QuDw==
Date:   Tue, 18 May 2021 11:17:27 +0200
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
Subject: [patch 2/8] perf/arm-ccn: Use irq_set_affinity()
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
 drivers/perf/arm-ccn.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -1211,7 +1211,7 @@ static int arm_ccn_pmu_offline_cpu(unsig
 	perf_pmu_migrate_context(&dt->pmu, cpu, target);
 	dt->cpu = target;
 	if (ccn->irq)
-		WARN_ON(irq_set_affinity_hint(ccn->irq, cpumask_of(dt->cpu)));
+		WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
 	return 0;
 }
 
@@ -1291,7 +1291,7 @@ static int arm_ccn_pmu_init(struct arm_c
 
 	/* Also make sure that the overflow interrupt is handled by this CPU */
 	if (ccn->irq) {
-		err = irq_set_affinity_hint(ccn->irq, cpumask_of(ccn->dt.cpu));
+		err = irq_set_affinity(ccn->irq, cpumask_of(ccn->dt.cpu));
 		if (err) {
 			dev_err(ccn->dev, "Failed to set interrupt affinity!\n");
 			goto error_set_affinity;
@@ -1325,8 +1325,6 @@ static void arm_ccn_pmu_cleanup(struct a
 
 	cpuhp_state_remove_instance_nocalls(CPUHP_AP_PERF_ARM_CCN_ONLINE,
 					    &ccn->dt.node);
-	if (ccn->irq)
-		irq_set_affinity_hint(ccn->irq, NULL);
 	for (i = 0; i < ccn->num_xps; i++)
 		writel(0, ccn->xp[i].base + CCN_XP_DT_CONTROL);
 	writel(0, ccn->dt.base + CCN_DT_PMCR);

