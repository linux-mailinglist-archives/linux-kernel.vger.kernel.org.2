Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B55D33727B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhCKMYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbhCKMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:23:43 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0AC061574;
        Thu, 11 Mar 2021 04:23:43 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id a7so21628190iok.12;
        Thu, 11 Mar 2021 04:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/1eRW92JwOgmgHh8pStulchqrdZFv0PvHzTi4ooGlbU=;
        b=ABAe0EbAisZxs26ZAzCsiZ452rI64Irkpb+JwQW0b+Gb6Xitdf0Am2zRNms+qYRp98
         49QmR7Ix+9a5Jn7Mipp3xpAWNDxYlNOkOjhZ+eghS3kU0dKDE7U40Yv+AKbFYo/ebI7a
         N/+iQ2q9KENxfZl1U7rhr1NCIsX2n1izzZoGat7grASUsdKJKO7JEVLpZN0JHv6Ixkek
         pFbhN5tEYcRYMSDzscSkwgW2DEJVLLNyYLIExhfxvTrgOM+wxLDE72vMM+E6i3ZqQLAc
         Oprc4gfpz9RIrrzhRlHGgN9pf2X8rcOeCsNXrPH3TAXJca0v3kQIpo+IrFIAGBoMSx4U
         pawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/1eRW92JwOgmgHh8pStulchqrdZFv0PvHzTi4ooGlbU=;
        b=i6hQ5IzIT/2U907NaV63qneIxRRGKZvOQwJEGs6fV5lwMTPtz+J2sWc4A6AKu7u3OD
         iConyfMECYsNZlql5p4sgzxyMInoeS2gsroY/trH5GI2neY3jK4SC8ScylWktcxFWHHC
         iioU2PjLzZE7+kYgGv7VXmvtN5sGGT2DYs6FNe79v/upzb6v4LaohQz1gFZJQO5hZCiv
         e4u6x/O5Sufii5KcoCj+s/yFs/iwuaatkq5zTwxqbC/nroFuaFQi5QgWbKaM+CFGUNHy
         nB17WmhCWNiZ/4qnq9IAFWnZVCfxjSPn047VNziV8kfu933DOkuXwok4yzmpQkpr2udL
         Mh6Q==
X-Gm-Message-State: AOAM532oq6FMh7rLCSVcaJ4wF2pVhrwi/sx96fIyFia5CfwQaRRO9RBe
        fDXf6BfIbXOuT4gMdAdHX+dtJhlSBzKHinck3uY=
X-Google-Smtp-Source: ABdhPJy/ZsNUqDhFLax1SpPodTPJsqWw/8DfqL5A2w8M0F8Ofjw/0zhUgxnlm11nAkD845LjFXP9rJfpfQYZeD6sAIE=
X-Received: by 2002:a05:6602:280f:: with SMTP id d15mr5792774ioe.127.1615465422526;
 Thu, 11 Mar 2021 04:23:42 -0800 (PST)
MIME-Version: 1.0
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-6-git-send-email-dillon.minfei@gmail.com> <b5f96460-dcdf-f40a-89d7-89def5669d7b@foss.st.com>
In-Reply-To: <b5f96460-dcdf-f40a-89d7-89def5669d7b@foss.st.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Thu, 11 Mar 2021 20:23:06 +0800
Message-ID: <CAL9mu0+YFC97OBNLH-gip+MFKfdX4rAaxsFB4rMNrgjmhc5=Rw@mail.gmail.com>
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

On Thu, Mar 11, 2021 at 6:40 PM Alexandre TORGUE
<alexandre.torgue@foss.st.com> wrote:
>
> Hi Dillon
>
> On 3/3/21 9:05 AM, dillon.minfei@gmail.com wrote:
> > From: dillon min <dillon.minfei@gmail.com>
> >
> > To support stm32h750 and stm32h743, we need a base stm32h7-pinctrl.dtsi
> > as stm32h743 & h750 has almost the same interface. so, just rename
> > stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi
> >
>
> You do not "just" rename but you keel also the old version. I don't
> agree with this approach. You have first to rename
> stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (keeping copyright as
> they are please) and modify existing H7 boards which currently use
> stm32h743-pinctrl.dtsi.
> Then you create a second patch adding your pingroups.
For stm32h7's new board support , I guess following the stm32f7/stm32f4's s=
tyle
is a reasonable way to do it, but add a little optimization=E3=80=82
which means :
old structure
stm32h7-pinctrl.dtsi --> stm32h743-pinctrl.dtsi  (referenced by
stm32h743i-disco, -eval)
                                |--> stm32h750-pinctrl.dtsi
(referenced by stm32h750i-art-pi, etc)
add art-pi other board's pin definition in stm32h750-pinctrl.dtsi with
xxx_pins_a, xxx_pins_b
xxx_pins_a used for art-pi, xxx_pins_b used for other boards.

after more boards add in support, there will be more xxx_pin_c, .... define=
d

as the pin map is according to the hardware schematic diagram io connection=
.
so, why not move xxx_pin_x to a board specific place. such as
stm32h750i-art-pi.dts

new structure:
1, rename stm32h743-pinctrl.dtsi to stm32h7-pinctrl.dtsi (only
preserve gpioa...k,)
2, move xxx_pins_x from stm32h7-pinctrl.dtsi to
stm32h7xx-disco/eval/art-pi/etc.dts (as they depends on hardware
schematic)

stm32h7-pinctrl.dtsi --> stm32h743i-discon.dts
                                |--> stm32h743i-eval.dts
                                |--> stm32h750i-art-pi.dts
                                |--> stm32h7xxx.dts
would you agree this ?
>
> Now regarding "st,stm32h750-pinctrl", I see a patch dealing with this
> new binding but no update on driver side. Do I miss something ? what are
> differences between h743 and h750 regarding pinctrl ?
Oh, i forget to add pin driver under drivers/pinctrl/stm32/
will add it next time.
>
> Regards
> Alex
>
> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
> > ---
> >   arch/arm/boot/dts/stm32h7-pinctrl.dtsi   | 392 ++++++++++++++++++++++=
+++++++++
> >   arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 307 +---------------------=
--
> >   2 files changed, 398 insertions(+), 301 deletions(-)
> >   create mode 100644 arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> >
> > diff --git a/arch/arm/boot/dts/stm32h7-pinctrl.dtsi b/arch/arm/boot/dts=
/stm32h7-pinctrl.dtsi
> > new file mode 100644
> > index 000000000000..7d4b5d683ccc
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/stm32h7-pinctrl.dtsi
> > @@ -0,0 +1,392 @@
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
> > + *     published by the Free Software Foundation; either version 2 of =
the
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
> > +#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> > +
> > +/ {
> > +     soc {
> > +             pinctrl: pin-controller {
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     ranges =3D <0 0x58020000 0x3000>;
> > +                     interrupt-parent =3D <&exti>;
> > +                     st,syscfg =3D <&syscfg 0x8>;
> > +                     pins-are-numbered;
> > +
> > +                     gpioa: gpio@58020000 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x0 0x400>;
> > +                             clocks =3D <&rcc GPIOA_CK>;
> > +                             st,bank-name =3D "GPIOA";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpiob: gpio@58020400 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x400 0x400>;
> > +                             clocks =3D <&rcc GPIOB_CK>;
> > +                             st,bank-name =3D "GPIOB";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpioc: gpio@58020800 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x800 0x400>;
> > +                             clocks =3D <&rcc GPIOC_CK>;
> > +                             st,bank-name =3D "GPIOC";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpiod: gpio@58020c00 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0xc00 0x400>;
> > +                             clocks =3D <&rcc GPIOD_CK>;
> > +                             st,bank-name =3D "GPIOD";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpioe: gpio@58021000 {
> > +                             gpio-controller;

> > +                             reg =3D <0x1000 0x400>;
> > +                             clocks =3D <&rcc GPIOE_CK>;
> > +                             st,bank-name =3D "GPIOE";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpiof: gpio@58021400 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x1400 0x400>;
> > +                             clocks =3D <&rcc GPIOF_CK>;
> > +                             st,bank-name =3D "GPIOF";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpiog: gpio@58021800 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x1800 0x400>;
> > +                             clocks =3D <&rcc GPIOG_CK>;
> > +                             st,bank-name =3D "GPIOG";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpioh: gpio@58021c00 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x1c00 0x400>;
> > +                             clocks =3D <&rcc GPIOH_CK>;
> > +                             st,bank-name =3D "GPIOH";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpioi: gpio@58022000 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x2000 0x400>;
> > +                             clocks =3D <&rcc GPIOI_CK>;
> > +                             st,bank-name =3D "GPIOI";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpioj: gpio@58022400 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x2400 0x400>;
> > +                             clocks =3D <&rcc GPIOJ_CK>;
> > +                             st,bank-name =3D "GPIOJ";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     gpiok: gpio@58022800 {
> > +                             gpio-controller;
> > +                             #gpio-cells =3D <2>;
> > +                             reg =3D <0x2800 0x400>;
> > +                             clocks =3D <&rcc GPIOK_CK>;
> > +                             st,bank-name =3D "GPIOK";
> > +                             interrupt-controller;
> > +                             #interrupt-cells =3D <2>;
> > +                     };
> > +
> > +                     i2c1_pins_a: i2c1-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('B', 6, =
AF4)>, /* I2C1_SCL */
> > +                                              <STM32_PINMUX('B', 7, AF=
4)>; /* I2C1_SDA */
> > +                                     bias-disable;
> > +                                     drive-open-drain;
> > +                                     slew-rate =3D <0>;
> > +                             };
> > +                     };
> > +
> > +                     ethernet_rmii: rmii-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('G', 11,=
 AF11)>,
> > +                                              <STM32_PINMUX('G', 13, A=
F11)>,
> > +                                              <STM32_PINMUX('G', 12, A=
F11)>,
> > +                                              <STM32_PINMUX('C', 4, AF=
11)>,
> > +                                              <STM32_PINMUX('C', 5, AF=
11)>,
> > +                                              <STM32_PINMUX('A', 7, AF=
11)>,
> > +                                              <STM32_PINMUX('C', 1, AF=
11)>,
> > +                                              <STM32_PINMUX('A', 2, AF=
11)>,
> > +                                              <STM32_PINMUX('A', 1, AF=
11)>;
> > +                                     slew-rate =3D <2>;
> > +                             };
> > +                     };
> > +
> > +                     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('C', 8, =
AF12)>, /* SDMMC1_D0 */
> > +                                              <STM32_PINMUX('C', 9, AF=
12)>, /* SDMMC1_D1 */
> > +                                              <STM32_PINMUX('C', 10, A=
F12)>, /* SDMMC1_D2 */
> > +                                              <STM32_PINMUX('C', 11, A=
F12)>, /* SDMMC1_D3 */
> > +                                              <STM32_PINMUX('C', 12, A=
F12)>, /* SDMMC1_CK */
> > +                                              <STM32_PINMUX('D', 2, AF=
12)>; /* SDMMC1_CMD */
> > +                                     slew-rate =3D <3>;
> > +                                     drive-push-pull;
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('C', 8, =
AF12)>, /* SDMMC1_D0 */
> > +                                              <STM32_PINMUX('C', 9, AF=
12)>, /* SDMMC1_D1 */
> > +                                              <STM32_PINMUX('C', 10, A=
F12)>, /* SDMMC1_D2 */
> > +                                              <STM32_PINMUX('C', 11, A=
F12)>, /* SDMMC1_D3 */
> > +                                              <STM32_PINMUX('C', 12, A=
F12)>; /* SDMMC1_CK */
> > +                                     slew-rate =3D <3>;
> > +                                     drive-push-pull;
> > +                                     bias-disable;
> > +                             };
> > +                             pins2{
> > +                                     pinmux =3D <STM32_PINMUX('D', 2, =
AF12)>; /* SDMMC1_CMD */
> > +                                     slew-rate =3D <3>;
> > +                                     drive-open-drain;
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('C', 8, =
ANALOG)>, /* SDMMC1_D0 */
> > +                                              <STM32_PINMUX('C', 9, AN=
ALOG)>, /* SDMMC1_D1 */
> > +                                              <STM32_PINMUX('C', 10, A=
NALOG)>, /* SDMMC1_D2 */
> > +                                              <STM32_PINMUX('C', 11, A=
NALOG)>, /* SDMMC1_D3 */
> > +                                              <STM32_PINMUX('C', 12, A=
NALOG)>, /* SDMMC1_CK */
> > +                                              <STM32_PINMUX('D', 2, AN=
ALOG)>; /* SDMMC1_CMD */
> > +                             };
> > +                     };
> > +
> > +                     sdmmc2_b4_pins_a: sdmmc2-b4-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('B', 14,=
 AF9)>, /* SDMMC1_D0 */
> > +                                              <STM32_PINMUX('B', 15, A=
F9)>, /* SDMMC1_D1 */
> > +                                              <STM32_PINMUX('B', 3, AF=
9)>, /* SDMMC1_D2 */
> > +                                              <STM32_PINMUX('B', 4, AF=
9)>, /* SDMMC1_D3 */
> > +                                              <STM32_PINMUX('D', 6, AF=
11)>, /* SDMMC1_CK */
> > +                                              <STM32_PINMUX('D', 7, AF=
11)>; /* SDMMC1_CMD */
> > +                                     slew-rate =3D <3>;
> > +                                     drive-push-pull;
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     sdmmc2_b4_od_pins_a: sdmmc2-b4-od-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('B', 14,=
 AF9)>, /* SDMMC2_D0 */
> > +                                              <STM32_PINMUX('B', 15, A=
F9)>, /* SDMMC1_D1 */
> > +                                              <STM32_PINMUX('B', 3, AF=
9)>, /* SDMMC1_D2 */
> > +                                              <STM32_PINMUX('B', 4, AF=
9)>, /* SDMMC1_D3 */
> > +                                              <STM32_PINMUX('D', 6, AF=
11)>; /* SDMMC1_CK */
> > +                                     slew-rate =3D <3>;
> > +                                     drive-push-pull;
> > +                                     bias-disable;
> > +                             };
> > +                             pins2{
> > +                                     pinmux =3D <STM32_PINMUX('D', 7, =
AF11)>; /* SDMMC1_CMD */
> > +                                     slew-rate =3D <3>;
> > +                                     drive-open-drain;
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     sdmmc2_b4_sleep_pins_a: sdmmc2-b4-sleep-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('B', 14,=
 ANALOG)>, /* SDMMC1_D0 */
> > +                                              <STM32_PINMUX('B', 15, A=
NALOG)>, /* SDMMC1_D1 */
> > +                                              <STM32_PINMUX('B', 3, AN=
ALOG)>, /* SDMMC1_D2 */
> > +                                              <STM32_PINMUX('B', 4, AN=
ALOG)>, /* SDMMC1_D3 */
> > +                                              <STM32_PINMUX('D', 6, AN=
ALOG)>, /* SDMMC1_CK */
> > +                                              <STM32_PINMUX('D', 7, AN=
ALOG)>; /* SDMMC1_CMD */
> > +                             };
> > +                     };
> > +
> > +                     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('C', 6, =
AF8)>, /* SDMMC1_D0DIR */
> > +                                              <STM32_PINMUX('C', 7, AF=
8)>, /* SDMMC1_D123DIR */
> > +                                              <STM32_PINMUX('B', 9, AF=
7)>; /* SDMMC1_CDIR */
> > +                                     slew-rate =3D <3>;
> > +                                     drive-push-pull;
> > +                                     bias-pull-up;
> > +                             };
> > +                             pins2{
> > +                                     pinmux =3D <STM32_PINMUX('B', 8, =
AF7)>; /* SDMMC1_CKIN */
> > +                                     bias-pull-up;
> > +                             };
> > +                     };
> > +
> > +                     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('C', 6, =
ANALOG)>, /* SDMMC1_D0DIR */
> > +                                              <STM32_PINMUX('C', 7, AN=
ALOG)>, /* SDMMC1_D123DIR */
> > +                                              <STM32_PINMUX('B', 9, AN=
ALOG)>, /* SDMMC1_CDIR */
> > +                                              <STM32_PINMUX('B', 8, AN=
ALOG)>; /* SDMMC1_CKIN */
> > +                             };
> > +                     };
> > +
> > +                     usart1_pins: usart1-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('B', 14,=
 AF4)>; /* USART1_TX */
> > +                                     bias-disable;
> > +                                     drive-push-pull;
> > +                                     slew-rate =3D <0>;
> > +                             };
> > +                             pins2 {
> > +                                     pinmux =3D <STM32_PINMUX('B', 15,=
 AF4)>; /* USART1_RX */
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     usart2_pins: usart2-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('D', 5, =
AF7)>; /* USART2_TX */
> > +                                     bias-disable;
> > +                                     drive-push-pull;
> > +                                     slew-rate =3D <0>;
> > +                             };
> > +                             pins2 {
> > +                                     pinmux =3D <STM32_PINMUX('D', 6, =
AF7)>; /* USART2_RX */
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     usart3_pins: usart3-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('B', 10,=
 AF7)>; /* USART3_TX */
> > +                                     bias-disable;
> > +                                     drive-push-pull;
> > +                                     slew-rate =3D <0>;
> > +                             };
> > +                             pins2 {
> > +                                     pinmux =3D <STM32_PINMUX('B', 11,=
 AF7)>; /* USART3_RX */
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     uart4_pins: uart4-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('A', 0, =
AF8)>; /* UART4_TX */
> > +                                     bias-disable;
> > +                                     drive-push-pull;
> > +                                     slew-rate =3D <0>;
> > +                             };
> > +                             pins2 {
> > +                                     pinmux =3D <STM32_PINMUX('I', 9, =
AF8)>; /* UART4_RX */
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +
> > +                     usbotg_hs_pins_a: usbotg-hs-0 {
> > +                             pins {
> > +                                     pinmux =3D <STM32_PINMUX('H', 4, =
AF10)>,  /* ULPI_NXT */
> > +                                                      <STM32_PINMUX('I=
', 11, AF10)>, /* ULPI_DIR> */
> > +                                                      <STM32_PINMUX('C=
', 0, AF10)>,  /* ULPI_STP> */
> > +                                                      <STM32_PINMUX('A=
', 5, AF10)>,  /* ULPI_CK> */
> > +                                                      <STM32_PINMUX('A=
', 3, AF10)>,  /* ULPI_D0> */
> > +                                                      <STM32_PINMUX('B=
', 0, AF10)>,  /* ULPI_D1> */
> > +                                                      <STM32_PINMUX('B=
', 1, AF10)>,  /* ULPI_D2> */
> > +                                                      <STM32_PINMUX('B=
', 10, AF10)>, /* ULPI_D3> */
> > +                                                      <STM32_PINMUX('B=
', 11, AF10)>, /* ULPI_D4> */
> > +                                                      <STM32_PINMUX('B=
', 12, AF10)>, /* ULPI_D5> */
> > +                                                      <STM32_PINMUX('B=
', 13, AF10)>, /* ULPI_D6> */
> > +                                                      <STM32_PINMUX('B=
', 5, AF10)>;  /* ULPI_D7> */
> > +                                     bias-disable;
> > +                                     drive-push-pull;
> > +                                     slew-rate =3D <2>;
> > +                             };
> > +                     };
> > +
> > +                     spi1_pins: spi1-0 {
> > +                             pins1 {
> > +                                     pinmux =3D <STM32_PINMUX('A', 5, =
AF5)>,
> > +                                             /* SPI1_CLK */
> > +                                              <STM32_PINMUX('B', 5, AF=
5)>;
> > +                                             /* SPI1_MOSI */
> > +                                     bias-disable;
> > +                                     drive-push-pull;
> > +                                     slew-rate =3D <2>;
> > +                             };
> > +                             pins2 {
> > +                                     pinmux =3D <STM32_PINMUX('G', 9, =
AF5)>;
> > +                                             /* SPI1_MISO */
> > +                                     bias-disable;
> > +                             };
> > +                     };
> > +             };
> > +     };
> > +};
> > diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/d=
ts/stm32h743-pinctrl.dtsi
> > index fa5dcb6a5fdd..6b1e115307b9 100644
> > --- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
> > @@ -1,306 +1,11 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> >   /*
> > - * Copyright 2017 - Alexandre Torgue <alexandre.torgue@st.com>
> > - *
> > - * This file is dual-licensed: you can use it either under the terms
> > - * of the GPL or the X11 license, at your option. Note that this dual
> > - * licensing only applies to this file, and not this project as a
> > - * whole.
> > - *
> > - *  a) This file is free software; you can redistribute it and/or
> > - *     modify it under the terms of the GNU General Public License as
> > - *     published by the Free Software Foundation; either version 2 of =
the
> > - *     License, or (at your option) any later version.
> > - *
> > - *     This file is distributed in the hope that it will be useful,
> > - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - *     GNU General Public License for more details.
> > - *
> > - * Or, alternatively,
> > - *
> > - *  b) Permission is hereby granted, free of charge, to any person
> > - *     obtaining a copy of this software and associated documentation
> > - *     files (the "Software"), to deal in the Software without
> > - *     restriction, including without limitation the rights to use,
> > - *     copy, modify, merge, publish, distribute, sublicense, and/or
> > - *     sell copies of the Software, and to permit persons to whom the
> > - *     Software is furnished to do so, subject to the following
> > - *     conditions:
> > - *
> > - *     The above copyright notice and this permission notice shall be
> > - *     included in all copies or substantial portions of the Software.
> > - *
> > - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> > - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> > - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> > - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> > - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> > - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > - *     OTHER DEALINGS IN THE SOFTWARE.
> > + * Copyright (C) STMicroelectronics 2017 - All Rights Reserved
> > + * Author: Alexandre Torgue  <alexandre.torgue@st.com> for STMicroelec=
tronics.
> >    */
> >
> > -#include <dt-bindings/pinctrl/stm32-pinfunc.h>
> > +#include "stm32h7-pinctrl.dtsi"
> >
> > -/ {
> > -     soc {
> > -             pin-controller {
> > -                     #address-cells =3D <1>;
> > -                     #size-cells =3D <1>;
> > -                     compatible =3D "st,stm32h743-pinctrl";
> > -                     ranges =3D <0 0x58020000 0x3000>;
> > -                     interrupt-parent =3D <&exti>;
> > -                     st,syscfg =3D <&syscfg 0x8>;
> > -                     pins-are-numbered;
> > -
> > -                     gpioa: gpio@58020000 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x0 0x400>;
> > -                             clocks =3D <&rcc GPIOA_CK>;
> > -                             st,bank-name =3D "GPIOA";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpiob: gpio@58020400 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x400 0x400>;
> > -                             clocks =3D <&rcc GPIOB_CK>;
> > -                             st,bank-name =3D "GPIOB";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpioc: gpio@58020800 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x800 0x400>;
> > -                             clocks =3D <&rcc GPIOC_CK>;
> > -                             st,bank-name =3D "GPIOC";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpiod: gpio@58020c00 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0xc00 0x400>;
> > -                             clocks =3D <&rcc GPIOD_CK>;
> > -                             st,bank-name =3D "GPIOD";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpioe: gpio@58021000 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x1000 0x400>;
> > -                             clocks =3D <&rcc GPIOE_CK>;
> > -                             st,bank-name =3D "GPIOE";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpiof: gpio@58021400 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x1400 0x400>;
> > -                             clocks =3D <&rcc GPIOF_CK>;
> > -                             st,bank-name =3D "GPIOF";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpiog: gpio@58021800 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x1800 0x400>;
> > -                             clocks =3D <&rcc GPIOG_CK>;
> > -                             st,bank-name =3D "GPIOG";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpioh: gpio@58021c00 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x1c00 0x400>;
> > -                             clocks =3D <&rcc GPIOH_CK>;
> > -                             st,bank-name =3D "GPIOH";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpioi: gpio@58022000 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x2000 0x400>;
> > -                             clocks =3D <&rcc GPIOI_CK>;
> > -                             st,bank-name =3D "GPIOI";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpioj: gpio@58022400 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x2400 0x400>;
> > -                             clocks =3D <&rcc GPIOJ_CK>;
> > -                             st,bank-name =3D "GPIOJ";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     gpiok: gpio@58022800 {
> > -                             gpio-controller;
> > -                             #gpio-cells =3D <2>;
> > -                             reg =3D <0x2800 0x400>;
> > -                             clocks =3D <&rcc GPIOK_CK>;
> > -                             st,bank-name =3D "GPIOK";
> > -                             interrupt-controller;
> > -                             #interrupt-cells =3D <2>;
> > -                     };
> > -
> > -                     i2c1_pins_a: i2c1-0 {
> > -                             pins {
> > -                                     pinmux =3D <STM32_PINMUX('B', 6, =
AF4)>, /* I2C1_SCL */
> > -                                              <STM32_PINMUX('B', 7, AF=
4)>; /* I2C1_SDA */
> > -                                     bias-disable;
> > -                                     drive-open-drain;
> > -                                     slew-rate =3D <0>;
> > -                             };
> > -                     };
> > -
> > -                     ethernet_rmii: rmii-0 {
> > -                             pins {
> > -                                     pinmux =3D <STM32_PINMUX('G', 11,=
 AF11)>,
> > -                                              <STM32_PINMUX('G', 13, A=
F11)>,
> > -                                              <STM32_PINMUX('G', 12, A=
F11)>,
> > -                                              <STM32_PINMUX('C', 4, AF=
11)>,
> > -                                              <STM32_PINMUX('C', 5, AF=
11)>,
> > -                                              <STM32_PINMUX('A', 7, AF=
11)>,
> > -                                              <STM32_PINMUX('C', 1, AF=
11)>,
> > -                                              <STM32_PINMUX('A', 2, AF=
11)>,
> > -                                              <STM32_PINMUX('A', 1, AF=
11)>;
> > -                                     slew-rate =3D <2>;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_b4_pins_a: sdmmc1-b4-0 {
> > -                             pins {
> > -                                     pinmux =3D <STM32_PINMUX('C', 8, =
AF12)>, /* SDMMC1_D0 */
> > -                                              <STM32_PINMUX('C', 9, AF=
12)>, /* SDMMC1_D1 */
> > -                                              <STM32_PINMUX('C', 10, A=
F12)>, /* SDMMC1_D2 */
> > -                                              <STM32_PINMUX('C', 11, A=
F12)>, /* SDMMC1_D3 */
> > -                                              <STM32_PINMUX('C', 12, A=
F12)>, /* SDMMC1_CK */
> > -                                              <STM32_PINMUX('D', 2, AF=
12)>; /* SDMMC1_CMD */
> > -                                     slew-rate =3D <3>;
> > -                                     drive-push-pull;
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_b4_od_pins_a: sdmmc1-b4-od-0 {
> > -                             pins1 {
> > -                                     pinmux =3D <STM32_PINMUX('C', 8, =
AF12)>, /* SDMMC1_D0 */
> > -                                              <STM32_PINMUX('C', 9, AF=
12)>, /* SDMMC1_D1 */
> > -                                              <STM32_PINMUX('C', 10, A=
F12)>, /* SDMMC1_D2 */
> > -                                              <STM32_PINMUX('C', 11, A=
F12)>, /* SDMMC1_D3 */
> > -                                              <STM32_PINMUX('C', 12, A=
F12)>; /* SDMMC1_CK */
> > -                                     slew-rate =3D <3>;
> > -                                     drive-push-pull;
> > -                                     bias-disable;
> > -                             };
> > -                             pins2{
> > -                                     pinmux =3D <STM32_PINMUX('D', 2, =
AF12)>; /* SDMMC1_CMD */
> > -                                     slew-rate =3D <3>;
> > -                                     drive-open-drain;
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_b4_sleep_pins_a: sdmmc1-b4-sleep-0 {
> > -                             pins {
> > -                                     pinmux =3D <STM32_PINMUX('C', 8, =
ANALOG)>, /* SDMMC1_D0 */
> > -                                              <STM32_PINMUX('C', 9, AN=
ALOG)>, /* SDMMC1_D1 */
> > -                                              <STM32_PINMUX('C', 10, A=
NALOG)>, /* SDMMC1_D2 */
> > -                                              <STM32_PINMUX('C', 11, A=
NALOG)>, /* SDMMC1_D3 */
> > -                                              <STM32_PINMUX('C', 12, A=
NALOG)>, /* SDMMC1_CK */
> > -                                              <STM32_PINMUX('D', 2, AN=
ALOG)>; /* SDMMC1_CMD */
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_dir_pins_a: sdmmc1-dir-0 {
> > -                             pins1 {
> > -                                     pinmux =3D <STM32_PINMUX('C', 6, =
AF8)>, /* SDMMC1_D0DIR */
> > -                                              <STM32_PINMUX('C', 7, AF=
8)>, /* SDMMC1_D123DIR */
> > -                                              <STM32_PINMUX('B', 9, AF=
7)>; /* SDMMC1_CDIR */
> > -                                     slew-rate =3D <3>;
> > -                                     drive-push-pull;
> > -                                     bias-pull-up;
> > -                             };
> > -                             pins2{
> > -                                     pinmux =3D <STM32_PINMUX('B', 8, =
AF7)>; /* SDMMC1_CKIN */
> > -                                     bias-pull-up;
> > -                             };
> > -                     };
> > -
> > -                     sdmmc1_dir_sleep_pins_a: sdmmc1-dir-sleep-0 {
> > -                             pins {
> > -                                     pinmux =3D <STM32_PINMUX('C', 6, =
ANALOG)>, /* SDMMC1_D0DIR */
> > -                                              <STM32_PINMUX('C', 7, AN=
ALOG)>, /* SDMMC1_D123DIR */
> > -                                              <STM32_PINMUX('B', 9, AN=
ALOG)>, /* SDMMC1_CDIR */
> > -                                              <STM32_PINMUX('B', 8, AN=
ALOG)>; /* SDMMC1_CKIN */
> > -                             };
> > -                     };
> > -
> > -                     usart1_pins: usart1-0 {
> > -                             pins1 {
> > -                                     pinmux =3D <STM32_PINMUX('B', 14,=
 AF4)>; /* USART1_TX */
> > -                                     bias-disable;
> > -                                     drive-push-pull;
> > -                                     slew-rate =3D <0>;
> > -                             };
> > -                             pins2 {
> > -                                     pinmux =3D <STM32_PINMUX('B', 15,=
 AF4)>; /* USART1_RX */
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     usart2_pins: usart2-0 {
> > -                             pins1 {
> > -                                     pinmux =3D <STM32_PINMUX('D', 5, =
AF7)>; /* USART2_TX */
> > -                                     bias-disable;
> > -                                     drive-push-pull;
> > -                                     slew-rate =3D <0>;
> > -                             };
> > -                             pins2 {
> > -                                     pinmux =3D <STM32_PINMUX('D', 6, =
AF7)>; /* USART2_RX */
> > -                                     bias-disable;
> > -                             };
> > -                     };
> > -
> > -                     usbotg_hs_pins_a: usbotg-hs-0 {
> > -                             pins {
> > -                                     pinmux =3D <STM32_PINMUX('H', 4, =
AF10)>,  /* ULPI_NXT */
> > -                                                      <STM32_PINMUX('I=
', 11, AF10)>, /* ULPI_DIR> */
> > -                                                      <STM32_PINMUX('C=
', 0, AF10)>,  /* ULPI_STP> */
> > -                                                      <STM32_PINMUX('A=
', 5, AF10)>,  /* ULPI_CK> */
> > -                                                      <STM32_PINMUX('A=
', 3, AF10)>,  /* ULPI_D0> */
> > -                                                      <STM32_PINMUX('B=
', 0, AF10)>,  /* ULPI_D1> */
> > -                                                      <STM32_PINMUX('B=
', 1, AF10)>,  /* ULPI_D2> */
> > -                                                      <STM32_PINMUX('B=
', 10, AF10)>, /* ULPI_D3> */
> > -                                                      <STM32_PINMUX('B=
', 11, AF10)>, /* ULPI_D4> */
> > -                                                      <STM32_PINMUX('B=
', 12, AF10)>, /* ULPI_D5> */
> > -                                                      <STM32_PINMUX('B=
', 13, AF10)>, /* ULPI_D6> */
> > -                                                      <STM32_PINMUX('B=
', 5, AF10)>;  /* ULPI_D7> */
> > -                                     bias-disable;
> > -                                     drive-push-pull;
> > -                                     slew-rate =3D <2>;
> > -                             };
> > -                     };
> > -             };
> > -     };
> > +&pinctrl{
> > +     compatible =3D "st,stm32h743-pinctrl";
> >   };
> >
