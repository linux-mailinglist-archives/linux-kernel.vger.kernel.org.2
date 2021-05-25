Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE123907C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhEYRfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:35:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234006AbhEYRe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:34:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56BFB168F;
        Tue, 25 May 2021 10:33:25 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 467B43F792;
        Tue, 25 May 2021 10:33:24 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH v2 08/10] irqchip/gic-v3-its: Use irq_chip_ack_parent()
Date:   Tue, 25 May 2021 18:32:53 +0100
Message-Id: <20210525173255.620606-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525173255.620606-1-valentin.schneider@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subsequent patches will make the GIC irqchips use a flow handler that
issues an ->irq_ack(). irqchips of child domains need to handle this.

Note: I'm very much not fond of this; this is treacherous and explodes if
any parent chip doesn't have an ->ack() callback. It turns out okay with
EOImode=0 because handle_fasteoi_irq() doesn't issue any ->ack(), but that
is very fragile at best.

An alternative would be to
o make irq_chip_ack_parent() check the callback against NULL
o make irq_chip_ack_parent() the default chip->irq_ack() via
  MSI_FLAG_USE_DEF_CHIP_OPS.

XXX: what about pMSI and fMSI ?

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3-its-pci-msi.c | 1 +
 drivers/irqchip/irq-gic-v3-its.c         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index ad2810c017ed..5bc2787ee86a 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -27,6 +27,7 @@ static struct irq_chip its_msi_irq_chip = {
 	.name			= "ITS-MSI",
 	.irq_unmask		= its_unmask_msi_irq,
 	.irq_mask		= its_mask_msi_irq,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 2e6923c2c8a8..ce39d52409e9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1976,6 +1976,7 @@ static struct irq_chip its_irq_chip = {
 	.name			= "ITS",
 	.irq_mask		= its_mask_irq,
 	.irq_unmask		= its_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
-- 
2.25.1

