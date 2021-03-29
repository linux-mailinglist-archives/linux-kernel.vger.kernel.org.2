Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66BD34D44B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhC2Puq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhC2Puh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:50:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36B8C061574;
        Mon, 29 Mar 2021 08:50:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x16so13350973wrn.4;
        Mon, 29 Mar 2021 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vVulNAgkS7cIMGOyXspAyuoXQyG90qaflFWTYWzViY8=;
        b=us3HZyuNffumsXVeXyRuENc7s34ifchnF542A6lj2hS+NnszHKEcwB8Y+AUtrA/8Rm
         t/jA7hiAGrbtp/buv0has+6o9C2u24MMu26s6ZFDjJaSSWOGzyK7bnajq8Oj8QPbaLuc
         DWdEk8Cb5XtSCAqWsy7XbwxOj5wlI8IpPvfdvp7ysAfMvL2JR1cqXn4xG/LnLKayqnVY
         xjt14dtv0RR8gNmvsD0iM2a8LHlBSxtSIFVeeXSfZtfFltyCiW75R7Ls+dM8U/bzeykE
         wZVC4ACAUziojXxTWq1oS011PND6G/ZPTyCIy5OlHcGsswCp4llo2Tww2d4qHlc2hqL0
         1btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vVulNAgkS7cIMGOyXspAyuoXQyG90qaflFWTYWzViY8=;
        b=bCu3CotydwpaGa01XXyB/77p+3k64qWG8IsH200tjJ0iX7bJJugSRzyl0XOIApgxjE
         uWqtFsmx/XADeuvopePm8zJpbzkht7ZJv6na34nQdVPmErK1W5UCqaYJPQhDa5XsgxgV
         Veyt8fiu1Myi4B1EBcPQdZcs1lMR+eebfWdbVquydDJ0ypy6TmLB2U8MfksC4/n6maoo
         2tBCRgKSVS2+jA6uoT+QJywVbwJIdDISqNJt9vim2dmABNoPrst6+I74yISGc2NTCmkW
         WOl2zgSUHdvhN9wZVAgv/arj5P4sxHStqdVeTn1TWBES/fqgI2fGsRleDyU5XgSStB9m
         JxKg==
X-Gm-Message-State: AOAM5307je0nwo6kq8MSe5DGxyXXR18V6Q4MpwJtaqpP+bd2aG/4Acm6
        uL+rCJUHohIE0nurPCNmsRo=
X-Google-Smtp-Source: ABdhPJy0o4dA+W1psLIjVopkFnM6kqV/xT30PKw+7t3FhVq6F4Y6LEVnDswVcB7WIALHAoUL/sGvWQ==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr29467162wro.337.1617033034649;
        Mon, 29 Mar 2021 08:50:34 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id f2sm31416341wrq.34.2021.03.29.08.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 08:50:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: add MT6779 spi master dts node
To:     Mason Zhang <Mason.Zhang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanks.chen@mediateka.com, wsd_upstream@mediatek.com
References: <20210226105918.3057-1-Mason.Zhang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <d3666864-cb46-755c-0d0d-d05ac9af0379@gmail.com>
Date:   Mon, 29 Mar 2021 17:50:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210226105918.3057-1-Mason.Zhang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/02/2021 11:59, Mason Zhang wrote:
> this patch add spi master dts node for mt6779 SOC.
> 
> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6779.dtsi | 96 ++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> index 370f309d32de..ca72eb09cff9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> @@ -219,6 +219,102 @@
>  			status = "disabled";
>  		};
>  
> +		spi0: spi0@1100a000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x1100a000 0 0x1000>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				<&topckgen CLK_TOP_SPI>,
> +				<&infracfg_ao CLK_INFRA_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};

Please also update binding description accordingling and add as another patch. I
wasn't able to find a 2/2 neither. I foudn v1 2/2 which on a quick look seemed
the same as this patch.

Regards,
Matthias

> +
> +		spi1: spi1@11010000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x11010000 0 0x1000>;
> +			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				<&topckgen CLK_TOP_SPI>,
> +				<&infracfg_ao CLK_INFRA_SPI1>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
> +
> +		spi2: spi2@11012000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x11012000 0 0x1000>;
> +			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				<&infracfg_ao CLK_INFRA_SPI2>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
> +
> +		spi3: spi3@11013000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x11013000 0 0x1000>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_SPI3>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
> +
> +		spi4: spi4@11018000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x11018000 0 0x1000>;
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_SPI4>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
> +
> +		spi5: spi5@11019000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x11019000 0 0x1000>;
> +			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				<&topckgen CLK_TOP_SPI>,
> +				<&infracfg_ao CLK_INFRA_SPI5>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
> +
> +		spi6: spi6@1101d000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x1101d000 0 0x1000>;
> +			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_SPI6>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
> +
> +		spi7: spi7@1101e000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			mediatek,pad-select = <0>;
> +			reg = <0 0x1101e000 0 0x1000>;
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_SPI7>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
> +
>  		audio: clock-controller@11210000 {
>  			compatible = "mediatek,mt6779-audio", "syscon";
>  			reg = <0 0x11210000 0 0x1000>;
> 
