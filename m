Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F4533D624
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbhCPOto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbhCPOtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:49:19 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440A0C06174A;
        Tue, 16 Mar 2021 07:49:19 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id b5so12877743ilq.10;
        Tue, 16 Mar 2021 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVPpQW2mM7eMcXo/2OtBaimiBNrHKr/09oT1dgBiYKc=;
        b=uEeuHXURZCqrNAroRmu67dj4ng1plskwJlZW8jjmcGlastdy6jatBLJ/fwlgGWn7Mh
         PzzUcykEA0uOABI9ziXPvDKxPkQnz0IPV0W/2doeAZBqIEivUr7iwpMCqJ51/HEGAp04
         VdnN4+H91N7VUMOYV8aVyxJ6B2BfsQX8IycWXrXzRrJ7NxPm0RFbNSjcZA0qhR1gBpGq
         xPrH09LxDgcOSxqDiZQKsNJOlG5aqOMvd7r0UQ89T5U2SRMZJQeiSCVZEk07FPdYiCGK
         8Jc0HJ8j5FVwOe2+2pQB4pUnm5O5hBnlosQVs9MTK6R8ouYKBQxwH4HB4o/TzyejDVg/
         fmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JVPpQW2mM7eMcXo/2OtBaimiBNrHKr/09oT1dgBiYKc=;
        b=kME+FPr6tGVIBVRxz1xyak8D4nhOj0WRvolKfzI0bt4YRE00hp+NpMdtHwwSrpczpn
         ZTz6rZEH9Hga1olvJ4i4EGxv/vDMVlwqPipAxUk4/oSs4JGBNdsFo9LQ3oogxtYscYRp
         dm9HK+2+EUIXniMCLM8ZoaDX7LmCRJUm/XthDpq5B2ghqPu4ezGoWCFA0LgD2XqV7oLs
         rIBh2DyDXE2JdxHxR/VCSv6Es3MLUh0tdg6GykkUiWVvRNacj5Q7vd+u6Shf3o+s/L/Q
         uZqzQqmDxXPdIQI5jspN0/Jn4nzQBVTEdS2nvdQYwVq8ntWmiVdurYGH5A6NDo0dhVqk
         B5sw==
X-Gm-Message-State: AOAM532Yp4NmRrItVSOe1ZbIha8tW2jv5qIH5ql5MXsIcpW60VOYwU7E
        O+fyL+0vjSkt9A3MumN8uNg=
X-Google-Smtp-Source: ABdhPJxs3cwTuUwrRXS8JK/slrHmsvZk0FDcihO3TPF19AB2XU3UAcFsgxTVcX1IvQe6gghmQ4eTQg==
X-Received: by 2002:a92:3652:: with SMTP id d18mr4091306ilf.100.1615906158583;
        Tue, 16 Mar 2021 07:49:18 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id q15sm9525809ilt.30.2021.03.16.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:49:17 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Tianling Shen <cnsztl@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Marty Jones <mj8263788@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] rockchip: rk3399: Add support for FriendlyARM NanoPi R4S
Date:   Tue, 16 Mar 2021 22:49:12 +0800
Message-Id: <20210316144912.6057-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-16 12:32, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-03-13 13:22, CN_SZTL wrote:
> > Robin Murphy <robin.murphy@arm.com> 于2021年3月13日周六 下午7:55写道：
> >>
> >> On 2021-03-13 03:25, Tianling Shen wrote:
> >>> This adds support for the NanoPi R4S from FriendlyArm.
> >>>
> >>> Rockchip RK3399 SoC
> >>> 1GB DDR3 or 4GB LPDDR4 RAM
> >>> Gigabit Ethernet (WAN)
> >>> Gigabit Ethernet (PCIe) (LAN)
> >>> USB 3.0 Port x 2
> >>> MicroSD slot
> >>> Reset button
> >>> WAN - LAN - SYS LED
> >>>
> >>> [initial DTS file]
> >>> Co-developed-by: Jensen Huang <jensenhuang@friendlyarm.com>
> >>> Signed-off-by: Jensen Huang <jensenhuang@friendlyarm.com>
> >>> [minor adjustments]
> >>> Co-developed-by: Marty Jones <mj8263788@gmail.com>
> >>> Signed-off-by: Marty Jones <mj8263788@gmail.com>
> >>> [fixed format issues]
> >>> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> >>>
> >>> Reported-by: kernel test robot <lkp@intel.com>
> >>> ---
> >>>    arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >>>    .../boot/dts/rockchip/rk3399-nanopi-r4s.dts   | 179 ++++++++++++++++++
> >>>    2 files changed, 180 insertions(+)
> >>>    create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> >>>
> >>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> >>> index 62d3abc17a24..c3e00c0e2db7 100644
> >>> --- a/arch/arm64/boot/dts/rockchip/Makefile
> >>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> >>> @@ -36,6 +36,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
> >>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
> >>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4b.dtb
> >>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
> >>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
> >>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
> >>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
> >>>    dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> >>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> >>> new file mode 100644
> >>> index 000000000000..41b3d5c5043c
> >>> --- /dev/null
> >>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-r4s.dts
> >>> @@ -0,0 +1,179 @@
> >>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >>> +/*
> >>> + * FriendlyElec NanoPC-T4 board device tree source
> >>> + *
> >>> + * Copyright (c) 2020 FriendlyElec Computer Tech. Co., Ltd.
> >>> + * (http://www.friendlyarm.com)
> >>> + *
> >>> + * Copyright (c) 2018 Collabora Ltd.
> >>> + *
> >>> + * Copyright (c) 2020 Jensen Huang <jensenhuang@friendlyarm.com>
> >>> + * Copyright (c) 2020 Marty Jones <mj8263788@gmail.com>
> >>> + * Copyright (c) 2021 Tianling Shen <cnsztl@gmail.com>
> >>> + */
> >>> +
> >>> +/dts-v1/;
> >>> +#include "rk3399-nanopi4.dtsi"
> >>> +
> >>> +/ {
> >>> +     model = "FriendlyElec NanoPi R4S";
> >>> +     compatible = "friendlyarm,nanopi-r4s", "rockchip,rk3399";
> >>> +
> >>> +     /delete-node/ gpio-leds;
> >>
> >> Why? You could justify deleting &status_led, but redefining the whole
> >> node from scratch seems unnecessary.
> >
> > First of all, thank you for reviewing, and sorry for my poor English.
> >
> > I need to redefine `pinctrl-0`, but if I use `/delete-property/
> > pinctrl-0;`, it will throw an error,
> > so maybe I made a mistake? And I will try again...
>
> You don't need to delete the property itself though - simply specifying
> it replaces whatever previous value was inherited from the DTSI. Think
> about how all those "status = ..." lines work, for example.

I see, thank you so much!

>
> Similarly, given that you're redefining the led-0 node anyway you
> wouldn't really *need* to delete that either; doing so just avoids the
> extra &status_led label hanging around if the DTB is built with symbols,
> and saves having to explicitly override/delete the default trigger
> property if necessary.

I plan to take advice from Geert, rename them to `lan-led`, `sys-led`,`wan-led`, so deleting `led-0` might to be need here...>

> >>> +     gpio-leds {
> >>> +             compatible = "gpio-leds";
> >>> +             pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
> >>> +             pinctrl-names = "default";
> >>> +
> >>> +             lan_led: led-0 {
> >>> +                     gpios = <&gpio1 RK_PA1 GPIO_ACTIVE_HIGH>;
> >>> +                     label = "nanopi-r4s:green:lan";
> >>> +             };
> >>> +
> >>> +             sys_led: led-1 {
> >>> +                     gpios = <&gpio0 RK_PB5 GPIO_ACTIVE_HIGH>;
> >>> +                     label = "nanopi-r4s:red:sys";
> >>> +                     default-state = "on";
> >>> +             };
> >>> +
> >>> +             wan_led: led-2 {
> >>> +                     gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> >>> +                     label = "nanopi-r4s:green:wan";
> >>> +             };
>
> Nit: (apologies for overlooking it before) there isn't an obvious
> definitive order for the LEDs, but the order here is certainly not
> consistent with anything. The most logical would probably be sys, wan,
> lan since that's both in order of GPIO number and how they are
> physically positioned relative to each other on the board/case (although
> you could also argue for wan, lan, sys in that regard, depending on how
> you look at it).
>
> >>> +     };
> >>> +
> >>> +     /delete-node/ gpio-keys;
> >>
> >> Ditto - just removing the power key node itself should suffice.
> >
> > Just like gpio-leds.
> >>
> >>> +     gpio-keys {
> >>> +             compatible = "gpio-keys";
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&reset_button_pin>;
> >>> +
> >>> +             reset {
> >>> +                     debounce-interval = <50>;
> >>> +                     gpios = <&gpio1 RK_PC6 GPIO_ACTIVE_LOW>;
> >>> +                     label = "reset";
> >>> +                     linux,code = <KEY_RESTART>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     vdd_5v: vdd-5v {
> >>> +             compatible = "regulator-fixed";
> >>> +             regulator-name = "vdd_5v";
> >>> +             regulator-always-on;
> >>> +             regulator-boot-on;
> >>> +     };
> >>> +
> >>> +     fan: pwm-fan {
> >>> +             compatible = "pwm-fan";
> >>> +             /*
> >>> +              * With 20KHz PWM and an EVERCOOL EC4007H12SA fan, these levels
> >>> +              * work out to 0, ~1200, ~3000, and 5000RPM respectively.
> >>> +              */
> >>> +             cooling-levels = <0 12 18 255>;
> >>
> >> This is clearly not true - those numbers refer to a 12V fan on my
> >> NanoPC-T4's 12V PWM circuit, while the output circuit here is 5V. If you
> >> really want a placeholder here maybe just use <0 255>, or figure out
> >> some empirical values with a suitable 5V fan that are actually meaningful.
> >
> > Okay... I'll drop these as they're not really meaningful.
> >>
> >>> +             #cooling-cells = <2>;
> >>> +             fan-supply = <&vdd_5v>;
> >>> +             pwms = <&pwm1 0 50000 0>;
> >>> +     };
> >>> +};
> >>> +
> >>> +&cpu_thermal {
> >>> +     trips {
> >>> +             cpu_warm: cpu_warm {
> >>> +                     temperature = <55000>;
> >>> +                     hysteresis = <2000>;
> >>> +                     type = "active";
> >>> +             };
> >>> +
> >>> +             cpu_hot: cpu_hot {
> >>> +                     temperature = <65000>;
> >>> +                     hysteresis = <2000>;
> >>> +                     type = "active";
> >>> +             };
> >>> +     };
> >>> +
> >>> +     cooling-maps {
> >>> +             map2 {
> >>> +                     trip = <&cpu_warm>;
> >>> +                     cooling-device = <&fan THERMAL_NO_LIMIT 1>;
> >>> +             };
> >>> +
> >>> +             map3 {
> >>> +                     trip = <&cpu_hot>;
> >>> +                     cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&emmc_phy {
> >>> +     status = "disabled";
> >>> +};
> >>> +
> >>> +&fusb0 {
> >>> +     status = "disabled";
> >>
> >> This can never be enabled since it doesn't exist in the design at all,
> >> so it's one place where deletion *would* make good sense. AFAICS this
> >> means you also don't need i2c4 enabled either.
> >
> > Is it fine to disable i2c4 directly?
>
> I think it would make sense, since it's not physically available short
> of trying to solder on to the 0201 pull-up resistors.
>
> >>
> >>> +};
> >>
> >> It might be nice to disable HDMI and all the other display pieces given
> >> that the board is physically headless.
> >
> > Fine, I will delete `display-subsystem` node.
> >>
> >>> +
> >>> +&pcie0 {
> >>> +     max-link-speed = <1>;
> >>> +     num-lanes = <1>;
> >>> +     vpcie3v3-supply = <&vcc3v3_sys>;
> >>> +
> >>> +     pcie@0 {
> >>> +             reg = <0x00000000 0 0 0 0>;
> >>> +             #address-cells = <3>;
> >>> +             #size-cells = <2>;
> >>> +     };
> >>
> >> What's this for?
> >
> > This is for the on-board PCIe ethernet adapter (RTL8111h).
>
> OK, but *how* exactly does the ethernet adapter need an empty DT node
> describing the root port?

Actually I just took this from the vendor.
This seems useless, and I'll drop it.

>
> >>
> >>> +};
> >>> +
> >>> +&pinctrl {
> >>> +     /delete-node/ gpio-leds;
> >>
> >> Again, at most you'd only need to delete &status_led_pin.
> >
> > Yes, I will do it.
> >>
> >>> +     gpio-leds {
> >>> +             lan_led_pin: lan-led-pin {
> >>> +                     rockchip,pins = <1 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>;
> >>> +             };
> >>> +
> >>> +             sys_led_pin: sys-led-pin {
> >>> +                     rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
> >>> +             };
> >>> +
> >>> +             wan_led_pin: wan-led-pin {
> >>> +                     rockchip,pins = <1 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none>;
> >>> +             };
> >>> +     };
> >>> +
> >>> +     /delete-node/ rockchip-key;
> >>
> >> Ditto for &power_key.
> >
> > Yes.
> >>
> >>> +     rockchip-key {
> >>> +             reset_button_pin: reset-button-pin {
> >>> +                     rockchip,pins = <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up>;
> >>> +             };
> >>> +     };
> >>> +};
> >>> +
> >>> +&sdhci {
> >>> +     status = "disabled";
> >>> +};
> >>> +
> >>> +&sdio0 {
> >>> +     status = "disabled";
> >>> +};
> >>> +
> >>> +&sdmmc {
> >>> +     sd-uhs-sdr12;
> >>> +     sd-uhs-sdr25;
> >>> +     sd-uhs-sdr50;
> >>
> >> Are those modes unique to this particular board?
> >
> > These seem not right and I will drop them.
>
> I mean that if the other boards already support SDR104, they can
> presumably support slower modes as well, so if these are worth having at
> all then they could probably go in the common DTSI.

I'm not sure, just based on the dts of R2S, and I added them here.
However they should be general for all NanoPi4 boards.

>
> >>
> >>> +};
> >>> +
> >>
> >> What about the Bluetooth stuff on uart0?
> >
> > R4S doesn't have it, so I guess I should disable uart0, like i2c4.
>
> Yes, the UART itself isn't available on the board, and either way you
> certainly don't want the kernel wasting time and possibly throwing
> errors trying to probe a non-existent device through it.
>
> Thanks,
> Robin.

Thanks,
Tianling.
