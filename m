Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D603309FA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCHJJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 04:09:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229471AbhCHJJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 04:09:53 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07720651B9;
        Mon,  8 Mar 2021 09:09:53 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1lJBtf-000IHt-0Y; Mon, 08 Mar 2021 09:09:51 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 08 Mar 2021 09:09:50 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     daniel@thingy.jp, jason@lakedaemon.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        tglx@linutronix.de, yj.chiang@mediatek.com
Subject: Re: [PATCH] irqchip/irq-mst: Support polarity configuration
In-Reply-To: <20210308030102.5161-1-mark-pk.tsai@mediatek.com>
References: <874khorux9.wl-maz@kernel.org>
 <20210308030102.5161-1-mark-pk.tsai@mediatek.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <01b1c85119619c2418908a2fdabfb5dc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: mark-pk.tsai@mediatek.com, daniel@thingy.jp, jason@lakedaemon.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com, tglx@linutronix.de, yj.chiang@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-08 03:01, Mark-PK Tsai wrote:
> From: Marc Zyngier <maz@kernel.org>
> 
>> >
>> > Support irq polarity configuration and save and restore the config
>> > when system suspend and resume.
>> >
>> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
>> > ---
>> >  drivers/irqchip/irq-mst-intc.c | 87 ++++++++++++++++++++++++++++++++--
>> >  1 file changed, 84 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
>> > index 143657b0cf28..979a4d55bcb1 100644
>> > --- a/drivers/irqchip/irq-mst-intc.c
>> > +++ b/drivers/irqchip/irq-mst-intc.c
>> > @@ -13,15 +13,25 @@
>> >  #include <linux/of_irq.h>
>> >  #include <linux/slab.h>
>> >  #include <linux/spinlock.h>
>> > +#include <linux/syscore_ops.h>
>> >
>> > -#define INTC_MASK	0x0
>> > -#define INTC_EOI	0x20
>> > +#define INTC_MASK		0x0
>> > +#define INTC_REV_POLARITY	0x10
>> > +#define INTC_EOI		0x20
>> > +
>> > +#ifdef CONFIG_PM_SLEEP
>> > +static LIST_HEAD(mst_intc_list);
>> > +#endif
>> >
>> >  struct mst_intc_chip_data {
>> >  	raw_spinlock_t	lock;
>> >  	unsigned int	irq_start, nr_irqs;
>> >  	void __iomem	*base;
>> >  	bool		no_eoi;
>> > +#ifdef CONFIG_PM_SLEEP
>> > +	struct list_head entry;
>> > +	u16 saved_polarity_conf[DIV_ROUND_UP(64, 16)];
>> 
>> Where is this 64 coming from?
> 
> The maximum number of interrupts a mst-intc supports is 64 in
> Mstar and Mediatek SoCs now.
> So I just use the maximum number of interrupts here.

Then please use a named constant instead of a magic number.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
