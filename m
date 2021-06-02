Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC857398866
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhFBLaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhFBLas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:30:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98347C061756;
        Wed,  2 Jun 2021 04:29:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l1so3322692ejb.6;
        Wed, 02 Jun 2021 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HunnI1ZQ2e2PI4I0tqkM8S6XEuDgEHj7y+5tLpXrcfA=;
        b=UrcZ+UVKzphzbMWNayC4Pxb0bEya1xTBnx2c0Xncvh3YOccQzCzAeXBoB2aRvyYYjy
         vheHVRLAAA1hZkqNBqh7pkCKZSoRkxXBcX7Frm7TUbIjwivEkoYw/SFlZTHVyCwA6Xf3
         pTUyJb7CqB7JmfuZsEXrfXIi/AIkv6SepaserAj+R42bKcu5JMgPTEQywiZuZup0HKpC
         u/jKZFY/tnXDkBvGEXuC+IFGt0M3yv9GhHj+6tJoxPu2oEhXRNzpx4NAhE3QF+n4rJcs
         Dbb8Qp83/1X5WeE8fBTyU3eFq9b/JVUAnQXmrWUlpVuHH7bVCu0Uqd1dhgK09m9JjKTd
         v3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HunnI1ZQ2e2PI4I0tqkM8S6XEuDgEHj7y+5tLpXrcfA=;
        b=NorXP1UfJhKO09aPNRm8E/opECG29a+HiiRhrQfmAVN/2AqJ6D6BSdf657/Jvt3yZo
         Mdzldy7pwXZGl7rDsj1fnsBhoQnwwSm03ZA9LZOV1VSMMBLe4+1vaacwms/tJow9UPGE
         AO7f7dI5y7YgiwXb4P/hcbReyi3YQf+Sveo69YcLo2UzF/qxRqRsePQU+lCagdYK+Ec7
         4D+HA6ptz8xkSdYFDXqVBrhcLuMi957HkXfuyx4CiDx2xkl1YpJi9hysLV7WXHGOsld4
         67rUTDwobKelQMw67BsPE1y/GiJlbd0MQsh5n1B9HeawxuO7Fqj+RrPEZeovLjYnb0mu
         GhHA==
X-Gm-Message-State: AOAM531G8GtVas1/eVopJ/LEVxCYcrCZk03AnArJYWDyTlgVfKTL6DAn
        YwYqQYL1UXTqJGR3A9pxc8xIlxZ0b5Y=
X-Google-Smtp-Source: ABdhPJzWt3Lpk2F6hIjoklEI+4scgj0GFMgZDBwCrtxWx0q1mK6P9nYxIQSACekA8WyUnoMf2BDyrQ==
X-Received: by 2002:a17:906:4e06:: with SMTP id z6mr24351016eju.34.1622633344113;
        Wed, 02 Jun 2021 04:29:04 -0700 (PDT)
Received: from ziggy.stardust ([46.6.149.244])
        by smtp.gmail.com with ESMTPSA id u12sm5447429ejz.1.2021.06.02.04.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 04:29:03 -0700 (PDT)
To:     Seiya Wang <seiya.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
References: <20210601075350.31515-1-seiya.wang@mediatek.com>
 <20210601075350.31515-2-seiya.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [v3 1/1] arm64: dts: Add Mediatek SoC MT8195 and evaluation board
 dts and Makefile
Message-ID: <feefafa0-62b9-9e0f-d982-71b67a319064@gmail.com>
Date:   Wed, 2 Jun 2021 13:28:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601075350.31515-2-seiya.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/06/2021 09:53, Seiya Wang wrote:
> Add basic chip support for Mediatek MT8195
> 
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile       |   1 +
>  arch/arm64/boot/dts/mediatek/mt8195-evb.dts |  29 ++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi    | 561 ++++++++++++++++++++++++++++
>  3 files changed, 591 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-evb.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195.dtsi
> 
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
> index a1c50adc98fa..6044c8e46302 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -24,4 +24,5 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> new file mode 100644
> index 000000000000..82bb10e9a531
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
> @@ -0,0 +1,29 @@
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
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> new file mode 100644
> index 000000000000..8fc2af12c0f8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -0,0 +1,561 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (c) 2021 MediaTek Inc.
> + * Author: Seiya Wang <seiya.wang@mediatek.com>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +/ {
> +	compatible = "mediatek,mt8195";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		clk26m: oscillator0 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <26000000>;
> +			clock-output-names = "clk26m";
> +		};
> +
> +		clk32k: oscillator1 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +			clock-output-names = "clk32k";
> +		};
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
> +			interrupts = <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH 0>;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		watchdog: watchdog@10007000 {
> +			compatible = "mediatek,mt8195-wdt", "mediatek,mt6589-wdt";

"mediatek,mt8195-wdt" not defined in binding description. Please add patch for that.

> +			reg = <0 0x10007000 0 0x100>;
> +		};
> +
> +		systimer: timer@10017000 {
> +			compatible = "mediatek,mt8195-timer", "mediatek,mt6765-timer";
> +			reg = <0 0x10017000 0 0x1000>;
> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>;
> +		};
> +
> +		uart0: serial@11001100 {
> +			compatible = "mediatek,mt8195-uart", "mediatek,mt6577-uart";
> +			reg = <0 0x11001100 0 0x100>;
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "baud", "bus";

I'm not really a fan of having dummy clocks defined in the DTS. When can we
expect the clock controller driver to be posted/mainlined?

Regards,
Matthias
