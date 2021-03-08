Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18453310EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhCHOe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:34:58 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41665 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231408AbhCHOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:34:38 -0500
X-UUID: 1f678c5153ea4dc4b6762b2c293aa136-20210308
X-UUID: 1f678c5153ea4dc4b6762b2c293aa136-20210308
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1103821765; Mon, 08 Mar 2021 22:34:25 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 8 Mar 2021 22:34:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 8 Mar 2021 22:34:24 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <maz@kernel.org>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>
CC:     <daniel@thingy.jp>, <jason@lakedaemon.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] irqchip/irq-mst: Support polarity configuration
Date:   Mon, 8 Mar 2021 22:31:10 +0800
Message-ID: <20210308143109.24644-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <01b1c85119619c2418908a2fdabfb5dc@kernel.org>
References: <01b1c85119619c2418908a2fdabfb5dc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

>On 2021-03-08 03:01, Mark-PK Tsai wrote:
>> From: Marc Zyngier <maz@kernel.org>
>> 
>>> >
>>> > Support irq polarity configuration and save and restore the config
>>> > when system suspend and resume.
>>> >
>>> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
>>> > ---
>>> >  drivers/irqchip/irq-mst-intc.c | 87 ++++++++++++++++++++++++++++++++--
>>> >  1 file changed, 84 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
>>> > index 143657b0cf28..979a4d55bcb1 100644
>>> > --- a/drivers/irqchip/irq-mst-intc.c
>>> > +++ b/drivers/irqchip/irq-mst-intc.c
>>> > @@ -13,15 +13,25 @@
>>> >  #include <linux/of_irq.h>
>>> >  #include <linux/slab.h>
>>> >  #include <linux/spinlock.h>
>>> > +#include <linux/syscore_ops.h>
>>> >
>>> > -#define INTC_MASK	0x0
>>> > -#define INTC_EOI	0x20
>>> > +#define INTC_MASK		0x0
>>> > +#define INTC_REV_POLARITY	0x10
>>> > +#define INTC_EOI		0x20
>>> > +
>>> > +#ifdef CONFIG_PM_SLEEP
>>> > +static LIST_HEAD(mst_intc_list);
>>> > +#endif
>>> >
>>> >  struct mst_intc_chip_data {
>>> >  	raw_spinlock_t	lock;
>>> >  	unsigned int	irq_start, nr_irqs;
>>> >  	void __iomem	*base;
>>> >  	bool		no_eoi;
>>> > +#ifdef CONFIG_PM_SLEEP
>>> > +	struct list_head entry;
>>> > +	u16 saved_polarity_conf[DIV_ROUND_UP(64, 16)];
>>> 
>>> Where is this 64 coming from?
>> 
>> The maximum number of interrupts a mst-intc supports is 64 in
>> Mstar and Mediatek SoCs now.
>> So I just use the maximum number of interrupts here.
>
>Then please use a named constant instead of a magic number.
>

Okay, I will update in patch v3.

