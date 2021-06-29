Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933203B775A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbhF2RqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 13:46:14 -0400
Received: from mx.mrwax.de ([188.138.10.209]:42449 "EHLO mx.mrwax.eu"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhF2RqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:46:13 -0400
X-Greylist: delayed 2310 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jun 2021 13:46:12 EDT
Received: from ip5b434b8b.dynamic.kabel-deutschland.de ([91.67.75.139] helo=[192.168.200.247])
        by mx.mrwax.eu with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <knaerzche@gmail.com>)
        id 1lyHAT-0000qv-Nb; Tue, 29 Jun 2021 19:05:04 +0200
Subject: Re: [PATCH] arm64: dts: rockchip: add rock-pi-4 analog audio
To:     Robin Murphy <robin.murphy@arm.com>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, jack@radxa.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>
References: <20210628113033.9145-1-adrian.ratiu@collabora.com>
 <7f806d30-594e-2325-615a-8fee875c83a8@gmail.com>
 <87eeck3e1o.fsf@ryzen9.i-did-not-set--mail-host-address--so-tickle-me>
 <6a9d976e-22fe-2723-9897-da58b3af456a@arm.com>
From:   Alex Bee <knaerzche@gmail.com>
Message-ID: <e37c4d79-36f9-217e-b6f6-acf1a9e7a63b@gmail.com>
Date:   Tue, 29 Jun 2021 19:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6a9d976e-22fe-2723-9897-da58b3af456a@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MRWX-Virus-Scanned: ClamAV 0.102.3/26216/Tue Jun 29 13:09:49 2021
X-MRWX-Spam-Scanned: SpamAssassin version 3.4.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian, Hi Robin
Am 29.06.21 um 17:42 schrieb Robin Murphy:
> On 2021-06-29 16:07, Adrian Ratiu wrote:
>> Hi Alex,
>>
>> On Tue, 29 Jun 2021, Alex Bee <knaerzche@gmail.com> wrote:
>>> Hi Adrian,
>>> I've submitted similar patch already. Its part of [1]
>>
>> Thank you for pointing out your patch, I was not aware of it as it was 
>> not merged yet (I tested latest linux-next).
>>
>> It is a good sign that our code is almost identical except for the 
>> headphone detect pin which you mention.
>>
>>>
>>> There is no headphone detection pin in the schematics, btw.
>>
>> There are two reasons I added it:
>>
>> 1. The es8316 codec failed to probe() in my testing unless the irq was 
>> defined. That might have been due to me testing the codec directly 
>> with the simple card driver instead of the graph driver.
>>
>> Point 1 doesn't appear to be an issue anymore, the codec + graph 
>> driver probe correctly and audio supposedly (see below) works even 
>> without the irq.
I guess that just a "warning" that doesn't mean the driver failed to 
probe. (It the same for RockPro64, for example - where the interrupt 
line isn't connected as well)
>>
>> 2. I got the gpio bank 1 pin 0 location from various headphone 
>> detection commits in the vendor v4.4 kernel, like for example [1].
>>
>> Are you 100% sure there is no hp detection pin wired on the rock-pi-4?
>> Even if it might be missing from the schematics, the vendor driver 
>> code apparently defines and uses it?
> 
> FWIW according to the schematics it *is* wired up on the Model C board, 
> but not on the Model A or B.
> 
Thanks for the pointer, I did look at v1.3 only, tbh.

I'm not sure I understand why we should pull up this pin.

Shouldn't we better use hp-det-gpio property of audio-graph-card to make 
real use of this pin?

> Robin.
> 
>>  From booting with the irq defined I get the following in 
>> /proc/interrupts however I'm having an unrelated difficulty testing 
>> because the audio connector literally broke off the board like in [2].
>> 90: 1  0  0  0  0  rockchip_gpio_irq   0 Level     es8316
According to the Model C schematics the codec interrupt (HP_INT) is 
connected to GPIO1_PA1 (in contrast to GPIO1_PA0 which is used for hp 
detection).

If you're OK I'll update my series and add those pins for Model C only 
(and will request the schematics of A+ and B+ which seem not to be 
published yet to check out what the manufacturer decided for those variants)

Alex
>>
>> Team Radxa was very nice in offering me a replacement but until that 
>> arrives I can't test this anymore.
>>
>> [1] 
>> https://github.com/radxa/kernel/commit/e945cad5c3ec82d171760465d3c7a84bb10ed1b7 
>>
>>
>> [2] https://forum.radxa.com/t/audio-jack-broke-off/935
>>
>>> [1] 
>>> https://patchwork.kernel.org/project/linux-rockchip/cover/20210618181256.27992-1-knaerzche@gmail.com/ 
>>>
>>>
>>> Best,
>>>
>>> Alex
>>>
>>> Am 28.06.21 um 13:30 schrieb Adrian Ratiu:
>>>> This adds the necessary pinctrl and nodes to enable the
>>>> analog audio on rk3399 rock-pi-4 SBCs using the es8316
>>>> codec and the audio-graph-card driver.
>>>>
>>>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
>>>> ---
>>>>   .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 38 
>>>> +++++++++++++++++++
>>>>   1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi 
>>>> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>>>> index b28888ea9262..77781d9150ac 100644
>>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
>>>> @@ -128,6 +128,12 @@ vdd_log: vdd-log {
>>>>           regulator-max-microvolt = <1400000>;
>>>>           vin-supply = <&vcc5v0_sys>;
>>>>       };
>>>> +
>>>> +    sound {
>>>> +        compatible = "audio-graph-card";
>>>> +        label = "rockchip,rk3399";
>>>> +        dais = <&i2s0_p0>;
>>>> +    };
>>>>   };
>>>>   &cpu_l0 {
>>>> @@ -422,6 +428,24 @@ &i2c1 {
>>>>       i2c-scl-rising-time-ns = <300>;
>>>>       i2c-scl-falling-time-ns = <15>;
>>>>       status = "okay";
>>>> +
>>>> +    es8316: codec@11 {
>>>> +        compatible = "everest,es8316";
>>>> +        reg = <0x11>;
>>>> +        clocks = <&cru SCLK_I2S_8CH_OUT>;
>>>> +        clock-names = "mclk";
>>>> +        pinctrl-names = "default";
>>>> +        pinctrl-0 = <&hp_det_pin>;
>>>> +        interrupt-parent = <&gpio1>;
>>>> +        interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
>>>> +        #sound-dai-cells = <0>;
>>>> +
>>>> +        port {
>>>> +            es8316_p0_0: endpoint {
>>>> +                remote-endpoint = <&i2s0_p0_0>;
>>>> +            };
>>>> +        };
>>>> +    };
>>>>   };
>>>>   &i2c3 {
>>>> @@ -441,6 +465,14 @@ &i2s0 {
>>>>       rockchip,capture-channels = <2>;
>>>>       rockchip,playback-channels = <2>;
>>>>       status = "okay";
>>>> +
>>>> +    i2s0_p0: port {
>>>> +        i2s0_p0_0: endpoint {
>>>> +            dai-format = "i2s";
>>>> +            mclk-fs = <256>;
>>>> +            remote-endpoint = <&es8316_p0_0>;
>>>> +        };
>>>> +    };
>>>>   };
>>>>   &i2s1 {
>>>> @@ -556,6 +588,12 @@ wifi_host_wake_l: wifi-host-wake-l {
>>>>               rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
>>>>           };
>>>>       };
>>>> +
>>>> +    es8316 {
>>>> +        hp_det_pin: hp-det-pin {
>>>> +            rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
>>>> +        };
>>>> +    };
>>>>   };
>>>>   &pwm2 {
>>
>> _______________________________________________
>> Linux-rockchip mailing list
>> Linux-rockchip@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

