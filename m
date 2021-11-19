Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C540E456D22
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234463AbhKSKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhKSKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:23:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CACC06173E;
        Fri, 19 Nov 2021 02:20:45 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i12so7993551wmq.4;
        Fri, 19 Nov 2021 02:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+7jG+bFD+kIdQ5bsHd/vlx0n62piLiUdJJXH8/IuRnc=;
        b=ci98AIudn6Z+LdqtbSTbasxcoj3jYwwXDkUXrfQHV11kYcnNryBwEzjzjH0SYqfT/X
         nvtNNz9xPgb7oNYPPeD4BSCN6EfBhEb/yM0BQiuqp9SVjnFXjWUyzdReCwurRtfK5mjK
         3KZCG9FskFppX8k19KHx2EHi5wOB2pM41feh2qjZ4cd2t7zlRrlt/i4uCIgmFzHpCfWu
         ZzOsD6xD+o1UM6aqoajA4dTpu9dczU/JiAt25pKHr3n70lP8CXNUg6FHNWiOaetlCPeS
         41MYHatChQmskX3a/VCUyTp39ZOUO2Q5L71Ayo6vOuYXYI3MYpVvPd3tP1AbecdyAgGV
         EExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+7jG+bFD+kIdQ5bsHd/vlx0n62piLiUdJJXH8/IuRnc=;
        b=RaAF1uVLbib+5uOGah1s58MT9zI6f7QsoYFJ9WbRYXnJO3oXah2Gz13GcdoJWvDxh6
         VcBwoeOS2sRl2RvLjRf/doxV3rZxK70yHGwjuGppoRN2wvEybRMtc4esLBYd8diPS3+b
         Xdtwaxl6LpKM10hTS2UdzIQD0v6RYb6Vyt1W+TGfOMwh/kdiNP1u8B3hQTuks/QZ4gzT
         9OmU2R4n3Z5xM5HCeXFYhwoV/kNc6NUCUwcQZNwHiCktMCybZHAagGMcx/KmrvtrogP0
         SPulzT021gd3MPsvFxAKtnaGbSRYSps/lyyQvbNUZUs6RNGI+nCou1U9rhSlv90vtPwT
         DVRw==
X-Gm-Message-State: AOAM531pMPvt9+odzanWY5V3jvlC1s4k/uvhBBw05MoQdzGo1ZFLkyZS
        9SHDgnEWGM9XKzdP569nPmA=
X-Google-Smtp-Source: ABdhPJy6iVB+2C45C5zoD0suEkGFaaEFoU9LHQz1SW37UEOsXKjjI31bBMtrkNvK3Z2nacQ9mYX4og==
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr5373824wmi.139.1637317243492;
        Fri, 19 Nov 2021 02:20:43 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id v15sm2515082wro.35.2021.11.19.02.20.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 02:20:42 -0800 (PST)
Message-ID: <c7f8a1d9-3166-04e3-d801-f654da019e42@gmail.com>
Date:   Fri, 19 Nov 2021 11:20:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 2/2] arm64: dts: Add mediatek SoC mt8195 and evaluation
 board
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>, robh+dt@kernel.org,
        bgolaszewski@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Seiya Wang <seiya.wang@mediatek.com>
References: <20211112050811.21202-1-tinghan.shen@mediatek.com>
 <20211112050811.21202-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20211112050811.21202-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/2021 06:08, Tinghan Shen wrote:
> Add basic chip support for mediatek mt8195.
> 
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/Makefile       |    1 +
>   arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  210 ++++
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 1044 +++++++++++++++++++
>   3 files changed, 1255 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>   create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index 4f68ebed2e31..7aa08bb4c078 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -32,4 +32,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>   dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> new file mode 100644
> index 000000000000..a620d4c3ea5d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> @@ -0,0 +1,210 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + * Author: Seiya Wang <seiya.wang@mediatek.com>
> + */
> +/dts-v1/;
> +#include "mt8195.dtsi"
> +
> +/ {
> +	model = "MediaTek MT8195 evaluation board";
> +	compatible = "mediatek,mt8195-evb", "mediatek,mt8195";
> +
> +	aliases {
> +		serial0 = &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:921600n8";
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		reg = <0 0x40000000 0 0x80000000>;
> +	};
> +};
> +
> +&auxadc {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c0_pin>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c1_pin>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c2_pin>;
> +	status = "disabled";
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c3_pin>;
> +	status = "disabled";
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c4_pin>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c5_pin>;
> +	status = "disabled";
> +};
> +
> +&i2c6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2c6_pin>;
> +	clock-frequency = <400000>;
> +	status = "disabled";
> +};
> +
> +&nor_flash {
> +	status = "okay";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&nor_pins_default>;
> +	flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <50000000>;
> +	};
> +};
> +
> +&pio {
> +	pinctrl-names = "default";
> +	i2c0_pin: i2c0_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO8__FUNC_SDA0>,
> +				 <PINMUX_GPIO9__FUNC_SCL0>;
> +			bias-pull-up = <1>;
> +			mediatek,rsel = <7>;
> +			mediatek,drive-strength-adv = <0>;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +		};
> +	};
> +	i2c1_pin: i2c1_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO10__FUNC_SDA1>,
> +				 <PINMUX_GPIO11__FUNC_SCL1>;
> +			bias-pull-up = <1>;
> +			mediatek,rsel = <7>;
> +			mediatek,drive-strength-adv = <0>;
> +			drive-strength = <MTK_DRIVE_6mA>;
> +		};
> +	};
> +	i2c2_pin: i2c2_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO12__FUNC_SDA2>,
> +				 <PINMUX_GPIO13__FUNC_SCL2>;
> +			bias-pull-up = <1>;
> +			mediatek,rsel = <7>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +	i2c3_pin: i2c3_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO14__FUNC_SDA3>,
> +				 <PINMUX_GPIO15__FUNC_SCL3>;
> +			bias-pull-up = <1>;
> +			mediatek,rsel = <7>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +	i2c4_pin: i2c4_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO16__FUNC_SDA4>,
> +				 <PINMUX_GPIO17__FUNC_SCL4>;
> +			bias-pull-up = <1>;
> +			mediatek,rsel = <7>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +	i2c5_pin: i2c5_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO29__FUNC_SCL5>,
> +				 <PINMUX_GPIO30__FUNC_SDA5>;
> +			bias-pull-up = <1>;
> +			mediatek,rsel = <7>;
> +			mediatek,drive-strength-adv = <7>;
> +		};
> +	};
> +	i2c6_pin: i2c6_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
> +				 <PINMUX_GPIO26__FUNC_SCL6>;
> +			bias-pull-up = <1>;
> +		};
> +	};
> +	i2c7_pin: i2c7_pin {
> +		pins_bus {
> +			pinmux = <PINMUX_GPIO27__FUNC_SCL7>,
> +				 <PINMUX_GPIO28__FUNC_SDA7>;
> +			bias-pull-up = <1>;
> +		};
> +	};
> +	nor_pins_default: nordefault {
> +		pins0 {
> +			pinmux = <PINMUX_GPIO142__FUNC_SPINOR_IO0>,
> +					 <PINMUX_GPIO141__FUNC_SPINOR_CK>,
> +					 <PINMUX_GPIO143__FUNC_SPINOR_IO1>;
> +			bias-pull-down;
> +		};
> +		pins1 {
> +			pinmux = <PINMUX_GPIO140__FUNC_SPINOR_CS>,
> +				     <PINMUX_GPIO130__FUNC_SPINOR_IO2>,
> +				     <PINMUX_GPIO131__FUNC_SPINOR_IO3>;
> +			bias-pull-up;
> +		};
> +	};
> +	uart0_pin: uart0_pin {
> +		uart_pins {
> +			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
> +				<PINMUX_GPIO99__FUNC_URXD0>;
> +		};
> +	};
> +};
> +
> +&u2port0 {
> +	status = "okay";
> +};
> +
> +&u2port1 {
> +	status = "okay";
> +};
> +
> +&u3phy0 {
> +	status="okay";
> +};
> +
> +&u3phy1 {
> +	status="okay";
> +};
> +
> +&u3port0 {
> +	status = "okay";
> +};
> +
> +&u3port1 {
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pin>;
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> new file mode 100644
> index 000000000000..c290189b2479
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -0,0 +1,1044 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Seiya Wang <seiya.wang@mediatek.com>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/clock/mt8195-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/phy/phy.h>
> +#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/reset/ti-syscon.h>
> +
> +/ {
> +	compatible = "mediatek,mt8195";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clk26m: oscillator0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <26000000>;
> +		clock-output-names = "clk26m";
> +	};
> +
> +	clk32k: oscillator1 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "clk32k";
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x000>;
> +			enable-method = "psci";
> +			clock-frequency = <1701000000>;
> +			capacity-dmips-mhz = <578>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +			clock-frequency = <1701000000>;
> +			capacity-dmips-mhz = <578>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +			clock-frequency = <1701000000>;
> +			capacity-dmips-mhz = <578>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55", "arm,armv8";
> +			reg = <0x300>;
> +			enable-method = "psci";
> +			clock-frequency = <1701000000>;
> +			capacity-dmips-mhz = <578>;
> +			cpu-idle-states = <&cpuoff_l &clusteroff_l>;
> +			next-level-cache = <&l2_0>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu4: cpu@400 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78", "arm,armv8";
> +			reg = <0x400>;
> +			enable-method = "psci";
> +			clock-frequency = <2171000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu5: cpu@500 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78", "arm,armv8";
> +			reg = <0x500>;
> +			enable-method = "psci";
> +			clock-frequency = <2171000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu6: cpu@600 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78", "arm,armv8";
> +			reg = <0x600>;
> +			enable-method = "psci";
> +			clock-frequency = <2171000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu7: cpu@700 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a78", "arm,armv8";
> +			reg = <0x700>;
> +			enable-method = "psci";
> +			clock-frequency = <2171000000>;
> +			capacity-dmips-mhz = <1024>;
> +			cpu-idle-states = <&cpuoff_b &clusteroff_b>;
> +			next-level-cache = <&l2_1>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu4>;
> +				};
> +				core1 {
> +					cpu = <&cpu5>;
> +				};
> +				core2 {
> +					cpu = <&cpu6>;
> +				};
> +				core3 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		idle-states {
> +			entry-method = "arm,psci";
> +			cpuoff_l: cpuoff_l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <95>;
> +				min-residency-us = <580>;
> +			};
> +			cpuoff_b: cpuoff_b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x00010001>;
> +				local-timer-stop;
> +				entry-latency-us = <45>;
> +				exit-latency-us = <140>;
> +				min-residency-us = <740>;
> +			};
> +			clusteroff_l: clusteroff_l {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010002>;
> +				local-timer-stop;
> +				entry-latency-us = <55>;
> +				exit-latency-us = <155>;
> +				min-residency-us = <840>;
> +			};
> +			clusteroff_b: clusteroff_b {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x01010002>;
> +				local-timer-stop;
> +				entry-latency-us = <50>;
> +				exit-latency-us = <200>;
> +				min-residency-us = <1000>;
> +			};
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			next-level-cache = <&l3_0>;
> +		};
> +
> +		l3_0: l3-cache {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	dsu-pmu {
> +		compatible = "arm,dsu-pmu";
> +		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH 0>;
> +		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
> +		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
> +	};
> +
> +	pmu-a55 {
> +		compatible = "arm,cortex-a55-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster0>;
> +	};
> +
> +	pmu-a78 {
> +		compatible = "arm,cortex-a78-pmu";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH &ppi_cluster1>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	timer: timer {
> +		compatible = "arm,armv8-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH 0>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH 0>;
> +		clock-frequency = <13000000>;
> +	};
> +
> +	soc {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		compatible = "simple-bus";
> +		ranges;
> +
> +		gic: interrupt-controller@c000000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <4>;
> +			#redistributor-regions = <1>;
> +			interrupt-parent = <&gic>;
> +			interrupt-controller;
> +			reg = <0 0x0c000000 0 0x40000>,
> +			      <0 0x0c040000 0 0x200000>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +			ppi-partitions {
> +				ppi_cluster0: interrupt-partition-0 {
> +					affinity = <&cpu0 &cpu1 &cpu2 &cpu3>;
> +				};
> +				ppi_cluster1: interrupt-partition-1 {
> +					affinity = <&cpu4 &cpu5 &cpu6 &cpu7>;
> +				};
> +			};
> +		};
> +
> +		topckgen: syscon@10000000 {
> +			compatible = "mediatek,mt8195-topckgen", "syscon";
> +			reg = <0 0x10000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		infracfg_ao: syscon@10001000 {
> +			compatible = "mediatek,mt8195-infracfg_ao", "syscon", "simple-mfd";
> +			reg = <0 0x10001000 0 0x1000>;
> +			#clock-cells = <1>;
> +			infracfg_rst: reset-controller {
> +				compatible = "ti,syscon-reset";
> +				#reset-cells = <1>;
> +				ti,reset-bits = <
> +					0x140 18 0x144 18 0 0 (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +					0x120 0 0x124 0 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +					0x730 10 0x734 10 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +					0x150 5 0x154 5 0 0     (ASSERT_SET | DEASSERT_SET | STATUS_NONE)
> +				>;
> +			};
> +		};
> +
> +		pericfg: syscon@10003000 {
> +			compatible = "mediatek,mt8195-pericfg", "syscon";
> +			reg = <0 0x10003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		pio: pinctrl@10005000 {
> +			compatible = "mediatek,mt8195-pinctrl";
> +			reg = <0 0x10005000 0 0x1000>,
> +			      <0 0x11d10000 0 0x1000>,
> +			      <0 0x11d30000 0 0x1000>,
> +			      <0 0x11d40000 0 0x1000>,
> +			      <0 0x11e20000 0 0x1000>,
> +			      <0 0x11eb0000 0 0x1000>,
> +			      <0 0x11f40000 0 0x1000>,
> +			      <0 0x1000b000 0 0x1000>;
> +			reg-names = "iocfg0", "iocfg_bm", "iocfg_bl",
> +				    "iocfg_br", "iocfg_lm", "iocfg_rb",
> +				    "iocfg_tl", "eint";
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&pio 0 0 144>;
> +			interrupt-controller;
> +			interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8195-wdt",
> +				     "mediatek,mt6589-wdt";
> +			reg = <0 0x10007000 0 0x100>;
> +		};
> +
> +		apmixedsys: syscon@1000c000 {
> +			compatible = "mediatek,mt8195-apmixedsys", "syscon";
> +			reg = <0 0x1000c000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		systimer: timer@10017000 {
> +			compatible = "mediatek,mt8195-timer",
> +				     "mediatek,mt6765-timer";
> +			reg = <0 0x10017000 0 0x1000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_CLK26M_D2>;
> +		};
> +
> +		pwrap: pwrap@10024000 {
> +			compatible = "mediatek,mt8195-pwrap", "syscon";
> +			reg = <0 0x10024000 0 0x1000>;
> +			reg-names = "pwrap";
> +			interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_PMIC_AP>,
> +				 <&infracfg_ao CLK_INFRA_AO_PMIC_TMR>;
> +			clock-names = "spi", "wrap";
> +			assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_ULPOSC1_D10>;
> +		};
> +
> +		scp_adsp: clock-controller@10720000 {
> +			compatible = "mediatek,mt8195-scp_adsp";
> +			reg = <0 0x10720000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		uart0: serial@11001100 {
> +			compatible = "mediatek,mt8195-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11001100 0 0x100>;
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART0>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart1: serial@11001200 {
> +			compatible = "mediatek,mt8195-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11001200 0 0x100>;
> +			interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART1>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart2: serial@11001300 {
> +			compatible = "mediatek,mt8195-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11001300 0 0x100>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART2>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart3: serial@11001400 {
> +			compatible = "mediatek,mt8195-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11001400 0 0x100>;
> +			interrupts = <GIC_SPI 723 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART3>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart4: serial@11001500 {
> +			compatible = "mediatek,mt8195-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11001500 0 0x100>;
> +			interrupts = <GIC_SPI 724 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART4>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		uart5: serial@11001600 {
> +			compatible = "mediatek,mt8195-uart",
> +				     "mediatek,mt6577-uart";
> +			reg = <0 0x11001600 0 0x100>;
> +			interrupts = <GIC_SPI 725 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&infracfg_ao CLK_INFRA_AO_UART5>;
> +			clock-names = "baud", "bus";
> +			status = "disabled";
> +		};
> +
> +		auxadc: auxadc@11002000 {
> +			compatible = "mediatek,mt8195-auxadc",
> +				     "mediatek,mt8173-auxadc";
> +			reg = <0 0x11002000 0 0x1000>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_AUXADC>;
> +			clock-names = "main";
> +			#io-channel-cells = <1>;
> +			status = "disabled";
> +		};
> +
> +		pericfg_ao: syscon@11003000 {
> +			compatible = "mediatek,mt8195-pericfg_ao", "syscon";
> +			reg = <0 0x11003000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		spi0: spi@1100a000 {
> +			compatible = "mediatek,mt8195-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100a000 0 0x1000>;
> +			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI0>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@11010000 {
> +			compatible = "mediatek,mt8195-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11010000 0 0x1000>;
> +			interrupts = <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI1>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi2: spi@11012000 {
> +			compatible = "mediatek,mt8195-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11012000 0 0x1000>;
> +			interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI2>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi3: spi@11013000 {
> +			compatible = "mediatek,mt8195-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11013000 0 0x1000>;
> +			interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI3>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi4: spi@11018000 {
> +			compatible = "mediatek,mt8195-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11018000 0 0x1000>;
> +			interrupts = <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI4>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spi5: spi@11019000 {
> +			compatible = "mediatek,mt8195-spi",
> +				     "mediatek,mt6765-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x11019000 0 0x1000>;
> +			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_UNIVPLL_D6_D2>,
> +				 <&topckgen CLK_TOP_SPI>,
> +				 <&infracfg_ao CLK_INFRA_AO_SPI5>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk";
> +			status = "disabled";
> +		};
> +
> +		spis0: spi@1101d000 {
> +			compatible = "mediatek,mt8195-spi-slave";
> +			reg = <0 0x1101d000 0 0x1000>;
> +			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_SPIS0>;
> +			clock-names = "spi";
> +			assigned-clocks = <&topckgen CLK_TOP_SPIS>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6>;
> +			status = "disabled";
> +		};
> +
> +		spis1: spi@1101e000 {
> +			compatible = "mediatek,mt8195-spi-slave";
> +			reg = <0 0x1101e000 0 0x1000>;
> +			interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_SPIS1>;
> +			clock-names = "spi";
> +			assigned-clocks = <&topckgen CLK_TOP_SPIS>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D6>;
> +			status = "disabled";
> +		};
> +
> +		xhci0: xhci@11200000 {
> +			compatible = "mediatek,mt8195-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x11200000 0 0x1000>,
> +			      <0 0x11203e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port0 PHY_TYPE_USB2>,
> +			       <&u3port0 PHY_TYPE_USB3>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
> +				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_REF>,
> +				 <&apmixedsys CLK_APMIXED_USB1PLL>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt8195-mmc",
> +				     "mediatek,mt8192-mmc",
> +				     "mediatek,mt8183-mmc";
> +			reg = <0 0x11230000 0 0x10000>,
> +			      <0 0x11f50000 0 0x1000>;
> +			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC50_0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC0_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			status = "disabled";
> +		};
> +
> +		mmc1: mmc@11240000 {
> +			compatible = "mediatek,mt8195-mmc",
> +				     "mediatek,mt8192-mmc",
> +				     "mediatek,mt8183-mmc";
> +			reg = <0 0x11240000 0 0x1000>,
> +			      <0 0x11c70000 0 0x1000>;
> +			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_1>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC1>,
> +				 <&infracfg_ao CLK_INFRA_AO_MSDC1_SRC>;
> +			clock-names = "source", "hclk", "source_cg";
> +			assigned-clocks = <&topckgen CLK_TOP_MSDC30_1>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
> +			status = "disabled";
> +		};
> +
> +		mmc2: mmc@11250000 {
> +			compatible = "mediatek,mt8195-mmc",
> +				     "mediatek,mt8192-mmc";
> +			reg = <0 0x11250000 0 0x1000>,
> +			      <0 0x11e60000 0 0x1000>;
> +			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_MSDC30_2>,
> +				 <&infracfg_ao CLK_INFRA_AO_CG1_MSDC2>,
> +				 <&infracfg_ao CLK_INFRA_AO_CG3_MSDC2>;
> +			clock-names = "source", "hclk", "source_cg";
> +			assigned-clocks = <&topckgen CLK_TOP_MSDC30_2>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_MSDCPLL_D2>;
> +			status = "disabled";
> +		};
> +
> +		xhci1: xhci1@11290000 {

should be usb@

Please run dtbs_check on the file and fix the issues. You don't have to fix 
issues that a due to the fact that we still have a txt file instead a yaml file, 
but all others should be addressed.

Thanks,
Matthias

> +			compatible = "mediatek,mt8195-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x11290000 0 0x1000>,
> +			      <0 0x11293e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port1 PHY_TYPE_USB2>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_1P>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_1P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_1P_BUS>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_1P_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_P1_REF>,
> +				 <&apmixedsys CLK_APMIXED_USB1PLL>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck", "mcu_ck";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		xhci2: xhci2@112a0000 {
> +			compatible = "mediatek,mt8195-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x112a0000 0 0x1000>,
> +			      <0 0x112a3e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port2 PHY_TYPE_USB2>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_2P>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_2P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_2P_BUS>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_2P_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_P2_REF>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck";
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		xhci3: xhci3@112b0000 {
> +			compatible = "mediatek,mt8195-xhci",
> +				     "mediatek,mtk-xhci";
> +			reg = <0 0x112b0000 0 0x1000>,
> +			      <0 0x112b3e00 0 0x0100>;
> +			reg-names = "mac", "ippc";
> +			interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
> +			phys = <&u2port3 PHY_TYPE_USB2>;
> +			assigned-clocks = <&topckgen CLK_TOP_USB_TOP_3P>,
> +					  <&topckgen CLK_TOP_SSUSB_XHCI_3P>;
> +			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
> +						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
> +			clocks = <&pericfg_ao CLK_PERI_AO_SSUSB_3P_BUS>,
> +				 <&pericfg_ao CLK_PERI_AO_SSUSB_3P_XHCI>,
> +				 <&topckgen CLK_TOP_SSUSB_P3_REF>;
> +			clock-names = "sys_ck", "xhci_ck", "ref_ck";
> +			usb2-lpm-disable;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			status = "disabled";
> +		};
> +
> +		nor_flash: nor@1132c000 {
> +			compatible = "mediatek,mt8195-nor",
> +				     "mediatek,mt8173-nor";
> +			reg = <0 0x1132c000 0 0x1000>;
> +			interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&topckgen CLK_TOP_SPINOR>,
> +				 <&pericfg_ao CLK_PERI_AO_FLASHIF_FLASH>,
> +				 <&pericfg_ao CLK_PERI_AO_FLASHIF_BUS>;
> +			clock-names = "spi", "sf", "axi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		u3phy2: t-phy@11c40000 {
> +			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x11c40000 0x700>;
> +			status = "disabled";
> +
> +			u2port2: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P2_REF>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
> +		u3phy3: t-phy@11c50000 {
> +			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x11c50000 0x700>;
> +			status = "disabled";
> +
> +			u2port3: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P3_REF>;
> +				clock-names = "ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
> +		i2c5: i2c@11d00000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11d00000 0 0x1000>,
> +			      <0 0x10220580 0 0x80>;
> +			interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C5>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c6: i2c@11d01000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11d01000 0 0x1000>,
> +			      <0 0x10220600 0 0x80>;
> +			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C6>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c7: i2c@11d02000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11d02000 0 0x1000>,
> +			      <0 0x10220680 0 0x80>;
> +			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_s CLK_IMP_IIC_WRAP_S_I2C7>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		imp_iic_wrap_s: clock-controller@11d03000 {
> +			compatible = "mediatek,mt8195-imp_iic_wrap_s";
> +			reg = <0 0x11d03000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		i2c0: i2c@11e00000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11e00000 0 0x1000>,
> +			      <0 0x10220080 0 0x80>;
> +			interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C0>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "okay";
> +		};
> +
> +		i2c1: i2c@11e01000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11e01000 0 0x1000>,
> +			      <0 0x10220200 0 0x80>;
> +			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C1>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c2: i2c@11e02000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11e02000 0 0x1000>,
> +			      <0 0x10220380 0 0x80>;
> +			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C2>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c3: i2c@11e03000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11e03000 0 0x1000>,
> +			      <0 0x10220480 0 0x80>;
> +			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C3>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		i2c4: i2c@11e04000 {
> +			compatible = "mediatek,mt8195-i2c",
> +				     "mediatek,mt8192-i2c";
> +			reg = <0 0x11e04000 0 0x1000>,
> +			      <0 0x10220500 0 0x80>;
> +			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clock-div = <1>;
> +			clocks = <&imp_iic_wrap_w CLK_IMP_IIC_WRAP_W_I2C4>,
> +				 <&infracfg_ao CLK_INFRA_AO_APDMA_B>;
> +			clock-names = "main", "dma";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		imp_iic_wrap_w: clock-controller@11e05000 {
> +			compatible = "mediatek,mt8195-imp_iic_wrap_w";
> +			reg = <0 0x11e05000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		u3phy1: t-phy@11e30000 {
> +			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x11e30000 0xe00>;
> +			status = "disabled";
> +
> +			u2port1: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_P1_REF>,
> +					 <&clk26m>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u3port1: usb-phy@700 {
> +				reg = <0x700 0x700>;
> +				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
> +					 <&topckgen CLK_TOP_SSUSB_PHY_P1_REF>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
> +		u3phy0: t-phy@11e40000 {
> +			compatible = "mediatek,mt8195-tphy", "mediatek,generic-tphy-v3";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0 0x11e40000 0xe00>;
> +			status = "disabled";
> +
> +			u2port0: usb-phy@0 {
> +				reg = <0x0 0x700>;
> +				clocks = <&topckgen CLK_TOP_SSUSB_PHY_REF>,
> +					 <&clk26m>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +
> +			u3port0: usb-phy@700 {
> +				reg = <0x700 0x700>;
> +				clocks = <&apmixedsys CLK_APMIXED_PLL_SSUSB26M>,
> +					 <&topckgen CLK_TOP_SSUSB_PHY_REF>;
> +				clock-names = "ref", "da_ref";
> +				#phy-cells = <1>;
> +			};
> +		};
> +
> +		ufsphy: phy@11fa0000 {
> +			compatible = "mediatek,mt8195-ufsphy", "mediatek,mt8183-ufsphy";
> +			reg = <0 0x11fa0000 0 0xc000>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "unipro", "mp";
> +			#phy-cells = <0>;
> +			status = "disabled";
> +		};
> +
> +		mfgcfg: clock-controller@13fbf000 {
> +			compatible = "mediatek,mt8195-mfgcfg";
> +			reg = <0 0x13fbf000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		wpesys: clock-controller@14e00000 {
> +			compatible = "mediatek,mt8195-wpesys";
> +			reg = <0 0x14e00000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		wpesys_vpp0: clock-controller@14e02000 {
> +			compatible = "mediatek,mt8195-wpesys_vpp0";
> +			reg = <0 0x14e02000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		wpesys_vpp1: clock-controller@14e03000 {
> +			compatible = "mediatek,mt8195-wpesys_vpp1";
> +			reg = <0 0x14e03000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys: clock-controller@15000000 {
> +			compatible = "mediatek,mt8195-imgsys";
> +			reg = <0 0x15000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys1_dip_top: clock-controller@15110000 {
> +			compatible = "mediatek,mt8195-imgsys1_dip_top";
> +			reg = <0 0x15110000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys1_dip_nr: clock-controller@15130000 {
> +			compatible = "mediatek,mt8195-imgsys1_dip_nr";
> +			reg = <0 0x15130000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		imgsys1_wpe: clock-controller@15220000 {
> +			compatible = "mediatek,mt8195-imgsys1_wpe";
> +			reg = <0 0x15220000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		ipesys: clock-controller@15330000 {
> +			compatible = "mediatek,mt8195-ipesys";
> +			reg = <0 0x15330000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys: clock-controller@16000000 {
> +			compatible = "mediatek,mt8195-camsys";
> +			reg = <0 0x16000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_rawa: clock-controller@1604f000 {
> +			compatible = "mediatek,mt8195-camsys_rawa";
> +			reg = <0 0x1604f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_yuva: clock-controller@1606f000 {
> +			compatible = "mediatek,mt8195-camsys_yuva";
> +			reg = <0 0x1606f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_rawb: clock-controller@1608f000 {
> +			compatible = "mediatek,mt8195-camsys_rawb";
> +			reg = <0 0x1608f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_yuvb: clock-controller@160af000 {
> +			compatible = "mediatek,mt8195-camsys_yuvb";
> +			reg = <0 0x160af000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		camsys_mraw: clock-controller@16140000 {
> +			compatible = "mediatek,mt8195-camsys_mraw";
> +			reg = <0 0x16140000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		ccusys: clock-controller@17200000 {
> +			compatible = "mediatek,mt8195-ccusys";
> +			reg = <0 0x17200000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys_soc: clock-controller@1800f000 {
> +			compatible = "mediatek,mt8195-vdecsys_soc";
> +			reg = <0 0x1800f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys: clock-controller@1802f000 {
> +			compatible = "mediatek,mt8195-vdecsys";
> +			reg = <0 0x1802f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vdecsys_core1: clock-controller@1803f000 {
> +			compatible = "mediatek,mt8195-vdecsys_core1";
> +			reg = <0 0x1803f000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		apusys_pll: clock-controller@190f3000 {
> +			compatible = "mediatek,mt8195-apusys_pll";
> +			reg = <0 0x190f3000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vencsys: clock-controller@1a000000 {
> +			compatible = "mediatek,mt8195-vencsys";
> +			reg = <0 0x1a000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +
> +		vencsys_core1: clock-controller@1b000000 {
> +			compatible = "mediatek,mt8195-vencsys_core1";
> +			reg = <0 0x1b000000 0 0x1000>;
> +			#clock-cells = <1>;
> +		};
> +	};
> +};
> 
