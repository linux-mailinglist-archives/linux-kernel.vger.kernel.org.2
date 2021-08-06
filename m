Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67493E2D70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244197AbhHFPR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhHFPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:17:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36006C0613CF;
        Fri,  6 Aug 2021 08:17:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m19so5881828wms.0;
        Fri, 06 Aug 2021 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j/xa8qZshCFoVyKlVsIewNJFCDwxE/FrxKwLU0KiPE4=;
        b=WPrLOCzNvhv8KNqSShRQUBN2qwuptA051kIsiir7ru9+zj2d49CdZObiE6GgQ8NpM2
         DxKYyKwCo55SxjGm1k581sD7oj6BSRrxXaybPR5LvRW+47WoqzQXdmJaXH/+yLnYjXD7
         dnSgl076wT0+pRoPHqO0N+NzokNv9fOtrm1L6FfJHWZNpHlGpUGs51LptXDpvHE4gEhJ
         KR7hyRQIDYS86NUksGq1ASINqG7QKs6LePp+XEkzG6n8xbwju4LHBXHZipC9Dn7MfciD
         MCa/GA/5abNUpxBJyorJdmZrDwp5w4/cmskzlZPIWcnq8gzFx7vSS1EUlq53JpKa8klv
         UwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j/xa8qZshCFoVyKlVsIewNJFCDwxE/FrxKwLU0KiPE4=;
        b=grKzAKZQq3axa2gVCF2zdvQz/aNJ3t6ergwRzQmwwKDd/Il8YHKNMAWBhSZHZO8Yu+
         GdnOFOA2abi9s+kH51I5enYdcgy86whsw9zHKXKBJJj1xOosdIOdkc4RgUYDbGvIyamt
         Meoi1DLhoSrBmAVqtPqHHcWWRFjR3a+yHYhKSiALvQIPwadx0nKWR8sLx4t+HfYvx1yz
         sDMFkH7n7OowFJhccdbIpHoICOBH/+LeMPtozL9lR2wIUFTIRd/m/kHmL2DbNHz3sTDu
         L3BMrcf39E6W0Je6PirJLB/cI1cheIrgsIbMAxCTVyd+y5F9zs2Z02yEeS1IHLvUoXlG
         49mA==
X-Gm-Message-State: AOAM530auQ3VKrxHGqjzhuGOxVzi0MgTY/26Ynb0MwC2wkdQpPp/gdo0
        koZkCkb5mD1sNEFICLtK8DQ=
X-Google-Smtp-Source: ABdhPJxFTP9E5ZhcnGK/Dd1vsXBwE3Hk/wGttb3x40ysCdrU5NSJYankQRiDNvXfZesQtqW57+WGow==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr3823549wmi.70.1628263030758;
        Fri, 06 Aug 2021 08:17:10 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id l41sm9573096wmp.23.2021.08.06.08.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 08:17:10 -0700 (PDT)
Subject: Re: [PATCH v4 1/1] arm64: dts: mediatek: add MT6779 spi master dts
 node
To:     Mason Zhang <mason.zhang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
References: <20210624021137.11513-1-mason.zhang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <358eca25-34b5-bf12-67aa-98491bbcc9d2@gmail.com>
Date:   Fri, 6 Aug 2021 17:17:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210624021137.11513-1-mason.zhang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/06/2021 04:11, Mason Zhang wrote:
> From: Mason Zhang <Mason.Zhang@mediatek.com>
> 
> This patch add spi master dts node for MT6779 SOC.
> 
> Signed-off-by: Mason Zhang <Mason.Zhang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6779.dtsi | 112 +++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6779.dtsi b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> index 370f309d32de..c81e76865d1b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6779.dtsi
> @@ -219,6 +219,118 @@
>  			status = "disabled";
>  		};
>  
> +		spi0: spi0@1100a000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			mediatek,pad-select = <0>;

pad-select should be part of board DTS.

> +			reg = <0 0x1100a000 0 0x1000>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				<&topckgen CLK_TOP_SPI>,
> +				<&infracfg_ao CLK_INFRA_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";

Should be disabled by default and enabled in board DTS.

> +		};

This gives me the following warning:
arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi0@1100a000:#interrupt-cells: size is (16),
expected multiple of 12

arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi1@11010000:#interrupt-cells: size is (16),
expected multiple of 12

arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi2@11012000:#interrupt-cells: size is (16),
expected multiple of 12

arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi3@11013000:#interrupt-cells: size is (16),
expected multiple of 12

arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi4@11018000:#interrupt-cells: size is (16),
expected multiple of 12

arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi5@11019000:#interrupt-cells: size is (16),
expected multiple of 12

arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi6@1101d000:#interrupt-cells: size is (16),
expected multiple of 12

arch/arm64/boot/dts/mediatek/mt6779.dtsi:145.4-27: Warning
(interrupts_property): /soc/spi7@1101e000:#interrupt-cells: size is (16),
expected multiple of 12


Regards,
Matthias

> +
> +		spi1: spi1@11010000 {
> +			compatible = "mediatek,mt6779-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
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
> +			#address-cells = <1>;
> +			#size-cells = <0>;
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
> +			#address-cells = <1>;
> +			#size-cells = <0>;
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
> +			#address-cells = <1>;
> +			#size-cells = <0>;
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
> +			#address-cells = <1>;
> +			#size-cells = <0>;
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
> +			#address-cells = <1>;
> +			#size-cells = <0>;
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
> +			#address-cells = <1>;
> +			#size-cells = <0>;
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
