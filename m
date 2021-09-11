Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3324074D0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 05:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhIKDT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 23:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhIKDT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 23:19:57 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1191C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 20:18:43 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f22so4314250qkm.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 20:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yglhQiqMuWRPXEcp/S7cp6xw4g2Boo9OI0xnp6CMYq0=;
        b=WIz8lZM8PLGizh5UoEnFP8TfCrOQRzhtjoMSFgBW6nZVGw1g7pIgTv2s7R4uf7BE7i
         1Vcn6md5a/DpD/uE0Z0jbqm3xF+uW+OJ5FNv465mG9zup5WjKMvfgXkPtpdqUb6ibXaD
         +ebjUbCnGE5zhrzDu0fCNtIWBpGDOoWEO3TC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yglhQiqMuWRPXEcp/S7cp6xw4g2Boo9OI0xnp6CMYq0=;
        b=KMUsEki2W8BHaX0TFlco/eDSVJe9AKTrFY5x444fX2ni0UbZwjoypmq1iVqCh6L7r8
         xpcadGYFIxrx44bgVfVwMQ7XD0UC6k1y1iXZTbkJkJYCEWXCUrrKzlq62aTQ+qFK8TFS
         pR/lRl3tQahkCVvb5htlDp/C5AFcO1nVJLvhcWovcNU2Y9ric1I9IuIiYnGuBL2D1NEa
         uTgauza+hzrz+1VGcA9I6y8OAc9DAUFHpF5fkK/60Ex7NCBKkXbTznxxdiLLlMhhmCa9
         23zwAK5XXwexWiaiBuMDJduUcPRfVBbtvXdUPya2hzw0y4JGctWrV6ElbgFS11akdBix
         0a5Q==
X-Gm-Message-State: AOAM533dN2nJIXvppn31h+sV6lcFt3cyxLK50xbWBEvimwd3l5bIRfHq
        9DBDDievIvwnt416UmcikTmusW9r8Or5UcfxwUzTQw==
X-Google-Smtp-Source: ABdhPJxrshc0/e0qK2u4rQeCBzQr0P9W4mE/w2bCGPbHuyvvD1MoYhyx+d2tpScTXawu9idjHi4apmLNG0MU0Rawwm4=
X-Received: by 2002:a05:620a:228a:: with SMTP id o10mr545406qkh.342.1631330322890;
 Fri, 10 Sep 2021 20:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210910190322.27058-1-romain.perier@gmail.com> <20210910190322.27058-3-romain.perier@gmail.com>
In-Reply-To: <20210910190322.27058-3-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 11 Sep 2021 12:18:32 +0900
Message-ID: <CAFr9PXmRXcu_ifE62dT5AwZv2uFbYVfAc5ZX5qBoRkEPKGB+JA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: dts: mstar: Add the Wireless Tag IDO-SBC2D06-V1B-22W
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Sat, 11 Sept 2021 at 04:03, Romain Perier <romain.perier@gmail.com> wrote:
> +              - wirelesstag,ido-som2d01 # Wireless Tag IDO-SOM2D01
> +              - wirelesstag,ido-sbc2d06-v1b-22w # Wireless Tag IDO-SBC2D06-1VB-22W

For anyone wondering why we have two strings here:
The SBC board is made up of a SoM and a board with the connectors.
The SoM could be used standalone so we might as well have a compatible
for it too.
We have some dtsis for the SoM but really those could be built as is
to support someone using the SoM on it's own.

> +++ b/arch/arm/boot/dts/mstar-infinity2m-ssd201-som2d01-common.dtsi

For anyone wondering:

The som2d01 can come with an SSD201 (64MB DDR2 integrated) or SSD202D
(128MB DDR3 integrated) and they need different fixed regulators for
the DDR supply.
So we have a common dtsi and then override the regulator in another
layer of dtsi for the SSD202D version.

Thinking about it now I think we can drop common from the file name.

> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +/*
> + * Copyright (c) 2021 thingy.jp.
> + * Author: Daniel Palmer <daniel@thingy.jp>
> + * Author: Romain Perier <romain.perier@gmail.com>
> + */
> +
> +/ {
> +

Unneeded space.

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
> diff --git a/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi b/arch/arm/boot/dts/mstar-infinity2m-ssd202d-wirelesstag-ido-som2d01.dtsi
> new file mode 100644
> index 000000000000..06567a5219c5
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
> +#include "mstar-infinity2m-ssd201-som2d01-common.dtsi"
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

Cheers,

Daniel
