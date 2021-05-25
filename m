Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30A63907C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 19:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhEYRe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 13:34:58 -0400
Received: from foss.arm.com ([217.140.110.172]:33046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232787AbhEYRet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 13:34:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 300401692;
        Tue, 25 May 2021 10:33:19 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 279CA3F73B;
        Tue, 25 May 2021 10:33:18 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [RFC PATCH v2 03/10] genirq: Employ ack_irq() and eoi_irq() where relevant
Date:   Tue, 25 May 2021 18:32:48 +0100
Message-Id: <20210525173255.620606-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525173255.620606-1-valentin.schneider@arm.com>
References: <20210525173255.620606-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This can easily be coccinelle'd to replace all existing chip->irq_{ack,
eoi} callsites, however not all callsites benefit from this
replacement: fasteoi flow handlers for instance only deal with an
->irq_eoi() callback. Instead, only patch callsites that can benefit from
the added functionality.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/irq/chip.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 793dbd8307b9..4d3bde55c5d9 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -429,10 +429,12 @@ static inline void mask_ack_irq(struct irq_desc *desc)
 	if (desc->irq_data.chip->irq_mask_ack) {
 		desc->irq_data.chip->irq_mask_ack(&desc->irq_data);
 		irq_state_set_masked(desc);
+		if (desc->irq_data.chip->flags & IRQCHIP_AUTOMASKS_FLOW)
+			irq_state_set_flow_masked(desc);
 	} else {
 		mask_irq(desc);
 		if (desc->irq_data.chip->irq_ack)
-			desc->irq_data.chip->irq_ack(&desc->irq_data);
+			ack_irq(desc);
 	}
 }
 
@@ -463,7 +465,7 @@ void unmask_threaded_irq(struct irq_desc *desc)
 	struct irq_chip *chip = desc->irq_data.chip;
 
 	if (chip->flags & IRQCHIP_EOI_THREADED)
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 
 	unmask_irq(desc);
 }
@@ -680,7 +682,7 @@ EXPORT_SYMBOL_GPL(handle_level_irq);
 static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 {
 	if (!(desc->istate & IRQS_ONESHOT)) {
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 		return;
 	}
 	/*
@@ -691,10 +693,10 @@ static void cond_unmask_eoi_irq(struct irq_desc *desc, struct irq_chip *chip)
 	 */
 	if (!irqd_irq_disabled(&desc->irq_data) &&
 	    irqd_irq_masked(&desc->irq_data) && !desc->threads_oneshot) {
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 		unmask_irq(desc);
 	} else if (!(chip->flags & IRQCHIP_EOI_THREADED)) {
-		chip->irq_eoi(&desc->irq_data);
+		eoi_irq(desc);
 	}
 }
 
-- 
2.25.1

