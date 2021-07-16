Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0753CBA82
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhGPQ30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPQ3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:29:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E9C06175F;
        Fri, 16 Jul 2021 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=BT3u5ZofuAHSdxMpV3wWSwl12UFAwfImxEpiJ4fE1TA=; b=GQk1Il8kjV3MxLqeHnE9MC83DN
        +ghHzeT3iaF+vLczDq/vP8Z6zFRERcHTzk7C5zs3PAlOh882QdgRMy1mECabqB/SLusuhdOBweUbv
        GO+ZJLsV7GZu1Ybh7Pfoc6wl0L+FfEdU1S8wHL4zxkjCJ4tHgzwSIQhkcpEPR7P5nJotCZYStIk3y
        YDXVGhxQCAThyZCluVNa4GMmU3J0TkXim59Zv+tUP9zXzxbZ4ARCbMv/WS/aNpoSZVTZpoFotcTdA
        LG6Pd9JQadPRYeMCHp7ABYCy3G/N40AehA1EeFrfKwowxFaULIwz+hf5mnfUKBmciJKGoPDFFIAmR
        lPGL9xLA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m4QfM-004rAm-6x; Fri, 16 Jul 2021 16:26:20 +0000
Subject: Re: [PATCH v6 3/3] power: supply: mt6360_charger: add MT6360 charger
 support
To:     Gene Chen <gene.chen.richtek@gmail.com>, sre@kernel.org,
        matthias.bgg@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     broonie@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        inux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com, cy_huang@richtek.com,
        benjamin.chao@mediatek.com
References: <20210716094353.140536-1-gene.chen.richtek@gmail.com>
 <20210716094353.140536-4-gene.chen.richtek@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c636cac0-defe-7bed-8428-818a52040d1b@infradead.org>
Date:   Fri, 16 Jul 2021 09:26:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716094353.140536-4-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 7/16/21 2:43 AM, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add basic support for the battery charger for MT6360 PMIC
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/power/supply/Kconfig          |  11 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/mt6360_charger.c | 867 ++++++++++++++++++++++++++
>  3 files changed, 879 insertions(+)
>  create mode 100644 drivers/power/supply/mt6360_charger.c
> 
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 11f5368e810e..81f02f8d4377 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -577,6 +577,17 @@ config CHARGER_MP2629
>  	  Battery charger. This driver provides Battery charger power management
>  	  functions on the systems.
>  
> +config CHARGER_MT6360
> +	tristate "Mediatek MT6360 Charger Driver"
> +	depends on MFD_MT6360
> +	depends on REGULATOR
> +	select LINEAR_RANGES
> +	help
> +	  Say Y here to enable MT6360 Charger Part.
> +	  The device supports High-Accuracy Voltage/Current Regulation,
> +	  Average Input Current Regulation, Battery Tempature Sensing,

	                                            Temperature

> +	  Over-Temperature Protection, DPDM Detection for BC1.2
> +
>  config CHARGER_QCOM_SMBB
>  	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

