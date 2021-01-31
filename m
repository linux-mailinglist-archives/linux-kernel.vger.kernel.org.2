Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582A6309D79
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbhAaPYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhAaOQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:16:44 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21763C061573;
        Sun, 31 Jan 2021 06:15:55 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p15so13707036wrq.8;
        Sun, 31 Jan 2021 06:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vHm2GaYgjU/RQgYozOeLN5GW4640nrEkHzr4EfB5zx4=;
        b=ZsJ3FhgFp/owp0U86EJAxQwbDaodP/Vnl7QXPKUVOxf2WVtl5G3dZnn9VVCEnmBi7i
         urpsp7KtipY8jExUCmZPgpQTeTPIITCO+6MAifE94eOq4iUunEtEChxCGqmHeBUPiHhy
         KFHksqhh+q4/oFRO9afOVQaHdzXuDLRsE/3K2mO1H4PElqiBq/jlcnLVPxw+JcrsPuOa
         HeZljzZVGlWCCSgd6GJjjbT6VW+P3ub6rtwN0cgNfYBDn6CIhY7u+v3mo5oEA/033sxb
         noOwVHPxgfedI6Yc1qSyUVKnXVOucWL9ogsu2qNNIF2JnNbEk632H8ZHa2xFULI1Wt5b
         HzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vHm2GaYgjU/RQgYozOeLN5GW4640nrEkHzr4EfB5zx4=;
        b=fMKJ76K009V9p/IIefOyvwv5HV2sItDx9UP+nabLDa3EgFh4UJt5xtdhXJjJqfIYN/
         K/QFHdeVaPev1QeLTSLgwSLcp44mSSgWZzO0cuAHVrY4dJaxwonUYqhr19qb/YCoN16f
         APFjSKY9qbikJzabJAWdTbga0aQ2o4rpdMksME7RsaVsVojYr+MmkyXsZ617o7YftT2E
         AzCLLmFtd0rXgKDvIlaJxci5HRcxEAnY7g9/QV3evEGinX82fa9/ElaGwH1ehHK8uEDk
         t7xpwniyva68FvHhyU0O3U0Bh+ERgn5ZsVBPJ8M3umN4cPYrfIdS/zTBcjiy2f+5krSl
         sxNA==
X-Gm-Message-State: AOAM530t2ja+BrkGXgQ//s2xMlEQwgjut7dFVke3yr866AClqf5cPzpf
        KGegwPUnVk1QdheL8ZZmauY=
X-Google-Smtp-Source: ABdhPJxoj72SiMcWoOi8eEnlcMafudsyYsk5bNrdpE8nyslXd7rzYjfwtQDtQBjYRnqTbeUPz453xw==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr13317681wrv.319.1612102553914;
        Sun, 31 Jan 2021 06:15:53 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 62sm18476218wmd.34.2021.01.31.06.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:15:53 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: mediatek: Correct i2c clock of MT8192
To:     qii.wang@mediatek.com, robh+dt@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com
References: <1608553590-26459-1-git-send-email-qii.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <3a8411e6-02e7-1c05-7063-aa12dc286ce0@gmail.com>
Date:   Sun, 31 Jan 2021 15:15:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608553590-26459-1-git-send-email-qii.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/12/2020 13:26, qii.wang@mediatek.com wrote:
> From: Qii Wang <qii.wang@mediatek.com>
> 
> imp wrapper clock is the i2c source clock of MT8192
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---

Thanks for your patch. The next time please provide information about any
out-of-tree series that are needed to apply cleanly.

Regards,
Matthias

>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 43 ++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index faea0d9..9c194a8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -17,6 +17,19 @@
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> +	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		i2c7 = &i2c7;
> +		i2c8 = &i2c8;
> +		i2c9 = &i2c9;
> +	};
> +
>  	clk26m: oscillator0 {
>  		compatible = "fixed-clock";
>  		#clock-cells = <0>;
> @@ -593,7 +606,8 @@
>  			reg = <0 0x11cb0000 0 0x1000>,
>  			      <0 0x10217300 0 0x80>;
>  			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_e CLK_IMP_IIC_WRAP_E_I2C3>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -612,7 +626,8 @@
>  			reg = <0 0x11d00000 0 0x1000>,
>  			      <0 0x10217600 0 0x180>;
>  			interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C7>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -625,7 +640,8 @@
>  			reg = <0 0x11d01000 0 0x1000>,
>  			      <0 0x10217780 0 0x180>;
>  			interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C8>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -638,7 +654,8 @@
>  			reg = <0 0x11d02000 0 0x1000>,
>  			      <0 0x10217900 0 0x180>;
>  			interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C9>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -657,7 +674,8 @@
>  			reg = <0 0x11d20000 0 0x1000>,
>  			      <0 0x10217100 0 0x80>;
>  			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C1>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -670,7 +688,8 @@
>  			reg = <0 0x11d21000 0 0x1000>,
>  			      <0 0x10217180 0 0x180>;
>  			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C2>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -683,7 +702,8 @@
>  			reg = <0 0x11d22000 0 0x1000>,
>  			      <0 0x10217380 0 0x180>;
>  			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_ws CLK_IMP_IIC_WRAP_WS_I2C4>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -702,7 +722,8 @@
>  			reg = <0 0x11e00000 0 0x1000>,
>  			      <0 0x10217500 0 0x80>;
>  			interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C5>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -721,7 +742,8 @@
>  			reg = <0 0x11f00000 0 0x1000>,
>  			      <0 0x10217080 0 0x80>;
>  			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_n CLK_IMP_IIC_WRAP_N_I2C0>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> @@ -734,7 +756,8 @@
>  			reg = <0 0x11f01000 0 0x1000>,
>  			      <0 0x10217580 0 0x80>;
>  			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>, <&clk26m>;
> +			clocks = <&imp_iic_wrap_n CLK_IMP_IIC_WRAP_N_I2C6>,
> +				 <&infracfg CLK_INFRA_AP_DMA>;
>  			clock-names = "main", "dma";
>  			clock-div = <1>;
>  			#address-cells = <1>;
> 
