Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA7A34A15A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhCZGBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:01:24 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42842 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhCZGBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:01:07 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 12Q60upr125895;
        Fri, 26 Mar 2021 01:00:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1616738456;
        bh=lxxdhjoqiYJiQ0CML73zLpa+aZyczWRPBxGGDpiarXg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XsRS/qDVfK+hOpk/dRzhnEWyd1vwu/F1ctgcYW1Ox218sRf2wQ8bYGwP7Orgvy0/8
         OYrvA9aZI0MbCBg0vVkpndc150HZUbuuXw1sIU/mBA2mcwRUnoSD6XBdjs39xwFOtB
         jBvY6in4wsdXQAEOzvIQ7gOQKYF7+VepKNZ0ybvE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 12Q60uCe081597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Mar 2021 01:00:56 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 26
 Mar 2021 01:00:56 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 26 Mar 2021 01:00:55 -0500
Received: from [172.24.145.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 12Q60qQW066274;
        Fri, 26 Mar 2021 01:00:53 -0500
Subject: Re: [PATCH v8 3/3] arm64: dts: ti: k3-j7200: Add support for higher
 speed modes and update delay select values for MMCSD subsystems
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210324063759.5837-1-a-govindraju@ti.com>
 <20210324063759.5837-4-a-govindraju@ti.com>
 <b8799a32-2461-988a-4a88-177e672ab64e@ti.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <6b8b71fc-7b0e-6e6a-6d2f-43087032f0b4@ti.com>
Date:   Fri, 26 Mar 2021 11:30:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b8799a32-2461-988a-4a88-177e672ab64e@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 25/03/21 9:44 pm, Kishon Vijay Abraham I wrote:
> Hi Aswath,
> 
> On 24/03/21 12:07 pm, Aswath Govindraju wrote:
>> The following speed modes are now supported in J7200 SoC,
>> - HS200 and HS400 modes at 1.8 V card voltage, in MMCSD0 subsystem [1].
>> - UHS-I speed modes in MMCSD1 subsystem [1].
>>
>> Add support for UHS-I modes by adding voltage regulator device tree nodes
>> and corresponding pinmux details, to power cycle and voltage switch cards.
>> Set respective tags in sdhci0 and remove no-1-8-v tag from sdhci1
>> device tree nodes.
>>
>> Also update the delay values for various speed modes supported, based on
>> the revised january 2021 J7200 datasheet[2].
>>
>> [1] - section 12.3.6.1.1 MMCSD Features, in
>>       https://www.ti.com/lit/ug/spruiu1a/spruiu1a.pdf,
>>       (SPRUIU1A – JULY 2020 – REVISED JANUARY 2021)
>>
>> [2] - https://www.ti.com/lit/ds/symlink/dra821u.pdf,
>>       (SPRSP57B – APRIL 2020 – REVISED JANUARY 2021)
> minor comments below.. once you fix them, please add
> 
> Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
>>

Thank you for your review :).

>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  .../dts/ti/k3-j7200-common-proc-board.dts     | 78 +++++++++++++++++++
>>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 14 +++-
>>  2 files changed, 90 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index b493f939b09a..a069787e1783 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -16,6 +16,65 @@
>>  		stdout-path = "serial2:115200n8";
>>  		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
>>  	};
>> +
>> +	evm_12v0: fixedregulator-evm12v0 {
>> +		/* main supply */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "evm_12v0";
>> +		regulator-min-microvolt = <12000000>;
>> +		regulator-max-microvolt = <12000000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vsys_3v3: fixedregulator-vsys3v3 {
>> +		/* Output of LMS140 */
> 
> %s/LMS140/LM5140

Will make this change in respin.

>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vsys_3v3";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		vin-supply = <&evm_12v0>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vsys_5v0: fixedregulator-vsys5v0 {
>> +		/* Output of LM5140 */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vsys_5v0";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		vin-supply = <&evm_12v0>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vdd_mmc1: fixedregulator-sd {
>> +		/* Output of TPS22918  */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_mmc1";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +		vin-supply = <&vsys_3v3>;
>> +		gpio = <&exp2 2 GPIO_ACTIVE_HIGH>;
>> +	};
>> +
>> +	vdd_sd_dv: gpio-regulator-vdd-sd-dv {
>> +		/* Output of TLV71033 */
> 
> Would have preferred to keep this similar to j721e.
> gpio-regulator-TLV71033 is used in j721e

Will make this change in respin

>> +		compatible = "regulator-gpio";
>> +		regulator-name = "vdd_sd_dv";
> 
> same comment here..

Will make this change in respin

>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&vdd_sd_dv_pins_default>;
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		vin-supply = <&vsys_5v0>;
>> +		gpios = <&main_gpio0 55 GPIO_ACTIVE_HIGH>;
>> +		states = <1800000 0x0>,
>> +			 <3300000 0x1>;
>> +	};
>>  };
>>  
>>  &wkup_pmx0 {
>> @@ -45,6 +104,13 @@
>>  };
>>  
>>  &main_pmx0 {
>> +	main_i2c0_pins_default: main-i2c0-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
>> +			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
>> +		>;
>> +	};
>> +
>>  	main_i2c1_pins_default: main-i2c1-pins-default {
>>  		pinctrl-single,pins = <
>>  			J721E_IOPAD(0xdc, PIN_INPUT_PULLUP, 3) /* (U3) ECAP0_IN_APWM_OUT.I2C1_SCL */
>> @@ -70,6 +136,12 @@
>>  			J721E_IOPAD(0x120, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
>>  		>;
>>  	};
>> +
>> +	vdd_sd_dv_pins_default: vdd-sd-dv-pins-default {
>> +		pinctrl-single,pins = <
>> +			J721E_IOPAD(0xd0, PIN_INPUT, 7) /* (T5) SPI0_D1.GPIO0_55 */
> 
> This should ideally be PIN_OUTPUT. Can you check the latest sysconfig?
> 

The sysconfig tool by default is giving the mode as
PIN_INPUT(bidirectional) but yes ideally this should be PIN_OUTPUT. Will
make this change in respin.

Thanks,
Aswath

> Thanks
> Kishon
> 

