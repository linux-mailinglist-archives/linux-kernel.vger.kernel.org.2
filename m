Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9C315568
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 18:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhBIRu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 12:50:28 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:45162 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233385AbhBIRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 12:41:13 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 119HeCRm007476
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 18:40:13 +0100
Received: from [167.87.249.204] ([167.87.249.204])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 119HeBth022727;
        Tue, 9 Feb 2021 18:40:12 +0100
Subject: Re: [PATCH] arm64: dts: ti: Add support for Siemens IOT2050 boards
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Le Jin <le.jin@siemens.com>,
        Bao Cheng Su <baocheng.su@siemens.com>
References: <367f1249-700e-38f2-36de-46fb0be61c5b@siemens.com>
 <20210209144427.np6kpecc2jbh2wa7@tingling>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5dc27777-eede-c4b4-8b21-1ac15a2e2617@siemens.com>
Date:   Tue, 9 Feb 2021 18:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209144427.np6kpecc2jbh2wa7@tingling>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.21 15:44, Nishanth Menon wrote:
> Jan,
> 
> A few quick scan comments below, you might need to post based off
> 5.12-rc1 once available..
> 
> Also, I see a bit of warnings with dtbs_check, which probably needs a
> little more digging into (pcie insists to get a device_type property,
> etc..)
> 
> you could use kernel_patch_verify or https://github.com/nmenon/kernel_patch_verify/blob/master/Dockerbuild.md
> 
> it throws up a report like this https://pastebin.ubuntu.com/p/SdkZr432z3/
> 

Ok, will have a look - is that checkpatch on steroids?

> So, many of my comments below are just first pass parse of that log -> I
> usually do recommend building with W=2 and dtbs_check (with yamlint etc)
> to make sure things are a bit sane. Will be good to have additional
> eyes.
> 
> On 11:21-20210209, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Add support for two Siemens SIMATIC IOT2050 variants, Basic and
>> Advanced. They are based on the TI AM6528 and AM6548 SOCs.
>>
>> Based on original version by Le Jin.
> 
> Might be good to add links to the boards as well (if available), for
> future reference.
> 

Sure, though stability of links is not under my control. But I could
additionally drop https://github.com/siemens/meta-iot2050 here.

>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
> 
> Will be nice to see at least a pastebin link for a bootlog on the boards
> in the cover-letter / diffstat section with the v2 - for reference.
> 

Sure.

>>  .../devicetree/bindings/arm/ti/k3.yaml        |   2 +
>>  arch/arm64/boot/dts/ti/Makefile               |   4 +
>>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 649 ++++++++++++++++++
>>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  56 ++
>>  .../dts/ti/k3-am6548-iot2050-advanced.dts     |  57 ++
>>  5 files changed, 768 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> index c6e1c1e63e43..b1ab0cf4a2d6 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
>> @@ -23,6 +23,8 @@ properties:
>>          items:
>>            - enum:
>>                - ti,am654-evm
>> +              - siemens,iot2050-basic
>> +              - siemens,iot2050-advanced
> 
> - In a separate patch, ./Documentation/devicetree/bindings/vendor-prefixes.yaml -> Could you
>   make sure we add 'siemens' there?
> - and, lets move the bindings to it's own patch, since that is how Rob
>  prefers to review in https://patchwork.ozlabs.org/project/devicetree-bindings/list/
> 
> Both of these patches will need Rob to ack. I think I should be able
> to pick the first one up as well to reduce dependency, but we can
> check with Rob in case there is a preference.
> 

Ok.

>>            - const: ti,am654
>>  
>>        - description: K3 J721E SoC
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
>> index 65506f21ba30..928ea26ce250 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -8,6 +8,10 @@
>>  
>>  dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
>>  
> 
> - drop the EOL to club am65 dtbs close to each other
> 
>> +dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
>> +
> 
> - Drop this EOL as well. Something like this:
> 
> dtb-$(CONFIG_ARCH_K3) += k3-am654-base-board.dtb
> dtb-$(CONFIG_ARCH_K3) += k3-am6528-iot2050-basic.dtb
> dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
> 
> dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
> 
>> +dtb-$(CONFIG_ARCH_K3) += k3-am6548-iot2050-advanced.dtb
>> +
>>  dtb-$(CONFIG_ARCH_K3) += k3-j721e-common-proc-board.dtb
>>  
>>  dtb-$(CONFIG_ARCH_K3) += k3-j7200-common-proc-board.dtb
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> new file mode 100644
>> index 000000000000..de05937dbb60
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
>> @@ -0,0 +1,649 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Siemens AG, 2018-2021
>> + *
> 
> Optional: might be nice to add a oneliner comment for reuse scope..
> 

You mean something like "Common bits for IOT2050 basic and advanced boards"?

>> + * Authors:
>> + *   Le Jin <le.jin@siemens.com>
>> + *   Jan Kiszka <jan.kiszk@siemens.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "k3-am654.dtsi"
>> +#include <dt-bindings/phy/phy.h>
>> +
>> +/ {
>> +	aliases {
>> +		spi0 = &mcu_spi0;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial3:115200n8";
>> +		bootargs = "earlycon=ns16550a,mmio32,0x02800000";
> 
> serial3 is main_uart1, did you mean 0x02810000 instead of 0x02800000 ?

Indeed, this is 0x02810000 here. We overwrote this in our image - will
fix this occurrence.

> 
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		secure_ddr: secure_ddr@9e800000 {
> 
> "_" is not something we prefer for node names, so something like
> 	secure_ddr: secure-ddr@...
> 

Yeah, should be no problem to rename.

>> +			reg = <0 0x9e800000 0 0x01800000>; /* for OP-TEE */
>> +			alignment = <0x1000>;
>> +			no-map;
>> +		};
>> +
>> +		mcu_r5fss0_core0_dma_memory_region: r5f-dma-memory@a0000000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0 0xa0000000 0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		mcu_r5fss0_core0_memory_region: r5f-memory@a0100000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0 0xa0100000 0 0xf00000>;
>> +			no-map;
>> +		};
>> +
>> +		mcu_r5fss0_core1_dma_memory_region: r5f-dma-memory@a1000000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0 0xa1000000 0 0x100000>;
>> +			no-map;
>> +		};
>> +
>> +		mcu_r5fss0_core1_memory_region: r5f-memory@a1100000 {
>> +			compatible = "shared-dma-pool";
>> +			reg = <0 0xa1100000 0 0xf00000>;
>> +			no-map;
>> +		};
>> +
>> +		rtos_ipc_memory_region: ipc-memories@a2000000 {
>> +			reg = <0x00 0xa2000000 0x00 0x00200000>;
>> +			alignment = <0x1000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	gpio_leds {
> 
> just 'leds'?
> 
>> +		compatible = "gpio-leds";
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&leds_pins_default>;
>> +
>> +		status-led-red {
>> +			gpios = <&wkup_gpio0 32 GPIO_ACTIVE_HIGH>;
>> +			panic-indicator;
>> +			linux,default-trigger = "gpio";
>> +		};
>> +
>> +		status-led-green {
>> +			gpios = <&wkup_gpio0 24 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "gpio";
>> +		};
>> +
>> +		user-led1-red {
>> +			gpios = <&pcal9535_3 14 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "gpio";
>> +		};
>> +
>> +		user-led1-green {
>> +			gpios = <&pcal9535_2 15 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "gpio";
>> +		};
>> +
>> +		user-led2-red {
>> +			gpios = <&wkup_gpio0 17 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "gpio";
>> +		};
>> +
>> +		user-led2-green {
>> +			gpios = <&wkup_gpio0 22 GPIO_ACTIVE_HIGH>;
>> +			linux,default-trigger = "gpio";
> 
> are you sure this is "gpio" ? dtbs_check reports should be one of:
> 	['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']

Good point, never checked. None of them has a default trigger, in fact.

>> +		};
>> +	};
>> +
>> +	dp_refclk: clock {
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <19200000>;
>> +	};
>> +};
>> +
>> +&wkup_pmx0 {
>> +	wkup_i2c0_pins_default: wkup_i2c0_pins_default {
> 
> 	Here, and else where:
> 		wkup_i2c0_pins_default: wkup-i2c0-pins-default
> 
> Prefer we dont use _ in node names (rest of the pinmux node names as
> 		well).
> 
>> +		pinctrl-single,pins = <
>> +			AM65X_WKUP_IOPAD(0x00e0, PIN_INPUT,  0)  /* (AC7) WKUP_I2C0_SCL */
>> +			AM65X_WKUP_IOPAD(0x00e4, PIN_INPUT,  0)  /* (AD6) WKUP_I2C0_SDA */
>> +		>;
>> +	};
>> +
>> +	mcu_i2c0_pins_default: mcu_i2c0_pins_default {
>> +		pinctrl-single,pins = <
>> +			AM65X_IOPAD(0x0070, PIN_INPUT,  5)  /* (R25) I2C2_SDA */
> 
> [... similar issues with '_' elsewhere.. ]
> 
>> +		>;
>> +	};
>> +};
>> +
>> +&main_pmx1 {
>> +	main_i2c0_pins_default: main-i2c0-pins-default {
> 
> 	these look fine..
> 
>> +		pinctrl-single,pins = <
>> +			AM65X_IOPAD(0x0000, PIN_INPUT,  0)  /* (D20) I2C0_SCL */
>> +			AM65X_IOPAD(0x0004, PIN_INPUT,  0)  /* (C21) I2C0_SDA */
>> +		>;
>> +	};
>> +
>> +	main_i2c1_pins_default: main-i2c1-pins-default {
>> +		pinctrl-single,pins = <
>> +			AM65X_IOPAD(0x0008, PIN_INPUT,  0)  /* (B21) I2C1_SCL */
>> +			AM65X_IOPAD(0x000c, PIN_INPUT,  0)  /* (E21) I2C1_SDA */
>> +		>;
>> +	};
>> +
>> +	ecap0_pins_default: ecap0-pins-default {
>> +		pinctrl-single,pins = <
>> +			AM65X_IOPAD(0x0010, PIN_INPUT,  0)  /* (D21) ECAP0_IN_APWM_OUT */
>> +		>;
>> +	};
>> +};
>> +
>> +&wkup_uart0 {
>> +	/* Wakeup UART is used by System firmware */
>> +	status = "disabled";
> In case of reservation for firmware usage:
> status = "reserved";
> 

Ah, ok.

> [...]
> 
>> +
>> +&wkup_gpio0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <
>> +		&arduino_io_d2_to_d3_pins_default
>> +		&arduino_i2c_aio_switch_pins_default
>> +		&arduino_io_oe_pins_default
>> +		&push_button_pins_default
>> +		&db9_com_mode_pins_default
>> +	>;
>> +	gpio-line-names =
>> +		"wkup_gpio0-base", "", "", "", "UART0-mode1", "UART0-mode0",
>> +			"UART0-enable", "UART0-terminate", "", "WIFI-disable",
>> +		"", "", "", "", "", "", "", "", "", "",
>> +		"", "A4A5-I2C-mux", "", "", "", "USER-button", "", "", "","IO0",
>> +		"IO1", "IO2", "", "IO3", "IO17-direction",
>> +			"A5", "IO16-direction", "IO15-direction",
>> +			"IO14-direction", "A3",
>> +		"", "IO18-direction", "A4", "A2", "A1",
>> +			"A0", "", "", "IO13", "IO11",
>> +		"IO12", "IO10";
> 
> Any chance of intending this consistently?

There is in fact a plan behind this way: I intended every 10 entries, to
ease counting the pins (and that proved to be valuable more than once
already).

> 
>> +};
>> +
>> +&wkup_i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&wkup_i2c0_pins_default>;
>> +	clock-frequency = <400000>;
>> +};
>> +
>> +&mcu_i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_i2c0_pins_default>;
>> +	clock-frequency = <400000>;
>> +
>> +	psu: tps62363@60 {
>> +		compatible = "ti,tps62363";
>> +		reg =  <0x60>;
>> +		regulator-name = "tps62363-vout";
>> +		regulator-min-microvolt = <500000>;
>> +		regulator-max-microvolt = <1500000>;
>> +		regulator-boot-on;
>> +		/* ti,vsel0-gpio = <&gpio1 16 0>; */
>> +		/* ti,vsel1-gpio = <&gpio1 17 0>; */
> 
> Could you drop the commented out properties: above and later?
> 

Sure, missed that. Will first check again where that came from.

>> +		ti,vsel0-state-high;
>> +		ti,vsel1-state-high;
>> +		/* ti,enable-pull-down; */
>> +		/* ti,enable-force-pwm; */
>> +		ti,enable-vout-discharge;
>> +	};
>> +
>> +	/*D4200*/
> Add a space prefix and postfix? (here and below)
> /* D4200 */
> 
>> +	pcal9535_1: gpio@20 {
>> +		compatible = "nxp,pcal9535";
>> +		reg = <0x20>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		gpio-line-names =
>> +			"A0-pull", "A1-pull", "A2-pull", "A3-pull", "A4-pull",
>> +			"A5-pull", "", "",
>> +			"IO14-enable", "IO15-enable", "IO16-enable",
>> +			"IO17-enable", "IO18-enable", "IO19-enable";
>> +	};
>> +
>> +	/*D4201*/
>> +	pcal9535_2: gpio@21 {
>> +		compatible = "nxp,pcal9535";
>> +		reg = <0x21>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		gpio-line-names =
>> +			"IO0-direction", "IO1-direction", "IO2-direction",
>> +			"IO3-direction", "IO4-direction", "IO5-direction",
>> +			"IO6-direction", "IO7-direction",
>> +			"IO8-direction", "IO9-direction", "IO10-direction",
>> +			"IO11-direction", "IO12-direction", "IO13-direction",
>> +			"IO19-direction";
>> +	};
>> +
> 
> 	[...]
> 
>> +
>> +&pcie1_rc {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&minipcie_pins_default>;
>> +
>> +	num-lanes = <1>;
>> +	phys = <&serdes1 PHY_TYPE_PCIE 0>;
>> +	phy-names = "pcie-phy0";
>> +	reset-gpios = <&wkup_gpio0 27 GPIO_ACTIVE_HIGH>;
> 
> schema seems to want a device_type, and there seems to be some warnings
> 	on serdes as well.. might be something to check up on..
> 

Will try to understand. Maybe something changed between the BSP kernel
where we are coming from and the final upstream bindings, and I missed that.

>> +};
>> +
>> +&pcie1_ep {
>> +	status = "disabled";
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>> new file mode 100644
>> index 000000000000..bb9ab4fdd74e
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>> @@ -0,0 +1,56 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Siemens AG, 2018-2021
>> + *
> 
> Will be nice to explain the difference between basic and advanced dts.
> 
> Are they two different boards? looks like the basic is using a part spin
> with a single cluster, perhaps? I guess links might help..

The main difference was mentioned in the commit message: AM6528 vs.
AM6548 (dual-core, single-cluster vs. quad-core, dual-cluster).

The Advanced also has 16G eMMC, 2 GB RAM (instead of 1) and exploits
some security features (which leads to different external UART
connectivity). Will add that to the respective dts file headers.

> 
>> + * Authors:
>> + *   Le Jin <le.jin@siemens.com>
>> + *   Jan Kiszka <jan.kiszk@siemens.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "k3-am65-iot2050-common.dtsi"
>> +
>> +/ {
>> +	compatible = "siemens,iot2050-basic", "ti,am654";
>> +	model = "SIMATIC IOT2050 Basic";
>> +
>> +	memory@80000000 {
>> +		device_type = "memory";
>> +		/* 1G RAM */
>> +		reg = <0x00000000 0x80000000 0x00000000 0x40000000>;
>> +	};
>> +
>> +	cpus {
>> +		cpu-map {
>> +			/delete-node/ cluster1;
>> +		};
>> +		/delete-node/ cpu@100;
>> +		/delete-node/ cpu@101;
>> +	};
> 
> Personally, I'd prefer this (handling efuse spins in board files or
> even overlays) instead of having to create 100s of dtsi per SoC for
> every permutation & combination of TI efused devices and handle these
> in board files. I do see examples of similar usage elsewhere in:
> 
> $ git grep /delete-node/ arch/arm64/boot/dts/
> 
> But, if someone has a different opinion, feel free to pipe up with a
> reasonable way to prevent file explosion.
> 
>> +};
>> +
>> +/* eMMC */
>> +&sdhci0 {
>> +	status = "disabled";
>> +};
>> +
>> +&main_pmx0 {
>> +	main_uart0_pins_default: main_uart0_pins_default {
>> +		pinctrl-single,pins = <
>> +			AM65X_IOPAD(0x01e4, PIN_INPUT,  0)  /* (AF11) UART0_RXD */
>> +			AM65X_IOPAD(0x01e8, PIN_OUTPUT, 0)  /* (AE11) UART0_TXD */
>> +			AM65X_IOPAD(0x01ec, PIN_INPUT,  0)  /* (AG11) UART0_CTSn */
>> +			AM65X_IOPAD(0x01f0, PIN_OUTPUT, 0)  /* (AD11) UART0_RTSn */
>> +			AM65X_IOPAD(0x0188, PIN_INPUT,  1)  /* (D25) UART0_DCDn */
>> +			AM65X_IOPAD(0x018c, PIN_INPUT,  1)  /* (B26) UART0_DSRn */
>> +			AM65X_IOPAD(0x0190, PIN_OUTPUT, 1)  /* (A24) UART0_DTRn */
>> +			AM65X_IOPAD(0x0194, PIN_INPUT,  1)  /* (E24) UART0_RIN */
>> +		>;
>> +	};
>> +};
>> +
>> +&main_uart0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&main_uart0_pins_default>;
>> +};
>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>> new file mode 100644
>> index 000000000000..aa1ef081ef22
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>> @@ -0,0 +1,57 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Siemens AG, 2018-2021
>> + *
>> + * Authors:
>> + *   Le Jin <le.jin@siemens.com>
>> + *   Jan Kiszka <jan.kiszk@siemens.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "k3-am65-iot2050-common.dtsi"
> [...]
> 

Thanks for the review! Will come up with v2 soon, once all the points
are resolved.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
