Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B81933C5B6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhCOSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:32:58 -0400
Received: from mailoutvs3.siol.net ([185.57.226.194]:59049 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230338AbhCOSc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:32:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 90AE9523D7A;
        Mon, 15 Mar 2021 19:32:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ze0LKZRU4ttd; Mon, 15 Mar 2021 19:32:22 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 2F9C9523F53;
        Mon, 15 Mar 2021 19:32:22 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-86-58-17-133.cable.triera.net [86.58.17.133])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id BD969523E6A;
        Mon, 15 Mar 2021 19:32:20 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 4/5] arm64: dts: allwinner: Add sun4i MMIO timer nodes
Date:   Mon, 15 Mar 2021 19:32:20 +0100
Message-ID: <1897259.uecf0MpyRy@jernej-laptop>
In-Reply-To: <20210315043250.45095-5-samuel@sholland.org>
References: <20210315043250.45095-1-samuel@sholland.org> <20210315043250.45095-5-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 15. marec 2021 ob 05:32:49 CET je Samuel Holland napisal(a):
> For a CPU to enter an idle state, there must be some timer which can
> trigger an IRQ to wake it back up. The local ARM architectural timer is
> not sufficient, because that timer stops when the CPU is powered down.
> Some other CPU's ARM architectural timer can be used, but this prevents
> that other CPU from entering an idle state. So to allow all CPUs to
> enter an idle state at the same time, some MMIO timer must be available
> that is not tied to any CPU.
> 
> The basic "sun4i" timer seems most appropriate for this purpose due to
> its moderate rate, balancing precision and power consumption.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi  | 9 +++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi   | 9 +++++++++
>  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 9 +++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi index
> 33df866f6ea9..64e8b4a372cc 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -905,6 +905,15 @@ uart4_rts_cts_pins: uart4-rts-cts-pins {
>  			};
>  		};
> 
> +		timer@1c20c00 {
> +			compatible = "allwinner,sun50i-a64-timer",
> +				     "allwinner,sun8i-a23-timer";
> +			reg = <0x01c20c00 0xa0>;
> +			interrupts = <GIC_SPI 18 
IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 19 
IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc24M>;
> +		};
> +
>  		wdt0: watchdog@1c20ca0 {
>  			compatible = "allwinner,sun50i-a64-wdt",
>  				     "allwinner,sun6i-a31-wdt";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi index
> 62334054c710..9ba3b30e11fa 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -332,6 +332,15 @@ cpu_speed_grade: cpu-speed-grade@1c {
>  			};
>  		};
> 
> +		timer@3009000 {
> +			compatible = "allwinner,sun50i-h6-timer",
> +				     "allwinner,sun8i-a23-timer";
> +			reg = <0x03009000 0xa0>;
> +			interrupts = <GIC_SPI 48 
IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 49 
IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc24M>;
> +		};
> +
>  		watchdog: watchdog@30090a0 {
>  			compatible = "allwinner,sun50i-h6-wdt",
>  				     "allwinner,sun6i-a31-wdt";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi index
> c277b53f94ea..ff55712ce96e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi

This file does not exist yet upstream.

Best regards,
Jernej

> @@ -128,6 +128,15 @@ ccu: clock@3001000 {
>  			#reset-cells = <1>;
>  		};
> 
> +		timer@3009000 {
> +			compatible = "allwinner,sun50i-h616-timer",
> +				     "allwinner,sun8i-a23-timer";
> +			reg = <0x03009000 0xa0>;
> +			interrupts = <GIC_SPI 48 
IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 49 
IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&osc24M>;
> +		};
> +
>  		watchdog: watchdog@30090a0 {
>  			compatible = "allwinner,sun50i-h616-wdt",
>  				     "allwinner,sun6i-a31-wdt";




