Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0930D39FE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhFHRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:54:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33261 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233875AbhFHRye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:54:34 -0400
X-UUID: 486d4d675717480597efe5b0e4bf2965-20210609
X-UUID: 486d4d675717480597efe5b0e4bf2965-20210609
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1986328103; Wed, 09 Jun 2021 01:52:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Jun 2021 01:52:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Jun 2021 01:52:37 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <maz@kernel.org>, <tglx@linutronix.de>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] irqchip/irq-mst: Use ARCH_MSTARV7 as default value for MST_IRQ
Date:   Wed, 9 Jun 2021 01:52:37 +0800
Message-ID: <20210608175237.13596-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <90e2330d-4e7b-17ed-1c63-eafdf6db89fa@gmail.com>
References: <90e2330d-4e7b-17ed-1c63-eafdf6db89fa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 07/06/2021 05:59, Mark-PK Tsai wrote:
> > Only TV SoCs of Mediatek products have this controller
> > which inherit from MStar TV SoCs.
> > Don't enable it by default if ARCH_MEDIATEK is selected.
> > Instead, use ARCH_MSTARV7 as default value.
> > 
> > Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> > ---
> >  drivers/irqchip/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 62543a4eccc0..30f578e18a11 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -576,7 +576,7 @@ config LOONGSON_PCH_MSI
> >  config MST_IRQ
> >  	bool "MStar Interrupt Controller"
> >  	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
> 
> We should also delete ARCH_MEDIATEK dependency.

Actually what I want to do is decouple the MST_IRQ from
ARCH_MEDIATEK, because there are only TV SoCs have this.
But if I remove the ARCH_MEDIATEK dependency, then all the
Mediatek TV SoCs kernel have to select ARCH_MSTARV7 too.
It's kind of weird.

Though it may ask some Mediatek users about MST_IRQ,
I just change the default config to prevent that all
the Mediatek kernel include this driver by default.

What would you suggest for this?

> 
> Regards,
> Matthias
> 
> > -	default ARCH_MEDIATEK
> > +	default ARCH_MSTARV7
> >  	select IRQ_DOMAIN
> >  	select IRQ_DOMAIN_HIERARCHY
> >  	help
> > 
> 
