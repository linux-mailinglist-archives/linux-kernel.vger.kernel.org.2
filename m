Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D133DAA1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhG2R2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:28:24 -0400
Received: from foss.arm.com ([217.140.110.172]:53640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232238AbhG2R2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:28:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87AED1FB;
        Thu, 29 Jul 2021 10:28:19 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBEF03F73D;
        Thu, 29 Jul 2021 10:28:18 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH 1/2] irqchip/gic-v3: Add __gic_get_ppi_index() to find the PPI number from hwirq
Date:   Thu, 29 Jul 2021 17:27:47 +0000
Message-Id: <20210729172748.28841-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210729172748.28841-1-james.morse@arm.com>
References: <20210729172748.28841-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gic_get_ppi_index() is a useful concept for ppi partitions, as the GIC
has two PPI ranges but needs mapping to a single range when used as an
index in the gic_data.ppi_descs[] array.

Add a double-underscore version which takes just the intid. This will
be used in the partition domain select and translate helpers to enable
partition support for the EPPI range.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e0f4debe64e1..b24f0a9d2876 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -446,18 +446,23 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 	writeb_relaxed(prio, base + offset + index);
 }
 
-static u32 gic_get_ppi_index(struct irq_data *d)
+static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
 {
-	switch (get_intid_range(d)) {
+	switch (__get_intid_range(hwirq)) {
 	case PPI_RANGE:
-		return d->hwirq - 16;
+		return hwirq - 16;
 	case EPPI_RANGE:
-		return d->hwirq - EPPI_BASE_INTID + 16;
+		return hwirq - EPPI_BASE_INTID + 16;
 	default:
 		unreachable();
 	}
 }
 
+static u32 gic_get_ppi_index(struct irq_data *d)
+{
+	return __gic_get_ppi_index(d->hwirq);
+}
+
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc = irq_to_desc(d->irq);
-- 
2.30.2

