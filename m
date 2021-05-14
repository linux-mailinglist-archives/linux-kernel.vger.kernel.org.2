Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02473380404
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbhENHJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:44208 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhENHJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5910175D;
        Fri, 14 May 2021 00:08:02 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76FB63F718;
        Fri, 14 May 2021 00:08:01 -0700 (PDT)
Date:   Fri, 14 May 2021 08:07:56 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] ARM: dts: sun8i: v3s: add DMA properties to
 peripherals supporting DMA
Message-ID: <20210514080756.3a6c0f53@slackpad.fritz.box>
In-Reply-To: <20210513233024.2076725-3-t.schramm@manjaro.org>
References: <20210513233024.2076725-1-t.schramm@manjaro.org>
        <20210513233024.2076725-3-t.schramm@manjaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 01:30:19 +0200
Tobias Schramm <t.schramm@manjaro.org> wrote:

> This commit adds DMA properties to all peripherals supporting DMA on the
> Allwinner V3s, enabling accelerated data transfer to them.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>

DMA channels match the manual.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index f0296ab46137..3eaa8703e2ac 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -285,6 +285,8 @@ crypto@1c15000 {
>  			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_CE>, <&ccu CLK_CE>;
>  			clock-names = "ahb", "mod";
> +			dmas = <&dma 16>, <&dma 16>;
> +			dma-names = "rx", "tx";
>  			resets = <&ccu RST_BUS_CE>;
>  			reset-names = "ahb";
>  		};
> @@ -446,6 +448,8 @@ uart0: serial@1c28000 {
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			clocks = <&ccu CLK_BUS_UART0>;
> +			dmas = <&dma 6>, <&dma 6>;
> +			dma-names = "rx", "tx";
>  			resets = <&ccu RST_BUS_UART0>;
>  			status = "disabled";
>  		};
> @@ -457,6 +461,8 @@ uart1: serial@1c28400 {
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			clocks = <&ccu CLK_BUS_UART1>;
> +			dmas = <&dma 7>, <&dma 7>;
> +			dma-names = "rx", "tx";
>  			resets = <&ccu RST_BUS_UART1>;
>  			status = "disabled";
>  		};
> @@ -468,6 +474,8 @@ uart2: serial@1c28800 {
>  			reg-shift = <2>;
>  			reg-io-width = <4>;
>  			clocks = <&ccu CLK_BUS_UART2>;
> +			dmas = <&dma 8>, <&dma 8>;
> +			dma-names = "rx", "tx";
>  			resets = <&ccu RST_BUS_UART2>;
>  			pinctrl-0 = <&uart2_pins>;
>  			pinctrl-names = "default";
> @@ -547,6 +555,8 @@ spi0: spi@1c68000 {
>  			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_SPI0>, <&ccu CLK_SPI0>;
>  			clock-names = "ahb", "mod";
> +			dmas = <&dma 23>, <&dma 23>;
> +			dma-names = "rx", "tx";
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&spi0_pins>;
>  			resets = <&ccu RST_BUS_SPI0>;

