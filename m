Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C789387536
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347985AbhERJej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347949AbhERJee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:34 -0400
Message-Id: <20210518093118.395086573@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=V/bDG9qNgIKyZrOc6/zeyVIGnDKc6AhtxpbL8tdrgEg=;
        b=nTMhrM2cWjxRO31M1UWVX24nzEnK2DOZaPrMex1tUmUEEtWVHbqHAeKl2m3kNE4TZdls7m
        ObFZanUcSWItBDDWqYjAIbw8VxCi4GLRs7BgljMgc1rYKWbgXXvw9WCH4br8XfYSswCvfh
        AqMYqWbQ4CXK2SGYh9LshwR3sFOvUcbsc2ePaFM7pKrwbt7lqXZBtaF/dww+iIydCYoyOQ
        qDXBMtx0SYQ7ISf41e+ck5mKeF6NVsrNZByCichqSepZjmAQH3X0sOG/r5NScjFaOKSWGI
        gEjx5k3oVtlU5851Z/cwT0P/3zBPz5y38fTZd90EvxVsOGg602WZGMRTLEzE7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=V/bDG9qNgIKyZrOc6/zeyVIGnDKc6AhtxpbL8tdrgEg=;
        b=cup5q3qN59BJFgsZj64XE9K5e0LBYILUgKCeyX0o6J8VORqCPT8vfavNXt4QZxdcW89soH
        G8M2ZIME4scHuzDg==
Date:   Tue, 18 May 2021 11:17:29 +0200
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
Subject: [patch 4/8] perf/arm-dmc620: Use irq_set_affinity()
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
 drivers/perf/arm_dmc620_pmu.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/perf/arm_dmc620_pmu.c
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -421,7 +421,7 @@ static struct dmc620_pmu_irq *__dmc620_p
 	if (ret)
 		goto out_free_aff;
 
-	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
+	ret = irq_set_affinity(irq_num, cpumask_of(irq->cpu));
 	if (ret)
 		goto out_free_irq;
 
@@ -475,7 +475,6 @@ static void dmc620_pmu_put_irq(struct dm
 	list_del(&irq->irqs_node);
 	mutex_unlock(&dmc620_pmu_irqs_lock);
 
-	WARN_ON(irq_set_affinity_hint(irq->irq_num, NULL));
 	free_irq(irq->irq_num, irq);
 	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
 	kfree(irq);
@@ -622,7 +621,7 @@ static int dmc620_pmu_cpu_teardown(unsig
 		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
 	mutex_unlock(&dmc620_pmu_irqs_lock);
 
-	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
+	WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
 	irq->cpu = target;
 
 	return 0;

