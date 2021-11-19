Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04F5456D0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 11:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbhKSKQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 05:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbhKSKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 05:15:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827A4C061574;
        Fri, 19 Nov 2021 02:12:57 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r8so17188131wra.7;
        Fri, 19 Nov 2021 02:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=rEsT0X4m8zE5sAPHyHgnn2bJ48afbiU2dKo7rD4SyRI=;
        b=JtDiFVbcZBGVdAxVhvnRghYTMiZV79Y0aH76IfoLWv9bO7uk1ptSrULh/uJc8qxeIi
         z/rxUyak450RpNGUAJ2Au0+O4eRNgph6cjKqMaIHDePvSz5cMsNzV+O/ETovp9xg0dhv
         c77PjUGVGWZzhMjpggXn2qu3fZRBQQHMHWUAskG3FUvCax3w1hUDeY/W66V59k7cg6E6
         RAcgalaG7bqeaTI97kIY9GE+mlAz2ZUVI8mbatQC6RDbVrYK2bJH5wjKY+pVKb4hh91w
         dnZD9xGvtKwDjkC7rUNvPv7BUhfuWd/I9JI036VNF450g89qIs7cK91eoR3MqMmPh9nh
         6wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=rEsT0X4m8zE5sAPHyHgnn2bJ48afbiU2dKo7rD4SyRI=;
        b=V943Ia86t8GBcBOcGaq8VN/zMd43dXUfQLSHPCXOqUK7RIYgCuZWizTsJz6X3rrl1K
         W6LQilSROYRUJxzYU903KXe1NGf2bnHEKXPeD1btqRsixJmFurM77CH4484s2pUQrDnj
         uXo2dBSOl3t6/dsIZ1WAvYL+nZnCu5+eZuuj3om6NUZFVpcpWLpY9DBlVPICfIWhmqu3
         1+ZMp9xy1iNR5mPZkNaTwd2noQbXhgZ1A6b5ATHmVVl2n5D+cWcYc9xbq9Nopu4tkqGY
         M05wB12dTVh63OtutabmcdNTtBSDQWH8nQpSI55A6MvMc9hkJmFzEYl0Qsu79AlZOnFf
         GJiA==
X-Gm-Message-State: AOAM531u7E+xuc/UPA3eRwZVeUgDAzOSk1hta/UuHekPt/ldnUPsPJo0
        AOdlZx28yo1PU2IOglllD9A=
X-Google-Smtp-Source: ABdhPJwYWGmKqPCGPv71wtsqQsl5QHYfUi4F/TKDGORJnFjlxCb82u6U79JZxCeMTvj2QFfLiAM9+Q==
X-Received: by 2002:a5d:648f:: with SMTP id o15mr5683122wri.381.1637316775919;
        Fri, 19 Nov 2021 02:12:55 -0800 (PST)
Received: from [192.168.2.177] ([207.188.161.251])
        by smtp.gmail.com with ESMTPSA id s63sm2614185wme.22.2021.11.19.02.12.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 02:12:55 -0800 (PST)
Message-ID: <4537ce97-4699-4493-d4a2-416c9661b96b@gmail.com>
Date:   Fri, 19 Nov 2021 11:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
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
Subject: Re: [PATCH v5 2/2] arm64: dts: Add mediatek SoC mt8195 and evaluation
 board
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

Should be spi@1132c000

Regards,
Matthias
