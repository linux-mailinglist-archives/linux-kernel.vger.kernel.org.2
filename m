Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513CA44F2F1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 12:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhKML5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 06:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234466AbhKML53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 06:57:29 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53EB96113B;
        Sat, 13 Nov 2021 11:54:37 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mlrcB-005BG2-Gg; Sat, 13 Nov 2021 11:54:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/8] irqchip/apple-aic: Add cpumasks for E and P cores
Date:   Sat, 13 Nov 2021 11:54:24 +0000
Message-Id: <20211113115429.4027571-4-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211113115429.4027571-1-maz@kernel.org>
References: <20211113115429.4027571-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, will@kernel.org, marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io, robh+dt@kernel.org, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to tell the core IRQ code about the affinity
of the PMU interrupt in later patches, compute the cpumasks of the
P and E cores at boot time.

This relies on the affinity scheme used by the vendor, which seems
to work for the couple of SoCs that are out in the wild.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-apple-aic.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
index 3759dc36cc8f..30ca80ccda8b 100644
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -177,6 +177,8 @@ struct aic_irq_chip {
 	void __iomem *base;
 	struct irq_domain *hw_domain;
 	struct irq_domain *ipi_domain;
+	struct cpumask ecore_mask;
+	struct cpumask pcore_mask;
 	int nr_hw;
 	int ipi_hwirq;
 };
@@ -200,6 +202,11 @@ static void aic_ic_write(struct aic_irq_chip *ic, u32 reg, u32 val)
 	writel_relaxed(val, ic->base + reg);
 }
 
+static bool __is_pcore(u64 mpidr)
+{
+	return MPIDR_AFFINITY_LEVEL(mpidr, 2) == 1;
+}
+
 /*
  * IRQ irqchip
  */
@@ -833,6 +840,13 @@ static int __init aic_of_ic_init(struct device_node *node, struct device_node *p
 		return -ENODEV;
 	}
 
+	for_each_possible_cpu(i) {
+		if (__is_pcore(cpu_logical_map(i)))
+			cpumask_set_cpu(i, &irqc->pcore_mask);
+		else
+			cpumask_set_cpu(i, &irqc->ecore_mask);
+	}
+
 	set_handle_irq(aic_handle_irq);
 	set_handle_fiq(aic_handle_fiq);
 
-- 
2.30.2

