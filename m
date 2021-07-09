Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71D3C2388
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 14:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhGIMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhGIMld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 08:41:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02AC0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 05:38:49 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1m1pm7-0004J4-2v; Fri, 09 Jul 2021 14:38:35 +0200
Message-ID: <891447bb1780e365a9b4c730c27f1f34995a3176.camel@pengutronix.de>
Subject: Re: [PATCH V8 3/4] soc: imx: Add generic blk-ctl driver
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "marex@denx.de" <marex@denx.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>
Date:   Fri, 09 Jul 2021 14:38:32 +0200
In-Reply-To: <DB6PR0402MB2760797C59DCDE0F284D6AB388189@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20210629072941.7980-1-peng.fan@oss.nxp.com>
         <20210629072941.7980-4-peng.fan@oss.nxp.com>
         <0fc1f5043eeedb0c40ae9f76e245c648e0c88cde.camel@pengutronix.de>
         <DB6PR0402MB2760EACC7F2457309F1D886C881A9@DB6PR0402MB2760.eurprd04.prod.outlook.com>
         <b1a0853e8491d817074042205db1951cb53da538.camel@pengutronix.de>
         <DB6PR0402MB2760797C59DCDE0F284D6AB388189@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 09.07.2021 um 10:08 +0000 schrieb Peng Fan:
> > Subject: Re: [PATCH V8 3/4] soc: imx: Add generic blk-ctl driver
> > 
> > Hi Peng,
> > 
> > Am Mittwoch, dem 07.07.2021 um 09:56 +0000 schrieb Peng Fan:
> > > Hi Lucas,
> > > 
> > > > Subject: Re: [PATCH V8 3/4] soc: imx: Add generic blk-ctl
> > > > driver
> > > 
> > > After rethinking about this driver, I think we still need expose
> > > to
> > > pgc to touch the blk-ctl hardware bus handshake.
> > > 
> > > Currently we are assuming the blk-ctl probe will finish the
> > > handshake.
> > > But there is another case, saying gpu.
> > > 
> > > -----------------------------------------------------------------
> > > ------>
> > > GPU on(1)
> > >           VPUMIX on (2)
> > >                         GPU off(3)
> > > 
> > > Between GPU on/off, VPUMIX-BLK-CTL not done, so vpumix pgc
> > > handshake
> > > not done. Then GPU off (3) will trigger failed to command pgc,
> > > because
> > > the last pgc(vpu power on) not finished.
> > > 
> > > I think this could be not avoided if we split the handshake into
> > > blk-ctl driver. How do you think?
> > > 
> > This is really unfortunate. So the PGC state machine really waits
> > for the ADB
> > handshake? 
> 
> Not very sure, just a guess here. Because of ....., I am not able to
> find
> HW people to give explaination for the messy hardware design.
> 
It's somewhat disillusioning to hear that not even you are able to find
people able to give a proper explanation on how those things fit
together. :/

> About your idea to not create a platform device as what gpcv2 driver
> did,
> I rethink about that.
> if we split the handshake in blk-ctl driver, we need saying
> vpumix-blk-ctl depends on pgc_vpumix
> pgc_vpu_g1/g2/h1 depends on vpumix-blk-ctl bus domain.
> It is hard to do defer probe if we just use simple parent/child pd
> tree.
> 
> If we move the handshake back to gpcv2 driver, the blk-ctl driver
> could be simplier I think, but have to add reference to blk-ctl node
> in pgc node.

I'll spend some time and see if I can come up with a proper abstraction
here. This will probably take a little while, as I don't have a good
plan yet, so it will involve some typing of prototype driver code to
see how things work out.

> 
> And rethink about the gpcv2 driver, should we add a mutex lock
> in power on/off? I know that genpd has lock, but the lock is per
> genpd.
> 
> Considering GPU powering on, VPU may be powering off, the power
> sequence maybe interrupted by the other. I thought this
> may cause failed to command PGC, so better add a mutex lock
> in pgc power on/off?
> 
I don't think sequences for different domains are interacting with each
other, at least that's my understanding of the PGC hardware. The
example code 5 in the i.MX8MM reference manual at least hints at it
being totally legal to request multiple domains to power-up at the same
time and also there are no waits for sequence completion between
request to power-down different domains.

> 
> Until now my understanding was that this isn't hooked up in the
> > state machine, but sequenced by software through writing and
> > waiting for the
> > bits in GPC_PU_PWRHSK.
> > 
> > > BTW: #linux-imx IRC moved to Libre.Chat
> > > 
> > > > 
> > > > Hi Peng,
> > > > 
> > > > Am Dienstag, dem 29.06.2021 um 15:29 +0800 schrieb Peng Fan
> > > > (OSS):
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > 
> > > > > The i.MX8MM introduces an IP named BLK_CTL and usually is
> > > > > comprised of some GPRs.
> > > > > 
> > > > > The GPRs has some clock bits and reset bits, but here we take
> > > > > it
> > > > > as virtual PDs, because of the clock and power domain A/B
> > > > > lock
> > > > > issue when taking it as a clock controller.
> > > > > 
> > > > > For some bits, it might be good to also make it as a reset
> > > > > controller, but to i.MX8MM, we not add that support for now.
> > > > > 
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >  drivers/soc/imx/Makefile  |   2 +-
> > > > >  drivers/soc/imx/blk-ctl.c | 324
> > > > > ++++++++++++++++++++++++++++++++++++++
> > > > >  drivers/soc/imx/blk-ctl.h |  85 ++++++++++
> > > > >  3 files changed, 410 insertions(+), 1 deletion(-)  create
> > > > > mode
> > > > > 100644 drivers/soc/imx/blk-ctl.c  create mode 100644
> > > > > drivers/soc/imx/blk-ctl.h
> > > > > 
> > > > > diff --git a/drivers/soc/imx/Makefile
> > > > > b/drivers/soc/imx/Makefile
> > > > > index 078dc918f4f3..d3d2b49a386c 100644
> > > > > --- a/drivers/soc/imx/Makefile
> > > > > +++ b/drivers/soc/imx/Makefile
> > > > > @@ -4,4 +4,4 @@ obj-$(CONFIG_ARCH_MXC) += soc-imx.o  endif
> > > > >  obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
> > > > >  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) += gpcv2.o
> > > > > -obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o
> > > > > +obj-$(CONFIG_SOC_IMX8M) += soc-imx8m.o blk-ctl.o
> > > > > diff --git a/drivers/soc/imx/blk-ctl.c b/drivers/soc/imx/blk-
> > > > > ctl.c
> > > > > new file mode 100644 index 000000000000..cec1884202e0
> > > > > --- /dev/null
> > > > > +++ b/drivers/soc/imx/blk-ctl.c
> > > > > @@ -0,0 +1,324 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright 2021 NXP.
> > > > > + */
> > > > > +
> > > > > +#include <linux/clk.h>
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/io.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/mutex.h>
> > > > > +#include <linux/of.h>
> > > > > +#include <linux/of_address.h>
> > > > > +#include <linux/of_device.h>
> > > > > +#include <linux/platform_device.h> #include
> > > > > <linux/pm_runtime.h>
> > > > > +#include <linux/pm_domain.h> #include <linux/regmap.h>
> > > > > #include
> > > > > +<linux/slab.h>
> > > > > +
> > > > > +#include "blk-ctl.h"
> > > > > +
> > > > > +static inline struct imx_blk_ctl_domain
> > > > > *to_imx_blk_ctl_pd(struct
> > > > > +generic_pm_domain *genpd) {
> > > > > +	return container_of(genpd, struct
> > > > > imx_blk_ctl_domain, genpd); }
> > > > > +
> > > > > +static int imx_blk_ctl_enable_hsk(struct device *dev) {
> > > > > +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> > > > > +	const struct imx_blk_ctl_hw *hw = blk_ctl->dev_data-
> > > > > >hw_hsk;
> > > > > +	struct regmap *regmap = blk_ctl->regmap;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> > > > > +		ret = regmap_update_bits(regmap, hw-
> > > > > >rst_offset,
> > hw->rst_mask,
> > > > hw->rst_mask);
> > > > > +		if (ret)
> > > > > +			return ret;
> > > > > +	}
> > > > > +
> > > > > +	ret = regmap_update_bits(regmap, hw->offset, hw-
> > > > > >mask,
> > > > > +hw->mask);
> > > > > +
> > > > > +	/* Wait for handshake */
> > > > > +	udelay(5);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static int imx_blk_ctl_power_on(struct generic_pm_domain
> > > > > *domain) {
> > > > > +	struct imx_blk_ctl_domain *pd =
> > > > > to_imx_blk_ctl_pd(domain);
> > > > > +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> > > > > +	struct regmap *regmap = blk_ctl->regmap;
> > > > > +	const struct imx_blk_ctl_hw *hw =
> > &blk_ctl->dev_data->pds[pd->id];
> > > > > +	int ret;
> > > > > +
> > > > > +	mutex_lock(&blk_ctl->lock);
> > > > > +
> > > > > +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks,
> > > > > blk_ctl->clks);
> > > > 
> > > > I'm still not a fan of enabling all the clocks going into the
> > > > blk-ctl to power up/down one specific domain. It's not really a
> > > > problem with clocks, where the parents are always on, as the
> > > > clock
> > > > gate/ungate is pretty cheap, but as soon as you get to
> > > > something
> > > > like the display pixel clock, where the parent PLL may be shut
> > > > down,
> > > > the clock enable may easily be the most costly operation of
> > > > this
> > > > whole function, even if this specific clock isn't even needed
> > > > for the domain
> > in question.
> > > 
> > > We had an agreement to use bulk clks in the beginning :) But I
> > > could
> > > look into use dedicated clk, but that requires new logic to map
> > > each
> > > pd with needed clks.
> > > 
> > Yea, I didn't totally reject using bulk clks, but looking at the
> > number of
> > different clocks going into e.g. the i.MX8MP MEDIAMIX blk-ctl, I
> > fear that
> > using bulk clocks is actually making the power up/down for the blk-
> > ctl
> > domains much more costly than it needs to be. I think we should
> > really think
> > about this now, as using bulk clks vs. individual clocks for each
> > domain will
> > most likely have an impact on the DT binding, so will be very hard
> > to change
> > once the driver is accepted upstream.
> 
> ok, I see.
> 
> > 
> > 
> > > > 
> > > > > +	if (ret) {
> > > > > +		mutex_unlock(&blk_ctl->lock);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	if (hw->flags & IMX_BLK_CTL_PD_HANDSHAKE) {
> > > > > +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> > > > > +		if (ret)
> > > > > +			dev_err(blk_ctl->dev, "Handshake
> > > > > failed when power
> > on\n");
> > > > > +
> > > > > +		/* Expected, handshake already handle
> > > > > reset*/
> > > > > +		goto disable_clk;
> > > > > +	}
> > > > > +
> > > > > +	if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> > > > > +		ret = regmap_clear_bits(regmap, hw-
> > > > > >rst_offset,
> > hw->rst_mask);
> > > > > +		if (ret)
> > > > > +			goto disable_clk;
> > > > > +
> > > > > +		/* Wait for reset propagate */
> > > > > +		udelay(5);
> > > > > +
> > > > > +		ret = regmap_update_bits(regmap, hw-
> > > > > >rst_offset,
> > hw->rst_mask,
> > > > hw->rst_mask);
> > > > > +		if (ret)
> > > > > +			goto disable_clk;
> > > > > +	}
> > > > > +
> > > > > +	ret = regmap_update_bits(regmap, hw->offset, hw-
> > > > > >mask,
> > > > > +hw->mask);
> > > > > 
> > > > 
> > > > I find this very hard to follow and reason about. Why do we
> > > > even
> > > > need those different paths for domains with or without the
> > > > handshake?
> > > > 
> > > > Shouldn't it be enough to just be enough to do the following in
> > > > all
> > > > cases:
> > > > 1. release sft reset
> > > > 2. enable sft clock
> > > > 3. wait a little for reset to propagate or ADB to ack power up
> > > 
> > > Reset flow is: assert reset, deassert reset, enable clk Handshake
> > > flow: deassert reset, enable clk.
> > > 
> > > Per my previous test, use reset flow for handshake seems not
> > > work. I
> > > could recall clearly.
> > > 
> > That's surprising to me, given that the blk-ctl resets should be
> > asserted when
> > we power up the GPC mix domains. I don't dispute your testing, but
> > I would
> > be very interested to learn what's going on in hardware that
> > asserting a
> > already asserted reset would break the power- up flow.
> 
> I could give a re-try, considering the code has changed a lot from
> the beginning.
> 
> You could also give a look at Marex's reset early patch, it maybe
> caused by
> the blk-ctl patch or not, but he confirms after add reset early,
> gpu/vpu
> not met failed to command PGC anymore.

I'll take a look at this. I'm still a bit puzzled as to why some of the
domains require a late, as in after the power-up request, reset.
Normally I would expect the reset to be level triggered, so it
shouldn't make a difference if the reset is asserted before or after
the power-up request.

> > 
> > > > 
> > > > > +disable_clk:
> > > > > +	clk_bulk_disable_unprepare(blk_ctl->num_clks,
> > > > > blk_ctl->clks);
> > > > > +
> > > > > +	mutex_unlock(&blk_ctl->lock);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static int imx_blk_ctl_power_off(struct generic_pm_domain
> > > > > *domain) {
> > > > > +	struct imx_blk_ctl_domain *pd =
> > > > > to_imx_blk_ctl_pd(domain);
> > > > > +	struct imx_blk_ctl *blk_ctl = pd->blk_ctl;
> > > > > +	struct regmap *regmap = blk_ctl->regmap;
> > > > > +	const struct imx_blk_ctl_hw *hw =
> > &blk_ctl->dev_data->pds[pd->id];
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	mutex_lock(&blk_ctl->lock);
> > > > > +
> > > > > +	ret = clk_bulk_prepare_enable(blk_ctl->num_clks,
> > > > > blk_ctl->clks);
> > > > > +	if (ret) {
> > > > > +		mutex_unlock(&blk_ctl->lock);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	if (!(hw->flags & IMX_BLK_CTL_PD_HANDSHAKE)) {
> > > > > +		ret = regmap_clear_bits(regmap, hw->offset,
> > > > > hw->mask);
> > > > > +		if (ret)
> > > > > +			goto disable_clk;
> > > > > +
> > > > > +		if (hw->flags & IMX_BLK_CTL_PD_RESET) {
> > > > > +			ret = regmap_clear_bits(regmap, hw-
> > > > > >rst_offset,
> > > > hw->rst_mask);
> > > > > +			if (ret)
> > > > > +				goto disable_clk;
> > > > > +		}
> > > > > +	} else {
> > > > > +		ret = imx_blk_ctl_enable_hsk(blk_ctl->dev);
> > > > 
> > > > Why would we need to enable the handshake again in the power
> > > > DOWN
> > > > path?
> > > > The clock/reset bits should still be set from the power up. The
> > > > power down should probably just be a no-op for the blk-ctl bus
> > > > domains, to allow the proper ADB handshake in the PGC domain
> > power-down.
> > > 
> > > I exported VPU-H1 as VPU-BUS for handshake, because they share
> > > same
> > > bits.  But you raise a valid idea, I think I could drop VPU-BUS,
> > > then
> > > just no-op here.
> > 
> > By share the same bits, you mean the ADB is connected to the same
> > clock and
> > reset as H1?
> 
> G1/G2/H1 all these three bits could be used for ADB handshake, I just
> use H1 here.
> 
> 
> > 
> > > 
> > > BTW: bus should be enabled when power down others.
> > 
> > I guess bus should just be always enabled as long as the PGC mix
> > domain is
> > powered-up, right?
> 
> Yes. correct.
> 
> > 
> > > 
> > > > 
> > > > > +		if (ret)
> > > > > +			dev_err(blk_ctl->dev, "Handshake
> > > > > failed when power
> > off\n");
> > > > > +	}
> > > > > +
> > > > > +disable_clk:
> > > > > +	clk_bulk_disable_unprepare(blk_ctl->num_clks,
> > > > > blk_ctl->clks);
> > > > > +
> > > > > +	mutex_unlock(&blk_ctl->lock);
> > > > > +
> > > > > +	return ret;
> > > > > +}
> > > > > +
> > > > > +static int imx_blk_ctl_probe(struct platform_device *pdev) {
> > > > > +	struct imx_blk_ctl_domain *domain = pdev-
> > > > > >dev.platform_data;
> > > > > +	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
> > > > > +	struct generic_pm_domain *parent_genpd;
> > > > > +	struct device *dev = &pdev->dev;
> > > > > +	struct device *active_pd;
> > > > > +	int ret;
> > > > > +
> > > > > +	pdev->dev.of_node = blk_ctl->dev->of_node;
> > > > > +
> > > > > +	if (domain->hw->active_pd_name) {
> > > > > +		active_pd =
> > > > > dev_pm_domain_attach_by_name(dev,
> > > > domain->hw->active_pd_name);
> > > > > +		if (IS_ERR_OR_NULL(active_pd)) {
> > > > > +			ret = PTR_ERR(active_pd) ? : -
> > > > > ENODATA;
> > > > > +			pdev->dev.of_node = NULL;
> > > > 
> > > > This is extremely ugly. I think we should not even have
> > > > separate
> > > > platform drivers for the blk-ctl domains, there is just no
> > > > reason
> > > > for it. See below for more comments in that direction.
> > > > 
> > > > > +			return ret;
> > > > > +		}
> > > > > +
> > > > > +		domain->active_pd = active_pd;
> > > > > +	} else {
> > > > > +		if (!blk_ctl->bus_domain) {
> > > > > +			pdev->dev.of_node = NULL;
> > > > > +			return -EPROBE_DEFER;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	if (domain->hw->active_pd_name)
> > > > > +		parent_genpd = pd_to_genpd(active_pd-
> > > > > >pm_domain);
> > > > > +	else
> > > > > +		parent_genpd = blk_ctl->bus_domain;
> > > > > +
> > > > > +	if (pm_genpd_add_subdomain(parent_genpd, &domain-
> > > > > >genpd)) {
> > > > > +		dev_warn(dev, "failed to add subdomain:
> > > > > %s\n",
> > > > domain->genpd.name);
> > > > 
> > > > I don't see where the dispmix_bus domain and clock is kept
> > > > enabled.
> > > > I would guess that the bus domain should be some kind of parent
> > > > to
> > > > the lcdif and mipi domains,
> > > 
> > > Yes. vpumix-blk-ctl bus domain is parent to vpu-g1/g2 and similar
> > > to others.
> > > 
> > >  as I don't think it would be okay to disable the bus clock,
> > > while any
> > > > of the peripherals in the dispmix complex are still active. Am
> > > > I
> > > > missing something here?
> > > 
> > > You are right, bus clock should be always kept enable if any
> > > periphals
> > > in dispmix is alive.
> > > 
> > > > 
> > > > > +	} else {
> > > > > +		mutex_lock(&blk_ctl->lock);
> > > > > +		domain->hooked = true;
> > > > > +		mutex_unlock(&blk_ctl->lock);
> > > > > +	}
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int imx_blk_ctl_remove(struct platform_device *pdev)
> > > > > {
> > > > > +	struct imx_blk_ctl_domain *domain = pdev-
> > > > > >dev.platform_data;
> > > > > +	struct imx_blk_ctl *blk_ctl = domain->blk_ctl;
> > > > > +	struct generic_pm_domain *parent_genpd;
> > > > > +	struct device *active_pd;
> > > > > +
> > > > > +	if (domain->hw->active_pd_name)
> > > > > +		parent_genpd = pd_to_genpd(active_pd-
> > > > > >pm_domain);
> > > > 
> > > > This has probably never been tested. active_pd is undefined at
> > > > this
> > > > point, so will most likely lead to a kernel crash.
> > > 
> > > My bad. Indeed, remove not tested.
> > > 
> > > > > +	else
> > > > > +		parent_genpd = blk_ctl->bus_domain;
> > > > > +
> > > > > +	pm_genpd_remove_subdomain(parent_genpd, &domain-
> > > > > >genpd);
> > > > > +
> > > > > +	mutex_lock(&blk_ctl->lock);
> > > > > +	domain->hooked = false;
> > > > > +	mutex_unlock(&blk_ctl->lock);
> > > > > +
> > > > > +	if (domain->hw->active_pd_name)
> > > > > +		dev_pm_domain_detach(domain->active_pd,
> > > > > false);
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static const struct platform_device_id imx_blk_ctl_id[] = {
> > > > > +	{ "imx-vpumix-blk-ctl", },
> > > > > +	{ "imx-dispmix-blk-ctl", },
> > > > > +	{ },
> > > > > +};
> > > > > +
> > > > > +static struct platform_driver imx_blk_ctl_driver = {
> > > > > +	.driver = {
> > > > > +		.name = "imx-blk-ctl",
> > > > > +	},
> > > > > +	.probe    = imx_blk_ctl_probe,
> > > > > +	.remove   = imx_blk_ctl_remove,
> > > > > +	.id_table = imx_blk_ctl_id,
> > > > > +};
> > > > > +builtin_platform_driver(imx_blk_ctl_driver)
> > > > > +
> > > > > +static struct generic_pm_domain
> > > > > *imx_blk_ctl_genpd_xlate(struct
> > > > of_phandle_args *genpdspec,
> > > > > +							
> > > > > void *data)
> > > > > +{
> > > > > +	struct genpd_onecell_data *genpd_data = data;
> > > > > +	unsigned int idx = genpdspec->args[0];
> > > > > +	struct imx_blk_ctl_domain *domain;
> > > > > +	struct generic_pm_domain *genpd = ERR_PTR(-
> > > > > EPROBE_DEFER);
> > > > > +
> > > > > +	if (genpdspec->args_count != 1)
> > > > > +		return ERR_PTR(-EINVAL);
> > > > > +
> > > > > +	if (idx >= genpd_data->num_domains)
> > > > > +		return ERR_PTR(-EINVAL);
> > > > > +
> > > > > +	if (!genpd_data->domains[idx])
> > > > > +		return ERR_PTR(-ENOENT);
> > > > > +
> > > > > +	domain = to_imx_blk_ctl_pd(genpd_data-
> > > > > >domains[idx]);
> > > > > +
> > > > > +	mutex_lock(&domain->blk_ctl->lock);
> > > > > +	if (domain->hooked)
> > > > > +		genpd = genpd_data->domains[idx];
> > > > > +	mutex_unlock(&domain->blk_ctl->lock);
> > > > > +
> > > > > +	return genpd;
> > > > > +}
> > > > > +
> > > > > +int imx_blk_ctl_register(struct device *dev) {
> > > > > +	struct imx_blk_ctl *blk_ctl = dev_get_drvdata(dev);
> > > > > +	const struct imx_blk_ctl_dev_data *dev_data =
> > > > > blk_ctl->dev_data;
> > > > > +	int num = dev_data->pds_num;
> > > > > +	struct imx_blk_ctl_domain *domain;
> > > > > +	struct generic_pm_domain *genpd;
> > > > > +	struct platform_device *pd_pdev;
> > > > > +	int domain_index;
> > > > > +	int i, ret;
> > > > > +
> > > > > +	blk_ctl->onecell_data.num_domains = num;
> > > > > +	blk_ctl->onecell_data.xlate =
> > > > > imx_blk_ctl_genpd_xlate;
> > > > > +	blk_ctl->onecell_data.domains = devm_kcalloc(dev,
> > > > > num,
> > > > > +sizeof(struct
> > > > generic_pm_domain *),
> > > > > +						    
> > > > > GFP_KERNEL);
> > > > > +	if (!blk_ctl->onecell_data.domains)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	for (i = 0; i < num; i++) {
> > > > > +		domain_index = dev_data->pds[i].id;
> > > > > +		if (domain_index >= num) {
> > > > > +			dev_warn(dev, "Domain index %d is
> > > > > out of bounds\n",
> > > > domain_index);
> > > > > +			continue;
> > > > > +		}
> > > > > +
> > > > > +		domain = devm_kzalloc(dev, sizeof(struct
> > > > > imx_blk_ctl_domain),
> > > > GFP_KERNEL);
> > > > > +		if (!domain)
> > > > > +			goto error;
> > > > > +
> > > > > +		pd_pdev = platform_device_alloc(dev_data-
> > > > > >name,
> > domain_index);
> > > > > +		if (!pd_pdev) {
> > > > > +			dev_err(dev, "Failed to allocate
> > > > > platform device\n");
> > > > > +			goto error;
> > > > > +		}
> > > > 
> > > > We don't need a full blow platform device and a driver for the
> > > > individual domains. The only point where we need the device is
> > > > to
> > > > attach the parent PGC power domains and for this we only need a
> > > > device.
> > > > 
> > > > So we could either have a dummy device for this usage in the
> > > > domain
> > > > or we could even reuse the device in the genpd, which is
> > > > initialized
> > > > in pm_genpd_init.
> > > > 
> > > > Now while I think about it... genpd_dev_pm_attach_by_name
> > > > already
> > > > allocates the virtual dummy device. I don't think we need to do
> > > > anything here on our own. Just get rid of the platform device
> > > > and driver.
> > > 
> > > ok, let me rethink about it. If you have chance to be on IRC, I
> > > could
> > > talk with you later if I come about new implementation.
> > 
> > I'm in the IRC channel if you prefer to talk there.
> 
> BTW, do you have time to pick up the BLK-CTL part? I think you have
> better architecture view than me.

Yes, this whole power-domain/blk-ctl complex is blocking a lot of other
things I'm supposed to look into. I'll spend some time trying to sort
this out.

Regards,
Lucas

