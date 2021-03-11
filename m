Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1562E3375D3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 15:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbhCKOdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 09:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbhCKOdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 09:33:25 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B2EC061574;
        Thu, 11 Mar 2021 06:33:25 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id d5so19088627iln.6;
        Thu, 11 Mar 2021 06:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VUIuMnqdUlTqUS5NcB1IghR/43hJ/nyKLZYqGp7cLHc=;
        b=Nh01dcuCqKtM6OljganOdpteE1cKK2RlR/KuEa7uE9YU2iwIAvre2JGT8z/iAnOsfi
         JRPfEGQz2hpsO6XMvFSkRASVTMitgw4nivycR6ScL+HZ8DruB6NCbIAIm+cmGqkYFTRN
         g7qFdhl8gbUk2cOTt29TzYYVQ4CU0InBJlzE3DnS6qZV3ZNpp6BBWZvqEIzkncCU1pZX
         NVlWTiMrs+xiNw5zlgkfZdA0v+sUuwY+atXiXBh6iFG0CPOWZOMc3/5q0jWj4coFRmmX
         lXNPumPeqJRSV5oHlHS3HhTUiTAea/8bdKxA/2uu8l6tIXox+pN+K7KMniG4dQK/4Nkd
         vQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VUIuMnqdUlTqUS5NcB1IghR/43hJ/nyKLZYqGp7cLHc=;
        b=KOVKaOLr/mGD26bKLBt3VtE9M6/J5ekKnGXKAiscdmknv+tyFTqVxp6xpOBfYNOiAu
         615Vhtz5ZgqtiFSHhyeDDLDG7H2jjHUkp5SAhz9e/DQVRyz6w+KdtsPpHkcM48lKDV6w
         Iv3muSW3Io0+7HWfqLhKQCjlO+QI7HKB1SkBSkIQYJFWg1L5ZZvCt7qMFLRB8QT/1gA1
         TI45KJqiUW4onQebFe8g1mxD2IbVFjVDC/barnQkGQbjEg37gyLpJSJHaxXtSNPRZfvj
         UfYwFHGIhZ9efwpMh5YYldrmJm4fWT7yXtzyodNqPynF3zY3XNWMQIAl1itcSEuQIYtm
         7wrA==
X-Gm-Message-State: AOAM530Eh2bo+bJeiCaI9HGXzdUmH0e8APGOHaKLFLlNT2srKIn75rfO
        KfcUli8y6+VwrWpoqTC1BzE6XZv3J1dWLoyX2/M=
X-Google-Smtp-Source: ABdhPJx4HHXvKoTxDY10PkfruxNGIw8pJuu/QWbdKUKg244/s77B28l5JD8HOtMhnJ/LN5bIa/UfLSuiQsamW3hf7tk=
X-Received: by 2002:a05:6e02:156e:: with SMTP id k14mr4791422ilu.200.1615473204304;
 Thu, 11 Mar 2021 06:33:24 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-6-git-send-email-dillon.minfei@gmail.com>
 <b5f96460-dcdf-f40a-89d7-89def5669d7b@foss.st.com> <CAL9mu0+YFC97OBNLH-gip+MFKfdX4rAaxsFB4rMNrgjmhc5=Rw@mail.gmail.com>
 <2c816d16-9925-c52f-6ead-a0112026df28@foss.st.com>
In-Reply-To: <2c816d16-9925-c52f-6ead-a0112026df28@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 11 Mar 2021 22:32:52 +0800
Message-ID: <CAL9mu0KfwL2W-WytH+EjAf6g-tebuJ3wut8AuZ1trvHFdwRW4Q@mail.gmail.com>
Subject: Re: [PATCH 5/8] ARM: dts: stm32: introduce stm32h7-pinctrl.dtsi to
 support stm32h75x
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre

On Thu, Mar 11, 2021 at 9:30 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Dillon
>
> On 3/11/21 1:23 PM, dillon min wrote:
> > Hi Alexandre
> >
> > On Thu, Mar 11, 2021 at 6:40 PM Alexandre TORGUE
> > <alexandre.torgue@foss.st.com> wrote:
> >>
> >> Hi Dillon
> >>
> >> On 3/3/21 9:05 AM, dillon.minfei@gmail.com wrote:
> >>> From: dillon min <dillon.minfei@gmail.com>
> >>>
> >>> To support stm32h750 and stm32h743, we need a base stm32h7-pinctrl.dt=
si
> >>> as stm32h743 & h750 has almost the same interface. so, just rename
> >>> stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
> >>>
> >>
> >> You do not "just" rename but you keel also the old version. I don't
> >> agree with this approach. You have first to rename
> >> stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (keeping copyright as
> >> they are please) and modify existing H7 boards which currently use
> >> stm32h743-pinctrl.dtsi.
> >> Then you create a second patch adding your pingroups.
> > For stm32h7's new board support , I guess following the stm32f7/stm32f4=
's style
>
> Yes sorry, I read it too quickly
>
> > is a reasonable way to do it, but add a little optimization=E3=80=82
> > which means :
> > old structure
> > stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi  (referenced by
> > stm32h743i-disco, -eval)
> >                                  |--> stm32h750-pinctrl.dtsi
> > (referenced by stm32h750i-art-pi, etc)
> > add art-pi other board's pin definition in stm32h750-pinctrl.dtsi with
> > xxx_pins_a, xxx_pins_b
> > xxx_pins_a used for art-pi, xxx_pins_b used for other boards.
> >
> > after more boards add in support, there will be more xxx_pin_c, .... de=
fined
> >
> > as the pin map is according to the hardware schematic diagram io connec=
tion.
> > so, why not move xxx_pin_x to a board specific place. such as
> > stm32h750i-art-pi.dts
> >
> > new structure:
> > 1, rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (only
> > preserve gpioa...k,)
> > 2, move xxx_pins_x from stm32h7-pinctrl.dtsi to
> > stm32h7xx-disco/eval/art-pi/etc.dts (as they depends on hardware
> > schematic)
> >
> > stm32h7-pinctrl.dtsi --> stm32h743i-discon.dts
> >                                  |--> stm32h743i-eval.dts
> >                                  |--> stm32h750i-art-pi.dts
> >                                  |--> stm32h7xxx.dts
> > would you agree this ?
>
> :) it remember me an old discussion we had with Ahmad or Marek. My first
> feeling is "The group definition follow the SoC, and the group choice is
> done on the board". But As said in the past I have to think more about
> this topic and check how it could be reorganize (as it would be nice to
> have the same approach for MPU and MCU boards.) I'll try to post
> something soon. Waiting that this patch looks. As you mainly change the
> name can you keep please header (copyright) as they were initially.
Okay, got it. before your patch for pinctrl update. I am just totally follo=
wing
your current style.
For file author name, copyright. i'm really sorry for that. this is
the first time for me
to add a board support, i'm not intended to replace with my name, just too
many files to change, wasn't beware of the difference with author name for =
new
created file and existing file . will be changed back in the next submit.
>
> >>
> >> Now regarding "st,stm32h750-pinctrl", I see a patch dealing with this
> >> new binding but no update on driver side. Do I miss something ? what a=
re
> >> differences between h743 and h750 regarding pinctrl ?
> > Oh, i forget to add pin driver under drivers/pinctrl/stm32/
> > will add it next time.
> >>
> >> Regards
> >> Alex
> >>
> >>> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> >>> ---
> >>>    arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 392 +++++++++++++++++++=
++++++++++++
> >>>    arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 307 +------------------=
-----
> >>>    2 files changed, 398 insertions(+), 301 deletions(-)
> >>>    create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> >>>
> >>> diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/d=
ts/stm32h7-pinctrl.dtsi
> >>> new file mode 100644
> >>> index 000000000000..7d4b5d683ccc
> >>> --- /dev/null
> >>> +++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> >>> @@ -0,0 +1,392 @@
> >>> +/*
> >>> + * Copyright 2021 - Dillon Min <dillon.minfei@gmail.com>
> >>> + *
> >>> + * This file is dual-licensed: you can use it either under the terms
> >>> + * of the GPL or the X11 license, at your option. Note that this dua=
l
> >>> + * licensing only applies to this file, and not this project as a
> >>> + * whole.
> >>> + *
> >>> + *  a) This file is free software; you can redistribute it and/or
> >>> + *     modify it under the terms of the GNU General Public License a=
s
> >>> + *     published by the Free Software Foundation; either version 2 o=
f the
> >>> + *     License, or (at your option) any later version.
> >>> + *
> >>> + *     This file is distributed in the hope that it will be useful,
> >>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
> >>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> + *     GNU General Public License for more details.
> >>> + *
> >>> + * Or, alternatively,
> >>> + *
> >>> + *  b) Permission is hereby granted, free of charge, to any person
> >>> + *     obtaining a copy of this software and associated documentatio=
n
> >>> + *     files (the "Software"), to deal in the Software without
> >>> + *     restriction, including without limitation the rights to use,
> >>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> >>> + *     sell copies of the Software, and to permit persons to whom th=
e
> >>> + *     Software is furnished to do so, subject to the following
> >>> + *     conditions:
> >>> + *
> >>> + *     The above copyright notice and this permission notice shall b=
e
> >>> + *     included in all copies or substantial portions of the Softwar=
e.
> >>> + *
> >>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIN=
D,
> >>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTI=
ES
> >>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>> + *     OTHER DEALINGS IN THE SOFTWARE.
> >>> + */
> >>> +
> >>> +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> >>> +
> >>> +/ {
> >>> +     soc {
> >>> +             pinctrl: pin-controller {
> >>> +                     #address-cells =3D <1>;
> >>> +                     #size-cells =3D <1>;
> >>> +                     ranges =3D <0 0x58020000 0x3000>;
> >>> +                     interrupt-parent =3D <&exti>;
> >>> +                     st,syscfg =3D <&syscfg 0x8>;
> >>> +                     pins-are-numbered;
> >>> +
> >>> +                     gpioa: gpio@58020000 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x0 0x400>;
> >>> +                             clocks =3D <&rcc GPIOA_CK>;
> >>> +                             st,bank-name =3D "GPIOA";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpiob: gpio@58020400 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x400 0x400>;
> >>> +                             clocks =3D <&rcc GPIOB_CK>;
> >>> +                             st,bank-name =3D "GPIOB";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpioc: gpio@58020800 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x800 0x400>;
> >>> +                             clocks =3D <&rcc GPIOC_CK>;
> >>> +                             st,bank-name =3D "GPIOC";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpiod: gpio@58020c00 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0xc00 0x400>;
> >>> +                             clocks =3D <&rcc GPIOD_CK>;
> >>> +                             st,bank-name =3D "GPIOD";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpioe: gpio@58021000 {
> >>> +                             gpio-controller;
> >
> >>> +                             reg =3D <0x1000 0x400>;
> >>> +                             clocks =3D <&rcc GPIOE_CK>;
> >>> +                             st,bank-name =3D "GPIOE";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpiof: gpio@58021400 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x1400 0x400>;
> >>> +                             clocks =3D <&rcc GPIOF_CK>;
> >>> +                             st,bank-name =3D "GPIOF";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpiog: gpio@58021800 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x1800 0x400>;
> >>> +                             clocks =3D <&rcc GPIOG_CK>;
> >>> +                             st,bank-name =3D "GPIOG";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpioh: gpio@58021c00 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x1c00 0x400>;
> >>> +                             clocks =3D <&rcc GPIOH_CK>;
> >>> +                             st,bank-name =3D "GPIOH";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpioi: gpio@58022000 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x2000 0x400>;
> >>> +                             clocks =3D <&rcc GPIOI_CK>;
> >>> +                             st,bank-name =3D "GPIOI";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpioj: gpio@58022400 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x2400 0x400>;
> >>> +                             clocks =3D <&rcc GPIOJ_CK>;
> >>> +                             st,bank-name =3D "GPIOJ";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     gpiok: gpio@58022800 {
> >>> +                             gpio-controller;
> >>> +                             #gpio-cells =3D <2>;
> >>> +                             reg =3D <0x2800 0x400>;
> >>> +                             clocks =3D <&rcc GPIOK_CK>;
> >>> +                             st,bank-name =3D "GPIOK";
> >>> +                             interrupt-controller;
> >>> +                             #interrupt-cells =3D <2>;
> >>> +                     };
> >>> +
> >>> +                     i2c1_pins_a: i2c1-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 6=
, AF4)>, /* I2C1_SCL */
> >>> +                                              <STM32_PINMUX('B', 7, =
AF4)>; /* I2C1_SDA */
> >>> +                                     bias-disable;
> >>> +                                     drive-open-drain;
> >>> +                                     slew-rate =3D <0>;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     ethernet_rmii: rmii-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('G', 1=
1, AF11)>,
> >>> +                                              <STM32_PINMUX('G', 13,=
 AF11)>,
> >>> +                                              <STM32_PINMUX('G', 12,=
 AF11)>,
> >>> +                                              <STM32_PINMUX('C', 4, =
AF11)>,
> >>> +                                              <STM32_PINMUX('C', 5, =
AF11)>,
> >>> +                                              <STM32_PINMUX('A', 7, =
AF11)>,
> >>> +                                              <STM32_PINMUX('C', 1, =
AF11)>,
> >>> +                                              <STM32_PINMUX('A', 2, =
AF11)>,
> >>> +                                              <STM32_PINMUX('A', 1, =
AF11)>;
> >>> +                                     slew-rate =3D <2>;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('C', 8=
, AF12)>, /* SDMMC1_D0 */
> >>> +                                              <STM32_PINMUX('C', 9, =
AF12)>, /* SDMMC1_D1 */
> >>> +                                              <STM32_PINMUX('C', 10,=
 AF12)>, /* SDMMC1_D2 */
> >>> +                                              <STM32_PINMUX('C', 11,=
 AF12)>, /* SDMMC1_D3 */
> >>> +                                              <STM32_PINMUX('C', 12,=
 AF12)>, /* SDMMC1_CK */
> >>> +                                              <STM32_PINMUX('D', 2, =
AF12)>; /* SDMMC1_CMD */
> >>> +                                     slew-rate =3D <3>;
> >>> +                                     drive-push-pull;
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('C', 8=
, AF12)>, /* SDMMC1_D0 */
> >>> +                                              <STM32_PINMUX('C', 9, =
AF12)>, /* SDMMC1_D1 */
> >>> +                                              <STM32_PINMUX('C', 10,=
 AF12)>, /* SDMMC1_D2 */
> >>> +                                              <STM32_PINMUX('C', 11,=
 AF12)>, /* SDMMC1_D3 */
> >>> +                                              <STM32_PINMUX('C', 12,=
 AF12)>; /* SDMMC1_CK */
> >>> +                                     slew-rate =3D <3>;
> >>> +                                     drive-push-pull;
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                             pins2{
> >>> +                                     pinmux =3D <STM32_PINMUX('D', 2=
, AF12)>; /* SDMMC1_CMD */
> >>> +                                     slew-rate =3D <3>;
> >>> +                                     drive-open-drain;
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('C', 8=
, ANALOG)>, /* SDMMC1_D0 */
> >>> +                                              <STM32_PINMUX('C', 9, =
ANALOG)>, /* SDMMC1_D1 */
> >>> +                                              <STM32_PINMUX('C', 10,=
 ANALOG)>, /* SDMMC1_D2 */
> >>> +                                              <STM32_PINMUX('C', 11,=
 ANALOG)>, /* SDMMC1_D3 */
> >>> +                                              <STM32_PINMUX('C', 12,=
 ANALOG)>, /* SDMMC1_CK */
> >>> +                                              <STM32_PINMUX('D', 2, =
ANALOG)>; /* SDMMC1_CMD */
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc2_b4_pins_a: sdmmc2-b4-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 1=
4, AF9)>, /* SDMMC1_D0 */
> >>> +                                              <STM32_PINMUX('B', 15,=
 AF9)>, /* SDMMC1_D1 */
> >>> +                                              <STM32_PINMUX('B', 3, =
AF9)>, /* SDMMC1_D2 */
> >>> +                                              <STM32_PINMUX('B', 4, =
AF9)>, /* SDMMC1_D3 */
> >>> +                                              <STM32_PINMUX('D', 6, =
AF11)>, /* SDMMC1_CK */
> >>> +                                              <STM32_PINMUX('D', 7, =
AF11)>; /* SDMMC1_CMD */
> >>> +                                     slew-rate =3D <3>;
> >>> +                                     drive-push-pull;
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 1=
4, AF9)>, /* SDMMC2_D0 */
> >>> +                                              <STM32_PINMUX('B', 15,=
 AF9)>, /* SDMMC1_D1 */
> >>> +                                              <STM32_PINMUX('B', 3, =
AF9)>, /* SDMMC1_D2 */
> >>> +                                              <STM32_PINMUX('B', 4, =
AF9)>, /* SDMMC1_D3 */
> >>> +                                              <STM32_PINMUX('D', 6, =
AF11)>; /* SDMMC1_CK */
> >>> +                                     slew-rate =3D <3>;
> >>> +                                     drive-push-pull;
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                             pins2{
> >>> +                                     pinmux =3D <STM32_PINMUX('D', 7=
, AF11)>; /* SDMMC1_CMD */
> >>> +                                     slew-rate =3D <3>;
> >>> +                                     drive-open-drain;
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 1=
4, ANALOG)>, /* SDMMC1_D0 */
> >>> +                                              <STM32_PINMUX('B', 15,=
 ANALOG)>, /* SDMMC1_D1 */
> >>> +                                              <STM32_PINMUX('B', 3, =
ANALOG)>, /* SDMMC1_D2 */
> >>> +                                              <STM32_PINMUX('B', 4, =
ANALOG)>, /* SDMMC1_D3 */
> >>> +                                              <STM32_PINMUX('D', 6, =
ANALOG)>, /* SDMMC1_CK */
> >>> +                                              <STM32_PINMUX('D', 7, =
ANALOG)>; /* SDMMC1_CMD */
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('C', 6=
, AF8)>, /* SDMMC1_D0DIR */
> >>> +                                              <STM32_PINMUX('C', 7, =
AF8)>, /* SDMMC1_D123DIR */
> >>> +                                              <STM32_PINMUX('B', 9, =
AF7)>; /* SDMMC1_CDIR */
> >>> +                                     slew-rate =3D <3>;
> >>> +                                     drive-push-pull;
> >>> +                                     bias-pull-up;
> >>> +                             };
> >>> +                             pins2{
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 8=
, AF7)>; /* SDMMC1_CKIN */
> >>> +                                     bias-pull-up;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('C', 6=
, ANALOG)>, /* SDMMC1_D0DIR */
> >>> +                                              <STM32_PINMUX('C', 7, =
ANALOG)>, /* SDMMC1_D123DIR */
> >>> +                                              <STM32_PINMUX('B', 9, =
ANALOG)>, /* SDMMC1_CDIR */
> >>> +                                              <STM32_PINMUX('B', 8, =
ANALOG)>; /* SDMMC1_CKIN */
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     usart1_pins: usart1-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 1=
4, AF4)>; /* USART1_TX */
> >>> +                                     bias-disable;
> >>> +                                     drive-push-pull;
> >>> +                                     slew-rate =3D <0>;
> >>> +                             };
> >>> +                             pins2 {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 1=
5, AF4)>; /* USART1_RX */
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     usart2_pins: usart2-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('D', 5=
, AF7)>; /* USART2_TX */
> >>> +                                     bias-disable;
> >>> +                                     drive-push-pull;
> >>> +                                     slew-rate =3D <0>;
> >>> +                             };
> >>> +                             pins2 {
> >>> +                                     pinmux =3D <STM32_PINMUX('D', 6=
, AF7)>; /* USART2_RX */
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     usart3_pins: usart3-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 1=
0, AF7)>; /* USART3_TX */
> >>> +                                     bias-disable;
> >>> +                                     drive-push-pull;
> >>> +                                     slew-rate =3D <0>;
> >>> +                             };
> >>> +                             pins2 {
> >>> +                                     pinmux =3D <STM32_PINMUX('B', 1=
1, AF7)>; /* USART3_RX */
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     uart4_pins: uart4-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('A', 0=
, AF8)>; /* UART4_TX */
> >>> +                                     bias-disable;
> >>> +                                     drive-push-pull;
> >>> +                                     slew-rate =3D <0>;
> >>> +                             };
> >>> +                             pins2 {
> >>> +                                     pinmux =3D <STM32_PINMUX('I', 9=
, AF8)>; /* UART4_RX */
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     usbotg_hs_pins_a: usbotg-hs-0 {
> >>> +                             pins {
> >>> +                                     pinmux =3D <STM32_PINMUX('H', 4=
, AF10)>,  /* ULPI_NXT */
> >>> +                                                      <STM32_PINMUX(=
'I', 11, AF10)>, /* ULPI_DIR> */
> >>> +                                                      <STM32_PINMUX(=
'C', 0, AF10)>,  /* ULPI_STP> */
> >>> +                                                      <STM32_PINMUX(=
'A', 5, AF10)>,  /* ULPI_CK> */
> >>> +                                                      <STM32_PINMUX(=
'A', 3, AF10)>,  /* ULPI_D0> */
> >>> +                                                      <STM32_PINMUX(=
'B', 0, AF10)>,  /* ULPI_D1> */
> >>> +                                                      <STM32_PINMUX(=
'B', 1, AF10)>,  /* ULPI_D2> */
> >>> +                                                      <STM32_PINMUX(=
'B', 10, AF10)>, /* ULPI_D3> */
> >>> +                                                      <STM32_PINMUX(=
'B', 11, AF10)>, /* ULPI_D4> */
> >>> +                                                      <STM32_PINMUX(=
'B', 12, AF10)>, /* ULPI_D5> */
> >>> +                                                      <STM32_PINMUX(=
'B', 13, AF10)>, /* ULPI_D6> */
> >>> +                                                      <STM32_PINMUX(=
'B', 5, AF10)>;  /* ULPI_D7> */
> >>> +                                     bias-disable;
> >>> +                                     drive-push-pull;
> >>> +                                     slew-rate =3D <2>;
> >>> +                             };
> >>> +                     };
> >>> +
> >>> +                     spi1_pins: spi1-0 {
> >>> +                             pins1 {
> >>> +                                     pinmux =3D <STM32_PINMUX('A', 5=
, AF5)>,
> >>> +                                             /* SPI1_CLK */
> >>> +                                              <STM32_PINMUX('B', 5, =
AF5)>;
> >>> +                                             /* SPI1_MOSI */
> >>> +                                     bias-disable;
> >>> +                                     drive-push-pull;
> >>> +                                     slew-rate =3D <2>;
> >>> +                             };
> >>> +                             pins2 {
> >>> +                                     pinmux =3D <STM32_PINMUX('G', 9=
, AF5)>;
> >>> +                                             /* SPI1_MISO */
> >>> +                                     bias-disable;
> >>> +                             };
> >>> +                     };
> >>> +             };
> >>> +     };
> >>> +};
> >>> diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot=
/dts/stm32h743-pinctrl.dtsi
> >>> index fa5dcb6a5fdd..6b1e115307b9 100644
> >>> --- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> >>> +++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> >>> @@ -1,306 +1,11 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >>>    /*
> >>> - * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
> >>> - *
> >>> - * This file is dual-licensed: you can use it either under the terms
> >>> - * of the GPL or the X11 license, at your option. Note that this dua=
l
> >>> - * licensing only applies to this file, and not this project as a
> >>> - * whole.
> >>> - *
> >>> - *  a) This file is free software; you can redistribute it and/or
> >>> - *     modify it under the terms of the GNU General Public License a=
s
> >>> - *     published by the Free Software Foundation; either version 2 o=
f the
> >>> - *     License, or (at your option) any later version.
> >>> - *
> >>> - *     This file is distributed in the hope that it will be useful,
> >>> - *     but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
> >>> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>> - *     GNU General Public License for more details.
> >>> - *
> >>> - * Or, alternatively,
> >>> - *
> >>> - *  b) Permission is hereby granted, free of charge, to any person
> >>> - *     obtaining a copy of this software and associated documentatio=
n
> >>> - *     files (the "Software"), to deal in the Software without
> >>> - *     restriction, including without limitation the rights to use,
> >>> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> >>> - *     sell copies of the Software, and to permit persons to whom th=
e
> >>> - *     Software is furnished to do so, subject to the following
> >>> - *     conditions:
> >>> - *
> >>> - *     The above copyright notice and this permission notice shall b=
e
> >>> - *     included in all copies or substantial portions of the Softwar=
e.
> >>> - *
> >>> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIN=
D,
> >>> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTI=
ES
> >>> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> >>> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> >>> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> >>> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> >>> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> >>> - *     OTHER DEALINGS IN THE SOFTWARE.
> >>> + * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
> >>> + * Author: Alexandre Torgue  <alexandre.torgue@st.com> for STMicroel=
ectronics.
> >>>     */
> >>>
> >>> -#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> >>> +#include "stm32h7-pinctrl.dtsi"
> >>>
> >>> -/ {
> >>> -     soc {
> >>> -             pin-controller {
> >>> -                     #address-cells =3D <1>;
> >>> -                     #size-cells =3D <1>;
> >>> -                     compatible =3D "st,stm32h743-pinctrl";
> >>> -                     ranges =3D <0 0x58020000 0x3000>;
> >>> -                     interrupt-parent =3D <&exti>;
> >>> -                     st,syscfg =3D <&syscfg 0x8>;
> >>> -                     pins-are-numbered;
> >>> -
> >>> -                     gpioa: gpio@58020000 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x0 0x400>;
> >>> -                             clocks =3D <&rcc GPIOA_CK>;
> >>> -                             st,bank-name =3D "GPIOA";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpiob: gpio@58020400 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x400 0x400>;
> >>> -                             clocks =3D <&rcc GPIOB_CK>;
> >>> -                             st,bank-name =3D "GPIOB";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpioc: gpio@58020800 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x800 0x400>;
> >>> -                             clocks =3D <&rcc GPIOC_CK>;
> >>> -                             st,bank-name =3D "GPIOC";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpiod: gpio@58020c00 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0xc00 0x400>;
> >>> -                             clocks =3D <&rcc GPIOD_CK>;
> >>> -                             st,bank-name =3D "GPIOD";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpioe: gpio@58021000 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x1000 0x400>;
> >>> -                             clocks =3D <&rcc GPIOE_CK>;
> >>> -                             st,bank-name =3D "GPIOE";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpiof: gpio@58021400 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x1400 0x400>;
> >>> -                             clocks =3D <&rcc GPIOF_CK>;
> >>> -                             st,bank-name =3D "GPIOF";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpiog: gpio@58021800 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x1800 0x400>;
> >>> -                             clocks =3D <&rcc GPIOG_CK>;
> >>> -                             st,bank-name =3D "GPIOG";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpioh: gpio@58021c00 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x1c00 0x400>;
> >>> -                             clocks =3D <&rcc GPIOH_CK>;
> >>> -                             st,bank-name =3D "GPIOH";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpioi: gpio@58022000 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x2000 0x400>;
> >>> -                             clocks =3D <&rcc GPIOI_CK>;
> >>> -                             st,bank-name =3D "GPIOI";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpioj: gpio@58022400 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x2400 0x400>;
> >>> -                             clocks =3D <&rcc GPIOJ_CK>;
> >>> -                             st,bank-name =3D "GPIOJ";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     gpiok: gpio@58022800 {
> >>> -                             gpio-controller;
> >>> -                             #gpio-cells =3D <2>;
> >>> -                             reg =3D <0x2800 0x400>;
> >>> -                             clocks =3D <&rcc GPIOK_CK>;
> >>> -                             st,bank-name =3D "GPIOK";
> >>> -                             interrupt-controller;
> >>> -                             #interrupt-cells =3D <2>;
> >>> -                     };
> >>> -
> >>> -                     i2c1_pins_a: i2c1-0 {
> >>> -                             pins {
> >>> -                                     pinmux =3D <STM32_PINMUX('B', 6=
, AF4)>, /* I2C1_SCL */
> >>> -                                              <STM32_PINMUX('B', 7, =
AF4)>; /* I2C1_SDA */
> >>> -                                     bias-disable;
> >>> -                                     drive-open-drain;
> >>> -                                     slew-rate =3D <0>;
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     ethernet_rmii: rmii-0 {
> >>> -                             pins {
> >>> -                                     pinmux =3D <STM32_PINMUX('G', 1=
1, AF11)>,
> >>> -                                              <STM32_PINMUX('G', 13,=
 AF11)>,
> >>> -                                              <STM32_PINMUX('G', 12,=
 AF11)>,
> >>> -                                              <STM32_PINMUX('C', 4, =
AF11)>,
> >>> -                                              <STM32_PINMUX('C', 5, =
AF11)>,
> >>> -                                              <STM32_PINMUX('A', 7, =
AF11)>,
> >>> -                                              <STM32_PINMUX('C', 1, =
AF11)>,
> >>> -                                              <STM32_PINMUX('A', 2, =
AF11)>,
> >>> -                                              <STM32_PINMUX('A', 1, =
AF11)>;
> >>> -                                     slew-rate =3D <2>;
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> >>> -                             pins {
> >>> -                                     pinmux =3D <STM32_PINMUX('C', 8=
, AF12)>, /* SDMMC1_D0 */
> >>> -                                              <STM32_PINMUX('C', 9, =
AF12)>, /* SDMMC1_D1 */
> >>> -                                              <STM32_PINMUX('C', 10,=
 AF12)>, /* SDMMC1_D2 */
> >>> -                                              <STM32_PINMUX('C', 11,=
 AF12)>, /* SDMMC1_D3 */
> >>> -                                              <STM32_PINMUX('C', 12,=
 AF12)>, /* SDMMC1_CK */
> >>> -                                              <STM32_PINMUX('D', 2, =
AF12)>; /* SDMMC1_CMD */
> >>> -                                     slew-rate =3D <3>;
> >>> -                                     drive-push-pull;
> >>> -                                     bias-disable;
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> >>> -                             pins1 {
> >>> -                                     pinmux =3D <STM32_PINMUX('C', 8=
, AF12)>, /* SDMMC1_D0 */
> >>> -                                              <STM32_PINMUX('C', 9, =
AF12)>, /* SDMMC1_D1 */
> >>> -                                              <STM32_PINMUX('C', 10,=
 AF12)>, /* SDMMC1_D2 */
> >>> -                                              <STM32_PINMUX('C', 11,=
 AF12)>, /* SDMMC1_D3 */
> >>> -                                              <STM32_PINMUX('C', 12,=
 AF12)>; /* SDMMC1_CK */
> >>> -                                     slew-rate =3D <3>;
> >>> -                                     drive-push-pull;
> >>> -                                     bias-disable;
> >>> -                             };
> >>> -                             pins2{
> >>> -                                     pinmux =3D <STM32_PINMUX('D', 2=
, AF12)>; /* SDMMC1_CMD */
> >>> -                                     slew-rate =3D <3>;
> >>> -                                     drive-open-drain;
> >>> -                                     bias-disable;
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> >>> -                             pins {
> >>> -                                     pinmux =3D <STM32_PINMUX('C', 8=
, ANALOG)>, /* SDMMC1_D0 */
> >>> -                                              <STM32_PINMUX('C', 9, =
ANALOG)>, /* SDMMC1_D1 */
> >>> -                                              <STM32_PINMUX('C', 10,=
 ANALOG)>, /* SDMMC1_D2 */
> >>> -                                              <STM32_PINMUX('C', 11,=
 ANALOG)>, /* SDMMC1_D3 */
> >>> -                                              <STM32_PINMUX('C', 12,=
 ANALOG)>, /* SDMMC1_CK */
> >>> -                                              <STM32_PINMUX('D', 2, =
ANALOG)>; /* SDMMC1_CMD */
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> >>> -                             pins1 {
> >>> -                                     pinmux =3D <STM32_PINMUX('C', 6=
, AF8)>, /* SDMMC1_D0DIR */
> >>> -                                              <STM32_PINMUX('C', 7, =
AF8)>, /* SDMMC1_D123DIR */
> >>> -                                              <STM32_PINMUX('B', 9, =
AF7)>; /* SDMMC1_CDIR */
> >>> -                                     slew-rate =3D <3>;
> >>> -                                     drive-push-pull;
> >>> -                                     bias-pull-up;
> >>> -                             };
> >>> -                             pins2{
> >>> -                                     pinmux =3D <STM32_PINMUX('B', 8=
, AF7)>; /* SDMMC1_CKIN */
> >>> -                                     bias-pull-up;
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> >>> -                             pins {
> >>> -                                     pinmux =3D <STM32_PINMUX('C', 6=
, ANALOG)>, /* SDMMC1_D0DIR */
> >>> -                                              <STM32_PINMUX('C', 7, =
ANALOG)>, /* SDMMC1_D123DIR */
> >>> -                                              <STM32_PINMUX('B', 9, =
ANALOG)>, /* SDMMC1_CDIR */
> >>> -                                              <STM32_PINMUX('B', 8, =
ANALOG)>; /* SDMMC1_CKIN */
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     usart1_pins: usart1-0 {
> >>> -                             pins1 {
> >>> -                                     pinmux =3D <STM32_PINMUX('B', 1=
4, AF4)>; /* USART1_TX */
> >>> -                                     bias-disable;
> >>> -                                     drive-push-pull;
> >>> -                                     slew-rate =3D <0>;
> >>> -                             };
> >>> -                             pins2 {
> >>> -                                     pinmux =3D <STM32_PINMUX('B', 1=
5, AF4)>; /* USART1_RX */
> >>> -                                     bias-disable;
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     usart2_pins: usart2-0 {
> >>> -                             pins1 {
> >>> -                                     pinmux =3D <STM32_PINMUX('D', 5=
, AF7)>; /* USART2_TX */
> >>> -                                     bias-disable;
> >>> -                                     drive-push-pull;
> >>> -                                     slew-rate =3D <0>;
> >>> -                             };
> >>> -                             pins2 {
> >>> -                                     pinmux =3D <STM32_PINMUX('D', 6=
, AF7)>; /* USART2_RX */
> >>> -                                     bias-disable;
> >>> -                             };
> >>> -                     };
> >>> -
> >>> -                     usbotg_hs_pins_a: usbotg-hs-0 {
> >>> -                             pins {
> >>> -                                     pinmux =3D <STM32_PINMUX('H', 4=
, AF10)>,  /* ULPI_NXT */
> >>> -                                                      <STM32_PINMUX(=
'I', 11, AF10)>, /* ULPI_DIR> */
> >>> -                                                      <STM32_PINMUX(=
'C', 0, AF10)>,  /* ULPI_STP> */
> >>> -                                                      <STM32_PINMUX(=
'A', 5, AF10)>,  /* ULPI_CK> */
> >>> -                                                      <STM32_PINMUX(=
'A', 3, AF10)>,  /* ULPI_D0> */
> >>> -                                                      <STM32_PINMUX(=
'B', 0, AF10)>,  /* ULPI_D1> */
> >>> -                                                      <STM32_PINMUX(=
'B', 1, AF10)>,  /* ULPI_D2> */
> >>> -                                                      <STM32_PINMUX(=
'B', 10, AF10)>, /* ULPI_D3> */
> >>> -                                                      <STM32_PINMUX(=
'B', 11, AF10)>, /* ULPI_D4> */
> >>> -                                                      <STM32_PINMUX(=
'B', 12, AF10)>, /* ULPI_D5> */
> >>> -                                                      <STM32_PINMUX(=
'B', 13, AF10)>, /* ULPI_D6> */
> >>> -                                                      <STM32_PINMUX(=
'B', 5, AF10)>;  /* ULPI_D7> */
> >>> -                                     bias-disable;
> >>> -                                     drive-push-pull;
> >>> -                                     slew-rate =3D <2>;
> >>> -                             };
> >>> -                     };
> >>> -             };
> >>> -     };
> >>> +&pinctrl{
> >>> +     compatible =3D "st,stm32h743-pinctrl";
> >>>    };
> >>>
