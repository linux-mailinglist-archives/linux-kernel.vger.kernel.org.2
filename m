Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02440FA37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhIQOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 10:34:31 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39225 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241700AbhIQOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 10:34:30 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id F001F1C0002;
        Fri, 17 Sep 2021 14:33:05 +0000 (UTC)
Date:   Fri, 17 Sep 2021 16:33:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     kavyasree.kotagiri@microchip.com, ludovic.desroches@microchip.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Manohar.Puri@microchip.com,
        Madhuri.Sripada@microchip.com
Subject: Re: [PATCH v2] ARM: at91: add basic support for new SoC lan966x
Message-ID: <YUSnIfzWpQ+YGWkB@piout.net>
References: <20210831102138.2476-1-kavyasree.kotagiri@microchip.com>
 <8610dd7a-a6eb-0c65-f66e-b4f9fdbce854@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8610dd7a-a6eb-0c65-f66e-b4f9fdbce854@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I wanted to reply earlier but I still have a few comments...

On 17/09/2021 15:41:01+0200, Nicolas Ferre wrote:
> On 31/08/2021 at 12:21, kavyasree.kotagiri@microchip.com wrote:
> > From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>
> > 
> > This patch introduces Microchip LAN966X ARMv7 based SoC family
> > of multiport gigabit AVB/TSN-capable ethernet switches.
> > It supports two SKUs: 4-port LAN9662 with multiprotocol
> > processing support and 8-port LAN9668 switch.
> > 
> > LAN966X includes copper and serial ethernet interfaces,
> > peripheral interfaces such as PCIe, USB, TWI, SPI, UART, QSPI,
> > SD/eMMC, Parallel Interface (PI) as well as synchronization
> > and trigger inputs/outputs.
> > 
> > Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
> 
> Your name fixed with your permission and as Rob suggested in a previous
> series.
> 
> > ---
> > v1 -> v2:
> > - Removed lan966x_dt_device_init().
> >    System boots fine without this function.
> > 
> >   arch/arm/mach-at91/Kconfig   | 13 +++++++++++++
> >   arch/arm/mach-at91/Makefile  |  1 +
> 
> Kconfig and Makefile files updated to avoid merge conflict with SAMA7G5 that
> was integrated in 5.15-rc1.
> 
> >   arch/arm/mach-at91/lan966x.c | 25 +++++++++++++++++++++++++
> 
> 
> >   3 files changed, 39 insertions(+)
> >   create mode 100644 arch/arm/mach-at91/lan966x.c
> > 
> > diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> > index ccd7e80ce943..06cb425af761 100644
> > --- a/arch/arm/mach-at91/Kconfig
> > +++ b/arch/arm/mach-at91/Kconfig
> > @@ -122,6 +122,14 @@ config SOC_SAM9X60
> >   	help
> >   	  Select this if you are using Microchip's SAM9X60 SoC
> > +config SOC_LAN966X
> > +	bool "ARMv7 based Microchip LAN966X SoC family"
> > +	depends on ARCH_MULTI_V7
> > +	select SOC_LAN966
> > +	select DW_APB_TIMER_OF
> > +	help
> > +	  This enables support for ARMv7 based Microchip LAN966X SoC family.
> > +

I don't think SOC_LAN966X is a good name or said differently as it is
not part specific, I don't get why this isn't merged with SOC_LAN966. I
would have one or the other.

> >   comment "Clocksource driver selection"
> >   config ATMEL_CLOCKSOURCE_PIT
> > @@ -188,6 +196,11 @@ config SOC_SAMA5
> >   	select SOC_SAM_V7
> >   	select SRAM if PM
> > +config SOC_LAN966
> > +	bool
> > +	select ARM_GIC
> > +	select MEMORY
> > +
> >   config ATMEL_PM
> >   	bool
> > diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
> > index f565490f1b70..93cfd5b4e6d4 100644
> > --- a/arch/arm/mach-at91/Makefile
> > +++ b/arch/arm/mach-at91/Makefile
> > @@ -6,6 +6,7 @@
> >   # CPU-specific support
> >   obj-$(CONFIG_SOC_AT91RM9200)	+= at91rm9200.o
> >   obj-$(CONFIG_SOC_AT91SAM9)	+= at91sam9.o
> > +obj-$(CONFIG_SOC_LAN966X)	+= lan966x.o
> >   obj-$(CONFIG_SOC_SAM9X60)	+= sam9x60.o
> >   obj-$(CONFIG_SOC_SAMA5)		+= sama5.o
> >   obj-$(CONFIG_SOC_SAMV7)		+= samv7.o
> > diff --git a/arch/arm/mach-at91/lan966x.c b/arch/arm/mach-at91/lan966x.c
> > new file mode 100644
> > index 000000000000..154d616569ae
> > --- /dev/null
> > +++ b/arch/arm/mach-at91/lan966x.c
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Setup code for LAN966X
> > + *
> > + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> > + *
> > + */
> > +
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +
> > +#include <asm/mach/arch.h>
> > +#include <asm/system_misc.h>
> > +

I'm not sure all those include are actually used.

> > +#include "generic.h"
> > +
> > +static const char *const lan966x_dt_board_compat[] __initconst = {
> > +	"microchip,lan966x",
> 
> This compatibility string will need to be documented in
> Documentation/arm/microchip.rst
> and
> Documentation/devicetree/bindings/arm/atmel-at91.yaml (or a similar file, as
> you wish).
> 
> You'll add it to your DT patches.
> 

Yes and you'll have to document lan9662 and lan9668. Really, wildcards
in the compatible strings are usually not a good idea.

> > +	NULL
> > +};
> > +
> > +DT_MACHINE_START(lan966x_dt, "Microchip LAN966X")
> > +	/* Maintainer: Microchip */
> > +	.dt_compat	= lan966x_dt_board_compat,
> > +MACHINE_END
> > 
> 
> All the rest looks good to me: no need to resend. It's queued in at91-soc
> branch targeting 5.16.
> You'll see it appearing in linux-next in the next few days.
> 

Well, I'm still wondering one thing, is arch/arm/mach-at91/lan966x.c
necessary at all to boot the platform?

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
