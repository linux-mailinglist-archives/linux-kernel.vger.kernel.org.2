Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC693588C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbhDHPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:44:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232116AbhDHPoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78DFF11B3;
        Thu,  8 Apr 2021 08:44:09 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 770373F694;
        Thu,  8 Apr 2021 08:44:08 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH 08/10] irqchip/gic-v3-its: Use irq_chip_ack_parent()
Date:   Thu,  8 Apr 2021 16:43:24 +0100
Message-Id: <20210408154326.3988781-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408154326.3988781-1-valentin.schneider@arm.com>
References: <20210408154326.3988781-1-valentin.schneider@arm.com>
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
index c3485b230d70..d6856750c084 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1971,6 +1971,7 @@ static struct irq_chip its_irq_chip = {
 	.name			= "ITS",
 	.irq_mask		= its_mask_irq,
 	.irq_unmask		= its_unmask_irq,
+	.irq_ack		= irq_chip_ack_parent,
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_set_affinity	= its_set_affinity,
 	.irq_compose_msi_msg	= its_irq_compose_msi_msg,
-- 
2.25.1

