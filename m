Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB24375245
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234394AbhEFK0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbhEFK03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:26:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B300C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:25:31 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lebBr-0007Y4-Hd; Thu, 06 May 2021 12:25:07 +0200
Received: from pza by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <pza@pengutronix.de>)
        id 1lebBi-0006VF-Tg; Thu, 06 May 2021 12:24:58 +0200
Date:   Thu, 6 May 2021 12:24:58 +0200
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Steven Lee <steven_lee@aspeedtech.com>
Cc:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, Hongweiz@ami.com,
        ryan_chen@aspeedtech.com, chin-ting_kuo@aspeedtech.com
Subject: Re: [PATCH v3 5/5] mmc: sdhci-of-aspeed: Assert/Deassert reset
 signal before probing eMMC
Message-ID: <20210506102458.GA20777@pengutronix.de>
References: <20210506100312.1638-1-steven_lee@aspeedtech.com>
 <20210506100312.1638-6-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506100312.1638-6-steven_lee@aspeedtech.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 12:10:55 up 77 days, 13:34, 104 users,  load average: 0.57, 0.39,
 0.37
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: pza@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Thu, May 06, 2021 at 06:03:12PM +0800, Steven Lee wrote:
> For cleaning up the AST2600 eMMC controller, the reset signal should be
> asserted and deasserted before it is probed.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 49 ++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 4979f98ffb52..8ef06f32abff 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
[...]
> @@ -533,11 +545,22 @@ static struct platform_driver aspeed_sdhci_driver = {
>  	.remove		= aspeed_sdhci_remove,
>  };
>  
> +static const struct of_device_id aspeed_sdc_of_match[] = {
> +	{ .compatible = "aspeed,ast2400-sd-controller", },
> +	{ .compatible = "aspeed,ast2500-sd-controller", },
> +	{ .compatible = "aspeed,ast2600-sd-controller", .data = &ast2600_sdc_info},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
> +
>  static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  {
>  	struct device_node *parent, *child;
>  	struct aspeed_sdc *sdc;
> +	const struct of_device_id *match = NULL;
> +	const struct aspeed_sdc_info *info = NULL;

There is no need to initialize these variables to NULL, see below:

>  	int ret;
>  
>  	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
> @@ -546,6 +569,23 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
>  
>  	spin_lock_init(&sdc->lock);
>  
> +	match = of_match_device(aspeed_sdc_of_match, &pdev->dev);

match is set unconditionally before it is used,

> +	if (!match)
> +		return -ENODEV;
> +
> +	if (match->data)
> +		info = match->data;

and info could be set unconditionally as well:

	info = match->data;

> +	if (info) {
> +		if (info->flag & PROBE_AFTER_ASSET_DEASSERT) {
> +			sdc->rst = devm_reset_control_get(&pdev->dev, NULL);

Please use devm_reset_control_get_exclusive() or
devm_reset_control_get_optional_exclusive().

> +			if (!IS_ERR(sdc->rst)) {

Please just return errors here instead of ignoring them.
The reset_control_get_optional variants return NULL in case the
device node doesn't contain a resets phandle, in case you really
consider this reset to be optional even though the flag is set?

> +				reset_control_assert(sdc->rst);
> +				reset_control_deassert(sdc->rst);

Is there no need for delays between assertion and deassertion or after
the reset is deasserted?

> +			}
> +		}
> +	}
> +
>  	sdc->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(sdc->clk))
>  		return PTR_ERR(sdc->clk);

In general, I would assert/deassert the reset only after all resources
are successfully acquired. This might avoid unnecessary resets in case
of probe deferrals.

regards
Philipp
