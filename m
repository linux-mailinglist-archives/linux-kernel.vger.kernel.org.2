Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DEF39A1A0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFCM5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhFCM5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:57:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B73601FA;
        Thu,  3 Jun 2021 12:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622724929;
        bh=hlQCQeLNM6wv4+bzH7qwvgaV08CGpC6v6Cmi/Lm7hM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZC2DyaiRxHa+G/2hbGWT1les204ug+pukd5PXtVAwnttb0Gpzwe0e2fvt15f2sm2H
         JkPO1exrqmJpWNDJvLn2+4rZZnIampHwSc5wEGLoAkx8KJ1IH5Qt/VZ8IauXVu31BP
         ssqNquMQYGI0ZFzlnGhP0x/OSJbraki1ZvtRFnT0UyGdJliuqkA3LofbwpMXsxAKUM
         ep72bbR12pCtwkzmAu4kgGkGY5CjitZu2XgxuWV98m8zopYyXdQhXh+pog4byXUcT4
         xiov/uwRKAQxtNXQchzNDZLD/mQ04GJ3y1vBVRayrP3L5iMd7BjY/7yi6su4C3JIYj
         MvQYsHsn7mhdw==
Received: by pali.im (Postfix)
        id 575941229; Thu,  3 Jun 2021 14:55:25 +0200 (CEST)
Date:   Thu, 3 Jun 2021 14:55:25 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: mvebu: Enable MBUS error propagation
Message-ID: <20210603125525.nkswvixbabkgq5or@pali>
References: <20191124093529.32399-1-chris.packham@alliedtelesis.co.nz>
 <8736cqb63d.fsf@FE-laptop>
 <0285a09b2b1b7ae2ccc268a37e4357c95d270ac9.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0285a09b2b1b7ae2ccc268a37e4357c95d270ac9.camel@alliedtelesis.co.nz>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 January 2020 19:42:12 Chris Packham wrote:
> Hi Gregory,
> 
> On Wed, 2020-01-08 at 11:22 +0100, Gregory CLEMENT wrote:
> > Hello Chris,
> > 
> > > U-boot disables MBUS error propagation for Armada-385. The effect of
> > > this on the kernel is that any access to a mapped but inaccessible
> > > address causes the system to hang.
> > > 
> > > By enabling MBUS error propagation the kernel can raise a Bus Error and
> > > panic to restart the system.
> > 
> > Unless I miss it, it seems that nobody comment this patch: sorry for the
> > delay.
> > 
> 
> Thanks for the response.
> 
> > > 
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> > > 
> > > Notes:
> > >     We've encountered an issue where rogue accesses to PCI-e space cause an
> > >     Armada-385 system to lockup. We've found that enabling MBUS error
> > >     propagation lets us get a bus error which at least gives us a panic to
> > >     help identify what was accessed.
> > >     
> > >     U-boot clears the IO Err Prop Enable Bit[1] but so far no-one seems to
> > >     know why.
> > >     
> > >     I wasn't sure where to put this code. There is similar code for kirwood
> > >     in the equivalent dt_init function. On Armada-XP the register is part of
> > >     the Core Coherency Fabric block (for A385 it's documented as part of the
> > >     CCF block).
> > 
> > What about adding a new set of register to the mvebu mbus driver?
> > 
> 
> After more testing we found that some previously "good" boards started
> throwing up panics with this change. I think that this might require
> handling some of the PCI-e interrupts (for correctable errors) via the
> EDAC subsystem.
> 
> We're still working with Marvell to track down exactly why this is
> happening on our system.

Hello Chris! Have you somehow solved this issue? Or do you have some
contacts in Marvell for A385 PCIe subsystem?

> > In this case it will be called even earlier allowing to see bus error
> > earlier.
> > 
> > In any case, you should separate the device tree change from the code
> > change and at least provide 2 patches.
> 
> Agreed. If/when something solid eventuates we'll do it as a proper
> series.
> 
> > 
> > Gregory
> > 
> > >     
> > >     --
> > >     [1] - https://gitlab.denx.de/u-boot/u-boot/blob/master/arch/arm/mach-mvebu/cpu.c#L489
> > > 
> > >  arch/arm/boot/dts/armada-38x.dtsi |  5 +++++
> > >  arch/arm/mach-mvebu/board-v7.c    | 27 +++++++++++++++++++++++++++
> > >  2 files changed, 32 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> > > index 3f4bb44d85f0..3214c67433eb 100644
> > > --- a/arch/arm/boot/dts/armada-38x.dtsi
> > > +++ b/arch/arm/boot/dts/armada-38x.dtsi
> > > @@ -386,6 +386,11 @@
> > >  				      <0x20250 0x8>;
> > >  			};
> > >  
> > > +			ioerrc: io-err-control@20200 {
> > > +				compatible = "marvell,io-err-control";
> > > +				reg = <0x20200 0x4>;
> > > +			};
> > > +
> > >  			mpic: interrupt-controller@20a00 {
> > >  				compatible = "marvell,mpic";
> > >  				reg = <0x20a00 0x2d0>, <0x21070 0x58>;
> > > diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
> > > index d2df5ef9382b..fb7718386ef9 100644
> > > --- a/arch/arm/mach-mvebu/board-v7.c
> > > +++ b/arch/arm/mach-mvebu/board-v7.c
> > > @@ -138,10 +138,36 @@ static void __init i2c_quirk(void)
> > >  	}
> > >  }
> > >  
> > > +#define MBUS_ERR_PROP_EN BIT(8)
> > > +
> > > +/*
> > > + * U-boot disables MBUS error propagation. Re-enable it so we
> > > + * can handle them as Bus Errors.
> > > + */
> > > +static void __init enable_mbus_error_propagation(void)
> > > +{
> > > +	struct device_node *np =
> > > +		of_find_compatible_node(NULL, NULL, "marvell,io-err-control");
> > > +
> > > +	if (np) {
> > > +		void __iomem *reg;
> > > +
> > > +		reg = of_iomap(np, 0);
> > > +		if (reg) {
> > > +			u32 val;
> > > +
> > > +			val = readl_relaxed(reg);
> > > +			writel_relaxed(val | MBUS_ERR_PROP_EN, reg);
> > > +		}
> > > +		of_node_put(np);
> > > +	}
> > > +}
> > > +
> > >  static void __init mvebu_dt_init(void)
> > >  {
> > >  	if (of_machine_is_compatible("marvell,armadaxp"))
> > >  		i2c_quirk();
> > > +	enable_mbus_error_propagation();
> > >  }
> > >  
> > >  static void __init armada_370_xp_dt_fixup(void)
> > > @@ -191,6 +217,7 @@ DT_MACHINE_START(ARMADA_38X_DT, "Marvell Armada 380/385 (Device Tree)")
> > >  	.l2c_aux_val	= 0,
> > >  	.l2c_aux_mask	= ~0,
> > >  	.init_irq       = mvebu_init_irq,
> > > +	.init_machine	= mvebu_dt_init,
> > >  	.restart	= mvebu_restart,
> > >  	.dt_compat	= armada_38x_dt_compat,
> > >  MACHINE_END
> > > -- 
> > > 2.24.0
> > > 
> > 
> > 
