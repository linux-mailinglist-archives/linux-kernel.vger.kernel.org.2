Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD33F2510
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 04:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237936AbhHTC7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 22:59:52 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:37607 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234797AbhHTC7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 22:59:50 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3FC41580B51;
        Thu, 19 Aug 2021 22:59:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 19 Aug 2021 22:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=W
        4csqGF7EaCVQldDEP3prZ8OVQrteF1bQXmpxlvS0MU=; b=TvXK8//vl0XRoOqZ2
        C6a7geG3s3ZbGnxUZCsDNXc+023N1sy6gYH9IuZVgdSYc4OH6EHzSubEn6RHa4xM
        ROCBzVNPDvoQ9iOJCgwt5Q3owFsJb3P1+BB0Ta1LXDKdbo553mLIFKnjq5KJ/8If
        qCHtmBHCezOukFQ0NmXcoLCiDmUpAwVDeR2jNUvuOlzeV57zsL1ph7nGFGKxMYf+
        ZXtARtH0MydN65laKAlEu1RgZWhmyK52sf/t6nvgovSXJry3O1XkezGNMRtJeGP2
        G8i11DuLiKRf9K/Yb6J2e79Ai7ylpdIfrJ7DJIVnOuP0LVVKrqPN3cLUH9n7XapG
        uI0oQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=W4csqGF7EaCVQldDEP3prZ8OVQrteF1bQXmpxlvS0
        MU=; b=XiW/wQd79FiWRlvKJbBCB4kxzSdBP6NtnDSt+gxv/PGEhnrSSdJ2MCUxv
        m5yPhooO0apj7S+/Xc5LSHxAfvP3a9fgIORh9o/reTnZdserZkLYG/35cot3XTqc
        /a9ZIeKCvy4uQMtvhkjO+1FHcnjtOT3p6tXXebIE6Qy4e05dJ/8WVmSAho8Py+J1
        9aD/3bFaPu+yqV16T3ey4BX13BM2bbtsjWi+CzOmz8sJGRkMqL/t0E/RVHUjm9aA
        9oAX/7C+psAltrgdwrURA48KSFe5yiyzb+G/kWXUxieVqIU2agsErGbwezVwl5qY
        ozJIW/86/dDg9dbrQd025jfb29W4Q==
X-ME-Sender: <xms:fhofYVc4NjDcSwrkWsUocQ1Bnt4ulGdSJuIOJaDdBfVXw5eN3yY_Jg>
    <xme:fhofYTND3ue24QH4ZrpC5Y5dJW9JZbavjdsyucRMV3g0yV7Vvx2lcxEAtJB8cipRB
    e_V5Cm4gpAGRpNC4w>
X-ME-Received: <xmr:fhofYejGZo4G9XbkM2Xh9he6HIChrA5EcWtoZCU3ZEwuzMJ2jZ3x5hFPFuqBkVdAv8fYHbecipRLEJX0HtyLZVvGIU0xslfFGnX46j4R_75eAJkcKTA_WsX-wQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleekgdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:fhofYe-MOstNYwS3psbp0Nd9WfwC2Lf18M1IVcsLVka8AcHvwLQZkw>
    <xmx:fhofYRuAJI0Qo1Xb86kGnwRdWgqoOPrH8oS9IiNv-faScT-LSUu71A>
    <xmx:fhofYdFpbefr-jY9pxUNPvX_z-qxPgRYgyDTXUhYx0HDJbKiKU-eWw>
    <xmx:gRofYdGS5S6pbBsv7ptKqWQ0ZEGNXU1QBKo3m6BgsHIZy2y7WB2SIw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 22:59:09 -0400 (EDT)
Subject: Re: [PATCH 15/17] arm64: allwinner: dts: add DTSI file for R329 SoC
To:     Icenowy Zheng <icenowy@sipeed.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-16-icenowy@sipeed.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <6863e247-9ae5-0f90-bf99-8989efd45352@sholland.org>
Date:   Thu, 19 Aug 2021 21:59:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210802062212.73220-16-icenowy@sipeed.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 1:22 AM, Icenowy Zheng wrote:
> Allwinner R329 is a new SoC focused on smart audio devices.
> 
> Add a DTSI file for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-r329.dtsi | 244 ++++++++++++++++++
>  1 file changed, 244 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi

One comment below.

All of my other concerns are about the CCU and RTC bindings, which I have
commented on elsewhere.

Regards,
Samuel

> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
> new file mode 100644
> index 000000000000..bfefa2b734b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-r329.dtsi
> @@ -0,0 +1,244 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2021 Sipeed
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/sun50i-r329-ccu.h>
> +#include <dt-bindings/reset/sun50i-r329-ccu.h>
> +#include <dt-bindings/clock/sun50i-r329-r-ccu.h>
> +#include <dt-bindings/reset/sun50i-r329-r-ccu.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			compatible = "arm,cortex-a53";
> +			device_type = "cpu";
> +			reg = <1>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	osc24M: osc24M_clk {
> +		#clock-cells = <0>;
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		clock-output-names = "osc24M";
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		arm,no-tick-in-suspend;
> +		interrupts = <GIC_PPI 13
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 14
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 11
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>,
> +			     <GIC_PPI 10
> +			(GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		pio: pinctrl@2000400 {
> +			compatible = "allwinner,sun50i-r329-pinctrl";
> +			reg = <0x02000400 0x400>;
> +			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,

There is an IRQ documented for port C (at SPI 70). Do those pins possibly have
interrupt capability?

> +				     <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_APB1>, <&osc24M>, <&rtc 0>;
> +			clock-names = "apb", "hosc", "losc";
> +			gpio-controller;
> +			#gpio-cells = <3>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
