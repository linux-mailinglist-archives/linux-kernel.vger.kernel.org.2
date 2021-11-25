Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28945DE4D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356364AbhKYQKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:10:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57592 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233406AbhKYQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:08:41 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1APE64uk029721;
        Thu, 25 Nov 2021 17:05:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=pV+GDDW9DEUxt8OHkGEqSyHkuMaA/Asv/STTYSoBm4o=;
 b=Aoo/u+/VYzr0MJbvrTlAxSZvvHgm2uUCTEDqYKRKX8cg7dJohPWJ5GER/T27YXcRdQ49
 LGui6x/InIyP/D5t7klVf+7IACSU/Ob807z9RL/RS74453Q3rAmLHiR5i0Tf6ZPVsWHZ
 BZtKCKHuh+1aFokwREUmX4HdBiRMdmdstDm4nKrz+l7PGTZkLuZD8osXsVMmVxqf1RC6
 d2vDMlxXO+oxildf4uuazZQplMaPmgybOEWoYxs20yg46TROL7l9JUryJ6ceeNVWBUeG
 dHcFbhukquuZ/x5ZMpehCfQZF+2Ls1EqgxM1R/uzzJwOAtTuluZMog9Qsi46h7zNEBhj Mg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cj24vcr4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Nov 2021 17:05:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DEEE10002A;
        Thu, 25 Nov 2021 17:05:19 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 021AA226202;
        Thu, 25 Nov 2021 17:05:19 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Thu, 25 Nov
 2021 17:05:18 +0100
Subject: Re: [PATCH] arm: dts: stm32mp157c: Add support for the emtrion
 emSBC-Argon
To:     <reinhold.mueller@emtrion.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211124155410.37249-1-reinhold.mueller@emtrion.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <acbce921-8bec-2593-0a74-18f0f0b2661e@foss.st.com>
Date:   Thu, 25 Nov 2021 17:05:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124155410.37249-1-reinhold.mueller@emtrion.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-25_06,2021-11-25_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinhold

On 11/24/21 4:54 PM, reinhold.mueller@emtrion.com wrote:
> From: Reinhold Mueller <reinhold.mueller@emtrion.de>
> 
> This patch adds support for the emtrion GmbH Argon board series.
> They are available with STM32MP157 from STMicroelectronics
> with 512 MByte Memory.
> 
> The devicetree stm32mp157c-emstamp-argon.dtsi is the common part providing
> the module components and the basic support for the SoC. The support for
> the emSBC-Argon baseboard in the developer-kit configuration is provided
> by the stm32mp157c-emsbc-argon.dts file.
> 
> Signed-off-by: Reinhold Mueller <reinhold.mueller@emtrion.de>
> ---
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |   8 +
>   arch/arm/boot/dts/Makefile                    |   1 +
>   arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts |  53 ++
>   .../boot/dts/stm32mp157c-emstamp-argon.dtsi   | 665 ++++++++++++++++++
>   4 files changed, 727 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
> 

Can you split DT patches and yaml patch please? Note, for DT patches 
title should start by "ARM: dts: stm32: Add support for the stm32mp157 
emSBC-Argon'

> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> index bcaf7be3ab37..710230847dcd 100644
> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
> @@ -28,6 +28,14 @@ properties:
>             - enum:
>                 - st,stm32mp153
>                 - st,stm32mp157
> +
> +      - description: emtrion STM32MP1 Argon based Boards
> +        items:
> +          - enum:
> +              - emtrion,stm32mp157c-emsbc-argon
> +          - enum:
> +              - emtrion,stm32mp157c-emstamp-argon
> +          - const: st,stm32mp157
>         - items:
>             - enum:
>                 - st,stm32f429i-disco
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 8a2dfdf01ce3..a76226293f18 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1146,6 +1146,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>   	stm32mp157c-dhcom-picoitx.dtb \
>   	stm32mp157c-dk2.dtb \
>   	stm32mp157c-ed1.dtb \
> +	stm32mp157c-emsbc-argon.dtb \
>   	stm32mp157c-ev1.dtb \
>   	stm32mp157c-lxa-mc1.dtb \
>   	stm32mp157c-odyssey.dtb
> diff --git a/arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts b/arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts
> new file mode 100644
> index 000000000000..3ec873b1ba2d
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157c-emsbc-argon.dts
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +//
> +// Copyright (c) 2021 emtrion GmbH
> +// Author: Reinhold Müller <reinhold.mueller@emtrion.de>.
> +//
> +
> +/dts-v1/;
> +
> +#include "stm32mp157c-emstamp-argon.dtsi"
> +
> +/ {
> +	model = "emtrion STM32MP157C emSBC-Argon Developer Board";
> +	compatible = "emtrion,stm32mp157c-emsbc-argon", "emtrion,stm32mp157c-emstamp-argon",
> +			"st,stm32mp157";
> +
> +	led: gpio_leds {
> +		compatible = "gpio-leds";
> +		led2 {
> +			label = "red";
> +			gpios = <&gpiof 12 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "none";
> +			default-state = "off";
> +		};
> +		led3 {
> +			label = "green";
> +			gpios = <&gpioe 7 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "none";
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&dac {
> +	status = "okay";
> +};
> +
> +&sdmmc1 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc1_b4_pins_a>;
> +	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> +	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> +	cd-gpios = <&gpiob 7 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> +	disable-wp;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&vdd_sd>;
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	status = "okay";
> +};
> +
> diff --git a/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
> new file mode 100644
> index 000000000000..bcd6a2a687cf
> --- /dev/null
> +++ b/arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi
> @@ -0,0 +1,665 @@
> +// SPDX-License-Identifier: (GPL-2.0 or MIT)
> +//
> +// Copyright (c) 2021 emtrion GmbH
> +// Author: Reinhold Müller <reinhold.mueller@emtrion.de>.
> +//
> +
> +#include "stm32mp157.dtsi"
> +#include "stm32mp15xc.dtsi"
> +#include "stm32mp15-pinctrl.dtsi"
> +#include "stm32mp15xxac-pinctrl.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/mfd/st,stpmic1.h>
> +
> +/ {
> +	aliases {
> +		ethernet0 = &ethernet0;
> +		serial0 = &uart4;
> +		serial1 = &usart2;
> +		serial2 = &usart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory@c0000000 {
> +		device_type = "memory";
> +		reg = <0xc0000000 0x20000000>;
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mcuram2: mcuram2@10000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10000000 0x40000>;
> +			no-map;
> +		};
> +
> +		vdev0vring0: vdev0vring0@10040000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10040000 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev0vring1: vdev0vring1@10042000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10042000 0x2000>;
> +			no-map;
> +		};
> +
> +		vdev0buffer: vdev0buffer@10044000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x10044000 0x4000>;
> +			no-map;
> +		};
> +
> +		mcuram: mcuram@30000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x30000000 0x40000>;
> +			no-map;
> +		};
> +
> +		retram: retram@38000000 {
> +			compatible = "shared-dma-pool";
> +			reg = <0x38000000 0x10000>;
> +			no-map;
> +		};
> +
> +		gpu_reserved: gpu@dc000000 {
> +			reg = <0xdc000000 0x4000000>;
> +			no-map;
> +		};
> +	};
> +
> +	led: gpio_leds {
> +		compatible = "gpio-leds";
> +		led0 {

Regarding yaml file, led-0 should be used.

> +			label = "panic";
> +			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "none";
> +			default-state = "off";
> +			panic-indicator;
> +		};
> +		led1 {
> +			label = "heartbeat";
> +			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "on";
> +		};
> +	};
> +};
> +
> +&adc {
> +/*	pinctrl-names = "default"; */
> +/*	pinctrl-0 = <&adc1_in6_pins_a>; */
> +	vdd-supply = <&vdd>;
> +	vdda-supply = <&vdd>;
> +	vref-supply = <&vrefbuf>;
> +	status = "okay";
> +
> +	adc1: adc@0 {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&adc1_in6_pins_a>;
> +		st,min-sample-time-nsecs = <5000>;
> +		st,adc-channels = <6>;
> +		status = "disabled";
> +	};
> +
> +	adc2: adc@100 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		status = "okay";
> +		channel@12 {
> +			reg = <12>;
> +			label = "sense_temp";
> +			st,min-sample-time-ns = <9000>;
> +		};
> +		channel@15 {
> +			reg = <15>;
> +			label = "vbat";
> +			st,min-sample-time-ns = <9000>;
> +		};
> +		channel@16 {
> +			reg = <16>;
> +			label = "dac_out1";
> +			st,min-sample-time-ns = <9000>;
> +		};
> +		channel@17 {
> +			reg = <17>;
> +			label = "dac_out1";
> +			st,min-sample-time-ns = <9000>;
> +		};
> +	};
> +};
> +
> +&crc1 {
> +	status = "okay";
> +};
> +
> +&cryp1 {
> +	status = "okay";
> +};
> +
> +&dac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&dac_ch1_pins_a &dac_ch2_pins_a>;
> +	vref-supply = <&vdda>;
> +	status = "disabled";
> +
> +	dac1: dac@1 {
> +		status = "okay";
> +	};
> +	dac2: dac@2 {
> +		status = "okay";
> +	};
> +};
> +
> +&dts {
> +	status = "okay";
> +};
> +
> +&ethernet0 {
> +	status = "okay";
> +	snps,reset-gpio = <&gpioa 1 GPIO_ACTIVE_LOW>;
> +	snps,reset-active-low;
> +	snps,reset-delays-us = <0 30000 50000>;
> +	pinctrl-0 = <&ethernet0_rmii_pins>;
> +	pinctrl-1 = <&ethernet0_rmii_pins_sleep>;
> +	pinctrl-names = "default", "sleep";
> +	phy-mode = "rmii";
> +	max-speed = <100>;
> +	phy-handle = <&phy0>;
> +	clock-names = "stmmaceth",
> +			"mac-clk-tx",
> +			"mac-clk-rx",
> +			"ethstp",
> +			"eth-ck",
> +			"syscfg-clk";
> +	clocks = <&rcc ETHMAC>,
> +			 <&rcc ETHTX>,
> +			 <&rcc ETHRX>,
> +			 <&rcc ETHSTP>,
> +			 <&rcc ETHCK_K>,
> +			 <&rcc SYSCFG>;

Why do you update clocks here ? If one is missingit should be declared 
in stm32mp151.dtis file.

> +	st,eth-ref-clk-sel;
> +
> +	mdio0 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "snps,dwmac-mdio";
> +		phy0: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
> +&gpu {
> +	contiguous-area = <&gpu_reserved>;
> +};
> +
> +&hash1 {
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c1_pins_a>;
> +	pinctrl-1 = <&i2c1_sleep_pins_a>;
> +	i2c-scl-rising-time-ns = <100>;
> +	i2c-scl-falling-time-ns = <7>;
> +	status = "disabled";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +};
> +
> +&i2c4 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c4_pins_a>;
> +	pinctrl-1 = <&i2c4_sleep_pins_a>;
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "okay";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +
> +	pmic: stpmic@33 {
> +		compatible = "st,stpmic1";
> +		reg = <0x33>;
> +		interrupts-extended = <&gpioa 0 IRQ_TYPE_EDGE_FALLING>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		status = "okay";
> +
> +		regulators {
> +			compatible = "st,stpmic1-regulators";
> +
> +			ldo1-supply = <&v3v3>;
> +			ldo3-supply = <&vdd_ddr>;
> +			ldo6-supply = <&v3v3>;
> +			pwr_sw1-supply = <&bst_out>;
> +			pwr_sw2-supply = <&bst_out>;
> +
> +			vddcore: buck1 {
> +				regulator-name = "vddcore";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_ddr: buck2 {
> +				regulator-name = "vdd_ddr";
> +				regulator-min-microvolt = <1350000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-always-on;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd: buck3 {
> +				regulator-name = "vdd";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				st,mask-reset;
> +				regulator-initial-mode = <0>;
> +				regulator-over-current-protection;
> +			};
> +
> +			v3v3: buck4 {
> +				regulator-name = "v3v3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +				regulator-initial-mode = <0>;
> +			};
> +
> +			v1v8_audio: ldo1 {
> +				regulator-name = "v1v8_audio";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO1 0>;
> +			};
> +
> +			v3v3_hdmi: ldo2 {
> +				regulator-name = "v3v3_hdmi";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO2 0>;
> +			};
> +
> +			vtt_ddr: ldo3 {
> +				regulator-name = "vtt_ddr";
> +				regulator-min-microvolt = <500000>;
> +				regulator-max-microvolt = <750000>;
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +			};
> +
> +			vdd_usb: ldo4 {
> +				regulator-name = "vdd_usb";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				interrupts = <IT_CURLIM_LDO4 0>;
> +			};
> +
> +			vdd_sd: ldo5 {
> +				regulator-name = "vdd_sd";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				interrupts = <IT_CURLIM_LDO5 0>;
> +				regulator-always-on;
> +			};
> +
> +			vdda: ldo6 {
> +				regulator-name = "vdda";
> +				regulator-min-microvolt = <2900000>;
> +				regulator-max-microvolt = <2900000>;
> +				regulator-always-on;
> +				interrupts = <IT_CURLIM_LDO6 0>;
> +				regulator-boot-on;
> +			};
> +
> +			vref_ddr: vref_ddr {
> +				regulator-name = "vref_ddr";
> +				regulator-always-on;
> +				regulator-over-current-protection;
> +			};
> +
> +			bst_out: boost {
> +				regulator-name = "bst_out";
> +				interrupts = <IT_OCP_BOOST 0>;
> +			};
> +
> +			vbus_otg: pwr_sw1 {
> +				regulator-name = "vbus_otg";
> +				interrupts = <IT_OCP_OTG 0>;
> +				regulator-active-discharge;
> +			};
> +
> +			vbus_usbh: pwr_sw2 {
> +				regulator-name = "usbh_vbus";
> +				interrupts = <IT_OCP_SWOUT 0>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +		};
> +
> +		onkey {
> +			compatible = "st,stpmic1-onkey";
> +			interrupts = <IT_PONKEY_F 0>, <IT_PONKEY_R 1>;
> +			interrupt-names = "onkey-falling", "onkey-rising";
> +			status = "okay";
> +		};
> +
> +		watchdog {
> +			compatible = "st,stpmic1-wdt";
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&i2c5 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&i2c5_pins_a>;
> +	pinctrl-1 = <&i2c5_sleep_pins_a>;
> +	i2c-scl-rising-time-ns = <185>;
> +	i2c-scl-falling-time-ns = <20>;
> +	status = "disabled";
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +};
> +
> +&i2s2 {
> +	status = "disabled";
> +};
> +

Do you really need to set it as disabled ?


> +&ipcc {
> +	status = "okay";
> +};
> +
> +&iwdg2 {
> +	timeout-sec = <32>;
> +	status = "okay";
> +};
> +
> +&m4_rproc {
> +	memory-region = <&retram>, <&mcuram>, <&mcuram2>, <&vdev0vring0>,
> +			<&vdev0vring1>, <&vdev0buffer>;
> +	mboxes = <&ipcc 0>, <&ipcc 1>, <&ipcc 2>;
> +	mbox-names = "vq0", "vq1", "shutdown";
> +	interrupt-parent = <&exti>;
> +	interrupts = <68 1>;
> +	interrupt-names = "wdg";
> +	recovery;
> +	status = "okay";
> +};
> +
> +&pinctrl {

Add your pin configurations in stm32mp15-pinctrl please.

> +	ethernet0_rmii_pins: eth0_mx-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 5, AF0)>, /* ETH1_CLK */
> +				<STM32_PINMUX('C', 1, AF11)>, /* ETH1_MDC */
> +				<STM32_PINMUX('G', 13, AF11)>, /* ETH1_TXD0 */
> +				<STM32_PINMUX('G', 14, AF11)>; /* ETH1_TXD1 */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <1>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('A', 2, AF11)>; /* ETH1_MDIO */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins3 {
> +			pinmux = <STM32_PINMUX('A', 7, AF11)>, /* ETH1_CRS_DV */
> +				<STM32_PINMUX('C', 4, AF11)>, /* ETH1_RXD0 */
> +				<STM32_PINMUX('C', 5, AF11)>; /* ETH1_RXD1 */
> +			bias-disable;
> +		};
> +		pins4 {
> +			pinmux = <STM32_PINMUX('B', 11, AF11)>; /* ETH1_TX_EN */
> +		};
> +	};
> +
> +	ethernet0_rmii_pins_sleep: eth1_sleep_mx-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('A', 2, ANALOG)>, /* ETH1_MDIO */
> +				<STM32_PINMUX('A', 7, ANALOG)>, /* ETH1_CRS_DV */
> +				<STM32_PINMUX('B', 5, ANALOG)>, /* ETH1_CLK */
> +				<STM32_PINMUX('B', 11, ANALOG)>, /* ETH1_TX_EN */
> +				<STM32_PINMUX('C', 1, ANALOG)>, /* ETH1_MDC */
> +				<STM32_PINMUX('C', 4, ANALOG)>, /* ETH1_RXD0 */
> +				<STM32_PINMUX('C', 5, ANALOG)>, /* ETH1_RXD1 */
> +				<STM32_PINMUX('G', 13, ANALOG)>, /* ETH1_TXD0 */
> +				<STM32_PINMUX('G', 14, ANALOG)>; /* ETH1_TXD1 */
> +		};
> +	};
> +
> +	pwm1_pins_a: pwm1-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 9, AF1)>; /* TIM1_CH1 */
> +			bias-pull-down;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +	};
> +
> +	pwm1_sleep_pins_a: pwm1-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('E', 9, ANALOG)>; /* TIM1_CH1 */
> +		};
> +	};
> +
> +	usart3_pins_a: usart3-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, AF7)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, AF8)>; /* USART3_RTS */
> +			bias-disable;
> +			drive-push-pull;
> +			slew-rate = <0>;
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('D', 9, AF7)>, /* USART3_RX */
> +				 <STM32_PINMUX('D', 11, AF7)>; /* USART3_CTS_NSS */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart3_idle_pins_a: usart3-idle-0 {
> +		pins1 {
> +			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> +				 <STM32_PINMUX('D', 11, ANALOG)>; /* USART3_CTS_NSS */
> +		};
> +		pins2 {
> +			pinmux = <STM32_PINMUX('D', 9, AF7)>; /* USART3_RX */
> +			bias-disable;
> +		};
> +	};
> +
> +	usart3_sleep_pins_a: usart3-sleep-0 {
> +		pins {
> +			pinmux = <STM32_PINMUX('B', 10, ANALOG)>, /* USART3_TX */
> +				 <STM32_PINMUX('G', 8, ANALOG)>, /* USART3_RTS */
> +				 <STM32_PINMUX('D', 11, ANALOG)>, /* USART3_CTS_NSS */
> +				 <STM32_PINMUX('D', 9, ANALOG)>; /* USART3_RX */
> +		};
> +	};
> +};
> +
> +&pwr_regulators {
> +	vdd-supply = <&vdd>;
> +	vdd_3v3_usbfs-supply = <&vdd_usb>;
> +};
> +
> +&qspi {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a>;
> +	pinctrl-1 = <&qspi_clk_sleep_pins_a &qspi_bk1_sleep_pins_a>;
> +	reg = <0x58003000 0x1000>, <0x70000000 0x4000000>;
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	status = "okay";
> +
> +	flash0: is25lp016d@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <133000000>;
> +		spi-rx-bus-width = <1>;
> +		spi-tx-bus-width = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
> +&rng1 {
> +	status = "okay";
> +};
> +
> +&rtc {
> +	status = "okay";
> +};
> +
> +&sdmmc2 {
> +	arm,primecell-periphid = <0x10153180>;
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_b>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_b>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
> +	non-removable;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	status = "okay";
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi1_pins_a>;
> +	cs-gpios = <&gpioz 3 0>;
> +	status = "disabled";
> +
> +	spidev@0  {
> +		compatible = "spidev";
> +		reg = <0>;
> +		spi-max-frequency = <100000>;
> +	};
> +};
> +
> +&timers1 {
> +	/* spare dmas for other usage */
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	pwm {
> +		pinctrl-0 = <&pwm1_pins_a>;
> +		pinctrl-1 = <&pwm1_sleep_pins_a>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +	timer@0 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers4 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	pwm {
> +		pinctrl-0 = <&pwm4_pins_b>;
> +		pinctrl-1 = <&pwm4_sleep_pins_b>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +	timer@3 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers5 {
> +	/delete-property/dmas;
> +	/delete-property/dma-names;
> +	pwm {
> +		pinctrl-0 = <&pwm5_pins_a>;
> +		pinctrl-1 = <&pwm5_sleep_pins_a>;
> +		pinctrl-names = "default", "sleep";
> +		status = "okay";
> +	};
> +	timer@4 {
> +		status = "okay";
> +	};
> +};
> +
> +&uart4 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&uart4_pins_a>;
> +	pinctrl-1 = <&uart4_sleep_pins_a>;
> +	pinctrl-2 = <&uart4_idle_pins_a>;
> +	status = "okay";
> +};
> +
> +&usart2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&usart2_pins_a>;
> +	pinctrl-1 = <&usart2_sleep_pins_a>;
> +	status = "okay";
> +};
> +
> +&usart3 {
> +	pinctrl-names = "default", "sleep", "idle";
> +	pinctrl-0 = <&usart3_pins_a>;
> +	pinctrl-1 = <&usart3_sleep_pins_a>;
> +	pinctrl-2 = <&usart3_idle_pins_a>;
> +	status = "okay";
> +};
> +
> +&usbh_ehci {
> +	phys = <&usbphyc_port0>;
> +	phy-names = "usb";
> +	status = "okay";
> +};
> +
> +&usbh_ohci {
> +	phys = <&usbphyc_port0>;
> +	phy-names = "usb";
> +	status = "okay";
> +};
> +
> +&usbotg_hs {
> +	dr_mode = "peripheral";
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usbotg_hs_pins_a>;
> +	phy-names = "usb2-phy";
> +	phys = <&usbphyc_port1 0>;
> +	vbus-supply = <&vbus_otg>;
> +	status = "okay";
> +};
> +
> +&usbphyc {
> +	status = "okay";
> +};
> +
> +&usbphyc_port0 {
> +	phy-supply = <&vdd_usb>;
> +};
> +
> +&usbphyc_port1 {
> +	phy-supply = <&vdd_usb>;
> +};
> +
> +&vrefbuf {
> +	regulator-min-microvolt = <2500000>;
> +	regulator-max-microvolt = <2500000>;
> +	vdda-supply = <&vdd>;
> +	status = "okay";
> +};
> +
> 

