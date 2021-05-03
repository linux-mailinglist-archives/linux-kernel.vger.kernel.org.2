Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BBB3713D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhECKx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:53:59 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:42628 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbhECKxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:53:50 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 143AfCYu036456;
        Mon, 3 May 2021 18:41:12 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from aspeedtech.com (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 18:52:50 +0800
Date:   Mon, 3 May 2021 18:52:43 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Hongwei Zhang <Hongweiz@ami.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-of-aspeed: Sync capabilities from
 device tree to ast2600 SoC registers
Message-ID: <20210503105242.GB12520@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
 <20210503014336.20256-4-steven_lee@aspeedtech.com>
 <f1e86e81-d385-429a-ab8a-475240925f21@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <f1e86e81-d385-429a-ab8a-475240925f21@www.fastmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 143AfCYu036456
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 05/03/2021 13:04, Andrew Jeffery wrote:
> Hi Steven,
> 
> On Mon, 3 May 2021, at 11:13, Steven Lee wrote:
> > Sync Capbility Registers(SDIO140, SDIO144, SDIO240, SDIO244) of ast2600
> > SoC from the device tree.
> > The bit 26(Voltage Support 1.8v) of SDIO140/SDIO240 is set to 1 if
> > "mmc-hs200-1_8v" or "sd-uhs-sdr104" is added in the device tree.
> > The bit 1(SDR104 Supported) of SDR144/SDR244 is set to 1 if "sd-uhs-sdr104"
> > is added in the device tree.
> > "timing-phase" is synced to SDIO0F4(Colock Phase Control)
> > 
> > Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> > ---
> >  drivers/mmc/host/sdhci-of-aspeed.c | 107 ++++++++++++++++++++++++++---
> >  1 file changed, 98 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c 
> > b/drivers/mmc/host/sdhci-of-aspeed.c
> > index 7d8692e90996..2d755bac777a 100644
> > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reset.h>
> >  #include <linux/spinlock.h>
> >  
> >  #include "sdhci-pltfm.h"
> > @@ -30,10 +31,18 @@
> >  #define   ASPEED_SDC_S0_PHASE_IN_EN	BIT(2)
> >  #define   ASPEED_SDC_S0_PHASE_OUT_EN	GENMASK(1, 0)
> >  #define   ASPEED_SDC_PHASE_MAX		31
> > +#define ASPEED_SDC_CAP1_1_8V           BIT(26)
> > +#define ASPEED_SDC_CAP2_SDR104         BIT(1)
> > +#define PROBE_AFTER_ASSET_DEASSERT     0x1
> > +
> > +struct aspeed_sdc_info {
> > +	u32 flag;
> > +};
> >  
> >  struct aspeed_sdc {
> >  	struct clk *clk;
> >  	struct resource *res;
> > +	struct reset_control *rst;
> >  
> >  	spinlock_t lock;
> >  	void __iomem *regs;
> > @@ -72,6 +81,44 @@ struct aspeed_sdhci {
> >  	const struct aspeed_sdhci_phase_desc *phase_desc;
> >  };
> >  
> > +struct aspeed_sdc_info ast2600_sdc_info = {
> > +	.flag = PROBE_AFTER_ASSET_DEASSERT
> > +};
> > +
> > +/*
> > + * The function sets the mirror register for updating
> > + * capbilities of the current slot.
> > + *
> > + *   slot | cap_idx | caps_reg | mirror_reg
> > + *   -----|---------|----------|------------
> > + *     0  |    0    | SDIO140  |   SDIO10
> > + *     0  |    1    | SDIO144  |   SDIO14
> > + *     1  |    0    | SDIO240  |   SDIO20
> > + *     1  |    1    | SDIO244  |   SDIO24
> > + */
> > +static void aspeed_sdc_set_slot_capability(struct sdhci_host *host,
> > +					   struct aspeed_sdc *sdc,
> > +					   u32 reg_val,
> > +					   u8 slot,
> > +					   u8 cap_idx)
> 
> Having thought about this some more now we have code, I wonder if we can get
> rid of `cap_idx` as a parameter. Something like:
> 
> static void aspeed_sdc_set_slot_capability(struct sdhci_host *host,
>     struct aspeed_sdc *sdc, int capability, bool enable, u8 slot);
> 
> From there, instead of
> 
> #define ASPEED_SDC_CAP1_1_8V           BIT(26)
> #define ASPEED_SDC_CAP2_SDR104         BIT(1)
> 
> We do
> 
> /* SDIO{10,20} */
> #define ASPEED_SDC_CAP1_1_8V           (0 * 32 + 26)
> /* SDIO{14,24} */
> #define ASPEED_SDC_CAP2_SDR104         (1 * 32 + 1)
> 
> Then in the implementation of aspeed_sdc_set_slot_capability() we 
> derive cap_idx and reg_val:
> 
> u8 reg_val = enable * BIT(capability % 32);
> u8 cap_reg = capability / 32;
> 
> That way we get rid of the 0 and 1 magic values for cap_idx when 
> invoking aspeed_sdc_set_slot_capability() and the caller can't
> accidentally pass the wrong value.
> 

Thanks for the detailed suggestion, I will modify the function as you
suggested.

> > +{
> > +	u8 caps_reg_offset;
> > +	u32 caps_reg;
> > +	u32 mirror_reg_offset;
> > +	u32 caps_val;
> > +
> > +	if (cap_idx > 1 || slot > 1)
> > +		return;
> > +
> > +	caps_reg_offset = (cap_idx == 0) ? 0 : 4;
> > +	caps_reg = 0x40 + caps_reg_offset;
> > +	caps_val = sdhci_readl(host, caps_reg);
> 
> Hmm, I think you used sdhci_readl() because I commented on that last 
> time. If the global-area registers are truly mirrored we could read 
> from them as well right? In which case we could just use 
> readl(sdc->regs + mirror_reg_offset)? If so we can drop the host 
> parameter and (incorporating my suggestion above) just have:
> 
> static void aspeed_sdc_set_slot_capability(struct aspeed_sdc *sdc,
>     int capability, bool enable, u8 slot);
> 
> Sorry if I've sort of flip-flopped on that, but I think originally you 
> were still reading from the SDHCI (read-only) address?
> 

Yes, mirror registers are used to update the capability register, it returns
zero if we read the mirror register.
The test result is as follows:

# devmem 0x1e740010 32             // Read SDIO010(Mirror of SDIO140)
0x00000000

# devmem 0x1e740140 32             // Read capability
0x07FC0080

# devmem 0x1e740010 32 0x07fb0080  // Write mirror

# devmem 0x1e740010 32             // Read mirror
0x00000000

# devmem 0x1e740140 32             // Read capability
0x07FB0080

> > +	caps_val |= reg_val;
> > +	mirror_reg_offset = (slot == 0) ? 0x10 : 0x20;
> > +	mirror_reg_offset += caps_reg_offset;
> > +	writel(caps_val, sdc->regs + mirror_reg_offset);
> > +}
> > +
> >  static void aspeed_sdc_configure_8bit_mode(struct aspeed_sdc *sdc,
> >  					   struct aspeed_sdhci *sdhci,
> >  					   bool bus8)
> > @@ -329,9 +376,11 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
> >  {
> >  	const struct aspeed_sdhci_pdata *aspeed_pdata;
> >  	struct sdhci_pltfm_host *pltfm_host;
> > +	struct device_node *np = pdev->dev.of_node;
> >  	struct aspeed_sdhci *dev;
> >  	struct sdhci_host *host;
> >  	struct resource *res;
> > +	u32 reg_val;
> >  	int slot;
> >  	int ret;
> >  
> > @@ -372,6 +421,21 @@ static int aspeed_sdhci_probe(struct platform_device *pdev)
> >  
> >  	sdhci_get_of_property(pdev);
> >  
> > +	if (of_property_read_bool(np, "mmc-hs200-1_8v") ||
> > +	    of_property_read_bool(np, "sd-uhs-sdr104"))
> > +		aspeed_sdc_set_slot_capability(host,
> > +					       dev->parent,
> > +					       ASPEED_SDC_CAP1_1_8V,
> > +					       slot,
> > +					       0);
> 
> See the discussion above about reworking aspeed_sdc_set_slot_capability.
> 

Will do it.

> > +
> > +	if (of_property_read_bool(np, "sd-uhs-sdr104"))
> > +		aspeed_sdc_set_slot_capability(host,
> > +					       dev->parent,
> > +					       ASPEED_SDC_CAP2_SDR104,
> > +					       slot,
> > +					       1);
> 
> Again here.
> 

Will do it.

> > +
> >  	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> >  	if (IS_ERR(pltfm_host->clk))
> >  		return PTR_ERR(pltfm_host->clk);
> > @@ -476,12 +540,25 @@ static struct platform_driver aspeed_sdhci_driver = {
> >  	.remove		= aspeed_sdhci_remove,
> >  };
> >  
> > +static const struct of_device_id aspeed_sdc_of_match[] = {
> > +	{ .compatible = "aspeed,ast2400-sd-controller", },
> > +	{ .compatible = "aspeed,ast2500-sd-controller", },
> > +	{ .compatible = "aspeed,ast2600-sd-controller", .data = &ast2600_sdc_info},
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
> > +
> >  static int aspeed_sdc_probe(struct platform_device *pdev)
> >  
> >  {
> >  	struct device_node *parent, *child;
> >  	struct aspeed_sdc *sdc;
> > +	const struct of_device_id *match = NULL;
> > +	const struct aspeed_sdc_info *info = NULL;
> > +
> >  	int ret;
> > +	u32 timing_phase;
> >  
> >  	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
> >  	if (!sdc)
> > @@ -489,6 +566,23 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
> >  
> >  	spin_lock_init(&sdc->lock);
> >  
> > +	match = of_match_device(aspeed_sdc_of_match, &pdev->dev);
> > +	if (!match)
> > +		return -ENODEV;
> > +
> > +	if (match->data)
> > +		info = match->data;
> > +
> > +	if (info) {
> > +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> > +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);
> > +			if (!IS_ERR(sdc->rst)) {
> > +				reset_control_assert(sdc->rst);
> > +				reset_control_deassert(sdc->rst);
> > +			}
> > +		}
> > +	}
> 
> I think this should be a separate patch.
> 
> From the code it seems that this is necessary for just the 2600? Where 
> is this documented?
> 

Yes it is just for 2600. The patch is suggested by our chip designer and
is used for cleaning up MMC controller.
Currently, there is no document describes this changes.

And I have a question regarding the "separate patch", does it mean I should
create another patch set or I can add a new patch in the current
patch set?

> > +
> >  	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> >  	if (IS_ERR(sdc->clk))
> >  		return PTR_ERR(sdc->clk);
> > @@ -506,6 +600,10 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
> >  		goto err_clk;
> >  	}
> >  
> > +	if (!of_property_read_u32(pdev->dev.of_node,
> > +				  "timing-phase", &timing_phase))
> > +		writel(timing_phase, sdc->regs + ASPEED_SDC_PHASE);
> 
> I asked on v1 that you use the phase support already in the bindings 
> and in the driver. The example you added in the binding document[1] 
> used the existing devicetree properties but it seems you haven't fixed 
> the code.
> 
> Please drop your phase implementation from the patch.
> 

Sorry, I misunderstand the comment in the v1 patch. I thought that I should use
the exists ASPEED_SDC_PHASE for timing-phase.

Now I think I understand what you mean in the previous review.
I will remove the implementation you mentioned and add the following setting in
the device tree to verify again.

 clk-phase-mmc-hs200 = <N>, <N>;


> [1] https://lore.kernel.org/lkml/20210503014336.20256-2-steven_lee@aspeedtech.com/
> 
> Cheers,
> 
> Andrew
