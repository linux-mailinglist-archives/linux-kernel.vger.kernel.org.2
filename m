Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2540C35F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 12:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbhIOKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 06:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhIOKLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 06:11:04 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F8DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 03:09:46 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k10so2149724vsp.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 03:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFqGliDwobXn0VTsKFnNH6mxQw500v+TQf9F9dBTWuI=;
        b=f1Rtx5tr62jtbbW7oeJF94g1fvT62pzIviaSf2wOjUSuFr4trOwQIRVShSNcXRhwyl
         ofEE/gzfOFiC3C96/RHxRIaY8N8PUbUSG7HQSV12LZLcyW6BdDdageXWr6zYjjyi0dW+
         5S9EwVKnGwGzryqFBh/ck11WMzmMyuc1qGIe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFqGliDwobXn0VTsKFnNH6mxQw500v+TQf9F9dBTWuI=;
        b=YkM+ChUJHl0vjSJJ4En3dpUBlshB3FGmUqRBbvCe8nb2RSGL7TJ5HGGSV+vnRT4wHI
         AdQBkjFbiYg6s04+b844h8rzAd1igyfyBurjXUKcL3JwpkeaHwfuBq9A2+2L8ucEmcy/
         WhlJkWXpkL8Ptxohfn1gcQ0gDb6GpXXh0UXGJJcB6CHnGU947D2TcMkARXfTd8Mc/zBz
         jTgWgtaC8x6cPEtJoLwj2grvjl14ARKdJlrYrwiRavh9a1KrH0q0kd2IlgIVaTGJWKve
         5cepOzQ3Rk6yxwtGQmH0ta2DxwkqvV0CLK0vw9hBotK5k29KRzHbCEA2tQfO16Og9GzL
         s97w==
X-Gm-Message-State: AOAM532fd/MmvIDLtp4Dq5n0kFr9ELS/EHFTPPpjKmB4c4o/fYVZ6Wd3
        aEWCxw4FuMU2/qLWQ3n21fLe7AActm8xK39e5n07Jg==
X-Google-Smtp-Source: ABdhPJzS23UarLZJvPiRdCLAIvztFXPKRMlgTH50j3xhPyiv57lC9pruyhnT73eQce6ozImq8XVGvR0p3dkn4R1HB7g=
X-Received: by 2002:a67:bc09:: with SMTP id t9mr2379668vsn.45.1631700585222;
 Wed, 15 Sep 2021 03:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210914184141.32700-1-romain.perier@gmail.com> <20210914184141.32700-4-romain.perier@gmail.com>
In-Reply-To: <20210914184141.32700-4-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 15 Sep 2021 19:09:34 +0900
Message-ID: <CAFr9PXmfhkrJHwp-wVTKakQsg71AmcOz6Cc=rh+=R+8L_SHb8w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ARM: dts: mstar: Add the Wireless Tag IDO-SBC2D06-V1B-22W
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Wed, 15 Sept 2021 at 03:42, Romain Perier <romain.perier@gmail.com> wrote:
> 1. http://linux-chenxing.org/infinity2/ido-sbc2d06
> 2. http://www.wireless-tag.com/portfolio/ido-som2d01

I think these should be Link: xxxx. I can fix this up if/when I put it
into the mstar dt for 5.16 branch though.

> diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
> index a316eef1b728..10efd703717e 100644
> --- a/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
> +++ b/Documentation/devicetree/bindings/arm/mstar/mstar.yaml
> @@ -25,6 +25,8 @@ properties:
>            - enum:
>                - honestar,ssd201htv2 # Honestar SSD201_HT_V2 devkit
>                - m5stack,unitv2 # M5Stack UnitV2
> +              - wirelesstag,ido-som2d01 # Wireless Tag IDO-SOM2D01
> +              - wirelesstag,ido-sbc2d06-v1b-22w # Wireless Tag IDO-SBC2D06-1VB-22W
>            - const: mstar,infinity2m
>
>        - description: infinity3 boards

Looks fine.

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 7e0934180724..7f0e92cea716 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -1448,6 +1448,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
>  dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
>  dtb-$(CONFIG_ARCH_MSTARV7) += \
>         mstar-infinity-msc313-breadbee_crust.dtb \
> +       mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dtb \
>         mstar-infinity2m-ssd202d-ssd201htv2.dtb \
>         mstar-infinity2m-ssd202d-unitv2.dtb \
>         mstar-infinity3-msc313e-breadbee.dtb \

Looks fine.

> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
> new file mode 100644
> index 000000000000..34df472fed71
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01.dtsi
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + * Author: Romain Perier <romain.perier@gmail.com>
> + */
> +
> +/ {
> +       reg_vcc_dram: regulator-vcc-dram {
> +               compatible = "regulator-fixed";
> +               regulator-name = "vcc_dram";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-boot-on;
> +       };
> +};
> +
> +&pm_uart {
> +       status = "okay";
> +};

Looks fine.

> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
> new file mode 100644
> index 000000000000..20b40b711d4f
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-sbc2d06-v1b-22w.dts
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + * Author: Romain Perier <romain.perier@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +       model = "Wireless Tag IDO-SBC2D06-1VB-22W";
> +       compatible = "wirelesstag,ido-sbc2d06-v1b-22w", "wirelesstag,ido-som2d01", "mstar,infinity2m";
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               sys_led {
> +                       gpios = <&gpio SSD20XD_GPIO_GPIO85 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger = "heartbeat";
> +               };
> +       };
> +};

Looks fine.

> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
> new file mode 100644
> index 000000000000..d877aff85033
> --- /dev/null
> +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + * Author: Romain Perier <romain.perier@gmail.com>
> + */
> +
> +/dts-v1/;
> +#include "mstar-infinity2m-ssd202d.dtsi"
> +#include "mstar-infinity2m-ssd201-som2d01.dtsi"
> +
> +/ {
> +       model = "Wireless Tag IDO-SOM2D01 (SSD202D)";
> +       compatible = "wirelesstag,ido-som2d01", "mstar,infinity2m";
> +
> +       aliases {
> +               serial0 = &pm_uart;
> +       };
> +
> +       chosen {
> +               stdout-path = "serial0:115200n8";
> +       };
> +};
> +
> +&reg_vcc_dram {
> +       regulator-min-microvolt = <1500000>;
> +       regulator-max-microvolt = <1500000>;
> +};
> --
> 2.33.0
>

Looks ok.

At some point, probably next week, I'll take these into the
msc313_mainlining branch[0] and rework the commits that build on top
of this.

Cheers,

Daniel

0 - https://github.com/linux-chenxing/linux/tree/msc313_mainlining
