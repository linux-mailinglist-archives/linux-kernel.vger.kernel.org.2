Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90049382286
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 03:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhEQBaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 21:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhEQBay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 21:30:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CABDC061573;
        Sun, 16 May 2021 18:29:38 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b25so6722074eju.5;
        Sun, 16 May 2021 18:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tfk7idN6d8Us3CSSE9XskKFeDEhcgl+dS3ug7P80bS8=;
        b=nnbn1dsqRGedupN2zz6HPr/jbtHr7fGPU8tqQfsnNA1j7pmJQkKbdzcw5ND5az9MnI
         SLYxWjrVDlZFhejgYA5o5ple6RNTRlA38FeStpnYJKVz7cRFRA1I22HQ2kG9F60OTXSR
         +F9ezPkIoU7NXuWrUPFtHIuXGTkzELBnlyXoHPX7bqdyj+Ts2wcAMYu2Wd0DluFJATAr
         GoZGFuXzbVNR3KzZhir4Z1+w0jPy9gIzslhVbcxXtGINGUgpBPhBQsfzhKCCwl+66DWV
         tdxFWGr6QuPjxvHwcszLDg6LeAJ0GilzOiH5WjapL6OOJytte4D0wz0OvxA5n8MsHpQ9
         kk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tfk7idN6d8Us3CSSE9XskKFeDEhcgl+dS3ug7P80bS8=;
        b=OBFKO3uF5+2sGV1aMdski02fthV0uJKs1ksCvLayN84XBNsioCwCy/lAOflGsOIX6s
         g+H/yvjfLVh2vsER5VmRB1pqTNBA7UzruOcZMW9drfpJBUjYg3eMEPAfL3tHEE9/kToN
         aD7J55C62eETT4J7P5i8Y94i/giSrHO4xn5H9tcuRF7JRkUy8VaDcYMJDKO29nDrwfAN
         rfygqR7hUneNICmGYt1XQm+BmVkiz2pwbP4icc2Nphrf/B8hWiAuZL7gr9Tpnuvitz7m
         7mXF0gjBtxmX2xPHAavZsAPsrl59V9mB8bB9wHCwlw1MTJNhoylU7obRvQLMUSUWUQU8
         HAYg==
X-Gm-Message-State: AOAM530ydhYfUWeDJct6V5qbvzuN1DFY+fBr/nTU3FDoEA05tIt9OuWR
        CwPJwkFIEH0yr3mlTHSKbbSpu+v7z3I=
X-Google-Smtp-Source: ABdhPJyXGRthTcjGkL4IJZqMxkYi1ioLTjrnNMNE9okKPAez0P1oK4SGeOcUyjQ0gXfcuJWc3QCNiA==
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17mr6785404ejh.31.1621214976804;
        Sun, 16 May 2021 18:29:36 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s26sm55800edr.97.2021.05.16.18.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 May 2021 18:29:36 -0700 (PDT)
Subject: Re: [PATCH 3/9] arm64: dts: rockchip: Prepare Rockchip RK1808
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org
References: <20210516230551.12469-1-afaerber@suse.de>
 <20210516230551.12469-4-afaerber@suse.de>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <f46625ed-4c83-9fd2-52cd-e07a4d93a254@gmail.com>
Date:   Mon, 17 May 2021 03:29:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210516230551.12469-4-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Send the complete serie to all maintainers and mail lists.

===
Heiko's sort rules:

compatible
reg
interrupts
[alphabetical]
status [if needed]

===
My incomplete list:

For nodes:
If exists on top: model, compatible and chosen.
Sort things without reg alphabetical first,
then sort the rest by reg address.

Inside nodes:
If exists on top: compatible, reg and interrupts.
In alphabetical order the required properties.
Then in alphabetical order the other properties.
And as last things that start with '#' in alphabetical order.
Add status below all other properties for soc internal components with
any board-specifics.
Keep an empty line between properties and nodes.

Exceptions:
Sort pinctrl-0 above pinctrl-names, so it stays in line with clock-names
and dma-names.
Sort simple-audio-card,name above other simple-audio-card properties.
Sort regulator-name above other regulator properties.
Sort regulator-min-microvolt above regulator-max-microvolt.

===

Fix complete dtsi for property sort order!
Add more drivers. (cru, pinctrl)

Johan

On 5/17/21 1:05 AM, Andreas Färber wrote:
> Add an initial Device Tree for Rockchip RK1808 SoC.
> Based on shipping TB-RK1808M0 DTB.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  arch/arm64/boot/dts/rockchip/rk1808.dtsi | 203 +++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk1808.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk1808.dtsi b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
> new file mode 100644
> index 000000000000..af2b51afda7d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk1808.dtsi
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
> +/*
> + * Copyright (c) 2021 Andreas Färber
> + */
> +

#include <dt-bindings/clock/rk1808-cru.h>

> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "rockchip,rk1808";
> +	interrupt-parent = <&gic>;

> +	#address-cells = <1>;
> +	#size-cells = <1>;


	#address-cells = <2>;
	#size-cells = <2>;

64 bit ??

> +
> +	aliases {
> +		serial0 = &uart0;
> +		serial1 = &uart1;
> +		serial2 = &uart2;
> +		serial3 = &uart3;
> +		serial4 = &uart4;
> +		serial5 = &uart5;
> +		serial6 = &uart6;
> +		serial7 = &uart7;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a35";
> +			reg = <0x0 0x1>;
> +			enable-method = "psci";
> +			cpu-idle-states = <&CPU_SLEEP>;
> +		};
> +
> +		idle-states {
> +			entry-method = "psci";
> +
> +			CPU_SLEEP: cpu-sleep {
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x10000>;
> +				entry-latency-us = <120>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <900>;
> +			};
> +		};
> +	};
> +

> +	arm-pmu {

sort node names

> +		compatible = "arm,cortex-a35-pmu";
> +		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>, <&cpu1>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +		arm,no-tick-in-suspend;
> +	};
> +
> +	xin24m: xin24m {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		#clock-cells = <0>;
> +		clock-output-names = "xin24m";
> +	};
> +

> +	firmware {

sort node names

> +		psci {
> +			compatible = "arm,psci-1.0";
> +			method = "smc";
> +		};
> +
> +		tee {
> +			compatible = "linaro,optee-tz";
> +			method = "smc";
> +		};
> +	};
> +

> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;

Remove, use 64bit reg.
See:

https://github.com/rockchip-linux/kernel/blob/develop-4.19/arch/arm64/boot/dts/rockchip/rk1808.dtsi

> +
> +		system_sram: sram@fec00000 {
> +			compatible = "mmio-sram";
> +			reg = <0xfec00000 0x200000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xfec00000 0x200000>;
> +		};
> +
> +		gic: interrupt-controller@ff100000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0xff100000 0x10000>, /* GICD */
> +			      <0xff140000 0xc0000>, /* GICR */
> +			      <0xff300000 0x10000>, /* GICC */
> +			      <0xff310000 0x10000>, /* GICH */
> +			      <0xff320000 0x10000>; /* GICV */
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			gic_its: msi-controller@ff120000 {
> +				compatible = "arm,gic-v3-its";
> +				reg = <0xff120000 0x20000>;
> +				msi-controller;
> +				#msi-cells = <1>;
> +			};
> +		};
> +

> +		uart0: serial@ff430000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff430000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};

From manufacturer tree:

	uart0: serial@ff430000 {
		compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
		reg = <0x0 0xff430000 0x0 0x100>;
		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&cru SCLK_UART0_PMU>, <&cru PCLK_UART0_PMU>;
		clock-names = "baudclk", "apb_pclk";
		dmas = <&dmac 0>, <&dmac 1>;
		pinctrl-0 = <&uart0_xfer &uart0_cts &uart0_rts>;
		pinctrl-names = "default";
		reg-io-width = <4>;
		reg-shift = <2>;
		status = "disabled";
	};

Sort all uart nodes.

Does this work without SCLK_UART0_PMU, PCLK_UART0_PMU and pinctrl??
Add clk-rk1808.c rk1808-cru.h

In mainline pinctrl and gpio are WIP and split elsewhere now.

pinctrl: rockchip: add support for rk1808 SoCs

https://github.com/rockchip-linux/kernel/commit/b2828bc4417c9669fdaca3b8ef392f41850c86e7

> +
> +		uart1: serial@ff540000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff540000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@ff550000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff550000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@ff560000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff560000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@ff570000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff570000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@ff5a0000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff5a0000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart6: serial@ff5b0000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff5b0000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		uart7: serial@ff5c0000 {
> +			compatible = "rockchip,rk1808-uart", "snps,dw-apb-uart";
> +			reg = <0xff5c0000 0x100>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +	};
> +};
> 
