Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADC38D433
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 09:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbhEVHeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhEVHd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 03:33:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEEAC061574;
        Sat, 22 May 2021 00:32:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id l11-20020a05600c4f0bb029017a7cd488f5so5660973wmq.0;
        Sat, 22 May 2021 00:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WSZ2Q/Y0q3YRoddUYp+sP5TJC5PcpIK6WETfZxBFk8g=;
        b=S36AzcFneWYjgWZT59ihXTAK+LkYSOW5PWkjWRW5kvQX/up+Zw2MMnKfZCsqjKiWfU
         5b5+NJZC3Mk17kisI1gjNIJKRIkx8N+GLPTWvxX8BHgpRxnNgwkaeSNYkxgAhbCcDBFK
         oEXEUnfUq15COqKjGEHx1QV/3Y8P4MUiO4mD6NyAhhjy1P55IgReSZCnN4V9xCi7FD7C
         rQWCZQUIbwbJ5AbM1FfqeVONHmRrScOYoXCHrEibgK9E9634kLf1bewF8Rz0FPI7pRzb
         gTr4Wv4HppqwZK27PMCD5kgkdgKgaaGzwwEmsDtUEHlO2NQ3mOQcU2L90JlyEenwzEX2
         Bq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WSZ2Q/Y0q3YRoddUYp+sP5TJC5PcpIK6WETfZxBFk8g=;
        b=RgcD+VaHAfZjUZ0OvtrlUoUN6qNfnWhybxWvwa8H9TZlnDudhOgBX9hP3i1g+1ReWX
         4rJiaKNtQbiZ1xIaQt8xjMxgMflyMfpZoL8yZ6c4LFey38rYMzOyhMI/+Jr8CTvuGqzE
         eeYGu33DncnmuNm0P98YS29DQhNDu+3ZKGoelrm9Lyqk5+vuAYrjp8R8mQl0qDkE2sVP
         lf8AjTOO3a6FgzXdw9mjqZu5ibdIDEKRq1sIcsDqAPnW3/wTrcHdZ80xz5hLwLuBg4vC
         CtgGtC3twiZl0iH73Xkb50xsrq1ei7/LsnugYg2fzHQ5ztgEzshPGHfkteeeLMHTIl11
         X02A==
X-Gm-Message-State: AOAM533eYe0IGWk9ZWxoJDbrO3/pfCUXgVXb4ORanrn4dZBZsy72gN7M
        zZtL6WibSOTgeGq/FMFD3DY=
X-Google-Smtp-Source: ABdhPJzmdmK4dbOlCeYSEwnLB+uxVeYDgFALbpxtajo9rW3Iq3FbBNNEZOoOQJ8hYYL+VY6+KXa9CQ==
X-Received: by 2002:a1c:cc05:: with SMTP id h5mr12243907wmb.92.1621668753769;
        Sat, 22 May 2021 00:32:33 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-17-133.cable.triera.net. [86.58.17.133])
        by smtp.gmail.com with ESMTPSA id n6sm1669727wmq.34.2021.05.22.00.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 00:32:33 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 17/17] arm64: dts: allwinner: h616: Add X96 Mate TV box support
Date:   Sat, 22 May 2021 09:32:32 +0200
Message-ID: <2338288.Zx76mVtT47@kista>
In-Reply-To: <20210519104152.21119-18-andre.przywara@arm.com>
References: <20210519104152.21119-1-andre.przywara@arm.com> <20210519104152.21119-18-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre!

Dne sreda, 19. maj 2021 ob 12:41:52 CEST je Andre Przywara napisal(a):
> The X96 Mate is an Allwinner H616 based TV box, featuring:
>   - Four ARM Cortex-A53 cores, Mali-G31 MP2 GPU
>   - 2GiB/4GiB RAM (fully usable!)
>   - 16/32/64GiB eMMC
>   - 100Mbps Ethernet (via embedded AC200 EPHY, not yet supported)
>   - Unsupported Allwinner WiFi chip
>   - 2 x USB 2.0 host ports
>   - HDMI port
>   - IR receiver
>   - 5V/2A DC power supply via barrel plug
> 
> For more information see: https://linux-sunxi.org/X96_Mate
> 
> Add a basic devicetree for it, with SD card, eMMC and USB working, as
> well as serial and the essential peripherals, like the AXP PMIC.
> 
> This DT is somewhat minimal, and should work on many other similar TV
> boxes with the Allwinner H616 chip.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>  .../dts/allwinner/sun50i-h616-x96-mate.dts    | 201 ++++++++++++++++++
>  2 files changed, 202 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> 
> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/
allwinner/Makefile
> index 9ba4b5d92657..370d24ebaacf 100644
> --- a/arch/arm64/boot/dts/allwinner/Makefile
> +++ b/arch/arm64/boot/dts/allwinner/Makefile
> @@ -37,3 +37,4 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64-model-b.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-tanix-tx6.dtb
>  dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-orangepi-zero2.dtb
> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h616-x96-mate.dtb
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts b/arch/
arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> new file mode 100644
> index 000000000000..b960bb310289
> --- /dev/null
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616-x96-mate.dts
> @@ -0,0 +1,201 @@
> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
> +/*
> + * Copyright (C) 2021 Arm Ltd.
> + */
> +
> +/dts-v1/;
> +
> +#include "sun50i-h616.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	model = "X96 Mate";
> +	compatible = "hechuang,x96-mate", "allwinner,sun50i-h616";

Please document compatible.

Best regards,
Jernej

> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reg_vcc5v: vcc5v {
> +		/* board wide 5V supply directly from the DC input */
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc-5v";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci2 {
> +	status = "okay";
> +};
> +
> +&ir {
> +	status = "okay";
> +};
> +
> +&mmc0 {
> +	vmmc-supply = <&reg_dcdce>;
> +	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;	/* PF6 */
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&mmc2 {
> +	vmmc-supply = <&reg_dcdce>;
> +	vqmmc-supply = <&reg_bldo1>;
> +	bus-width = <8>;
> +	non-removable;
> +	cap-mmc-hw-reset;
> +	mmc-hs200-1_8v;
> +	status = "okay";
> +};
> +
> +&ohci0 {
> +	status = "okay";
> +};
> +
> +&ohci2 {
> +	status = "okay";
> +};
> +
> +&r_rsb {
> +	status = "okay";
> +
> +	axp305: pmic@745 {
> +		compatible = "x-powers,axp305", "x-powers,axp805",
> +			     "x-powers,axp806";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x745>;
> +
> +		x-powers,self-working-mode;
> +		vina-supply = <&reg_vcc5v>;
> +		vinb-supply = <&reg_vcc5v>;
> +		vinc-supply = <&reg_vcc5v>;
> +		vind-supply = <&reg_vcc5v>;
> +		vine-supply = <&reg_vcc5v>;
> +		aldoin-supply = <&reg_vcc5v>;
> +		bldoin-supply = <&reg_vcc5v>;
> +		cldoin-supply = <&reg_vcc5v>;
> +
> +		regulators {
> +			reg_aldo1: aldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc-sys";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_aldo2: aldo2 {
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc3v3-ext";
> +				status = "disabled";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_aldo3: aldo3 {
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc3v3-ext2";
> +				status = "disabled";
> +			};
> +
> +			reg_bldo1: bldo1 {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-name = "vcc1v8";
> +			};
> +
> +			/* Enabled by the Android BSP */
> +			reg_bldo2: bldo2 {
> +				regulator-min-microvolt = 
<1800000>;
> +				regulator-max-microvolt = 
<1800000>;
> +				regulator-name = "vcc1v8-2";
> +				status = "disabled";
> +			};
> +
> +			bldo3 {
> +				/* unused */
> +			};
> +
> +			bldo4 {
> +				/* unused */
> +			};
> +
> +			cldo1 {
> +				regulator-min-microvolt = 
<2500000>;
> +				regulator-max-microvolt = 
<2500000>;
> +				regulator-name = "vcc2v5";
> +			};
> +
> +			cldo2 {
> +				/* unused */
> +			};
> +
> +			cldo3 {
> +				/* unused */
> +			};
> +
> +			reg_dcdca: dcdca {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<1080000>;
> +				regulator-name = "vdd-cpu";
> +			};
> +
> +			reg_dcdcc: dcdcc {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<810000>;
> +				regulator-max-microvolt = 
<1080000>;
> +				regulator-name = "vdd-gpu-sys";
> +			};
> +
> +			reg_dcdcd: dcdcd {
> +				regulator-always-on;
> +				regulator-min-microvolt = 
<1360000>;
> +				regulator-max-microvolt = 
<1360000>;
> +				regulator-name = "vdd-dram";
> +			};
> +
> +			reg_dcdce: dcdce {
> +				regulator-boot-on;
> +				regulator-min-microvolt = 
<3300000>;
> +				regulator-max-microvolt = 
<3300000>;
> +				regulator-name = "vcc-eth-mmc";
> +			};
> +
> +			sw {
> +				/* unused */
> +			};
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_ph_pins>;
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "host";	/* USB A type receptable */
> +	status = "okay";
> +};
> +
> +&usbphy {
> +	status = "okay";
> +};
> -- 
> 2.17.5
> 
> 


