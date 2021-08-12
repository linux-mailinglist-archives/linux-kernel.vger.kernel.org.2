Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5883EA31E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 12:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhHLKtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 06:49:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbhHLKrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 06:47:31 -0400
Date:   Thu, 12 Aug 2021 10:47:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628765225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UubHqxy6TJUbrt++LfEVb28dSBCm6q91ZpkMVqTYiFk=;
        b=y/JZuaJtAqhN31YggQ8hSHVPEZmBn/FCwcPuSXksbvcLcLRZt/p5vKCl2vGZF4yMrRTgJ5
        V4AQ12GMLz3zpbcLdShH41qbL5M8tPg8KL7/b+ro4CFKv+azJgFMv0UrrN9uUtXR6Zqyo0
        6imQVwaatZsbhM3Isdw1oj82T2/BguTyIEo/58QS1wjSqxERnFwGrcr/MZrYYixxqfB0Jp
        eCbebMd33t5UUoMOs+CNDO1v8w7wPoE6fovCVsASaqZZhscDZAkJhLRkkZEjrm/moj7Asw
        P1aDeQAvHhwRmdv0tSY1PrD7IiSOKmdC9v/GozvRN5g+96e4w/enk/qpaBy/aw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628765225;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UubHqxy6TJUbrt++LfEVb28dSBCm6q91ZpkMVqTYiFk=;
        b=+rsYCyJPh/SXOBVhxMhUP5drIoyz/+x+R5O8mbZLFYM+qm/DyFZUOj3rGNguZIw3bSb8q+
        +qes9RMNG0BoB1Aw==
From:   "irqchip-bot for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/loongson-pch-pic: Improve edge
 triggered interrupt support
Cc:     Chen Zhu <zhuchen@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20210805132216.3539007-1-chenhuacai@loongson.cn>
References: <20210805132216.3539007-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Message-ID: <162876522520.395.12694110235509755781.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e5dec38ac5d05d17a7110c8045aa101015281e4d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e5dec38ac5d05d17a7110c8045aa101015281e4d
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Thu, 05 Aug 2021 21:22:16 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 12 Aug 2021 07:57:23 +01:00

irqchip/loongson-pch-pic: Improve edge triggered interrupt support

Edge-triggered mode and level-triggered mode need different handlers,
and edge-triggered mode need a specific ack operation. So improve it.

Fixes: ef8c01eb64ca6719da449dab0 ("irqchip: Add Loongson PCH PIC controller")
Signed-off-by: Chen Zhu <zhuchen@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20210805132216.3539007-1-chenhuacai@loongson.cn
---
 drivers/irqchip/irq-loongson-pch-pic.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-loongson-pch-pic.c b/drivers/irqchip/irq-loongson-pch-pic.c
index f790ca6..a4eb8a2 100644
--- a/drivers/irqchip/irq-loongson-pch-pic.c
+++ b/drivers/irqchip/irq-loongson-pch-pic.c
@@ -92,18 +92,22 @@ static int pch_pic_set_type(struct irq_data *d, unsigned int type)
 	case IRQ_TYPE_EDGE_RISING:
 		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_EDGE_FALLING:
 		pch_pic_bitset(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 	case IRQ_TYPE_LEVEL_HIGH:
 		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitclr(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
 		pch_pic_bitclr(priv, PCH_PIC_EDGE, d->hwirq);
 		pch_pic_bitset(priv, PCH_PIC_POL, d->hwirq);
+		irq_set_handler_locked(d, handle_level_irq);
 		break;
 	default:
 		ret = -EINVAL;
@@ -113,11 +117,24 @@ static int pch_pic_set_type(struct irq_data *d, unsigned int type)
 	return ret;
 }
 
+static void pch_pic_ack_irq(struct irq_data *d)
+{
+	unsigned int reg;
+	struct pch_pic *priv = irq_data_get_irq_chip_data(d);
+
+	reg = readl(priv->base + PCH_PIC_EDGE + PIC_REG_IDX(d->hwirq) * 4);
+	if (reg & BIT(PIC_REG_BIT(d->hwirq))) {
+		writel(BIT(PIC_REG_BIT(d->hwirq)),
+			priv->base + PCH_PIC_CLR + PIC_REG_IDX(d->hwirq) * 4);
+	}
+	irq_chip_ack_parent(d);
+}
+
 static struct irq_chip pch_pic_irq_chip = {
 	.name			= "PCH PIC",
 	.irq_mask		= pch_pic_mask_irq,
 	.irq_unmask		= pch_pic_unmask_irq,
-	.irq_ack		= irq_chip_ack_parent,
+	.irq_ack		= pch_pic_ack_irq,
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_type		= pch_pic_set_type,
 };
