Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C34356AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351847AbhDGLRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 07:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351818AbhDGLRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 07:17:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E9CC061756;
        Wed,  7 Apr 2021 04:17:30 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t140so12773974pgb.13;
        Wed, 07 Apr 2021 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jKz9PN0lLBTm9R3z1U/8bmvGzAhvQoiymdijIeKL3X0=;
        b=TMXXTJHYehvDU9gPzRCJlMtz0RmliEroITHgqqxKxrh5VGmRmYC6YbISZszwEUqO3F
         inhGipv5q1Gh0QnQH2WStCwsKzVHLEJUdanDAKFH4kK1Q3qZzxutyvTFQc4hInE3n4n4
         vIGa2sXPvkiF4Uw5K+qlGHn0HqLW2jL3uiHaoo/K0fkTlkHvyatmKYgbp2MbWetK6B5w
         /Vra7S2l1Xw+lqTTd71JZfzyMbMkGbIBMugg96W7GiK+0ndOGSHkH0MhsJNsQxgkEiGs
         peLzwL4erac36UjMsDGFR4k8TYfvjuU35/St13t+daPZJlt/lq++RDoR40R8521BYjcn
         zrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jKz9PN0lLBTm9R3z1U/8bmvGzAhvQoiymdijIeKL3X0=;
        b=edMF7zA1QO7jU9pCjs6w0oHAtRXOMWxRwqpe/IByDUcGQHc+Tm/oSQCH0kFpC1MOcO
         TyRBfxzDJWSY6fWrYnOEeZOcOomr7P0FbM5UZJheuzqO4y1ldd2AKG3OZLsUv7Q1qT7O
         Cjx9m0m9+8HbhnnKae/EJ9vutgJtJwbyWXdAcZsIdRyP3KXnYOfygYrn6aj4ql6Q8TjK
         Ei4xDHYS0DhLHgQ6i5jQVsZ1+J2taCkwRCyJpXKvIWOi+E38OhbF4K92DjMwdyY0K9B8
         UDF+2uI4rI6mokY3OYgiPC8lNBww9pFrMOaF4NeN2vWuwR/1h5vlnizDu+UOGCJxaWFE
         ZKhg==
X-Gm-Message-State: AOAM5339KMrMNmRt3Sb8feyXm9v/iIjq422s/VOBfUFuIyZ72PdmYRY0
        8DggeUTRegVEAFRYweepggs=
X-Google-Smtp-Source: ABdhPJwFV2aJZrVLPlD1sAyTTCmszAc7wE5xiEsEejZJmjvLeXnrzjYDWUhKCp/Ojtcz5XyVNtqV9g==
X-Received: by 2002:aa7:8493:0:b029:1ee:75b2:2865 with SMTP id u19-20020aa784930000b02901ee75b22865mr2304232pfn.61.1617794249919;
        Wed, 07 Apr 2021 04:17:29 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.37])
        by smtp.gmail.com with ESMTPSA id s19sm21132914pfh.168.2021.04.07.04.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 04:17:29 -0700 (PDT)
To:     Mason Zhang <Mason.Zhang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanks.chen@mediateka.com, wsd_upstream@mediatek.com,
        Leilk Liu <leilk.liu@mediatek.com>
References: <20210226105918.3057-1-Mason.Zhang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: add MT6779 spi master dts node
Message-ID: <4e39785a-06a6-4ec5-5930-8a5bf53e4f7b@gmail.com>
Date:   Wed, 7 Apr 2021 13:17:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210226105918.3057-1-Mason.Zhang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

From the binding description:
- #address-cells: should be 1.

- #size-cells: should be 0.

We are missing both here. Please fix that.

Apart the binding description is naming PLL, clock mux and clock gate IDs which
do not correspond to the ones used here. It seems that this binding was tailored
for a specific SoC family but never made generic. If you want, please do so and
convert it to yaml.

Regards,
Matthias

> +		};
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
