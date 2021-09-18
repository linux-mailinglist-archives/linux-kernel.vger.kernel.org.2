Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B341049B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbhIRHJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 03:09:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:16275 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242021AbhIRHJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 03:09:40 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HBMMp0LF5z8snt;
        Sat, 18 Sep 2021 15:07:34 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 18 Sep 2021 15:08:14 +0800
Message-ID: <6145905D.9040800@hisilicon.com>
Date:   Sat, 18 Sep 2021 15:08:13 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: hisilicon: Add support for Hikey 970
 PMIC
References: <cover.1630583382.git.mchehab+huawei@kernel.org>    <75bd73dc3a1a7a8d08eab60d4aab34e5feb2a000.1630583382.git.mchehab+huawei@kernel.org> <20210915145131.265502f6@coco.lan>
In-Reply-To: <20210915145131.265502f6@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.166.221]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On 2021/9/15 20:51, Mauro Carvalho Chehab wrote:
> Em Thu,  2 Sep 2021 13:55:23 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
> 
>> Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
>> on HiKey970 board.
>>
>> As we now have support for it, change the fixed regulators
>> used by the SD I/O to use the proper LDO supplies.
> 
> Hi Wei,
> 
> Gentile ping.
> 
> Now that the drivers and the DT schema are already upstreamed, could 
> you please merge those two patches?

Applied the patch 1 to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

> 
> Thank you!
> Mauro
> 
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> ---
>>  .../boot/dts/hisilicon/hi3670-hikey970.dts    | 22 +----
>>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  2 +-
>>  .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 86 +++++++++++++++++++
>>  3 files changed, 90 insertions(+), 20 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>> index d8abf442ee7e..7c32f5fd5cc5 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>> @@ -12,6 +12,7 @@
>>  
>>  #include "hi3670.dtsi"
>>  #include "hikey970-pinctrl.dtsi"
>> +#include "hikey970-pmic.dtsi"
>>  
>>  / {
>>  	model = "HiKey970";
>> @@ -39,23 +40,6 @@ memory@0 {
>>  		reg = <0x0 0x0 0x0 0x0>;
>>  	};
>>  
>> -	sd_1v8: regulator-1v8 {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "fixed-1.8V";
>> -		regulator-min-microvolt = <1800000>;
>> -		regulator-max-microvolt = <1800000>;
>> -		regulator-always-on;
>> -	};
>> -
>> -	sd_3v3: regulator-3v3 {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "fixed-3.3V";
>> -		regulator-min-microvolt = <3300000>;
>> -		regulator-max-microvolt = <3300000>;
>> -		regulator-boot-on;
>> -		regulator-always-on;
>> -	};
>> -
>>  	wlan_en: wlan-en-1-8v {
>>  		compatible = "regulator-fixed";
>>  		regulator-name = "wlan-en-regulator";
>> @@ -402,8 +386,8 @@ &dwmmc1 {
>>  	pinctrl-0 = <&sd_pmx_func
>>  		     &sd_clk_cfg_func
>>  		     &sd_cfg_func>;  
>> -	vmmc-supply = <&sd_3v3>;
>> -	vqmmc-supply = <&sd_1v8>;
>> +	vmmc-supply = <&ldo16>;
>> +	vqmmc-supply = <&ldo9>;
>>  	status = "okay";
>>  };
>>  
>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>> index 20698cfd0637..636c8817df7e 100644
>> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
>> @@ -669,7 +669,7 @@ ufs: ufs@ff3c0000 {
>>  			interrupt-parent = <&gic>;
>>  			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
>>  			clocks = <&crg_ctrl HI3670_CLK_GATE_UFSIO_REF>,
>> -				<&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
>> +				 <&crg_ctrl HI3670_CLK_GATE_UFS_SUBSYS>;
>>  			clock-names = "ref_clk", "phy_clk";
>>  			freq-table-hz = <0 0
>>  					 0 0>;
>> diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
>> new file mode 100644
>> index 000000000000..970047f2dabd
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
>> + *
>> + * Copyright (C) 2020, Huawei Tech. Co., Ltd.
>> + */
>> +
>> +#include <dt-bindings/spmi/spmi.h>
>> +
>> +/ {
>> +	spmi: spmi@fff24000 {
>> +		compatible = "hisilicon,kirin970-spmi-controller";
>> +		#address-cells = <2>;
>> +		#size-cells = <0>;
>> +		status = "okay";
>> +		reg = <0x0 0xfff24000 0x0 0x1000>;
>> +		hisilicon,spmi-channel = <2>;
>> +
>> +		pmic: pmic@0 {
>> +			compatible = "hisilicon,hi6421-spmi";
>> +			reg = <0 SPMI_USID>;
>> +
>> +			#interrupt-cells = <2>;
>> +			interrupt-controller;
>> +			gpios = <&gpio28 0 0>;
>> +
>> +			regulators {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				ldo3: ldo3 { /* HDMI */
>> +					regulator-name = "ldo3";
>> +					regulator-min-microvolt = <1500000>;
>> +					regulator-max-microvolt = <2000000>;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				ldo4: ldo4 { /* 40 PIN */
>> +					regulator-name = "ldo4";
>> +					regulator-min-microvolt = <1725000>;
>> +					regulator-max-microvolt = <1900000>;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				ldo9: ldo9 { /* SDCARD I/O */
>> +					regulator-name = "ldo9";
>> +					regulator-min-microvolt = <1750000>;
>> +					regulator-max-microvolt = <3300000>;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				ldo15: ldo15 { /* UFS */
>> +					regulator-name = "ldo15";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <3000000>;
>> +					regulator-always-on;
>> +				};
>> +
>> +				ldo16: ldo16 { /* SD */
>> +					regulator-name = "ldo16";
>> +					regulator-min-microvolt = <1800000>;
>> +					regulator-max-microvolt = <3000000>;
>> +					regulator-boot-on;
>> +				};
>> +
>> +				ldo17: ldo17 { /* USB HUB */
>> +					regulator-name = "ldo17";
>> +					regulator-min-microvolt = <2500000>;
>> +					regulator-max-microvolt = <3300000>;
>> +				};
>> +
>> +				ldo33: ldo33 { /* PEX8606 */
>> +					regulator-name = "ldo33";
>> +					regulator-min-microvolt = <2500000>;
>> +					regulator-max-microvolt = <3300000>;
>> +				};
>> +
>> +				ldo34: ldo34 { /* GPS AUX IN VDD */
>> +					regulator-name = "ldo34";
>> +					regulator-min-microvolt = <2600000>;
>> +					regulator-max-microvolt = <3300000>;
>> +				};
>> +			};
>> +		};
>> +	};
>> +};
> 
> 
> 
> Thanks,
> Mauro
> .
> 
