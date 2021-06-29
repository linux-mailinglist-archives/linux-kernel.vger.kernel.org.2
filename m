Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942EB3B7274
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbhF2MyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:50452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233847AbhF2Mx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:53:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7C28147A;
        Tue, 29 Jun 2021 05:50:58 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ABED53F718;
        Tue, 29 Jun 2021 05:50:57 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH v3 10/13] genirq/msi: Provide default .irq_ack() for MSI chips
Date:   Tue, 29 Jun 2021 13:50:07 +0100
Message-Id: <20210629125010.458872-11-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629125010.458872-1-valentin.schneider@arm.com>
References: <20210629125010.458872-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSI_FLAG_USE_DEF_CHIP_OPS can now provide a default .irq_eoi() to any
irqchip attached to an MSI domain. Complement it by adding a default
.irq_ack() implementation.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/irq/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index c97590945e99..127e0dd72b60 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -274,6 +274,8 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
 	if (!chip->irq_set_affinity)
 		chip->irq_set_affinity = msi_domain_set_affinity;
+	if (!chip->irq_ack)
+		chip->irq_ack = irq_chip_ack_parent;
 	if (!chip->irq_eoi)
 		chip->irq_eoi = irq_chip_eoi_parent;
 }
-- 
2.25.1

