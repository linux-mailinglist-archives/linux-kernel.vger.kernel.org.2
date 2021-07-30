Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082623DBD4C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhG3Qr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:47:56 -0400
Received: from foss.arm.com ([217.140.110.172]:44750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhG3Qrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:47:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE53F113E;
        Fri, 30 Jul 2021 09:47:49 -0700 (PDT)
Received: from slackpad.fritz.box (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35DB03F66F;
        Fri, 30 Jul 2021 09:47:48 -0700 (PDT)
Date:   Fri, 30 Jul 2021 17:47:04 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Bert Vermeulen <bert@biot.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 3/5] ARM: dts: Add basic support for EcoNet EN7523
Message-ID: <20210730174704.48c9a94f@slackpad.fritz.box>
In-Reply-To: <20210730134552.853350-4-bert@biot.com>
References: <20210730134552.853350-1-bert@biot.com>
        <20210730134552.853350-4-bert@biot.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2021 15:45:50 +0200
Bert Vermeulen <bert@biot.com> wrote:

Hi,

> From: John Crispin <john@phrozen.org>
> 
> Add basic support for EcoNet EN7523, enough for booting to console.
> 
> The UART is basically 8250-compatible, except for the clock selection.
> A clock-frequency value is synthesized to get this to run at 115200 bps.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  arch/arm/boot/dts/Makefile       |   2 +
>  arch/arm/boot/dts/en7523-evb.dts |  17 ++++
>  arch/arm/boot/dts/en7523.dtsi    | 128 +++++++++++++++++++++++++++++++
>  3 files changed, 147 insertions(+)
>  create mode 100644 arch/arm/boot/dts/en7523-evb.dts
>  create mode 100644 arch/arm/boot/dts/en7523.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 863347b6b65e..3eeb7715c6ce 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -174,6 +174,8 @@ dtb-$(CONFIG_ARCH_DAVINCI) += \
>  	da850-lego-ev3.dtb
>  dtb-$(CONFIG_ARCH_DIGICOLOR) += \
>  	cx92755_equinox.dtb
> +dtb-$(CONFIG_ARCH_ECONET) += \
> +	en7523-evb.dtb
>  dtb-$(CONFIG_ARCH_EXYNOS3) += \
>  	exynos3250-artik5-eval.dtb \
>  	exynos3250-monk.dtb \
> diff --git a/arch/arm/boot/dts/en7523-evb.dts b/arch/arm/boot/dts/en7523-evb.dts
> new file mode 100644
> index 000000000000..c5b75eb3715e
> --- /dev/null
> +++ b/arch/arm/boot/dts/en7523-evb.dts
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "en7523.dtsi"
> +
> +/ {
> +	model = "Econet EN7523 Evaluation Board";
> +	compatible = "econet,en7523-evb", "econet,en7523";
> +
> +	aliases {
> +		serial0 = &uart1;
> +	};
> +
> +	chosen {
> +		bootargs = "earlycon=uart8250,mmio32,0x1fbf0000 console=ttyS0,115200";
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/en7523.dtsi b/arch/arm/boot/dts/en7523.dtsi
> new file mode 100644
> index 000000000000..f4fe1c6f66e8
> --- /dev/null
> +++ b/arch/arm/boot/dts/en7523.dtsi
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		npu_binary@84000000 {
> +			no-map;
> +			reg = <0x84000000 0xA00000>;
> +		};
> +
> +		npu_flag@84B0000 {
> +			no-map;
> +			reg = <0x84B00000 0x100000>;
> +		};
> +
> +		npu_pkt@85000000 {
> +			no-map;
> +			reg = <0x85000000 0x1A00000>;
> +		};
> +
> +		npu_phyaddr@86B00000 {
> +			no-map;
> +			reg = <0x86B00000 0x100000>;
> +		};
> +
> +		npu_rxdesc@86D00000 {
> +			no-map;
> +			reg = <0x86D00000 0x100000>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			clock-frequency = <80000000>;
> +			next-level-cache = <&L2_0>;
> +
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			clock-frequency = <80000000>;
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache0 {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	gic: interrupt-controller@09000000 {

Please no leading zeros behind the '@', dtc should warn about this.

> +		compatible = "arm,gic-v3";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		reg = <0x09000000 0x20000>,

Mmh, 128K for the distributor, is that actually right? Is that to cover
some GIC-500 MBI aliases? I don't think we announce this in the DT,
though?

> +			  <0x09080000 0x80000>;

So this offset and length suggests there are four cores? Is that a
mistake or are there two more cores, that are possibly hidden? 

> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
> +
> +		its: gic-its@09020000 {

Another leading zero.

Cheers,
Andre


> +			compatible = "arm,gic-v3-its";
> +			msi-controller;
> +			#msi-cell = <1>;
> +			reg = <0x090200000 0x20000>;
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <25000000>;
> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x80000000 0x40000000>;
> +	};
> +
> +	uart1: serial@1fbf0000 {
> +		compatible = "ns8250";
> +		reg = <0x1fbf0000 0x30>;
> +		reg-io-width = <4>;
> +		reg-shift = <2>;
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <1843200>;
> +		status = "okay";
> +	};
> +};

