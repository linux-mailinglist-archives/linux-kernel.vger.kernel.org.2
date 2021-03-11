Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23A337624
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhCKOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:50:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35594 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231695AbhCKOu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:50:26 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BElDlL003812;
        Thu, 11 Mar 2021 15:50:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=oIj5JTb3v82glEXj55Nn4J0DVvuQiufP4Hz36RIgpzk=;
 b=5T5dAxa3QHdbqvP5ndelSU2/sBtFVA6/9pFTawrkTEvzONxHjpqUUlGPbMKkBObw0nsi
 ZGCWQbwyaHLZXOyVeglIR6c98xhbUQFe3bkWBy6GkLawU6N40Y6noKxRJIW2wCCI8dyl
 /Gw4LEx6qxH9VwTefSMTOietK/sMOjm9YFc/blNa1ht3jA62XPi58/qKgyXr9CoM/lZg
 yOU6/hGLbkF6J5Ij1RUBISl3Yy/RKpvbTUDlyu1pZgAsa/rpgvqwoNX4mdsAQ631al3l
 lJKpPSt2qNnxZWnBLOjWrHQyypE5dpIX6p7w/7+EKr/7sxOVGx6pOrE8C59E1ooE14sa CQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3741gpyesm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 15:50:10 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55898100034;
        Thu, 11 Mar 2021 15:50:10 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 18308248EF8;
        Thu, 11 Mar 2021 15:50:10 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Mar
 2021 15:50:08 +0100
Subject: Re: [PATCH 5/8] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to
 support stm32h75x
To:     dillon min <dillon.minfei@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux@armlinux.org.uk>, Vladimir Murzin <vladimir.murzin@arm.com>,
        <afzal.mohd.ma@gmail.com>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-6-git-send-email-dillon.minfei@gmail.com>
 <b5f96460-dcdf-f40a-89d7-89def5669d7b@foss.st.com>
 <CAL9mu0+YFC97OBNLH-gip+MFKfdX4rAaxsFB4rMNrgjmhc5=Rw@mail.gmail.com>
 <2c816d16-9925-c52f-6ead-a0112026df28@foss.st.com>
 <CAL9mu0KfwL2W-WytH+EjAf6g-tebuJ3wut8AuZ1trvHFdwRW4Q@mail.gmail.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
Message-ID: <f52209c4-01cb-7574-dcf6-cee42b5898ac@foss.st.com>
Date:   Thu, 11 Mar 2021 15:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL9mu0KfwL2W-WytH+EjAf6g-tebuJ3wut8AuZ1trvHFdwRW4Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_05:2021-03-10,2021-03-11 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/21 3:32 PM, dillon min wrote:
> Hi Alexandre
> 
> On Thu, Mar 11, 2021 at 9:30 PM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>> Hi Dillon
>>
>> On 3/11/21 1:23 PM, dillon min wrote:
>>> Hi Alexandre
>>>
>>> On Thu, Mar 11, 2021 at 6:40 PM Alexandre TORGUE
>>> <alexandre.torgue@foss.st.com> wrote:
>>>>
>>>> Hi Dillon
>>>>
>>>> On 3/3/21 9:05 AM, dillon.minfei@gmail.com wrote:
>>>>> From: dillon min <dillon.minfei@gmail.com>
>>>>>
>>>>> To support stm32h750 and stm32h743, we need a base stm32h7-pinctrl.dtsi
>>>>> as stm32h743 & h750 has almost the same interface. so, just rename
>>>>> stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
>>>>>
>>>>
>>>> You do not "just" rename but you keel also the old version. I don't
>>>> agree with this approach. You have first to rename
>>>> stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (keeping copyright as
>>>> they are please) and modify existing H7 boards which currently use
>>>> stm32h743-pinctrl.dtsi.
>>>> Then you create a second patch adding your pingroups.
>>> For stm32h7's new board support , I guess following the stm32f7/stm32f4's style
>>
>> Yes sorry, I read it too quickly
>>
>>> is a reasonable way to do it, but add a little optimization。
>>> which means :
>>> old structure
>>> stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi  (referenced by
>>> stm32h743i-disco, -eval)
>>>                                   |--> stm32h750-pinctrl.dtsi
>>> (referenced by stm32h750i-art-pi, etc)
>>> add art-pi other board's pin definition in stm32h750-pinctrl.dtsi with
>>> xxx_pins_a, xxx_pins_b
>>> xxx_pins_a used for art-pi, xxx_pins_b used for other boards.
>>>
>>> after more boards add in support, there will be more xxx_pin_c, .... defined
>>>
>>> as the pin map is according to the hardware schematic diagram io connection.
>>> so, why not move xxx_pin_x to a board specific place. such as
>>> stm32h750i-art-pi.dts
>>>
>>> new structure:
>>> 1, rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (only
>>> preserve gpioa...k,)
>>> 2, move xxx_pins_x from stm32h7-pinctrl.dtsi to
>>> stm32h7xx-disco/eval/art-pi/etc.dts (as they depends on hardware
>>> schematic)
>>>
>>> stm32h7-pinctrl.dtsi --> stm32h743i-discon.dts
>>>                                   |--> stm32h743i-eval.dts
>>>                                   |--> stm32h750i-art-pi.dts
>>>                                   |--> stm32h7xxx.dts
>>> would you agree this ?
>>
>> :) it remember me an old discussion we had with Ahmad or Marek. My first
>> feeling is "The group definition follow the SoC, and the group choice is
>> done on the board". But As said in the past I have to think more about
>> this topic and check how it could be reorganize (as it would be nice to
>> have the same approach for MPU and MCU boards.) I'll try to post
>> something soon. Waiting that this patch looks. As you mainly change the
>> name can you keep please header (copyright) as they were initially.
> Okay, got it. before your patch for pinctrl update. I am just totally following
> your current style.
> For file author name, copyright. i'm really sorry for that. this is
> the first time for me
> to add a board support, i'm not intended to replace with my name, just too
> many files to change, wasn't beware of the difference with author name for new
> created file and existing file . will be changed back in the next submit.

No problem Dillon, it is minor comments, anyway thanks for adding this 
new STM32 SoC.

Regards

>>>>
>>>> Now regarding "st,stm32h750-pinctrl", I see a patch dealing with this
>>>> new binding but no update on driver side. Do I miss something ? what are
>>>> differences between h743 and h750 regarding pinctrl ?
>>> Oh, i forget to add pin driver under drivers/pinctrl/stm32/
>>> will add it next time.
>>>>
>>>> Regards
>>>> Alex
>>>>
>>>>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
>>>>> ---
>>>>>     arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 392 +++++++++++++++++++++++++++++++
>>>>>     arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 307 +-----------------------
>>>>>     2 files changed, 398 insertions(+), 301 deletions(-)
>>>>>     create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
>>>>>
>>>>> diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
>>>>> new file mode 100644
>>>>> index 000000000000..7d4b5d683ccc
>>>>> --- /dev/null
>>>>> +++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
>>>>> @@ -0,0 +1,392 @@
>>>>> +/*
>>>>> + * Copyright 2021 - Dillon Min <dillon.minfei@gmail.com>
>>>>> + *
>>>>> + * This file is dual-licensed: you can use it either under the terms
>>>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>>>> + * licensing only applies to this file, and not this project as a
>>>>> + * whole.
>>>>> + *
>>>>> + *  a) This file is free software; you can redistribute it and/or
>>>>> + *     modify it under the terms of the GNU General Public License as
>>>>> + *     published by the Free Software Foundation; either version 2 of the
>>>>> + *     License, or (at your option) any later version.
>>>>> + *
>>>>> + *     This file is distributed in the hope that it will be useful,
>>>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> + *     GNU General Public License for more details.
>>>>> + *
>>>>> + * Or, alternatively,
>>>>> + *
>>>>> + *  b) Permission is hereby granted, free of charge, to any person
>>>>> + *     obtaining a copy of this software and associated documentation
>>>>> + *     files (the "Software"), to deal in the Software without
>>>>> + *     restriction, including without limitation the rights to use,
>>>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>>>> + *     sell copies of the Software, and to permit persons to whom the
>>>>> + *     Software is furnished to do so, subject to the following
>>>>> + *     conditions:
>>>>> + *
>>>>> + *     The above copyright notice and this permission notice shall be
>>>>> + *     included in all copies or substantial portions of the Software.
>>>>> + *
>>>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>>>> + */
>>>>> +
>>>>> +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
>>>>> +
>>>>> +/ {
>>>>> +     soc {
>>>>> +             pinctrl: pin-controller {
>>>>> +                     #address-cells = <1>;
>>>>> +                     #size-cells = <1>;
>>>>> +                     ranges = <0 0x58020000 0x3000>;
>>>>> +                     interrupt-parent = <&exti>;
>>>>> +                     st,syscfg = <&syscfg 0x8>;
>>>>> +                     pins-are-numbered;
>>>>> +
>>>>> +                     gpioa: gpio@58020000 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x0 0x400>;
>>>>> +                             clocks = <&rcc GPIOA_CK>;
>>>>> +                             st,bank-name = "GPIOA";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpiob: gpio@58020400 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x400 0x400>;
>>>>> +                             clocks = <&rcc GPIOB_CK>;
>>>>> +                             st,bank-name = "GPIOB";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpioc: gpio@58020800 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x800 0x400>;
>>>>> +                             clocks = <&rcc GPIOC_CK>;
>>>>> +                             st,bank-name = "GPIOC";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpiod: gpio@58020c00 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0xc00 0x400>;
>>>>> +                             clocks = <&rcc GPIOD_CK>;
>>>>> +                             st,bank-name = "GPIOD";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpioe: gpio@58021000 {
>>>>> +                             gpio-controller;
>>>
>>>>> +                             reg = <0x1000 0x400>;
>>>>> +                             clocks = <&rcc GPIOE_CK>;
>>>>> +                             st,bank-name = "GPIOE";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpiof: gpio@58021400 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x1400 0x400>;
>>>>> +                             clocks = <&rcc GPIOF_CK>;
>>>>> +                             st,bank-name = "GPIOF";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpiog: gpio@58021800 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x1800 0x400>;
>>>>> +                             clocks = <&rcc GPIOG_CK>;
>>>>> +                             st,bank-name = "GPIOG";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpioh: gpio@58021c00 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x1c00 0x400>;
>>>>> +                             clocks = <&rcc GPIOH_CK>;
>>>>> +                             st,bank-name = "GPIOH";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpioi: gpio@58022000 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x2000 0x400>;
>>>>> +                             clocks = <&rcc GPIOI_CK>;
>>>>> +                             st,bank-name = "GPIOI";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpioj: gpio@58022400 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x2400 0x400>;
>>>>> +                             clocks = <&rcc GPIOJ_CK>;
>>>>> +                             st,bank-name = "GPIOJ";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     gpiok: gpio@58022800 {
>>>>> +                             gpio-controller;
>>>>> +                             #gpio-cells = <2>;
>>>>> +                             reg = <0x2800 0x400>;
>>>>> +                             clocks = <&rcc GPIOK_CK>;
>>>>> +                             st,bank-name = "GPIOK";
>>>>> +                             interrupt-controller;
>>>>> +                             #interrupt-cells = <2>;
>>>>> +                     };
>>>>> +
>>>>> +                     i2c1_pins_a: i2c1-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
>>>>> +                                              <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
>>>>> +                                     bias-disable;
>>>>> +                                     drive-open-drain;
>>>>> +                                     slew-rate = <0>;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     ethernet_rmii: rmii-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('G', 11, AF11)>,
>>>>> +                                              <STM32_PINMUX('G', 13, AF11)>,
>>>>> +                                              <STM32_PINMUX('G', 12, AF11)>,
>>>>> +                                              <STM32_PINMUX('C', 4, AF11)>,
>>>>> +                                              <STM32_PINMUX('C', 5, AF11)>,
>>>>> +                                              <STM32_PINMUX('A', 7, AF11)>,
>>>>> +                                              <STM32_PINMUX('C', 1, AF11)>,
>>>>> +                                              <STM32_PINMUX('A', 2, AF11)>,
>>>>> +                                              <STM32_PINMUX('A', 1, AF11)>;
>>>>> +                                     slew-rate = <2>;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>>>>> +                                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
>>>>> +                                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
>>>>> +                                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
>>>>> +                                              <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
>>>>> +                                              <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
>>>>> +                                     slew-rate = <3>;
>>>>> +                                     drive-push-pull;
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>>>>> +                                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
>>>>> +                                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
>>>>> +                                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
>>>>> +                                              <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
>>>>> +                                     slew-rate = <3>;
>>>>> +                                     drive-push-pull;
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                             pins2{
>>>>> +                                     pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
>>>>> +                                     slew-rate = <3>;
>>>>> +                                     drive-open-drain;
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
>>>>> +                                              <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
>>>>> +                                              <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
>>>>> +                                              <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
>>>>> +                                              <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
>>>>> +                                              <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc2_b4_pins_a: sdmmc2-b4-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC1_D0 */
>>>>> +                                              <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
>>>>> +                                              <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
>>>>> +                                              <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
>>>>> +                                              <STM32_PINMUX('D', 6, AF11)>, /* SDMMC1_CK */
>>>>> +                                              <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
>>>>> +                                     slew-rate = <3>;
>>>>> +                                     drive-push-pull;
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 14, AF9)>, /* SDMMC2_D0 */
>>>>> +                                              <STM32_PINMUX('B', 15, AF9)>, /* SDMMC1_D1 */
>>>>> +                                              <STM32_PINMUX('B', 3, AF9)>, /* SDMMC1_D2 */
>>>>> +                                              <STM32_PINMUX('B', 4, AF9)>, /* SDMMC1_D3 */
>>>>> +                                              <STM32_PINMUX('D', 6, AF11)>; /* SDMMC1_CK */
>>>>> +                                     slew-rate = <3>;
>>>>> +                                     drive-push-pull;
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                             pins2{
>>>>> +                                     pinmux = <STM32_PINMUX('D', 7, AF11)>; /* SDMMC1_CMD */
>>>>> +                                     slew-rate = <3>;
>>>>> +                                     drive-open-drain;
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 14, ANALOG)>, /* SDMMC1_D0 */
>>>>> +                                              <STM32_PINMUX('B', 15, ANALOG)>, /* SDMMC1_D1 */
>>>>> +                                              <STM32_PINMUX('B', 3, ANALOG)>, /* SDMMC1_D2 */
>>>>> +                                              <STM32_PINMUX('B', 4, ANALOG)>, /* SDMMC1_D3 */
>>>>> +                                              <STM32_PINMUX('D', 6, ANALOG)>, /* SDMMC1_CK */
>>>>> +                                              <STM32_PINMUX('D', 7, ANALOG)>; /* SDMMC1_CMD */
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
>>>>> +                                              <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
>>>>> +                                              <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
>>>>> +                                     slew-rate = <3>;
>>>>> +                                     drive-push-pull;
>>>>> +                                     bias-pull-up;
>>>>> +                             };
>>>>> +                             pins2{
>>>>> +                                     pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
>>>>> +                                     bias-pull-up;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
>>>>> +                                              <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
>>>>> +                                              <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
>>>>> +                                              <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     usart1_pins: usart1-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
>>>>> +                                     bias-disable;
>>>>> +                                     drive-push-pull;
>>>>> +                                     slew-rate = <0>;
>>>>> +                             };
>>>>> +                             pins2 {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     usart2_pins: usart2-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
>>>>> +                                     bias-disable;
>>>>> +                                     drive-push-pull;
>>>>> +                                     slew-rate = <0>;
>>>>> +                             };
>>>>> +                             pins2 {
>>>>> +                                     pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     usart3_pins: usart3-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 10, AF7)>; /* USART3_TX */
>>>>> +                                     bias-disable;
>>>>> +                                     drive-push-pull;
>>>>> +                                     slew-rate = <0>;
>>>>> +                             };
>>>>> +                             pins2 {
>>>>> +                                     pinmux = <STM32_PINMUX('B', 11, AF7)>; /* USART3_RX */
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     uart4_pins: uart4-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('A', 0, AF8)>; /* UART4_TX */
>>>>> +                                     bias-disable;
>>>>> +                                     drive-push-pull;
>>>>> +                                     slew-rate = <0>;
>>>>> +                             };
>>>>> +                             pins2 {
>>>>> +                                     pinmux = <STM32_PINMUX('I', 9, AF8)>; /* UART4_RX */
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     usbotg_hs_pins_a: usbotg-hs-0 {
>>>>> +                             pins {
>>>>> +                                     pinmux = <STM32_PINMUX('H', 4, AF10)>,  /* ULPI_NXT */
>>>>> +                                                      <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
>>>>> +                                                      <STM32_PINMUX('C', 0, AF10)>,  /* ULPI_STP> */
>>>>> +                                                      <STM32_PINMUX('A', 5, AF10)>,  /* ULPI_CK> */
>>>>> +                                                      <STM32_PINMUX('A', 3, AF10)>,  /* ULPI_D0> */
>>>>> +                                                      <STM32_PINMUX('B', 0, AF10)>,  /* ULPI_D1> */
>>>>> +                                                      <STM32_PINMUX('B', 1, AF10)>,  /* ULPI_D2> */
>>>>> +                                                      <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
>>>>> +                                                      <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
>>>>> +                                                      <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
>>>>> +                                                      <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
>>>>> +                                                      <STM32_PINMUX('B', 5, AF10)>;  /* ULPI_D7> */
>>>>> +                                     bias-disable;
>>>>> +                                     drive-push-pull;
>>>>> +                                     slew-rate = <2>;
>>>>> +                             };
>>>>> +                     };
>>>>> +
>>>>> +                     spi1_pins: spi1-0 {
>>>>> +                             pins1 {
>>>>> +                                     pinmux = <STM32_PINMUX('A', 5, AF5)>,
>>>>> +                                             /* SPI1_CLK */
>>>>> +                                              <STM32_PINMUX('B', 5, AF5)>;
>>>>> +                                             /* SPI1_MOSI */
>>>>> +                                     bias-disable;
>>>>> +                                     drive-push-pull;
>>>>> +                                     slew-rate = <2>;
>>>>> +                             };
>>>>> +                             pins2 {
>>>>> +                                     pinmux = <STM32_PINMUX('G', 9, AF5)>;
>>>>> +                                             /* SPI1_MISO */
>>>>> +                                     bias-disable;
>>>>> +                             };
>>>>> +                     };
>>>>> +             };
>>>>> +     };
>>>>> +};
>>>>> diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
>>>>> index fa5dcb6a5fdd..6b1e115307b9 100644
>>>>> --- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
>>>>> +++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
>>>>> @@ -1,306 +1,11 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>>>>>     /*
>>>>> - * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
>>>>> - *
>>>>> - * This file is dual-licensed: you can use it either under the terms
>>>>> - * of the GPL or the X11 license, at your option. Note that this dual
>>>>> - * licensing only applies to this file, and not this project as a
>>>>> - * whole.
>>>>> - *
>>>>> - *  a) This file is free software; you can redistribute it and/or
>>>>> - *     modify it under the terms of the GNU General Public License as
>>>>> - *     published by the Free Software Foundation; either version 2 of the
>>>>> - *     License, or (at your option) any later version.
>>>>> - *
>>>>> - *     This file is distributed in the hope that it will be useful,
>>>>> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>>> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>>> - *     GNU General Public License for more details.
>>>>> - *
>>>>> - * Or, alternatively,
>>>>> - *
>>>>> - *  b) Permission is hereby granted, free of charge, to any person
>>>>> - *     obtaining a copy of this software and associated documentation
>>>>> - *     files (the "Software"), to deal in the Software without
>>>>> - *     restriction, including without limitation the rights to use,
>>>>> - *     copy, modify, merge, publish, distribute, sublicense, and/or
>>>>> - *     sell copies of the Software, and to permit persons to whom the
>>>>> - *     Software is furnished to do so, subject to the following
>>>>> - *     conditions:
>>>>> - *
>>>>> - *     The above copyright notice and this permission notice shall be
>>>>> - *     included in all copies or substantial portions of the Software.
>>>>> - *
>>>>> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>>> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>>>> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>>>> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>>>> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>>>> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>>>> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>>> - *     OTHER DEALINGS IN THE SOFTWARE.
>>>>> + * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
>>>>> + * Author: Alexandre Torgue  <alexandre.torgue@st.com> for STMicroelectronics.
>>>>>      */
>>>>>
>>>>> -#include <dt-bindings/pinctrl/stm32-pinfunc.h>
>>>>> +#include "stm32h7-pinctrl.dtsi"
>>>>>
>>>>> -/ {
>>>>> -     soc {
>>>>> -             pin-controller {
>>>>> -                     #address-cells = <1>;
>>>>> -                     #size-cells = <1>;
>>>>> -                     compatible = "st,stm32h743-pinctrl";
>>>>> -                     ranges = <0 0x58020000 0x3000>;
>>>>> -                     interrupt-parent = <&exti>;
>>>>> -                     st,syscfg = <&syscfg 0x8>;
>>>>> -                     pins-are-numbered;
>>>>> -
>>>>> -                     gpioa: gpio@58020000 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x0 0x400>;
>>>>> -                             clocks = <&rcc GPIOA_CK>;
>>>>> -                             st,bank-name = "GPIOA";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpiob: gpio@58020400 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x400 0x400>;
>>>>> -                             clocks = <&rcc GPIOB_CK>;
>>>>> -                             st,bank-name = "GPIOB";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpioc: gpio@58020800 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x800 0x400>;
>>>>> -                             clocks = <&rcc GPIOC_CK>;
>>>>> -                             st,bank-name = "GPIOC";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpiod: gpio@58020c00 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0xc00 0x400>;
>>>>> -                             clocks = <&rcc GPIOD_CK>;
>>>>> -                             st,bank-name = "GPIOD";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpioe: gpio@58021000 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x1000 0x400>;
>>>>> -                             clocks = <&rcc GPIOE_CK>;
>>>>> -                             st,bank-name = "GPIOE";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpiof: gpio@58021400 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x1400 0x400>;
>>>>> -                             clocks = <&rcc GPIOF_CK>;
>>>>> -                             st,bank-name = "GPIOF";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpiog: gpio@58021800 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x1800 0x400>;
>>>>> -                             clocks = <&rcc GPIOG_CK>;
>>>>> -                             st,bank-name = "GPIOG";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpioh: gpio@58021c00 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x1c00 0x400>;
>>>>> -                             clocks = <&rcc GPIOH_CK>;
>>>>> -                             st,bank-name = "GPIOH";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpioi: gpio@58022000 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x2000 0x400>;
>>>>> -                             clocks = <&rcc GPIOI_CK>;
>>>>> -                             st,bank-name = "GPIOI";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpioj: gpio@58022400 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x2400 0x400>;
>>>>> -                             clocks = <&rcc GPIOJ_CK>;
>>>>> -                             st,bank-name = "GPIOJ";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     gpiok: gpio@58022800 {
>>>>> -                             gpio-controller;
>>>>> -                             #gpio-cells = <2>;
>>>>> -                             reg = <0x2800 0x400>;
>>>>> -                             clocks = <&rcc GPIOK_CK>;
>>>>> -                             st,bank-name = "GPIOK";
>>>>> -                             interrupt-controller;
>>>>> -                             #interrupt-cells = <2>;
>>>>> -                     };
>>>>> -
>>>>> -                     i2c1_pins_a: i2c1-0 {
>>>>> -                             pins {
>>>>> -                                     pinmux = <STM32_PINMUX('B', 6, AF4)>, /* I2C1_SCL */
>>>>> -                                              <STM32_PINMUX('B', 7, AF4)>; /* I2C1_SDA */
>>>>> -                                     bias-disable;
>>>>> -                                     drive-open-drain;
>>>>> -                                     slew-rate = <0>;
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     ethernet_rmii: rmii-0 {
>>>>> -                             pins {
>>>>> -                                     pinmux = <STM32_PINMUX('G', 11, AF11)>,
>>>>> -                                              <STM32_PINMUX('G', 13, AF11)>,
>>>>> -                                              <STM32_PINMUX('G', 12, AF11)>,
>>>>> -                                              <STM32_PINMUX('C', 4, AF11)>,
>>>>> -                                              <STM32_PINMUX('C', 5, AF11)>,
>>>>> -                                              <STM32_PINMUX('A', 7, AF11)>,
>>>>> -                                              <STM32_PINMUX('C', 1, AF11)>,
>>>>> -                                              <STM32_PINMUX('A', 2, AF11)>,
>>>>> -                                              <STM32_PINMUX('A', 1, AF11)>;
>>>>> -                                     slew-rate = <2>;
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
>>>>> -                             pins {
>>>>> -                                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>>>>> -                                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
>>>>> -                                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
>>>>> -                                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
>>>>> -                                              <STM32_PINMUX('C', 12, AF12)>, /* SDMMC1_CK */
>>>>> -                                              <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
>>>>> -                                     slew-rate = <3>;
>>>>> -                                     drive-push-pull;
>>>>> -                                     bias-disable;
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
>>>>> -                             pins1 {
>>>>> -                                     pinmux = <STM32_PINMUX('C', 8, AF12)>, /* SDMMC1_D0 */
>>>>> -                                              <STM32_PINMUX('C', 9, AF12)>, /* SDMMC1_D1 */
>>>>> -                                              <STM32_PINMUX('C', 10, AF12)>, /* SDMMC1_D2 */
>>>>> -                                              <STM32_PINMUX('C', 11, AF12)>, /* SDMMC1_D3 */
>>>>> -                                              <STM32_PINMUX('C', 12, AF12)>; /* SDMMC1_CK */
>>>>> -                                     slew-rate = <3>;
>>>>> -                                     drive-push-pull;
>>>>> -                                     bias-disable;
>>>>> -                             };
>>>>> -                             pins2{
>>>>> -                                     pinmux = <STM32_PINMUX('D', 2, AF12)>; /* SDMMC1_CMD */
>>>>> -                                     slew-rate = <3>;
>>>>> -                                     drive-open-drain;
>>>>> -                                     bias-disable;
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
>>>>> -                             pins {
>>>>> -                                     pinmux = <STM32_PINMUX('C', 8, ANALOG)>, /* SDMMC1_D0 */
>>>>> -                                              <STM32_PINMUX('C', 9, ANALOG)>, /* SDMMC1_D1 */
>>>>> -                                              <STM32_PINMUX('C', 10, ANALOG)>, /* SDMMC1_D2 */
>>>>> -                                              <STM32_PINMUX('C', 11, ANALOG)>, /* SDMMC1_D3 */
>>>>> -                                              <STM32_PINMUX('C', 12, ANALOG)>, /* SDMMC1_CK */
>>>>> -                                              <STM32_PINMUX('D', 2, ANALOG)>; /* SDMMC1_CMD */
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
>>>>> -                             pins1 {
>>>>> -                                     pinmux = <STM32_PINMUX('C', 6, AF8)>, /* SDMMC1_D0DIR */
>>>>> -                                              <STM32_PINMUX('C', 7, AF8)>, /* SDMMC1_D123DIR */
>>>>> -                                              <STM32_PINMUX('B', 9, AF7)>; /* SDMMC1_CDIR */
>>>>> -                                     slew-rate = <3>;
>>>>> -                                     drive-push-pull;
>>>>> -                                     bias-pull-up;
>>>>> -                             };
>>>>> -                             pins2{
>>>>> -                                     pinmux = <STM32_PINMUX('B', 8, AF7)>; /* SDMMC1_CKIN */
>>>>> -                                     bias-pull-up;
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
>>>>> -                             pins {
>>>>> -                                     pinmux = <STM32_PINMUX('C', 6, ANALOG)>, /* SDMMC1_D0DIR */
>>>>> -                                              <STM32_PINMUX('C', 7, ANALOG)>, /* SDMMC1_D123DIR */
>>>>> -                                              <STM32_PINMUX('B', 9, ANALOG)>, /* SDMMC1_CDIR */
>>>>> -                                              <STM32_PINMUX('B', 8, ANALOG)>; /* SDMMC1_CKIN */
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     usart1_pins: usart1-0 {
>>>>> -                             pins1 {
>>>>> -                                     pinmux = <STM32_PINMUX('B', 14, AF4)>; /* USART1_TX */
>>>>> -                                     bias-disable;
>>>>> -                                     drive-push-pull;
>>>>> -                                     slew-rate = <0>;
>>>>> -                             };
>>>>> -                             pins2 {
>>>>> -                                     pinmux = <STM32_PINMUX('B', 15, AF4)>; /* USART1_RX */
>>>>> -                                     bias-disable;
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     usart2_pins: usart2-0 {
>>>>> -                             pins1 {
>>>>> -                                     pinmux = <STM32_PINMUX('D', 5, AF7)>; /* USART2_TX */
>>>>> -                                     bias-disable;
>>>>> -                                     drive-push-pull;
>>>>> -                                     slew-rate = <0>;
>>>>> -                             };
>>>>> -                             pins2 {
>>>>> -                                     pinmux = <STM32_PINMUX('D', 6, AF7)>; /* USART2_RX */
>>>>> -                                     bias-disable;
>>>>> -                             };
>>>>> -                     };
>>>>> -
>>>>> -                     usbotg_hs_pins_a: usbotg-hs-0 {
>>>>> -                             pins {
>>>>> -                                     pinmux = <STM32_PINMUX('H', 4, AF10)>,  /* ULPI_NXT */
>>>>> -                                                      <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
>>>>> -                                                      <STM32_PINMUX('C', 0, AF10)>,  /* ULPI_STP> */
>>>>> -                                                      <STM32_PINMUX('A', 5, AF10)>,  /* ULPI_CK> */
>>>>> -                                                      <STM32_PINMUX('A', 3, AF10)>,  /* ULPI_D0> */
>>>>> -                                                      <STM32_PINMUX('B', 0, AF10)>,  /* ULPI_D1> */
>>>>> -                                                      <STM32_PINMUX('B', 1, AF10)>,  /* ULPI_D2> */
>>>>> -                                                      <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
>>>>> -                                                      <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
>>>>> -                                                      <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
>>>>> -                                                      <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
>>>>> -                                                      <STM32_PINMUX('B', 5, AF10)>;  /* ULPI_D7> */
>>>>> -                                     bias-disable;
>>>>> -                                     drive-push-pull;
>>>>> -                                     slew-rate = <2>;
>>>>> -                             };
>>>>> -                     };
>>>>> -             };
>>>>> -     };
>>>>> +&pinctrl{
>>>>> +     compatible = "st,stm32h743-pinctrl";
>>>>>     };
>>>>>
