Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCC42D84F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhJNLj5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Oct 2021 07:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhJNLjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:39:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E65C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:37:50 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1maz3Q-0005y5-2b; Thu, 14 Oct 2021 13:37:44 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1maz3M-000463-0H; Thu, 14 Oct 2021 13:37:40 +0200
Message-ID: <fdea4ea765654a6c8dc820d75a6c2faad2284723.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] phy/rockchip: add naneng combo phy for RK3568
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com
Date:   Thu, 14 Oct 2021 13:37:39 +0200
In-Reply-To: <20211013101938.28061-3-yifeng.zhao@rock-chips.com>
References: <20211013101938.28061-1-yifeng.zhao@rock-chips.com>
         <20211013101938.28061-3-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

On Wed, 2021-10-13 at 18:19 +0800, Yifeng Zhao wrote:
> This patch implements a combo phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v2:
> - Using api devm_platform_get_and_ioremap_resource.
> - Modify rockchip_combphy_set_Mode.
> - Add some PHY registers definition.
> 
>  drivers/phy/rockchip/Kconfig                  |   8 +
>  drivers/phy/rockchip/Makefile                 |   1 +
>  .../rockchip/phy-rockchip-naneng-combphy.c    | 650 ++++++++++++++++++
>  3 files changed, 659 insertions(+)
>  create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> 
[...]
> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> new file mode 100644
> index 000000000000..fbfc5fbbd5b8
> --- /dev/null
> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
> @@ -0,0 +1,650 @@
[...]
> +static int rockchip_combphy_parse_dt(struct device *dev,
> +				     struct rockchip_combphy_priv *priv)
> +{
> +	const struct rockchip_combphy_cfg *phy_cfg = priv->cfg;
> +	int ret, mac_id;
> +
[...]
> +	priv->apb_rst = devm_reset_control_get_optional(dev, "combphy-apb");

Please use devm_reset_control_get_optional_exclusive().

Also, apb_rst is never used?

> +	if (IS_ERR(priv->apb_rst)) {
> +		ret = PTR_ERR(priv->apb_rst);
> +
> +		if (ret != -EPROBE_DEFER)
> +			dev_warn(dev, "failed to get apb reset\n");
> +
> +		return ret;

Any reason not to use dev_err_probe()?

> +	}
> +
> +	priv->phy_rst = devm_reset_control_get_optional(dev, "combphy");

Please use devm_reset_control_get_optional_exclusive().

> +	if (IS_ERR(priv->phy_rst)) {
> +		ret = PTR_ERR(priv->phy_rst);
> +
> +		if (ret != -EPROBE_DEFER)
> +			dev_warn(dev, "failed to get phy reset\n");
> +
> +		return ret;

Same as above.

> +	}
> +
> +	return reset_control_assert(priv->phy_rst);

It is unexpected that a function called rockchip_combphy_parse_dt()
already changes device state.

I'd move the reset_control_assert() out into rockchip_combphy_probe().

regards
Philipp
