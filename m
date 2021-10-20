Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F277434687
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJTIMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:12:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:46872 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTIMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:12:45 -0400
Received: from [213.208.157.36] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1md6g6-0002KZ-Qj; Wed, 20 Oct 2021 10:10:26 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399: Hook up DMA for UARTs
Date:   Wed, 20 Oct 2021 10:10:25 +0200
Message-ID: <2163516.Xs4XyuuM7S@phil>
In-Reply-To: <20210920175647.13008-2-wens@kernel.org>
References: <20210920175647.13008-1-wens@kernel.org> <20210920175647.13008-2-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 20. September 2021, 19:56:47 CEST schrieb Chen-Yu Tsai:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The RK3399 has two DMA controllers, one of which is wired up to work
> with the SPI controllers and UARTs. The SPI controllers are already
> hooked up, but the UARTs aren't.
> 
> Add the "dmas" and "dma-names" to the UART device nodes to hook up DMA.

last time this came up, there was the issue of the pl330 driver in the
kernel not being able to handle the case where the number of channels
hooked up was larger than the number of possible channels handled
at the same time (8 for dmac peri according to the TRM).

Did this get solved meanwhile or are we then possibly starving the spi
controllers from dma access when the uarts also get dma channels
and are possibly probed earlier?


Heiko


> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 3871c7fd83b0..87d6e4eb1337 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -608,6 +608,8 @@ uart0: serial@ff180000 {
>  		reg = <0x0 0xff180000 0x0 0x100>;
>  		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
>  		clock-names = "baudclk", "apb_pclk";
> +		dmas = <&dmac_peri 0>, <&dmac_peri 1>;
> +		dma-names = "tx", "rx";
>  		interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH 0>;
>  		reg-shift = <2>;
>  		reg-io-width = <4>;
> @@ -621,6 +623,8 @@ uart1: serial@ff190000 {
>  		reg = <0x0 0xff190000 0x0 0x100>;
>  		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
>  		clock-names = "baudclk", "apb_pclk";
> +		dmas = <&dmac_peri 2>, <&dmac_peri 3>;
> +		dma-names = "tx", "rx";
>  		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH 0>;
>  		reg-shift = <2>;
>  		reg-io-width = <4>;
> @@ -634,6 +638,8 @@ uart2: serial@ff1a0000 {
>  		reg = <0x0 0xff1a0000 0x0 0x100>;
>  		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
>  		clock-names = "baudclk", "apb_pclk";
> +		dmas = <&dmac_peri 4>, <&dmac_peri 5>;
> +		dma-names = "tx", "rx";
>  		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH 0>;
>  		reg-shift = <2>;
>  		reg-io-width = <4>;
> @@ -647,6 +653,8 @@ uart3: serial@ff1b0000 {
>  		reg = <0x0 0xff1b0000 0x0 0x100>;
>  		clocks = <&cru SCLK_UART3>, <&cru PCLK_UART3>;
>  		clock-names = "baudclk", "apb_pclk";
> +		dmas = <&dmac_peri 6>, <&dmac_peri 7>;
> +		dma-names = "tx", "rx";
>  		interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH 0>;
>  		reg-shift = <2>;
>  		reg-io-width = <4>;
> @@ -1142,6 +1150,8 @@ uart4: serial@ff370000 {
>  		reg = <0x0 0xff370000 0x0 0x100>;
>  		clocks = <&pmucru SCLK_UART4_PMU>, <&pmucru PCLK_UART4_PMU>;
>  		clock-names = "baudclk", "apb_pclk";
> +		dmas = <&dmac_peri 8>, <&dmac_peri 9>;
> +		dma-names = "tx", "rx";
>  		interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH 0>;
>  		reg-shift = <2>;
>  		reg-io-width = <4>;
> 




