Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3CF30EF68
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhBDJNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbhBDJMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:12:24 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FF1C061573;
        Thu,  4 Feb 2021 01:11:40 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id E7C281F45EBF
Subject: Re: next/master bisection: baseline.login on
 sun50i-h5-libretech-all-h3-cc
To:     Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>
References: <601b368c.1c69fb81.97b07.770c@mx.google.com>
Cc:     "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, clabbe.montjoie@gmail.com,
        Kevin Hilman <khilman@baylibre.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <357810a1-4c66-063d-24a1-dacdf9a2aba5@collabora.com>
Date:   Thu, 4 Feb 2021 09:11:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <601b368c.1c69fb81.97b07.770c@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

Please see the bisection report below about a boot failure on
sun50i-h5-libretech-all-h3-cc with next-20210203.

Reports aren't automatically sent to the public while we're
trialing new bisection features on kernelci.org but this one
looks valid.

The kernel is most likely crashing very early on, so there's
nothing in the logs.  Please let us know if you need some help
with debugging or trying a fix on these platforms.

Best wishes,
Guillaume


On 03/02/2021 23:49, KernelCI bot wrote:
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> * This automated bisection report was sent to you on the basis  *
> * that you may be involved with the breaking commit it has      *
> * found.  No manual investigation has been done to verify it,   *
> * and the root cause of the problem may be somewhere else.      *
> *                                                               *
> * If you do send a fix, please include this trailer:            *
> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
> *                                                               *
> * Hope this helps!                                              *
> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
> 
> next/master bisection: baseline.login on sun50i-h5-libretech-all-h3-cc
> 
> Summary:
>   Start:      58b6c0e507b7 Add linux-next specific files for 20210203
>   Plain log:  https://storage.kernelci.org/next/master/next-20210203/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-h5-libretech-all-h3-cc.txt
>   HTML log:   https://storage.kernelci.org/next/master/next-20210203/arm64/defconfig/gcc-8/lab-baylibre/baseline-sun50i-h5-libretech-all-h3-cc.html
>   Result:     7240f6156428 ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
> 
> Checks:
>   revert:     PASS
>   verify:     PASS
> 
> Parameters:
>   Tree:       next
>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
>   Branch:     master
>   Target:     sun50i-h5-libretech-all-h3-cc
>   CPU arch:   arm64
>   Lab:        lab-baylibre
>   Compiler:   gcc-8
>   Config:     defconfig
>   Test case:  baseline.login
> 
> Breaking commit found:
> 
> -------------------------------------------------------------------------------
> commit 7240f6156428fd61a9b681db71cc288848dd04d7
> Author: Samuel Holland <samuel@sholland.org>
> Date:   Sun Jan 17 23:50:38 2021 -0600
> 
>     ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
>     
>     All IRQs that can be used to wake up the system must be routed through
>     r_intc, so they are visible to firmware while the system is suspended.
>     
>     In addition to the external NMI input, which is already routed through
>     r_intc, these include PIO and R_PIO (gpio-keys), the LRADC, and the RTC.
>     
>     Acked-by: Maxime Ripard <mripard@kernel.org>
>     Signed-off-by: Samuel Holland <samuel@sholland.org>
>     Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index 9532331af8ef..a31f9072bf79 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -611,6 +611,7 @@
>  		pio: pinctrl@1c20800 {
>  			compatible = "allwinner,sun6i-a31-pinctrl";
>  			reg = <0x01c20800 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
> @@ -802,6 +803,7 @@
>  		lradc: lradc@1c22800 {
>  			compatible = "allwinner,sun4i-a10-lradc-keys";
>  			reg = <0x01c22800 0x100>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>  			status = "disabled";
>  		};
> @@ -1299,6 +1301,7 @@
>  			#clock-cells = <1>;
>  			compatible = "allwinner,sun6i-a31-rtc";
>  			reg = <0x01f00000 0x54>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&osc32k>;
> @@ -1383,6 +1386,7 @@
>  		r_pio: pinctrl@1f02c00 {
>  			compatible = "allwinner,sun6i-a31-r-pinctrl";
>  			reg = <0x01f02c00 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index a84c90a660ca..4461d5098b20 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -338,6 +338,7 @@
>  		pio: pinctrl@1c20800 {
>  			/* compatible gets set in SoC specific dtsi file */
>  			reg = <0x01c20800 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			/* interrupts get set in SoC specific dtsi file */
>  			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
>  			clock-names = "apb", "hosc", "losc";
> @@ -473,6 +474,7 @@
>  		lradc: lradc@1c22800 {
>  			compatible = "allwinner,sun4i-a10-lradc-keys";
>  			reg = <0x01c22800 0x100>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
>  			status = "disabled";
>  		};
> @@ -709,6 +711,7 @@
>  		rtc: rtc@1f00000 {
>  			compatible = "allwinner,sun8i-a23-rtc";
>  			reg = <0x01f00000 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-output-names = "osc32k", "osc32k-out";
> @@ -805,6 +808,7 @@
>  		r_pio: pinctrl@1f02c00 {
>  			compatible = "allwinner,sun8i-a23-r-pinctrl";
>  			reg = <0x01f02c00 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
>  			clock-names = "apb", "hosc", "losc";
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 414a8f9c73d1..dcccdd7b0c5b 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -708,6 +708,7 @@
>  
>  		pio: pinctrl@1c20800 {
>  			compatible = "allwinner,sun8i-a83t-pinctrl";
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> @@ -1147,6 +1148,7 @@
>  		r_lradc: lradc@1f03c00 {
>  			compatible = "allwinner,sun8i-a83t-r-lradc";
>  			reg = <0x01f03c00 0x100>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
>  			status = "disabled";
>  		};
> @@ -1154,6 +1156,7 @@
>  		r_pio: pinctrl@1f02c00 {
>  			compatible = "allwinner,sun8i-a83t-r-pinctrl";
>  			reg = <0x01f02c00 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>,
>  				 <&osc16Md512>;
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 4bf25c5b873e..c7428df9469e 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -395,6 +395,7 @@
>  		pio: pinctrl@1c20800 {
>  			/* compatible is in per SoC .dtsi file */
>  			reg = <0x01c20800 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
> @@ -852,6 +853,7 @@
>  		rtc: rtc@1f00000 {
>  			/* compatible is in per SoC .dtsi file */
>  			reg = <0x01f00000 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
>  			clock-output-names = "osc32k", "osc32k-out", "iosc";
> @@ -909,6 +911,7 @@
>  		r_pio: pinctrl@1f02c00 {
>  			compatible = "allwinner,sun8i-h3-r-pinctrl";
>  			reg = <0x01f02c00 0x400>;
> +			interrupt-parent = <&r_intc>;
>  			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&rtc 0>;
>  			clock-names = "apb", "hosc", "losc";
> -------------------------------------------------------------------------------
> 
> 
> Git bisection log:
> 
> -------------------------------------------------------------------------------
> git bisect start
> # good: [3aaf0a27ffc29b19a62314edd684b9bc6346f9a8] Merge tag 'clang-format-for-linux-v5.11-rc7' of git://github.com/ojeda/linux
> git bisect good 3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
> # bad: [58b6c0e507b7421b03b2f2a92bddbb8c6fa1b2f6] Add linux-next specific files for 20210203
> git bisect bad 58b6c0e507b7421b03b2f2a92bddbb8c6fa1b2f6
> # bad: [f3c2d07b431902b54796d1f9900e204e259b3fbe] Merge remote-tracking branch 'crypto/master'
> git bisect bad f3c2d07b431902b54796d1f9900e204e259b3fbe
> # bad: [beaae3d63383e985ab1586e11ea920079f05f436] Merge remote-tracking branch 'printk/for-next'
> git bisect bad beaae3d63383e985ab1586e11ea920079f05f436
> # good: [54fb15f26a5df379e94312bc836479359224a10e] Merge remote-tracking branch 'qcom/for-next'
> git bisect good 54fb15f26a5df379e94312bc836479359224a10e
> # bad: [e6eac2cd0d330b34a20cc8d44d7d9128cb4c4546] Merge remote-tracking branch 'fscache/fscache-next'
> git bisect bad e6eac2cd0d330b34a20cc8d44d7d9128cb4c4546
> # bad: [262b65d26567fbd8c794ed38b3166a04fdb144a7] Merge remote-tracking branch 'mips/mips-next'
> git bisect bad 262b65d26567fbd8c794ed38b3166a04fdb144a7
> # bad: [c0c33fc2564d400e72dfd7aa5480fe00dcfa6f56] Merge remote-tracking branch 'clk-renesas/renesas-clk'
> git bisect bad c0c33fc2564d400e72dfd7aa5480fe00dcfa6f56
> # good: [83b531d880acaa48b922321d0474bc93794d1b06] Merge remote-tracking branch 'stm32/stm32-next'
> git bisect good 83b531d880acaa48b922321d0474bc93794d1b06
> # bad: [fd8a1ce48fdbaa03abddf604d4f69b8e4c4a0de4] Merge remote-tracking branch 'sunxi/sunxi/for-next'
> git bisect bad fd8a1ce48fdbaa03abddf604d4f69b8e4c4a0de4
> # bad: [02e07b8ada0e8933d8a7f6e1126658bdd2f322d2] arm64: dts: allwinner: Move wakeup-capable IRQs to r_intc
> git bisect bad 02e07b8ada0e8933d8a7f6e1126658bdd2f322d2
> # good: [ee3ff030a3a9a88f14148ab81d62945ffbd77396] arm64: dts: allwinner: pinephone: Remove useless light sensor supplies
> git bisect good ee3ff030a3a9a88f14148ab81d62945ffbd77396
> # good: [01223da25a060c456d5a50116bbce7f1c3de0f2a] ARM: dts: sunxi: Rename nmi_intc to r_intc
> git bisect good 01223da25a060c456d5a50116bbce7f1c3de0f2a
> # good: [f10d37f21eaf50458f215cc1d4cf1ea1d4adc6c7] ARM: dts: sunxi: h3/h5: Add r_intc node
> git bisect good f10d37f21eaf50458f215cc1d4cf1ea1d4adc6c7
> # bad: [77f8a235273909e2d9a6da787046355098f5331c] arm64: dts: allwinner: Use the new r_intc binding
> git bisect bad 77f8a235273909e2d9a6da787046355098f5331c
> # bad: [7240f6156428fd61a9b681db71cc288848dd04d7] ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
> git bisect bad 7240f6156428fd61a9b681db71cc288848dd04d7
> # first bad commit: [7240f6156428fd61a9b681db71cc288848dd04d7] ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
> -------------------------------------------------------------------------------
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#6404): https://groups.io/g/kernelci-results/message/6404
> Mute This Topic: https://groups.io/mt/80368574/924702
> Group Owner: kernelci-results+owner@groups.io
> Unsubscribe: https://groups.io/g/kernelci-results/unsub [guillaume.tucker@collabora.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 
> 

