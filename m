Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5C53D5509
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 10:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhGZH3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 03:29:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:16001 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhGZH3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 03:29:36 -0400
Received: from dggeme758-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GYCDs0lYvzZsrC;
        Mon, 26 Jul 2021 16:06:37 +0800 (CST)
Received: from [10.40.166.221] (10.40.166.221) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 26 Jul 2021 16:10:03 +0800
Message-ID: <60FE6DDA.8080904@hisilicon.com>
Date:   Mon, 26 Jul 2021 16:10:02 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linuxarm@huawei.com>, <mauro.chehab@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "xuwei (O)" <xuwei5@huawei.com>
Subject: Re: [PATCH 1/2] dts: hisilicon: add support for the PMIC found on
 Hikey 970
References: <cover.1627116285.git.mchehab+huawei@kernel.org>    <4a3583dd683512c2a4a138e88d4c889e51bf48e8.1627116285.git.mchehab+huawei@kernel.org>     <60FE20AC.3050400@hisilicon.com>        <20210726081812.54431189@coco.lan>      <60FE57B5.2010603@hisilicon.com> <20210726094344.0a415bd0@coco.lan>
In-Reply-To: <20210726094344.0a415bd0@coco.lan>
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

On 2021/7/26 15:43, Mauro Carvalho Chehab wrote:
> Em Mon, 26 Jul 2021 14:35:33 +0800
> Wei Xu <xuwei5@hisilicon.com> escreveu:
> 
>> Hi Mauro,
>>
>> On 2021/7/26 14:19, Mauro Carvalho Chehab wrote:
>>> Em Mon, 26 Jul 2021 10:40:44 +0800
>>> Wei Xu <xuwei5@hisilicon.com> escreveu:
>>>   
>>>> Hi Mauro,
>>>>
>>>> On 2021/7/24 16:55, Mauro Carvalho Chehab wrote:  
>>>>> Add a device tree for the HiSilicon 6421v600 SPMI PMIC, used
>>>>> on HiKey970 board.
>>>>>
>>>>> As we now have support for it, change the fixed regulators
>>>>> used by the SD I/O to use the proper LDO supplies.
>>>>>
>>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>>> ---
>>>>>  .../boot/dts/hisilicon/hi3670-hikey970.dts    | 22 +----
>>>>>  .../boot/dts/hisilicon/hikey970-pmic.dtsi     | 86 +++++++++++++++++++
>>>>>  2 files changed, 89 insertions(+), 19 deletions(-)
>>>>>  create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>>>>> index d8abf442ee7e..7c32f5fd5cc5 100644
>>>>> --- a/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>>>>> +++ b/arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
>>>>> @@ -12,6 +12,7 @@
>>>>>  
>>>>>  #include "hi3670.dtsi"
>>>>>  #include "hikey970-pinctrl.dtsi"
>>>>> +#include "hikey970-pmic.dtsi"
>>>>>  
>>>>>  / {
>>>>>  	model = "HiKey970";
>>>>> @@ -39,23 +40,6 @@ memory@0 {
>>>>>  		reg = <0x0 0x0 0x0 0x0>;
>>>>>  	};
>>>>>  
>>>>> -	sd_1v8: regulator-1v8 {
>>>>> -		compatible = "regulator-fixed";
>>>>> -		regulator-name = "fixed-1.8V";
>>>>> -		regulator-min-microvolt = <1800000>;
>>>>> -		regulator-max-microvolt = <1800000>;
>>>>> -		regulator-always-on;
>>>>> -	};
>>>>> -
>>>>> -	sd_3v3: regulator-3v3 {
>>>>> -		compatible = "regulator-fixed";
>>>>> -		regulator-name = "fixed-3.3V";
>>>>> -		regulator-min-microvolt = <3300000>;
>>>>> -		regulator-max-microvolt = <3300000>;
>>>>> -		regulator-boot-on;
>>>>> -		regulator-always-on;
>>>>> -	};
>>>>> -
>>>>>  	wlan_en: wlan-en-1-8v {
>>>>>  		compatible = "regulator-fixed";
>>>>>  		regulator-name = "wlan-en-regulator";
>>>>> @@ -402,8 +386,8 @@ &dwmmc1 {
>>>>>  	pinctrl-0 = <&sd_pmx_func
>>>>>  		     &sd_clk_cfg_func    
>>>>>  		     &sd_cfg_func>;    
>>>>> -	vmmc-supply = <&sd_3v3>;
>>>>> -	vqmmc-supply = <&sd_1v8>;
>>>>> +	vmmc-supply = <&ldo16>;
>>>>> +	vqmmc-supply = <&ldo9>;
>>>>>  	status = "okay";
>>>>>  };
>>>>>  
>>>>> diff --git a/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..970047f2dabd
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi
>>>>> @@ -0,0 +1,86 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * dts file for Hi6421v600 SPMI PMIC used at the HiKey970 Development Board
>>>>> + *
>>>>> + * Copyright (C) 2020, Huawei Tech. Co., Ltd.
>>>>> + */
>>>>> +
>>>>> +#include <dt-bindings/spmi/spmi.h>
>>>>> +
>>>>> +/ {
>>>>> +	spmi: spmi@fff24000 {
>>>>> +		compatible = "hisilicon,kirin970-spmi-controller";
>>>>> +		#address-cells = <2>;
>>>>> +		#size-cells = <0>;
>>>>> +		status = "okay";
>>>>> +		reg = <0x0 0xfff24000 0x0 0x1000>;
>>>>> +		hisilicon,spmi-channel = <2>;
>>>>> +
>>>>> +		pmic: pmic@0 {
>>>>> +			compatible = "hisilicon,hi6421-spmi";    
>>>>
>>>> Should this be "hisilicon,hi6421-pmic" which is already in the binding document "mfd/hi6421.txt"?
>>>> Others are OK to me.  
>>>
>>> No. 
>>>
>>> hisilicon,hi6421-pmic is used by this driver
>>> 	drivers/mfd/hi6421-pmic-core.c
>>>
>>> which provides support for the Hi6421 variants that don't use a MIPI
>>> SPMI bus.
>>>
>>> The "hisilicon,hi6421-spmi" compatible is for the new driver:
>>> 	drivers/mfd/hi6421-spmi-pmic.c
>>>
>>> And it is defined at:
>>> 	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
>>>
>>> Both DT bindings and the driver were promoted from staging on this patch:
>>>
>>> 	https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git/commit/?h=staging-next&id=9bd9e0de1cf5b89c4854be505ac0a418ddcc01bf  
>>
>> Got it. Thanks for your kind explanation!
>> So I am fine with this patch.
>> Do you need my ack now or later I can merge it once it is out of staging.
> 
> Whatever works best for you and Greg.
> 
> It should be noticed that the driver should be out of staging for v5.15-rc1
> (as the patch moving it out of staging was already merged at Greg's tree).
> This patch is needed by the PCI driver patchset I'm currently working,
> so the best would be if this patch could also be merged for v5.15-rc1
> (either via HiSilicon tree or via staging tree).
> 
> I suspect that having your ack and merging this via staging would work
> best, as this would ensure that both changes will be merged upstream
> at the same time.
> 
> But, as I said, it is up to you both ;-)

Got it.
To avoid dependency, I think it is better to be merged by Greg's tree.
So for this patch,

Reviewed-by: Wei Xu <xuwei5@hisilicon.com>

Best Regards,
Wei

> 
> Thanks,
> Mauro
> .
> 
