Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84606358B9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhDHRoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:44:25 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:41529 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHRoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:44:24 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id EFC15C0003;
        Thu,  8 Apr 2021 17:44:10 +0000 (UTC)
Date:   Thu, 8 Apr 2021 19:44:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        Ludovic Desroches - M43218 <Ludovic.Desroches@microchip.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eugen Hristev - M18282 <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH 22/24] ARM: at91: sama7: introduce sama7 SoC family
Message-ID: <YG9A6gRAZTbUVb8+@piout.net>
References: <20210331105908.23027-1-claudiu.beznea@microchip.com>
 <20210331105908.23027-23-claudiu.beznea@microchip.com>
 <YGSc1L8yW0KniOsx@piout.net>
 <a908274a-c4d2-faab-54a4-31fd0ffeab7e@microchip.com>
 <21bd4417-a754-8ee6-370e-4fb4e0f1fef9@microchip.com>
 <51dbcf0b-4ee6-10c9-9598-a451cca16905@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51dbcf0b-4ee6-10c9-9598-a451cca16905@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/2021 17:24:39+0200, Nicolas Ferre wrote:
> On 01/04/2021 at 12:24, Claudiu Beznea - M18063 wrote:
> > On 01.04.2021 12:38, Claudiu Beznea - M18063 wrote:
> > > On 31.03.2021 19:01, Alexandre Belloni wrote:
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > > > 
> > > > On 31/03/2021 13:59:06+0300, Claudiu Beznea wrote:
> > > > > From: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > 
> > > > > Introduce new family of SoCs, sama7, and first SoC, sama7g5.
> > > > > 
> > > > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > > > > Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> > > > > ---
> > > > >   arch/arm/mach-at91/Makefile |  1 +
> > > > >   arch/arm/mach-at91/sama7.c  | 48 +++++++++++++++++++++++++++++++++++++
> > > > >   2 files changed, 49 insertions(+)
> > > > >   create mode 100644 arch/arm/mach-at91/sama7.c
> > > > > 
> > > > > diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> > > > > index f565490f1b70..6cc6624cddac 100644
> > > > > --- a/arch/arm/mach-at91/Makefile
> > > > > +++ b/arch/arm/mach-at91/Makefile
> > > > > @@ -9,6 +9,7 @@ obj-$(CONFIG_SOC_AT91SAM9)    += at91sam9.o
> > > > >   obj-$(CONFIG_SOC_SAM9X60)    += sam9x60.o
> > > > >   obj-$(CONFIG_SOC_SAMA5)              += sama5.o
> > > > >   obj-$(CONFIG_SOC_SAMV7)              += samv7.o
> > > > > +obj-$(CONFIG_SOC_SAMA7)              += sama7.o
> > > > > 
> > > > >   # Power Management
> > > > >   obj-$(CONFIG_ATMEL_PM)               += pm.o pm_suspend.o
> > > > > diff --git a/arch/arm/mach-at91/sama7.c b/arch/arm/mach-at91/sama7.c
> > > > > new file mode 100644
> > > > > index 000000000000..e04cadb569ad
> > > > > --- /dev/null
> > > > > +++ b/arch/arm/mach-at91/sama7.c
> > > > > @@ -0,0 +1,48 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > > +/*
> > > > > + * Setup code for SAMA7
> > > > > + *
> > > > > + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/of_platform.h>
> > > > > +
> > > > > +#include <asm/mach/arch.h>
> > > > > +#include <asm/system_misc.h>
> > > > > +
> > > > > +#include "generic.h"
> > > > > +
> > > > > +static void __init sama7_common_init(void)
> > > > > +{
> > > > > +     of_platform_default_populate(NULL, NULL, NULL);
> > > > 
> > > > Is this necessary? This is left as a workaround for the old SoCs using
> > > > pinctrl-at91. I guess this will be using pio4 so this has to be removed.
> > > 
> > > OK, I'll have a look. BTW, SAMA5D2 which is also using PIO4 calls
> > > of_platform_default_populate(NULL, NULL, NULL);
> > 
> > Without this call the PM code (arch/arm/mach-at/pm.c) is not able to locate
> > proper DT nodes:
> > 
> > [    0.194615] at91_pm_backup_init: failed to find securam device!
> > [    0.201393] at91_pm_sram_init: failed to find sram device!
> > [    0.207449] AT91: PM not supported, due to no SRAM allocated
> 
> Okay, so we can't afford removing these calls to sama5d2 and upcoming
> sama7g5 right now.
> 
> Is it a common pattern to have to reach DT content in the early stages that
> explicit call to of_platform_default_populate() tries to solve?
> 

That's fine, I didn't remember about that one, we can keep the call.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
