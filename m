Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9E3B7271
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhF2Mxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:53:53 -0400
Received: from foss.arm.com ([217.140.110.172]:50436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233838AbhF2MxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:53:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4383D1477;
        Tue, 29 Jun 2021 05:50:56 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4344F3F718;
        Tue, 29 Jun 2021 05:50:55 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 08/13] genirq/msi: Provide default .irq_eoi() for MSI chips
Date:   Tue, 29 Jun 2021 13:50:05 +0100
Message-Id: <20210629125010.458872-9-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629125010.458872-1-valentin.schneider@arm.com>
References: <20210629125010.458872-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only platform-MSI irqchips get a default .irq_eoi() when
MSI_FLAG_USE_DEF_CHIP_OPS is set. There's no reason PCI-MSI irqchips
couldn't benefit from this too, so let all MSI irqchips benefit from this
default.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/base/platform-msi.c | 2 --
 kernel/irq/msi.c            | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 0b72b134a304..659881da0593 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -101,8 +101,6 @@ static void platform_msi_update_chip_ops(struct msi_domain_info *info)
 		chip->irq_mask = irq_chip_mask_parent;
 	if (!chip->irq_unmask)
 		chip->irq_unmask = irq_chip_unmask_parent;
-	if (!chip->irq_eoi)
-		chip->irq_eoi = irq_chip_eoi_parent;
 	if (!chip->irq_set_affinity)
 		chip->irq_set_affinity = msi_domain_set_affinity;
 	if (!chip->irq_write_msi_msg)
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c41965e348b5..c97590945e99 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -274,6 +274,8 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
 	if (!chip->irq_set_affinity)
 		chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_eoi)
+		chip->irq_eoi = irq_chip_eoi_parent;
 }
 
 /**
-- 
2.25.1

