Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590AA339E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 14:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhCMNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhCMNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 08:22:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69483C061574;
        Sat, 13 Mar 2021 05:22:30 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v2so36765340lft.9;
        Sat, 13 Mar 2021 05:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q1uNAM0/4OgzNHUQ1vDyeY/D0ARXaNVQuCeWL6uPAt8=;
        b=WYK5JgrFqOInMBH6e3ObJdIvZO7B2EY8SfKfzokRmTuqlPhYzduOeTvxSslwA9okQc
         6VyXySbgB3kBW5hb59wYBwAIbqjWfUMUrJvxZjXW6XD1W7rVxgiCE9RWx8d6dtXAccTh
         xSF7yBUeAzMdisViS2JQF9xeJCABCK0bHZJJIU5rkO+F0A5g/LdXZBDBrlbkvKxp8hgU
         XiJUS0Fe0pZcQ9BdbOVVYu7gStHUU9+zdKk+PJqMz9CUfjST2xFQUsjqJvZeCZ9wRY36
         YXBl6NVVZqfpO9At0GrkZCP4ch/2RIEUn4pcfFPQQfxcKW7kmb7M7iF9PpOiMDl2Cdfi
         KFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q1uNAM0/4OgzNHUQ1vDyeY/D0ARXaNVQuCeWL6uPAt8=;
        b=UQheUs7L5X2VL3eWFg6IzJJgAHu/wehmC3I9zaIxiwn9p4PU7IHxsO3tiY4J5hfLC4
         G58k31L9cYqwXRX9m/LfFmVLI/DGWXyu3LVhfnuQfkyOm3xiP63A5t4v1dyCaJ3SNurc
         g/wLltY8FEVzSS13pzr4uxdwLbeDWDIh9DF1Uui0K44gpNv+BcG/x2xJaQAEOUdzso0Q
         PKtmCigVOn21vLib70GL3NE9yyWMnPn4bHuSJ6h3kSM88rJBLqzwE2N4/ksPh+PzAV8w
         69V4hN1979C6hEoHAxbSlfL6IehQYyBc6w8yLOwFI3TVXoGQ2cgyAkZapZsna4Y6M9kr
         kIDQ==
X-Gm-Message-State: AOAM533n82nmHmIGaBZ6bBkLrdHZqX9jLjh1u9LNOQU481+2Ly+o7K1y
        pP5fj/hfwuILOHEgP5TpHrenAs79t2RGGv5YrZs=
X-Google-Smtp-Source: ABdhPJyV8dgzTRXnAhPsIE+Vgevu5ejFgapwf9p3yJFdn0Jm/kb9r/A6P8YDthiD/wztYgin8cQV3/Ku91JmpH/C9JU=
X-Received: by 2002:a05:6512:ad3:: with SMTP id n19mr2619609lfu.328.1615641748580;
 Sat, 13 Mar 2021 05:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20210313032515.12590-1-cnsztl@gmail.com> <20210313032515.12590-2-cnsztl@gmail.com>
 <1f7f1a11-0b9b-b2e4-efbc-193f61d62832@arm.com>
In-Reply-To: <1f7f1a11-0b9b-b2e4-efbc-193f61d62832@arm.com>
From:   CN_SZTL <cnsztl@gmail.com>
Date:   Sat, 13 Mar 2021 21:22:17 +0800
Message-ID: <CAOP2_TgUQH9H9vuESek7KjStxu=idaBxX=S5Q7_=Mn=D_s-=JA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM
 NanoPi R4S
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Bauer <mail@david-bauer.net>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Marty Jones <mj8263788@gmail.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Murphy <robin.murphy@arm.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8813=E6=
=97=A5=E5=91=A8=E5=85=AD =E4=B8=8B=E5=8D=887:55=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2021-03-13 03:25, Tianling Shen wrote:
> > This adds support for the NanoPi R4S from FriendlyArm.
> >
> > Rockchip RK3399 SoC
> > 1GB DDR3 or 4GB LPDDR4 RAM
> > Gigabit Ethernet (WAN)
> > Gigabit Ethernet (PCIe) (LAN)
> > USB 3.0 Port x 2
> > MicroSD slot
> > Reset button
> > WAN - LAN - SYS LED
> >
> > [initial DTS file]
> > Co-developed-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> > [minor adjustments]
> > Co-developed-by: Marty Jones <mj8263788@gmail.com>
> > Signed-off-by: Marty Jones <mj8263788@gmail.com>
> > [fixed format issues]
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >   .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   | 179 +++++++++++++++++=
+
> >   2 files changed, 180 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> >
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dt=
s/rockchip/Makefile
> > index 62d3abc17a24..c3e00c0e2db7 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-nanopc-t4.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-nanopi-m4.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-nanopi-m4b.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-nanopi-neo4.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-nanopi-r4s.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-orangepi.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-pinebook-pro.dtb
> >   dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D rk3399-puma-haikou.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/=
arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > new file mode 100644
> > index 000000000000..41b3d5c5043c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> > @@ -0,0 +1,179 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * FriendlyElec NanoPC-T4 board device tree source
> > + *
> > + * Copyright (c) 2020 FriendlyElec Computer Tech. Co., Ltd.
> > + * (http://www.friendlyarm.com)
> > + *
> > + * Copyright (c) 2018 Collabora Ltd.
> > + *
> > + * Copyright (c) 2020 Jensen Huang <jensenhuang@friendlyarm.com>
> > + * Copyright (c) 2020 Marty Jones <mj8263788@gmail.com>
> > + * Copyright (c) 2021 Tianling Shen <cnsztl@gmail.com>
> > + */
> > +
> > +/dts-v1/;
> > +#include "rk3399-nanopi4.dtsi"
> > +
> > +/ {
> > +     model =3D "FriendlyElec NanoPi R4S";
> > +     compatible =3D "friendlyarm,nanopi-r4s", "rockchip,rk3399";
> > +
> > +     /delete-node/ gpio-leds;
>
> Why? You could justify deleting &status_led, but redefining the whole
> node from scratch seems unnecessary.

First of all, thank you for reviewing, and sorry for my poor English.

I need to redefine `pinctrl-0`, but if I use `/delete-property/
pinctrl-0;`, it will throw an error,
so maybe I made a mistake? And I will try again...
>
> > +     gpio-leds {
> > +             compatible =3D "gpio-leds";
> > +             pinctrl-0 =3D <&lan_led_pin>, <&sys_led_pin>, <&wan_led_p=
in>;
> > +             pinctrl-names =3D "default";
> > +
> > +             lan_led: led-0 {
> > +                     gpios =3D <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> > +                     label =3D "nanopi-r4s:green:lan";
> > +             };
> > +
> > +             sys_led: led-1 {
> > +                     gpios =3D <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> > +                     label =3D "nanopi-r4s:red:sys";
> > +                     default-state =3D "on";
> > +             };
> > +
> > +             wan_led: led-2 {
> > +                     gpios =3D <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> > +                     label =3D "nanopi-r4s:green:wan";
> > +             };
> > +     };
> > +
> > +     /delete-node/ gpio-keys;
>
> Ditto - just removing the power key node itself should suffice.

Just like gpio-leds.
>
> > +     gpio-keys {
> > +             compatible =3D "gpio-keys";
> > +             pinctrl-names =3D "default";
> > +             pinctrl-0 =3D <&reset_button_pin>;
> > +
> > +             reset {
> > +                     debounce-interval =3D <50>;
> > +                     gpios =3D <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
> > +                     label =3D "reset";
> > +                     linux,code =3D <KEY_RESTART>;
> > +             };
> > +     };
> > +
> > +     vdd_5v: vdd-5v {
> > +             compatible =3D "regulator-fixed";
> > +             regulator-name =3D "vdd_5v";
> > +             regulator-always-on;
> > +             regulator-boot-on;
> > +     };
> > +
> > +     fan: pwm-fan {
> > +             compatible =3D "pwm-fan";
> > +             /*
> > +              * With 20KHz PWM and an EVERCOOL EC4007H12SA fan, these =
levels
> > +              * work out to 0, ~1200, ~3000, and 5000RPM respectively.
> > +              */
> > +             cooling-levels =3D <0 12 18 255>;
>
> This is clearly not true - those numbers refer to a 12V fan on my
> NanoPC-T4's 12V PWM circuit, while the output circuit here is 5V. If you
> really want a placeholder here maybe just use <0 255>, or figure out
> some empirical values with a suitable 5V fan that are actually meaningful=
.

Okay... I'll drop these as they're not really meaningful.
>
> > +             #cooling-cells =3D <2>;
> > +             fan-supply =3D <&vdd_5v>;
> > +             pwms =3D <&pwm1 0 50000 0>;
> > +     };
> > +};
> > +
> > +&cpu_thermal {
> > +     trips {
> > +             cpu_warm: cpu_warm {
> > +                     temperature =3D <55000>;
> > +                     hysteresis =3D <2000>;
> > +                     type =3D "active";
> > +             };
> > +
> > +             cpu_hot: cpu_hot {
> > +                     temperature =3D <65000>;
> > +                     hysteresis =3D <2000>;
> > +                     type =3D "active";
> > +             };
> > +     };
> > +
> > +     cooling-maps {
> > +             map2 {
> > +                     trip =3D <&cpu_warm>;
> > +                     cooling-device =3D <&fan THERMAL_NO_LIMIT 1>;
> > +             };
> > +
> > +             map3 {
> > +                     trip =3D <&cpu_hot>;
> > +                     cooling-device =3D <&fan 2 THERMAL_NO_LIMIT>;
> > +             };
> > +     };
> > +};
> > +
> > +&emmc_phy {
> > +     status =3D "disabled";
> > +};
> > +
> > +&fusb0 {
> > +     status =3D "disabled";
>
> This can never be enabled since it doesn't exist in the design at all,
> so it's one place where deletion *would* make good sense. AFAICS this
> means you also don't need i2c4 enabled either.

Is it fine to disable i2c4 directly?
>
> > +};
>
> It might be nice to disable HDMI and all the other display pieces given
> that the board is physically headless.

Fine, I will delete `display-subsystem` node.
>
> > +
> > +&pcie0 {
> > +     max-link-speed =3D <1>;
> > +     num-lanes =3D <1>;
> > +     vpcie3v3-supply =3D <&vcc3v3_sys>;
> > +
> > +     pcie@0 {
> > +             reg =3D <0x00000000 0 0 0 0>;
> > +             #address-cells =3D <3>;
> > +             #size-cells =3D <2>;
> > +     };
>
> What's this for?

This is for the on-board PCIe ethernet adapter (RTL8111h).
>
> > +};
> > +
> > +&pinctrl {
> > +     /delete-node/ gpio-leds;
>
> Again, at most you'd only need to delete &status_led_pin.

Yes, I will do it.
>
> > +     gpio-leds {
> > +             lan_led_pin: lan-led-pin {
> > +                     rockchip,pins =3D <1 RK_PA1 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > +             };
> > +
> > +             sys_led_pin: sys-led-pin {
> > +                     rockchip,pins =3D <0 RK_PB5 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > +             };
> > +
> > +             wan_led_pin: wan-led-pin {
> > +                     rockchip,pins =3D <1 RK_PA0 RK_FUNC_GPIO &pcfg_pu=
ll_none>;
> > +             };
> > +     };
> > +
> > +     /delete-node/ rockchip-key;
>
> Ditto for &power_key.

Yes.
>
> > +     rockchip-key {
> > +             reset_button_pin: reset-button-pin {
> > +                     rockchip,pins =3D <1 RK_PC6 RK_FUNC_GPIO &pcfg_pu=
ll_up>;
> > +             };
> > +     };
> > +};
> > +
> > +&sdhci {
> > +     status =3D "disabled";
> > +};
> > +
> > +&sdio0 {
> > +     status =3D "disabled";
> > +};
> > +
> > +&sdmmc {
> > +     sd-uhs-sdr12;
> > +     sd-uhs-sdr25;
> > +     sd-uhs-sdr50;
>
> Are those modes unique to this particular board?

These seem not right and I will drop them.
>
> > +};
> > +
>
> What about the Bluetooth stuff on uart0?

R4S doesn't have it, so I guess I should disable uart0, like i2c4.
>
> Robin.
>
> > +&u2phy0_host {
> > +     phy-supply =3D <&vdd_5v>;
> > +};
> > +
> > +&u2phy1_host {
> > +     status =3D "disabled";
> > +};
> > +
> > +&usbdrd_dwc3_0 {
> > +     dr_mode =3D "host";
> > +};
> > +
> > +&vcc3v3_sys {
> > +     vin-supply =3D <&vcc5v0_sys>;
> > +};
> >

Tianling.
