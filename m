Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159E9429EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbhJLHi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbhJLHi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:38:56 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC93C061570;
        Tue, 12 Oct 2021 00:36:55 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j5so84149992lfg.8;
        Tue, 12 Oct 2021 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vB9uYdJsN7HfFIh1EPeV/AmLli9Pcmu7LFRCY4ZOmhM=;
        b=hbUYGPANbCGobhRYJTcf/mlq+dyADWC7z6fvhcM3ER2+BCPyQcaZToBU/wADPB7b0N
         0prHdPAExgBgj1pER9QInpPSAuoEgDCa7xC2H3SEsAY5MXpdzdzFeb6SY7ChaH4S20ep
         MzDiYLrS8OUmL6hL0iVsjVkBb6BfYMX4gPwmr70cr4ozpt075mUoH7ZJEwfhVEpeF/cL
         d8o1FxWcmqIlzLLM5VqhPeYdj2Tet+fPZL13gz/S6PMzU7YUD+3vwawjczx6tKABZ0VV
         WMjxuQkuqMBjcwQtkFXHdfhpZlt0aOfD1zfmOg8xoEpv3TELSYQYi0rL22J95y4Ccw5L
         ugRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vB9uYdJsN7HfFIh1EPeV/AmLli9Pcmu7LFRCY4ZOmhM=;
        b=YArRLnfgB1SU3q4Es2VetCxQFefDJ1QYNmqLyZF3zaRpUN+jU6y/3d+XyGvbOFO3ja
         SGDHUXK9OXmJcy/Cii8tIvWcIM8xh4UbSe7BMnZJoK7sn6ZWGnfLb85Z5zUCP2A9LU5j
         N22M/6jqwAjOzTuD9/heCZow3gvrZe2VHd0yCKQqap5ZOLLRAW6nasRk1R3DUE9atzZj
         dYSLO7+qE4oxKH3FtBl3kPAPH+z3yq0892IfJAGYS7+DvpmWejdRSjjdr4WoAEBopleh
         es8ebgXYa4010gDzJqJol/Gm9VC2eUOJnF7YlkdvQ3chPsqbNzuh6Z83Bqqw0w+4M8G/
         lHiA==
X-Gm-Message-State: AOAM530nwdgypB5OHuVHU2+f/7qqKtD39XcXBq09xux17izecbLKRheA
        b/1/jLKNn52LPvf6+6awOGY=
X-Google-Smtp-Source: ABdhPJxmsAtVWTmIwhXUKqHrj680l/Z9xEbT0Q5zkjpkJtxYwr/pmbkLLqsNA5Vua7Wdkm6x2zYrAw==
X-Received: by 2002:a05:6512:1595:: with SMTP id bp21mr7199977lfb.188.1634024213565;
        Tue, 12 Oct 2021 00:36:53 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id a14sm951376lfs.26.2021.10.12.00.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 00:36:53 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     heiko@sntech.de, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, michael.riesch@wolfvision.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v1 2/3] phy/rockchip: add naneng combo phy for RK3568
Date:   Tue, 12 Oct 2021 09:36:51 +0200
Message-ID: <1807525.kHsN9XgAzY@archbook>
In-Reply-To: <20210826123844.8464-3-yifeng.zhao@rock-chips.com>
References: <20210826123844.8464-1-yifeng.zhao@rock-chips.com> <20210826123844.8464-3-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 26. August 2021 14:38:43 CEST Yifeng Zhao wrote:
> This patch implements a combo phy driver for Rockchip SoCs
> with NaNeng IP block. This phy can be used as pcie-phy, usb3-phy,
> sata-phy or sgmii-phy.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> [...]
> +static int rockchip_combphy_pcie_init(struct rockchip_combphy_priv *priv)
> +{
> +	int ret = 0;
> +
> +	if (priv->cfg->combphy_cfg) {
> +		ret = priv->cfg->combphy_cfg(priv);
> +		if (ret) {
> +			dev_err(priv->dev, "failed to init phy for 
pcie\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int rockchip_combphy_usb3_init(struct rockchip_combphy_priv *priv)
> +{
> +	int ret = 0;
> +
> +	if (priv->cfg->combphy_cfg) {
> +		ret = priv->cfg->combphy_cfg(priv);
> +		if (ret) {
> +			dev_err(priv->dev, "failed to init phy for 
usb3\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int rockchip_combphy_sata_init(struct rockchip_combphy_priv *priv)
> +{
> +	int ret = 0;
> +
> +	if (priv->cfg->combphy_cfg) {
> +		ret = priv->cfg->combphy_cfg(priv);
> +		if (ret) {
> +			dev_err(priv->dev, "failed to init phy for 
sata\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int rockchip_combphy_sgmii_init(struct rockchip_combphy_priv *priv)
> +{
> +	int ret = 0;
> +
> +	if (priv->cfg->combphy_cfg) {
> +		ret = priv->cfg->combphy_cfg(priv);
> +		if (ret) {
> +			dev_err(priv->dev, "failed to init phy for 
sgmii\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int rockchip_combphy_set_mode(struct rockchip_combphy_priv *priv)
> +{
> +	switch (priv->mode) {
> +	case PHY_TYPE_PCIE:
> +		rockchip_combphy_pcie_init(priv);
> +		break;
> +	case PHY_TYPE_USB3:
> +		rockchip_combphy_usb3_init(priv);
> +		break;
> +	case PHY_TYPE_SATA:
> +		rockchip_combphy_sata_init(priv);
> +		break;
> +	case PHY_TYPE_SGMII:
> +	case PHY_TYPE_QSGMII:
> +		return rockchip_combphy_sgmii_init(priv);
> +	default:
> +		dev_err(priv->dev, "incompatible PHY type\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

All of the _init functions appear to be the same except for the error
string.

I think it would be better to just have the init done in _set_mode,
and then use the switch case statement to show the right error
message on if (ret).

> [...]
> +
> +static int rockchip_combphy_probe(struct platform_device *pdev)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev = &pdev->dev;
> +	struct rockchip_combphy_priv *priv;
> +	const struct rockchip_combphy_cfg *phy_cfg;
> +	struct resource *res;
> +	int ret;
> +
> +	phy_cfg = of_device_get_match_data(dev);
> +	if (!phy_cfg) {
> +		dev_err(dev, "No OF match data provided\n");
> +		return -EINVAL;
> +	}
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->mmio = devm_ioremap_resource(dev, res);

I think devm_platform_get_and_ioremap_resource is preferred here,
using it also means you can get rid of res.

> +	if (IS_ERR(priv->mmio)) {
> +		ret = PTR_ERR(priv->mmio);
> +		return ret;
> +	}
> +
> [...]

Regards,
Nicolas Frattaroli


