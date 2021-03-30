Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE28A34E516
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhC3KGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:06:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38726 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229633AbhC3KGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:06:31 -0400
X-UUID: 9500d5b3866a4e98be3859ff00f6738f-20210330
X-UUID: 9500d5b3866a4e98be3859ff00f6738f-20210330
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1021986996; Tue, 30 Mar 2021 18:06:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 18:06:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 18:06:26 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <tglx@linutronix.de>,
        <maz@kernel.org>
CC:     <julien.thierry@arm.com>, <lecopzer@gmail.com>,
        <yj.chiang@mediatek.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Subject: [PATCH] irqchip/gic-v3: Fix IPRIORITYR can't perform byte operations in GIC-600
Date:   Tue, 30 Mar 2021 18:06:19 +0800
Message-ID: <20210330100619.24747-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When pseudo-NMI enabled, register_nmi() set priority of specific IRQ
by byte ops, and this doesn't work in GIC-600.

We have asked ARM Support [1]:
> Please refer to following description in
> "2.1.2 Distributor ACE-Lite slave interface" of GIC-600 TRM for
> the GIC600 ACE-lite slave interface supported sizes:
>   "The GIC-600 only accepts single beat accesses of the sizes for
>   each register that are shown in the Programmers model,
>   see Chapter 4 Programmer's model on page 4-102.
>   All other accesses are rejected and given either an
>   OKAY or SLVERR response that is based on the GICT_ERR0CTLR.UE bit.".

Thus the register needs to be written by double word operation and
the step will be: read 32bit, set byte and write it back.

[1] https://services.arm.com/support/s/case/5003t00001L4Pba

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 drivers/irqchip/irq-gic-v3.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index eb0ee356a629..cfc5a6ad30dc 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -440,10 +440,21 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 {
 	void __iomem *base = gic_dist_base(d);
 	u32 offset, index;
+	u32 val, prio_offset_mask, prio_offset_shift;
 
 	offset = convert_offset_index(d, GICD_IPRIORITYR, &index);
 
-	writeb_relaxed(prio, base + offset + index);
+	/*
+	 * GIC-600 memory mapping register doesn't support byte opteration,
+	 * thus read 32-bits from register, set bytes and wtire back to it.
+	 */
+	prio_offset_shift = (index & 0x3) * 8;
+	prio_offset_mask = GENMASK(prio_offset_shift + 7, prio_offset_shift);
+	index &= ~0x3;
+	val = readl_relaxed(base + offset + index);
+	val &= ~prio_offset_mask;
+	val |= prio << prio_offset_shift;
+	writel_relaxed(val, base + offset + index);
 }
 
 static u32 gic_get_ppi_index(struct irq_data *d)
-- 
2.18.0

