Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6DED330639
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 04:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbhCHDCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 22:02:00 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:47520 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232580AbhCHDBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 22:01:39 -0500
X-UUID: 9660dc14640741cc9b7fe0fdb9a97424-20210308
X-UUID: 9660dc14640741cc9b7fe0fdb9a97424-20210308
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1241873775; Mon, 08 Mar 2021 11:01:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 11:01:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 11:01:33 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <daniel@thingy.jp>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] irqchip/irq-mst: Support polarity configuration
Date:   Mon, 8 Mar 2021 11:01:01 +0800
Message-ID: <20210308030102.5161-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <874khorux9.wl-maz@kernel.org>
References: <874khorux9.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

> > 
> > Support irq polarity configuration and save and restore the config
> > when system suspend and resume.
> > 
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  drivers/irqchip/irq-mst-intc.c | 87 ++++++++++++++++++++++++++++++++--
> >  1 file changed, 84 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
> > index 143657b0cf28..979a4d55bcb1 100644
> > --- a/drivers/irqchip/irq-mst-intc.c
> > +++ b/drivers/irqchip/irq-mst-intc.c
> > @@ -13,15 +13,25 @@
> >  #include <linux/of_irq.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/syscore_ops.h>
> >  
> > -#define INTC_MASK	0x0
> > -#define INTC_EOI	0x20
> > +#define INTC_MASK		0x0
> > +#define INTC_REV_POLARITY	0x10
> > +#define INTC_EOI		0x20
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static LIST_HEAD(mst_intc_list);
> > +#endif
> >  
> >  struct mst_intc_chip_data {
> >  	raw_spinlock_t	lock;
> >  	unsigned int	irq_start, nr_irqs;
> >  	void __iomem	*base;
> >  	bool		no_eoi;
> > +#ifdef CONFIG_PM_SLEEP
> > +	struct list_head entry;
> > +	u16 saved_polarity_conf[DIV_ROUND_UP(64, 16)];
> 
> Where is this 64 coming from?

The maximum number of interrupts a mst-intc supports is 64 in
Mstar and Mediatek SoCs now.
So I just use the maximum number of interrupts here.

> 
> > +#endif
> >  };
> >  
> >  static void mst_set_irq(struct irq_data *d, u32 offset)
> > @@ -78,6 +88,16 @@ static void mst_intc_eoi_irq(struct irq_data *d)
> >  	irq_chip_eoi_parent(d);
> >  }
> >  
> > +static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
> > +{
> > +	if (type == IRQ_TYPE_LEVEL_LOW) {
> > +		mst_set_irq(data, INTC_REV_POLARITY);
> > +		type = IRQ_TYPE_LEVEL_HIGH;
> > +	}
> 
> If you are introducing a irq_set_type callback, you need to return an
> error for the settings you don't handle.

Got it, thanks for the comment.
I will add it in the next patch.
