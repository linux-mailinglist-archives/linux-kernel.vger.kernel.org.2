Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E01A3B7273
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbhF2MyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:54:03 -0400
Received: from foss.arm.com ([217.140.110.172]:50440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233161AbhF2MxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:53:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 783DF1478;
        Tue, 29 Jun 2021 05:50:57 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 778083F718;
        Tue, 29 Jun 2021 05:50:56 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 09/13] irqchip/gic: Rely on MSI default .irq_eoi()
Date:   Tue, 29 Jun 2021 13:50:06 +0100
Message-Id: <20210629125010.458872-10-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629125010.458872-1-valentin.schneider@arm.com>
References: <20210629125010.458872-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, only platform-MSI irqchips would get a default .irq_eoi().
GIC-based platform-MSI irqchip's rely on this default callback, while
PCI-MSI ones are initialized explicitly.

As all MSI domains now get a default .irq_eoi(), drop the explicit
.irq_eoi() initialization for PCI-MSI chips.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c               | 1 -
 drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 1 -
 drivers/irqchip/irq-gic-v3-its-pci-msi.c    | 1 -
 drivers/irqchip/irq-gic-v3-mbi.c            | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index be9ea6fd6f8b..27a97c76ba0d 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -87,7 +87,6 @@ static struct irq_chip gicv2m_msi_irq_chip = {
 	.name			= "MSI",
 	.irq_mask		= gicv2m_mask_msi_irq,
 	.irq_unmask		= gicv2m_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
diff --git a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
index 634263dfd7b5..105ee646cd12 100644
--- a/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c
@@ -21,7 +21,6 @@ static struct irq_chip its_msi_irq_chip = {
 	.name = "ITS-fMSI",
 	.irq_mask = irq_chip_mask_parent,
 	.irq_unmask = irq_chip_unmask_parent,
-	.irq_eoi = irq_chip_eoi_parent,
 	.irq_set_affinity = msi_domain_set_affinity
 };
 
diff --git a/drivers/irqchip/irq-gic-v3-its-pci-msi.c b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
index ad2810c017ed..14f6e63c630c 100644
--- a/drivers/irqchip/irq-gic-v3-its-pci-msi.c
+++ b/drivers/irqchip/irq-gic-v3-its-pci-msi.c
@@ -27,7 +27,6 @@ static struct irq_chip its_msi_irq_chip = {
 	.name			= "ITS-MSI",
 	.irq_unmask		= its_unmask_msi_irq,
 	.irq_mask		= its_mask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
 
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e81e89a81cb5..a69ac299a533 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -169,7 +169,6 @@ static struct irq_chip mbi_msi_irq_chip = {
 	.name			= "MSI",
 	.irq_mask		= mbi_mask_msi_irq,
 	.irq_unmask		= mbi_unmask_msi_irq,
-	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_compose_msi_msg	= mbi_compose_msi_msg,
 	.irq_write_msi_msg	= pci_msi_domain_write_msg,
 };
-- 
2.25.1

