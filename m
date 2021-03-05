Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148EF32F11A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCERZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhCERZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:25:19 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A90C061574;
        Fri,  5 Mar 2021 09:25:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id n16so4919973lfb.4;
        Fri, 05 Mar 2021 09:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Np441ZlRT1a2usnQ/Y8yGKL2QkXFf+g/pzr8QgoQl7o=;
        b=ipbT/rebN5CulcvrH7TCpmujCz0raIjRCI44NaxVNPvfM63ktiDg36+zxXW1cJOu9b
         rmwihGhh7lHJDInqOSi2XnesohJn89fphP2Pq/KJpHO2B2Qv61cgLig0Z1Cip1RDoHYY
         DHuK+H1oPaZBREmO1VUADD0PG9bTXLtg44whHW0IpPoCdZb3kWd/1Q3i2MxMCtl+27pG
         QXNbgfpODs5/40/w8s1DojCzD2rWE3rPsFExI5ggp/5slk0TxJpMJQ9ayft0FP7RJNaT
         qBhLcLzyG4/NXKtYn27BFt3kFqJbQ0xPUL9GjsFf4Hq8XBiVcT05KC9rz7YH7XXbSvX5
         m+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Np441ZlRT1a2usnQ/Y8yGKL2QkXFf+g/pzr8QgoQl7o=;
        b=aF/vi0mRB0JQeqbmq8TIbqRTRCgysgrgE1+vEgoDvCJshybE8coL+I/GNfNm2+foLb
         3FDixJWS1/DlP5RNbElDOiC+cHPv74nkre1trlVsnnmE9LoBQhR9ifyEjmHF4nCxmdfK
         6i0sVzLuOJSsgXeaOSNd5ic46VgC8g1PnP+x9SaXKk6OgVkNTE7s9OGU9UNn0QpyzPtv
         LEUhG14Y7xfSNwsJFqTR0epWqs85mXqnd7OSqEYFSUZ99mZ+wymiTHa9Fp2uvUE/sqh0
         S7qm3JH5sGlSvfKrCyi8DCDWyq1P3Sm3bSl4yhJJjy8m/kIf+MIpcJx9U7XYFd4itjfT
         zn+g==
X-Gm-Message-State: AOAM530agrqUkbOr2KN7ydsqVOfAuvE+htqG5DMDj7jU2IQWLKwjaY7S
        gqzIq/Y5rOcqSkIv53x9Mjc=
X-Google-Smtp-Source: ABdhPJw9wZfgOjH8rW3K7ST07rnNPKOqyDfW/FZUxnolNbOhMGaWGEiSaXqmRF4N+kURQCJUHe1cbg==
X-Received: by 2002:ac2:51ba:: with SMTP id f26mr6294944lfk.207.1614965117645;
        Fri, 05 Mar 2021 09:25:17 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id p25sm375195ljn.61.2021.03.05.09.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 09:25:17 -0800 (PST)
Subject: Re: [PATCH 3/3] phy: bcm-ns-usb2: support updated single CRU reg DT
 binding
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-phy@lists.infradead.org
References: <20210226114501.31086-1-zajec5@gmail.com>
 <20210226114501.31086-3-zajec5@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <cce77b5e-8546-82ae-a6f5-209bdf3363a5@gmail.com>
Date:   Fri, 5 Mar 2021 18:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210226114501.31086-3-zajec5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc linux-phy@

On 26.02.2021 12:45, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Updated DT binding maps a single CRU register that is directly used for
> the PHY control. Accessing common CRU reg is handled using syscon &
> regmap.
> 
> The old binding has been deprecated and stays as a fallback method.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> It's a reworked version of my abonded 2019 patch:
> [PATCH V2 2/2] phy: bcm-ns-usb2: support updated DT binding with the CRU syscon
> https://lore.kernel.org/patchwork/patch/1029863/
> ---
>   drivers/phy/broadcom/phy-bcm-ns-usb2.c | 52 +++++++++++++++++++++-----
>   1 file changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> index 4b015b8a71c3..98d32729a45d 100644
> --- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> +++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> @@ -9,17 +9,23 @@
>   #include <linux/clk.h>
>   #include <linux/delay.h>
>   #include <linux/err.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of_address.h>
>   #include <linux/of_platform.h>
>   #include <linux/phy/phy.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/slab.h>
>   
>   struct bcm_ns_usb2 {
>   	struct device *dev;
>   	struct clk *ref_clk;
>   	struct phy *phy;
> +	struct regmap *clkset;
> +	void __iomem *base;
> +
> +	/* Deprecated binding */
>   	void __iomem *dmu;
>   };
>   
> @@ -27,7 +33,6 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>   {
>   	struct bcm_ns_usb2 *usb2 = phy_get_drvdata(phy);
>   	struct device *dev = usb2->dev;
> -	void __iomem *dmu = usb2->dmu;
>   	u32 ref_clk_rate, usb2ctl, usb_pll_ndiv, usb_pll_pdiv;
>   	int err = 0;
>   
> @@ -44,7 +49,10 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>   		goto err_clk_off;
>   	}
>   
> -	usb2ctl = readl(dmu + BCMA_DMU_CRU_USB2_CONTROL);
> +	if (usb2->base)
> +		usb2ctl = readl(usb2->base);
> +	else
> +		usb2ctl = readl(usb2->dmu + BCMA_DMU_CRU_USB2_CONTROL);
>   
>   	if (usb2ctl & BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_PDIV_MASK) {
>   		usb_pll_pdiv = usb2ctl;
> @@ -58,15 +66,24 @@ static int bcm_ns_usb2_phy_init(struct phy *phy)
>   	usb_pll_ndiv = (1920000000 * usb_pll_pdiv) / ref_clk_rate;
>   
>   	/* Unlock DMU PLL settings with some magic value */
> -	writel(0x0000ea68, dmu + BCMA_DMU_CRU_CLKSET_KEY);
> +	if (usb2->clkset)
> +		regmap_write(usb2->clkset, 0, 0x0000ea68);
> +	else
> +		writel(0x0000ea68, usb2->dmu + BCMA_DMU_CRU_CLKSET_KEY);
>   
>   	/* Write USB 2.0 PLL control setting */
>   	usb2ctl &= ~BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_MASK;
>   	usb2ctl |= usb_pll_ndiv << BCMA_DMU_CRU_USB2_CONTROL_USB_PLL_NDIV_SHIFT;
> -	writel(usb2ctl, dmu + BCMA_DMU_CRU_USB2_CONTROL);
> +	if (usb2->base)
> +		writel(usb2ctl, usb2->base);
> +	else
> +		writel(usb2ctl, usb2->dmu + BCMA_DMU_CRU_USB2_CONTROL);
>   
>   	/* Lock DMU PLL settings */
> -	writel(0x00000000, dmu + BCMA_DMU_CRU_CLKSET_KEY);
> +	if (usb2->clkset)
> +		regmap_write(usb2->clkset, 0, 0x00000000);
> +	else
> +		writel(0x00000000, usb2->dmu + BCMA_DMU_CRU_CLKSET_KEY);
>   
>   err_clk_off:
>   	clk_disable_unprepare(usb2->ref_clk);
> @@ -90,10 +107,27 @@ static int bcm_ns_usb2_probe(struct platform_device *pdev)
>   		return -ENOMEM;
>   	usb2->dev = dev;
>   
> -	usb2->dmu = devm_platform_ioremap_resource_byname(pdev, "dmu");
> -	if (IS_ERR(usb2->dmu)) {
> -		dev_err(dev, "Failed to map DMU regs\n");
> -		return PTR_ERR(usb2->dmu);
> +	if (of_find_property(dev->of_node, "brcm,syscon-clkset", NULL)) {
> +		usb2->base = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(usb2->base)) {
> +			dev_err(dev, "Failed to map control reg\n");
> +			return PTR_ERR(usb2->base);
> +		}
> +
> +		usb2->clkset = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							       "brcm,syscon-clkset");
> +		if (IS_ERR(usb2->clkset)) {
> +			dev_err(dev, "Failed to lookup clkset regmap\n");
> +			return PTR_ERR(usb2->clkset);
> +		}
> +	} else {
> +		usb2->dmu = devm_platform_ioremap_resource_byname(pdev, "dmu");
> +		if (IS_ERR(usb2->dmu)) {
> +			dev_err(dev, "Failed to map DMU regs\n");
> +			return PTR_ERR(usb2->dmu);
> +		}
> +
> +		dev_warn(dev, "using deprecated DT binding\n");
>   	}
>   
>   	usb2->ref_clk = devm_clk_get(dev, "phy-ref-clk");
> 
