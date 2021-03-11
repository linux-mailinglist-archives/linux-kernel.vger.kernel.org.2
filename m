Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D013372B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbhCKMds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbhCKMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:33:31 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AFCC061574;
        Thu, 11 Mar 2021 04:33:31 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u20so21672270iot.9;
        Thu, 11 Mar 2021 04:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ohn0BA71nRAjw9PLIhp8BCrIpL90tt+uHNBmyCfKZNI=;
        b=JXn7RVO6Obcws5EHsQPKqbeC9detSdti6QlOEiHIjOD9bP38FNLGUbPN6LITAi/+52
         U8rtGkO/mr12IGPVpBz1rEt4sV/tXEYou2f237QVTGB7a8ij96WkuNdSJMfcZTlzx+7v
         C+5f/6lHn3PvQpITERfwiOlVIxxLpybAmDgnq8L/5l93lVWfo5E5BLzVL8TFttibZKAR
         fKpjMlKY9Qyo4X5k+o4NzfhOBe3dXy/46Py3JdctE/XrB5zAtfheZhig49nLz3aoEYAE
         j+o10lcgHhfco6YXCu2+1wHfAejONyiV3IteKmliHp+rRz3QARTfv0rj9A3jWPmNbbNz
         u7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ohn0BA71nRAjw9PLIhp8BCrIpL90tt+uHNBmyCfKZNI=;
        b=VTEFW6qjoadzus9CNHXVZuztfy0HBQZpG2S2wgS6tT5tzGt5y5Ygyq1YSVveT9k2Ly
         sbrkBG8/WpGJyQNFnPewbL1BPtbz1hpz8I3/NLtLLLTPTIookUiMZAe8HzZOqV0WoUpM
         x0jU0zBJVC66Ht7zZxsORX3K8Fe6u/00pJRXuAW3JsZc7IZF8gAc8WMiDkrNyLLwUq+y
         3Dfovix9Na3VkagYe+6mvhz4gGQ89rI7Gvxe1/sN5gF6ht+CeZjDu9nrhFD/iMSWD5kA
         RCEh7iCo1+yOdnfngkCDXXsDuGdB+zm4pHQc9+aUurS5YWZfX0wqv6PdDSE5Xc+dZ6Yi
         sk7A==
X-Gm-Message-State: AOAM531P4cC0MM03y1ENUb5xcZ985aul7VcJXOHki5nN+hhrft3OvSSD
        pzCLmGphicWdxpeTu7z2SjwEj/iqLEFaXrTatbU1TdM0DqQvIg==
X-Google-Smtp-Source: ABdhPJz1D6iNjnDxMLP2MUVQs32Pn1AEgBCoBbJHgnsCdPntuIOOJ4qeHCuGnPY67Jw67UeozWP+pKbbYyw7/VRCGgY=
X-Received: by 2002:a05:6638:388e:: with SMTP id b14mr3419011jav.62.1615466010727;
 Thu, 11 Mar 2021 04:33:30 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-8-git-send-email-dillon.minfei@gmail.com> <c6bd6a3f-b53d-71d0-d9b4-69d29eb27395@foss.st.com>
In-Reply-To: <c6bd6a3f-b53d-71d0-d9b4-69d29eb27395@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 11 Mar 2021 20:32:54 +0800
Message-ID: <CAL9mu0+MVrq3P7URMauhqwKkxoZ-6fxGVvDErfcH+MycAUrBdA@mail.gmail.com>
Subject: Re: [PATCH 7/8] ARM: dts: stm32: add support for art-pi board based
 on stm32h750xbh6
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux@armlinux.org.uk, Vladimir Murzin <vladimir.murzin@arm.com>,
        afzal.mohd.ma@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre

On Thu, Mar 11, 2021 at 6:42 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
>
>
> On 3/3/21 9:05 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > This patchset has following changes:
> >
> > - add stm32h750i-art-pi.dtb
> > - add dts binding usart3 for bt, uart4 for console
> > - add dts binding sdmmc2 for wifi
> > - add stm32h750-art-pi.dts to support art-pi board
> >
> > board component:
> > - 8MiB qspi flash
> > - 16MiB spi flash
> > - 32MiB sdram
> > - ap6212 wifi&bt&fm
> >
> > the detail board information can be found at:
> > https://art-pi.gitee.io/website/
> >
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >   arch/arm/boot/dts/Makefile              |   1 +
> >   arch/arm/boot/dts/stm32h743.dtsi        |  30 +++++
> >   arch/arm/boot/dts/stm32h750.dtsi        |   5 +
> >   arch/arm/boot/dts/stm32h750i-art-pi.dts | 224 ++++++++++++++++++++++++++++++++
> >   4 files changed, 260 insertions(+)
> >   create mode 100644 arch/arm/boot/dts/stm32h750.dtsi
> >   create mode 100644 arch/arm/boot/dts/stm32h750i-art-pi.dts
> >
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index 8e5d4ab4e75e..a19c5ab9df84 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -1071,6 +1071,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
> >       stm32746g-eval.dtb \
> >       stm32h743i-eval.dtb \
> >       stm32h743i-disco.dtb \
> > +     stm32h750i-art-pi.dtb \
> >       stm32mp153c-dhcom-drc02.dtb \
> >       stm32mp157a-avenger96.dtb \
> >       stm32mp157a-dhcor-avenger96.dtb \
> > diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> > index 4ebffb0a45a3..981d44051007 100644
> > --- a/arch/arm/boot/dts/stm32h743.dtsi
> > +++ b/arch/arm/boot/dts/stm32h743.dtsi
> > @@ -135,6 +135,22 @@
> >                       clocks = <&rcc USART2_CK>;
> >               };
> >
> > +             usart3: serial@40004800 {
> > +                     compatible = "st,stm32h7-uart";
> > +                     reg = <0x40004800 0x400>;
> > +                     interrupts = <39>;
> > +                     status = "disabled";
> > +                     clocks = <&rcc USART3_CK>;
> > +             };
> > +
> > +             uart4: serial@40004c00 {
> > +                     compatible = "st,stm32h7-uart";
> > +                     reg = <0x40004c00 0x400>;
> > +                     interrupts = <52>;
> > +                     status = "disabled";
> > +                     clocks = <&rcc UART4_CK>;
> > +             };
> > +
>
> Those peripherals are available on h743 ?
Yes, available for stm32h743, but might not used by stm32h743i-disco board.
the difference between stm32h743xi and stm32h750xb:
 flash size:  2048/128,
ad convter : none/3
crypto-hash: none/aes,hmac,....

>
> >               i2c1: i2c@40005400 {
> >                       compatible = "st,stm32f7-i2c";
> >                       #address-cells = <1>;
> > @@ -368,6 +384,20 @@
> >                       max-frequency = <120000000>;
> >               };
> >
> > +             sdmmc2: mmc@48022400 {
> > +                     compatible = "arm,pl18x", "arm,primecell";
> > +                     arm,primecell-periphid = <0x10153180>;
> > +                     reg = <0x48022400 0x400>;
> > +                     interrupts = <124>;
> > +                     interrupt-names = "cmd_irq";
> > +                     clocks = <&rcc SDMMC2_CK>;
> > +                     clock-names = "apb_pclk";
> > +                     resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
> > +                     cap-sd-highspeed;
> > +                     cap-mmc-highspeed;
> > +                     max-frequency = <120000000>;
> > +             };
> > +
> >               exti: interrupt-controller@58000000 {
> >                       compatible = "st,stm32h7-exti";
> >                       interrupt-controller;
> > diff --git a/arch/arm/boot/dts/stm32h750.dtsi b/arch/arm/boot/dts/stm32h750.dtsi
> > new file mode 100644
> > index 000000000000..dd9166223c2f
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/stm32h750.dtsi
> > @@ -0,0 +1,5 @@
> > +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> > +/* Copyright (C) STMicroelectronics 2021 - All Rights Reserved */
> > +
> > +#include "stm32h743.dtsi"
> > +
> > diff --git a/arch/arm/boot/dts/stm32h750i-art-pi.dts b/arch/arm/boot/dts/stm32h750i-art-pi.dts
> > new file mode 100644
> > index 000000000000..84cf70d7800c
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/stm32h750i-art-pi.dts
> > @@ -0,0 +1,224 @@
> > +/*
> > + * Copyright 2021 - Dillon Min <dillon.minfei@gmail.com>
> > + *
> > + * This file is dual-licensed: you can use it either under the terms
> > + * of the GPL or the X11 license, at your option. Note that this dual
> > + * licensing only applies to this file, and not this project as a
> > + * whole.
> > + *
> > + *  a) This file is free software; you can redistribute it and/or
> > + *     modify it under the terms of the GNU General Public License as
> > + *     published by the Free Software Foundation; either version 2 of the
> > + *     License, or (at your option) any later version.
> > + *
> > + *     This file is distributed in the hope that it will be useful,
> > + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + *     GNU General Public License for more details.
> > + *
> > + * Or, alternatively,
> > + *
> > + *  b) Permission is hereby granted, free of charge, to any person
> > + *     obtaining a copy of this software and associated documentation
> > + *     files (the "Software"), to deal in the Software without
> > + *     restriction, including without limitation the rights to use,
> > + *     copy, modify, merge, publish, distribute, sublicense, and/or
> > + *     sell copies of the Software, and to permit persons to whom the
> > + *     Software is furnished to do so, subject to the following
> > + *     conditions:
> > + *
> > + *     The above copyright notice and this permission notice shall be
> > + *     included in all copies or substantial portions of the Software.
> > + *
> > + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + *     OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +/dts-v1/;
> > +#include "stm32h750.dtsi"
> > +#include "stm32h750-pinctrl.dtsi"
> > +#include <dt-bindings/interrupt-controller/irq.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +
> > +/ {
> > +     model = "RT-Thread STM32H750i-ART-PI board";
> > +     compatible = "st,stm32h750i-art-pi", "st,stm32h750";
> > +
> > +     chosen {
> > +             bootargs = "root=/dev/ram";
> > +             stdout-path = "serial0:2000000n8";
> > +     };
> > +
> > +     memory@c0000000 {
> > +             device_type = "memory";
> > +             reg = <0xc0000000 0x2000000>;
> > +     };
> > +
> > +     reserved-memory {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             ranges;
> > +
> > +             linux,cma {
> > +                     compatible = "shared-dma-pool";
> > +                     no-map;
> > +                     size = <0x100000>;
> > +                     linux,dma-default;
> > +             };
> > +     };
> > +
> > +     aliases {
> > +             serial0 = &uart4;
> > +             serial1 = &usart3;
> > +     };
> > +
> > +     leds {
> > +             compatible = "gpio-leds";
> > +             led-red {
> > +                     gpios = <&gpioi 8 0>;
> > +             };
> > +             led-green {
> > +                     gpios = <&gpioc 15 0>;
> > +                     linux,default-trigger = "heartbeat";
> > +             };
> > +     };
> > +
> > +     v3v3: regulator-v3v3 {
> > +             compatible = "regulator-fixed";
> > +             regulator-name = "v3v3";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +             regulator-always-on;
> > +     };
> > +
> > +     wlan_pwr: regulator-wlan {
> > +             compatible = "regulator-fixed";
> > +
> > +             regulator-name = "wl-reg";
> > +             regulator-min-microvolt = <3300000>;
> > +             regulator-max-microvolt = <3300000>;
> > +
> > +             gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
> > +             enable-active-high;
> > +     };
> > +};
> > +
> > +&clk_hse {
> > +     clock-frequency = <25000000>;
> > +};
> > +
> > +&mac {
> > +     status = "disabled";
> > +     pinctrl-0       = <&ethernet_rmii>;
> > +     pinctrl-names   = "default";
> > +     phy-mode        = "rmii";
> > +     phy-handle      = <&phy0>;
> > +
> > +     mdio0 {
> > +             #address-cells = <1>;
> > +             #size-cells = <0>;
> > +             compatible = "snps,dwmac-mdio";
> > +             phy0: ethernet-phy@0 {
> > +                     reg = <0>;
> > +             };
> > +     };
> > +};
> > +
> > +&sdmmc1 {
> > +     pinctrl-names = "default", "opendrain", "sleep";
> > +     pinctrl-0 = <&sdmmc1_b4_pins_a>;
> > +     pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
> > +     pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
> > +     broken-cd;
> > +     st,neg-edge;
> > +     bus-width = <4>;
> > +     vmmc-supply = <&v3v3>;
> > +     status = "okay";
> > +};
> > +
> > +&usart2 {
> > +     pinctrl-0 = <&usart2_pins>;
> > +     pinctrl-names = "default";
> > +     status = "disabled";
> > +};
> > +
> > +&uart4 {
> > +     pinctrl-0 = <&uart4_pins>;
> > +     pinctrl-names = "default";
> > +     status = "okay";
> > +};
> > +
> > +&dma1 {
> > +     status = "okay";
> > +};
> > +
>
> Would be better to order by name, but it is your board :)
Okay, i will follow stm32f7/f4's order next submit.
>
> > +&dma2 {
> > +     status = "okay";
> > +};
> > +
> > +&spi1 {
> > +     status = "okay";
> > +     pinctrl-0 = <&spi1_pins>;
> > +     pinctrl-names = "default";
> > +     cs-gpios = <&gpioa 4 GPIO_ACTIVE_LOW>;
> > +     dmas = <&dmamux1 37 0x400 0x05>,
> > +            <&dmamux1 38 0x400 0x05>;
> > +     dma-names = "rx", "tx";
> > +
> > +     flash@0 {
> > +             #address-cells = <1>;
> > +             #size-cells = <1>;
> > +             compatible = "winbond,w25q128", "jedec,spi-nor";
> > +             reg = <0>;
> > +             spi-max-frequency = <80000000>;
> > +
> > +             partition@0 {
> > +                     label = "root filesystem";
> > +                     reg = <0 0x1000000>;
> > +             };
> > +     };
> > +};
> > +
> > +&sdmmc2 {
> > +     pinctrl-names = "default", "opendrain", "sleep";
> > +     pinctrl-0 = <&sdmmc2_b4_pins_a>;
> > +     pinctrl-1 = <&sdmmc2_b4_od_pins_a>;
> > +     pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
> > +     broken-cd;
> > +     non-removable;
> > +     st,neg-edge;
> > +     bus-width = <4>;
> > +     vmmc-supply = <&wlan_pwr>;
> > +     status = "okay";
> > +
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +     brcmf: bcrmf@1 {
> > +             reg = <1>;
> > +             compatible = "brcm,bcm4329-fmac";
> > +     };
> > +};
> > +
> > +&usart3 {
> > +     /delete-property/st,hw-flow-ctrl;
> > +     cts-gpios = <&gpiod 11 GPIO_ACTIVE_LOW>;
> > +     rts-gpios = <&gpiod 12 GPIO_ACTIVE_LOW>;
> > +     dmas = <&dmamux1 45 0x400 0x05>,
> > +            <&dmamux1 46 0x400 0x05>;
> > +     dma-names = "rx", "tx";
> > +     status = "okay";
> > +
> > +     bluetooth {
> > +             host-wakeup-gpios = <&gpioc 0 GPIO_ACTIVE_HIGH>;
> > +             device-wakeup-gpios = <&gpioi 10 GPIO_ACTIVE_HIGH>;
> > +             shutdown-gpios = <&gpioi 11 GPIO_ACTIVE_HIGH>;
> > +             compatible = "brcm,bcm43438-bt";
> > +             max-speed = <115200>;
> > +     };
> > +};
> >
