Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672133B773F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhF2RdT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Jun 2021 13:33:19 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhF2RdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 13:33:18 -0400
Received: from chickenburger.collabora.co.uk (chickenburger.collabora.co.uk [46.235.227.242])
        by bhuna.collabora.co.uk (Postfix) with ESMTP id 223B51F42F26;
        Tue, 29 Jun 2021 18:30:49 +0100 (BST)
From:   "Adrian Ratiu" <adrian.ratiu@collabora.com>
In-Reply-To: <e37c4d79-36f9-217e-b6f6-acf1a9e7a63b@gmail.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 188.24.96.153
Date:   Tue, 29 Jun 2021 18:30:49 +0100
Cc:     "Robin Murphy" <robin.murphy@arm.com>,
        "Heiko Stuebner" <heiko@sntech.de>, jack@radxa.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, "Rob Herring" <robh+dt@kernel.org>
To:     "Alex Bee" <knaerzche@gmail.com>
MIME-Version: 1.0
Message-ID: <131f-60db5900-1d-7b1f8480@92301631>
Subject: =?utf-8?q?Re=3A?= [PATCH] =?utf-8?q?arm64=3A?==?utf-8?q?_dts=3A?=
 =?utf-8?q?_rockchip=3A?= add rock-pi-4 analog audio
User-Agent: SOGoMail 5.0.1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 29, 2021 20:04 EEST, Alex Bee <knaerzche@gmail.com> wrote: 
 
> Hi Adrian, Hi Robin
> Am 29.06.21 um 17:42 schrieb Robin Murphy:
> > On 2021-06-29 16:07, Adrian Ratiu wrote:
> >> Hi Alex,
> >>
> >> On Tue, 29 Jun 2021, Alex Bee <knaerzche@gmail.com> wrote:
> >>> Hi Adrian,
> >>> I've submitted similar patch already. Its part of [1]
> >>
> >> Thank you for pointing out your patch, I was not aware of it as it was 
> >> not merged yet (I tested latest linux-next).
> >>
> >> It is a good sign that our code is almost identical except for the 
> >> headphone detect pin which you mention.
> >>
> >>>
> >>> There is no headphone detection pin in the schematics, btw.
> >>
> >> There are two reasons I added it:
> >>
> >> 1. The es8316 codec failed to probe() in my testing unless the irq was 
> >> defined. That might have been due to me testing the codec directly 
> >> with the simple card driver instead of the graph driver.
> >>
> >> Point 1 doesn't appear to be an issue anymore, the codec + graph 
> >> driver probe correctly and audio supposedly (see below) works even 
> >> without the irq.
> I guess that just a "warning" that doesn't mean the driver failed to 
> probe. (It the same for RockPro64, for example - where the interrupt 
> line isn't connected as well)
> >>
> >> 2. I got the gpio bank 1 pin 0 location from various headphone 
> >> detection commits in the vendor v4.4 kernel, like for example [1].
> >>
> >> Are you 100% sure there is no hp detection pin wired on the rock-pi-4?
> >> Even if it might be missing from the schematics, the vendor driver 
> >> code apparently defines and uses it?
> > 
> > FWIW according to the schematics it *is* wired up on the Model C board, 
> > but not on the Model A or B.
> > 
> Thanks for the pointer, I did look at v1.3 only, tbh.
> 
> I'm not sure I understand why we should pull up this pin.
> 
> Shouldn't we better use hp-det-gpio property of audio-graph-card to make 
> real use of this pin?

That sounds like the best way forward, only on the model / revision which actually has the pin connected.

> 
> > Robin.
> > 
> >>  From booting with the irq defined I get the following in 
> >> /proc/interrupts however I'm having an unrelated difficulty testing 
> >> because the audio connector literally broke off the board like in [2].
> >> 90: 1  0  0  0  0  rockchip_gpio_irq   0 Level     es8316
> According to the Model C schematics the codec interrupt (HP_INT) is 
> connected to GPIO1_PA1 (in contrast to GPIO1_PA0 which is used for hp 
> detection).
> 
> If you're OK I'll update my series and add those pins for Model C only 
> (and will request the schematics of A+ and B+ which seem not to be 
> published yet to check out what the manufacturer decided for those variants)

Yes, thank you very much! Please CC me on the new series, hopefully I can provide a tested-by if I receive the fixed HW by then.

Adrian

> 
> Alex
> >>
> >> Team Radxa was very nice in offering me a replacement but until that 
> >> arrives I can't test this anymore.
> >>
> >> [1] 
> >> https://github.com/radxa/kernel/commit/e945cad5c3ec82d171760465d3c7a84bb10ed1b7 
> >>
> >>
> >> [2] https://forum.radxa.com/t/audio-jack-broke-off/935
> >>
> >>> [1] 
> >>> https://patchwork.kernel.org/project/linux-rockchip/cover/20210618181256.27992-1-knaerzche@gmail.com/ 
> >>>
> >>>
> >>> Best,
> >>>
> >>> Alex
> >>>
> >>> Am 28.06.21 um 13:30 schrieb Adrian Ratiu:
> >>>> This adds the necessary pinctrl and nodes to enable the
> >>>> analog audio on rk3399 rock-pi-4 SBCs using the es8316
> >>>> codec and the audio-graph-card driver.
> >>>>
> >>>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> >>>> ---
> >>>>   .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 38 
> >>>> +++++++++++++++++++
> >>>>   1 file changed, 38 insertions(+)
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi 
> >>>> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> >>>> index b28888ea9262..77781d9150ac 100644
> >>>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> >>>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
> >>>> @@ -128,6 +128,12 @@ vdd_log: vdd-log {
> >>>>           regulator-max-microvolt = <1400000>;
> >>>>           vin-supply = <&vcc5v0_sys>;
> >>>>       };
> >>>> +
> >>>> +    sound {
> >>>> +        compatible = "audio-graph-card";
> >>>> +        label = "rockchip,rk3399";
> >>>> +        dais = <&i2s0_p0>;
> >>>> +    };
> >>>>   };
> >>>>   &cpu_l0 {
> >>>> @@ -422,6 +428,24 @@ &i2c1 {
> >>>>       i2c-scl-rising-time-ns = <300>;
> >>>>       i2c-scl-falling-time-ns = <15>;
> >>>>       status = "okay";
> >>>> +
> >>>> +    es8316: codec@11 {
> >>>> +        compatible = "everest,es8316";
> >>>> +        reg = <0x11>;
> >>>> +        clocks = <&cru SCLK_I2S_8CH_OUT>;
> >>>> +        clock-names = "mclk";
> >>>> +        pinctrl-names = "default";
> >>>> +        pinctrl-0 = <&hp_det_pin>;
> >>>> +        interrupt-parent = <&gpio1>;
> >>>> +        interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
> >>>> +        #sound-dai-cells = <0>;
> >>>> +
> >>>> +        port {
> >>>> +            es8316_p0_0: endpoint {
> >>>> +                remote-endpoint = <&i2s0_p0_0>;
> >>>> +            };
> >>>> +        };
> >>>> +    };
> >>>>   };
> >>>>   &i2c3 {
> >>>> @@ -441,6 +465,14 @@ &i2s0 {
> >>>>       rockchip,capture-channels = <2>;
> >>>>       rockchip,playback-channels = <2>;
> >>>>       status = "okay";
> >>>> +
> >>>> +    i2s0_p0: port {
> >>>> +        i2s0_p0_0: endpoint {
> >>>> +            dai-format = "i2s";
> >>>> +            mclk-fs = <256>;
> >>>> +            remote-endpoint = <&es8316_p0_0>;
> >>>> +        };
> >>>> +    };
> >>>>   };
> >>>>   &i2s1 {
> >>>> @@ -556,6 +588,12 @@ wifi_host_wake_l: wifi-host-wake-l {
> >>>>               rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_none>;
> >>>>           };
> >>>>       };
> >>>> +
> >>>> +    es8316 {
> >>>> +        hp_det_pin: hp-det-pin {
> >>>> +            rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>;
> >>>> +        };
> >>>> +    };
> >>>>   };
> >>>>   &pwm2 {
> >>
> >> _______________________________________________
> >> Linux-rockchip mailing list
> >> Linux-rockchip@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> > 
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
>

