Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8224B3378E2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhCKQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:11:57 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:45792 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234434AbhCKQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:11:53 -0500
X-UUID: 920a9f543abd4b8eb024653144d1dcd3-20210312
X-UUID: 920a9f543abd4b8eb024653144d1dcd3-20210312
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 195972198; Fri, 12 Mar 2021 00:11:45 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 12 Mar 2021 00:11:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 12 Mar 2021 00:11:43 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <daniel@0x0f.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <daniel@thingy.jp>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <maz@kernel.org>, <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
Date:   Fri, 12 Mar 2021 00:11:40 +0800
Message-ID: <20210311161140.32678-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAFr9PXmHhB=PT1kRoYYowf2dw2fqa1-LGCD5S52hW9jJtq5Q4w@mail.gmail.com>
References: <CAFr9PXmHhB=PT1kRoYYowf2dw2fqa1-LGCD5S52hW9jJtq5Q4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F57B12502744B967590C3F5378BE9D0A449D426B3AD3C6D8362E0B0796EBA2102000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Palmer <daniel@0x0f.com>

> On Thu, 11 Mar 2021 at 12:12, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> > For a fiq controller, the input edge signal will be convert to level and
> > keep the interrupt status until we do EOI operation.
> > That means if a rising edge input if trigger the ouput line will keep high
> > until we clear the interrupt status.
> 
> I think maybe the fiq is always edge triggered?
> It seems like it latches on an edge and holds it's output to the GIC
> high until it is reset by eoi and then only triggers again on another
> edge.
> I can experiment to confirm that's what it actually does for the chips I have.
> 
> Then it seems like the irq version is almost just a configurable
> inverter that passes either the input signal or the inverted input
> signal to the GIC.
> 
> So maybe fiq should only accept edge type interrupts and irq could
> accept either?

Why irq could accept either?
And if it's a fiq controller, we can just remove 'mstar,intc-no-eoi' from the
device node.
Whether the controller is fiq or irq, the interrupt request from mst-intc to
parent GIC is level sensitive. Because if the source is edge triggered, mst-intc
always latch it.

> 
> >  static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
> >  {
> > -       if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
> > -               return -EINVAL;
> > -
> > -       if (type == IRQ_TYPE_LEVEL_LOW) {
> > +       if (type == IRQ_TYPE_EDGE_FALLING) {
> > +               mst_set_irq(data, INTC_REV_POLARITY);
> > +               type = IRQ_TYPE_EDGE_RISING;

The interrupt triggered type of the parent GIC should be active high,
I will modify it.

> > +       } else if (type == IRQ_TYPE_LEVEL_LOW) {
> >                 mst_set_irq(data, INTC_REV_POLARITY);
> >                 type = IRQ_TYPE_LEVEL_HIGH;
> >         }
> 
> I think this still needs the logic to check that type is something we
> can handle (not IRQ_TYPE_EDGE_BOTH) and maybe if the fiq controller

Agree.

> can only do edge interrupts level types should return -EINVAL?

No matter what triggered type of an irq we write in dts is edge or level triggered,
the init and handling flow is the same except we need to do eoi if the
controller doesn't have the property 'mstar,intc-no-eoi'.
So maybe we don't need to do extra work to check the type for an fiq or irq controller?

And I will update the patch as following:

diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
index 841b9b1c2699..f46ade7b1775 100644
--- a/drivers/irqchip/irq-mst-intc.c
+++ b/drivers/irqchip/irq-mst-intc.c
@@ -90,13 +90,14 @@ static void mst_intc_eoi_irq(struct irq_data *d)
 
 static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
 {
-	if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
+	if (type != IRQ_TYPE_EDGE_RISING && type != IRQ_TYPE_EDGE_FALLING &&
+	    type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_LEVEL_LOW)
 		return -EINVAL;
 
-	if (type == IRQ_TYPE_LEVEL_LOW) {
+	if (type == IRQ_TYPE_LEVEL_LOW || type == IRQ_TYPE_EDGE_FALLING)
 		mst_set_irq(data, INTC_REV_POLARITY);
-		type = IRQ_TYPE_LEVEL_HIGH;
-	}
+
+	type = IRQ_TYPE_LEVEL_HIGH;
 
 	return irq_chip_set_type_parent(data, type);
 }
@@ -219,11 +220,12 @@ static int mst_intc_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	parent_fwspec.param[1] = cd->irq_start + hwirq;
 
 	/*
-	 * If the irq signal is active low, configure it to active high
-	 * to meet GIC SPI spec in mst_irq_chip_set_type via REV_POLARITY bit
+	 * mst-intc latch the interrupt request if it's edge triggered,
+	 * so the output signal to parent GIC is always level sensitive.
+	 * And if the irq signal is active low, configure it to active high
+	 * to meet GIC SPI spec in mst_irq_chip_set_type via REV_POLARITY bit.
 	 */
-	if (fwspec->param[2] == IRQ_TYPE_LEVEL_LOW)
-		parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+	parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
 
 	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &parent_fwspec);
 }
