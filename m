Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC87537A464
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhEKKOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:14:48 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59438 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhEKKOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:14:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14BADVLq108425;
        Tue, 11 May 2021 05:13:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620728011;
        bh=y2JjfCoE8d5L3q6jw4JFDfq5P/UexxTrIO9PM1XEWfA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wCVHhk14JixmbiJ6fbQ5/NJNoVanXc2RhZnOMnm8uMkMYT6ovupVN5t3Nm5QKsPVA
         o1glgGBgnD9TefN+x3yv/8gL+A7K1DdgXiZTUuOtDHU0VBEKEGlby6SRE9ldk8G03r
         9zeJ2VSueAeBX35uXF3Yxs7F3Y7kJBeL+rNvjgcI=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14BADVbb019000
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 May 2021 05:13:31 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 11
 May 2021 05:13:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 11 May 2021 05:13:31 -0500
Received: from [10.250.235.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14BADPZ2111862;
        Tue, 11 May 2021 05:13:26 -0500
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Add support for UHS-I modes
 in MMCSD1 subsystem
To:     Jan Kiszka <jan.kiszka@siemens.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210511095339.16268-1-a-govindraju@ti.com>
 <200b5648-b2d9-b4c9-f81a-b39c3baf81f9@siemens.com>
From:   Aswath Govindraju <a-govindraju@ti.com>
Message-ID: <7561137c-adf1-bf03-c442-ff8174b2f143@ti.com>
Date:   Tue, 11 May 2021 15:43:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <200b5648-b2d9-b4c9-f81a-b39c3baf81f9@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 11/05/21 3:31 pm, Jan Kiszka wrote:
> On 11.05.21 11:53, Aswath Govindraju wrote:
>> UHS-I speed modes are supported in AM65 S.R. 2.0 SoC[1].
>>
>> Add support by removing the no-1-8-v tag and including the voltage
>> regulator device tree nodes for power cycling.
>>
>> However, the 4 bit interface of AM65 SR 1.0 cannot be supported at 3.3 V or
>> 1.8 V because of erratas i2025 and i2026 [2]. As the SD card is the primary
>> boot mode for development usecases, continue to enable SD card and disable
>> UHS-I modes in it to minimize any ageing issues happening because of
>> erratas.
>>
>> k3-am6528-iot2050-basic and k3-am6548-iot2050-advanced boards use S.R. 1.0
>> version of AM65 SoC. Therefore, add no-1-8-v in sdhci1 device tree nodes
>> for these boards.
>>
>> [1] - https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
>> [2] - https://www.ti.com/lit/er/sprz452e/sprz452e.pdf
>>
>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  1 -
>>  .../boot/dts/ti/k3-am6528-iot2050-basic.dts   |  4 +++
>>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 33 +++++++++++++++++++
>>  .../dts/ti/k3-am6548-iot2050-advanced.dts     |  4 +++
>>  4 files changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> index cb340d1b401f..632f32fce4a1 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
>> @@ -301,7 +301,6 @@
>>  		ti,otap-del-sel = <0x2>;
>>  		ti,trm-icp = <0x8>;
>>  		dma-coherent;
>> -		no-1-8-v;
>>  	};
>>  
>>  	scm_conf: scm-conf@100000 {
>> diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>> index 4f7e3f2a6265..485266960d5f 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic.dts
>> @@ -40,6 +40,10 @@
>>  	status = "disabled";
>>  };
>>  
>> +&sdhci1 {
>> +	no-1-8-v;
>> +};
>> +
> 
> Let's move that to k3-am65-iot2050-common.dtsi, to avoid repeating
> yourself. There is already a sdhci1 extension.
> 

The reason why I added these tags in board dts and not in the common
dtsi is because if it was added in the common board then for all the iot
boards this will be applicable and in future if a different version of
iot boards use S.R. 2.0 then we might have to change it again.

Thanks,
Aswath

> Jan
> 
>>  &main_pmx0 {
>>  	main_uart0_pins_default: main-uart0-pins-default {
>>  		pinctrl-single,pins = <
>> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> index 9e87fb313a54..51c594b4dddb 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
>> @@ -91,6 +91,38 @@
>>  		#clock-cells = <0>;
>>  		clock-frequency = <24000000>;
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
>> +	vcc3v3_io: fixedregulator-vcc3v3io {
>> +		/* Output of TPS54334 */
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc3v3_io";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +		vin-supply = <&evm_12v0>;
>> +	};
>> +
>> +	vdd_mmc1_sd: fixedregulator-sd {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vdd_mmc1_sd";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +		vin-supply = <&vcc3v3_io>;
>> +		gpio = <&pca9554 4 GPIO_ACTIVE_HIGH>;
>> +	};
>>  };
>>  
>>  &wkup_pmx0 {
>> @@ -350,6 +382,7 @@
>>   * disable sdhci1
>>   */
>>  &sdhci1 {
>> +	vmmc-supply = <&vdd_mmc1_sd>;
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&main_mmc1_pins_default>;
>>  	ti,driver-strength-ohm = <50>;
>> diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>> index ec9617c13cdb..3643a19b5f33 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced.dts
>> @@ -55,6 +55,10 @@
>>  	disable-wp;
>>  };
>>  
>> +&sdhci1 {
>> +	no-1-8-v;
>> +};
>> +
>>  &main_uart0 {
>>  	status = "disabled";
>>  };
>>
> 

