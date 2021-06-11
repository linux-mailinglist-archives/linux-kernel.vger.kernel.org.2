Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFAA3A43A1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhFKOAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhFKOAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:00:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C3AC061574;
        Fri, 11 Jun 2021 06:58:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id o3so6184174wri.8;
        Fri, 11 Jun 2021 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=65HXSbNbmh2eB86Bo4Ktjk4oUhG8UnCDwk0uApNVoXo=;
        b=vQ2nhn4M1kRI+inZ01ZL0rg1eKcQohm+IhGgChNvONiLqe9p/tKgEzGc1yxiTXQYPD
         RI3zK+MkYajI8+V/tXf0j9MEJsgxQtTOVpPfiKEHD4SJTpaTwZ5EfK0X4YCl4Xf8Bdwu
         Kvt8GR9lQOk7Z2f1Lq+yoOM5LoGQi0ab41KdOSA0jBDf5WsGqh7D1lZXPSa5rY4+lI9r
         amQhgZvD9HOJCJ+XjZrGvtI8mjdVkVEsZ6MNmXumH2VhEK9irMXZ/PscnRp59DCADNQ+
         ugsrorfuA2Aysctc3iw2q/j/0+ZJrcwfwbEpMW90UcT/BpGy/SjWZp3bDiuD3+qUhPEl
         PpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=65HXSbNbmh2eB86Bo4Ktjk4oUhG8UnCDwk0uApNVoXo=;
        b=mg4bNm6KEV6JVhBv+CH1doT228lkujd/AVy1EH5Hi0a5Ksb0pGr5N428uTFSYG4ZfP
         sR0/WQtK0+NrcocCqTZzh6ACpAnTcZcrC0oNSHOBH714Wj7zeSs6aHVG6x5Dfrcxd6cL
         RjQqNgI/EFsHPlSu4ZaCXk+OAHTXsjTzVv5vxm7C1F/pbGC86DNCp7C3J1COJEICOUSR
         a4iScXnbu2WbjCIkiZY91DxRDPjL+zbfLfZDKtCXsYmaderx2qOB74dWPvqnpBLqImik
         00rx8Z1etWwlIRWegejxERksm9887ZPOniMtxAcysdt0xu9Tl6iozO25klYeL0a9Rz2e
         Bqtw==
X-Gm-Message-State: AOAM532rusD7Bj1zB7Ihzok+T/Wym2rSFyXCJe5bb9C8+OMHd5QoKx0N
        a8n/SZx07ERSh+68ZAvSHQo=
X-Google-Smtp-Source: ABdhPJxZlr1sJExAQqIe+Ht9eFJb7CaHNbSMfSYh1iNUYux526F16gInmumcvtcfKoolHwU8y6GSoA==
X-Received: by 2002:adf:df09:: with SMTP id y9mr4379275wrl.108.1623419915200;
        Fri, 11 Jun 2021 06:58:35 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id o11sm5779133wmq.1.2021.06.11.06.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 06:58:34 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] arm64: dts: mediatek: add MT6779 spi master dts
 node
To:     Mason Zhang <Mason.Zhang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        hanks.chen@mediatek.com, wsd_upstream@mediatek.com
References: <20210409015651.11474-1-Mason.Zhang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <faafa83d-4831-2b70-78ec-0e9f3636b5c9@gmail.com>
Date:   Fri, 11 Jun 2021 15:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210409015651.11474-1-Mason.Zhang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/04/2021 03:56, Mason Zhang wrote:
> This patch add address-cells && size-cells in spi node based on patch v1.
> 

Can you please come up with a better commit message, otherwise patch looks good.

Regards,
Matthias

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
> +			reg = <0 0x1100a000 0 0x1000>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW 0>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D2>,
> +				<&topckgen CLK_TOP_SPI>,
> +				<&infracfg_ao CLK_INFRA_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +		};
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
