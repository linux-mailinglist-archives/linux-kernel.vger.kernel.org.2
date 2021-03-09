Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C40F331FBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 08:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCIHYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 02:24:35 -0500
Received: from lizzard.sbs.de ([194.138.37.39]:55850 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhCIHYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 02:24:07 -0500
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 1297Nr9S007196
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Mar 2021 08:23:53 +0100
Received: from [139.22.125.36] ([139.22.125.36])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1297IqCA000726;
        Tue, 9 Mar 2021 08:18:52 +0100
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: Add support for Siemens IOT2050
 boards
To:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Le Jin <le.jin@siemens.com>
References: <cover.1613071976.git.jan.kiszka@siemens.com>
 <0c64b6ad43e7a691c1547524da4a9fd33e61c70c.1613071976.git.jan.kiszka@siemens.com>
 <95e4231c-6bee-ba64-412f-87d257df61c4@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0561ad0d-7297-35ad-a3a9-49dc9a6bacd3@siemens.com>
Date:   Tue, 9 Mar 2021 08:18:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <95e4231c-6bee-ba64-412f-87d257df61c4@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.03.21 07:58, Vignesh Raghavendra wrote:
> Hi,
> 
> On 2/12/21 1:02 AM, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Add support for two Siemens SIMATIC IOT2050 variants, Basic and
>> Advanced. They are based on the TI AM6528 GP and AM6548 SOCs HS, thus
>> differ in their number of cores and availability of security features.
>> Furthermore the Advanced version comes with more RAM, an eMMC and a few
>> internal differences.
>>
>> Based on original version by Le Jin.
>>
>> Link: https://new.siemens.com/global/en/products/automation/pc-based/iot-gateways/simatic-iot2050.html
>> Link: https://github.com/siemens/meta-iot2050
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> 

Thanks!

> Few minor comments below:
> 
> [...]
> 
>> +
>> +&mcu_i2c0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_i2c0_pins_default>;
>> +	clock-frequency = <400000>;
>> +
>> +	psu: tps62363@60 {
> 
> Please use generic node names:
> 
> 	psu: regulator@60 { ... };
> 

Done.

>> +		compatible = "ti,tps62363";
>> +		reg =  <0x60>;
>> +		regulator-name = "tps62363-vout";
>> +		regulator-min-microvolt = <500000>;
>> +		regulator-max-microvolt = <1500000>;
>> +		regulator-boot-on;
>> +		ti,vsel0-state-high;
>> +		ti,vsel1-state-high;
>> +		ti,enable-vout-discharge;
>> +	};
>> +
>> +	/* D4200 */
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
>> +	/* D4201 */
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
>> +	/* D4202 */
>> +	pcal9535_3: gpio@25 {
>> +		compatible = "nxp,pcal9535";
>> +		reg = <0x25>;
>> +		#gpio-cells = <2>;
>> +		gpio-controller;
>> +		gpio-line-names =
>> +			"IO0-pull", "IO1-pull", "IO2-pull", "IO3-pull",
>> +			"IO4-pull", "IO5-pull", "IO6-pull", "IO7-pull",
>> +			"IO8-pull", "IO9-pull", "IO10-pull", "IO11-pull",
>> +			"IO12-pull", "IO13-pull";
>> +	};
>> +};
> 
> [...]
> 
>> +&dwc3_0 {
>> +	status = "okay";
>> +};
>> +
>> +&usb0_phy {
>> +	status = "okay";
>> +};
>> +
> 
> These nodes are enabled by default right? Above is redundant.

Seems like historic left-overs here - fixed.

> 
>> +&usb0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb0_pins_default>;
>> +	dr_mode = "host";
>> +};
>> +
>> +&dwc3_1 {
>> +	status = "okay";
>> +};
>> +
>> +&usb1_phy {
>> +	status = "okay";
>> +};
>> +
> 
> Same here...

Also fixed.

> 
>> +&usb1 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&usb1_pins_default>;
>> +	dr_mode = "host";
>> +};
>> +
> 
> [...]
> 
>> +&mcu_spi0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_spi0_pins_default>;
>> +
>> +	#address-cells = <1>;
>> +	#size-cells= <0>;
>> +	ti,pindir-d0-out-d1-in = <1>;
>> +
>> +	spidev@0 {
>> +		compatible = "rohm,dh2228fv";
>> +		spi-max-frequency = <20000000>;
>> +		reg = <0>;
>> +	};
> 
> Is the device really dh2228fv?

At least to my understanding, "rohm,dh2228fv" is commonly used for
declaring spidev, and this is what we need for userland here.

> 
>> +};
>> +
>> +&tscadc0 {
>> +	status = "disabled";
>> +};
>> +
>> +&tscadc1 {
>> +	adc {
>> +		ti,adc-channels = <0 1 2 3 4 5>;
>> +	};
>> +};
>> +
>> +&ospi0 {
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mcu_fss0_ospi0_pins_default>;
>> +
>> +	flash@0 {
>> +		compatible = "jedec,spi-nor";
>> +		reg = <0x0>;
>> +		spi-tx-bus-width = <1>;
>> +		spi-rx-bus-width = <1>;
>> +		spi-max-frequency = <50000000>;
>> +		cdns,tshsl-ns = <60>;
>> +		cdns,tsd2d-ns = <60>;
>> +		cdns,tchsh-ns = <60>;
>> +		cdns,tslch-ns = <60>;
>> +		cdns,read-delay = <2>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +	};
>> +};
>> +
>> +&dss {
>> +	status = "okay";
>> +
> 
> Node is enabled by default. Please drop above line for consistency.

Done.

> 
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&dss_vout1_pins_default>;
>> +
>> +	assigned-clocks = <&k3_clks 67 2>;
>> +	assigned-clock-parents = <&k3_clks 67 5>;
>> +};
>> +
>> +&dss_ports {
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	port@1 {
>> +		reg = <1>;
>> +
>> +		dpi_out: endpoint {
>> +			remote-endpoint = <&bridge_in>;
>> +		};
>> +	};
>> +};
>> +
> 
> [...]
> 
> Regards
> Vignesh
> 

Thanks again, v3 will come after some testing.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux
