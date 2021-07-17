Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991893CC5EF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 21:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhGQTtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 15:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhGQTtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 15:49:15 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA5C061762;
        Sat, 17 Jul 2021 12:46:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v1so17477965edt.6;
        Sat, 17 Jul 2021 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uf9ovgwZadCx9qH0j7ni/tLHBwLpSqqtIpLKHpJ2A5k=;
        b=amz7jyI6NWsc3UfcTGAZpqkYN7ZZ39sstx2gCWuQeDsnK4T5Ds0rAbwzj59MV3qOXS
         qVBOaKZ2v2IvqGnmHG45Qz/VtbUPE17qbDEoAlnZq3s2G8uVUJfgtKR9iPtmnIe5ysn5
         BLzMd6KEt5ugFv4yzpBAFSmWGCLCkxJb/Q/7C65uhvWIGqhce9y0rC+ugflM0C6mC0Xg
         +fBx+8vWN4IsZzoKP9raOuZ3QwjDUK5navpcxbsZCn3GpNR+6F/5EdOrvXWsr+Wq5R+9
         Q//P+eGDC4wTeAwLxtTeytA1HziCt4zF+/uqs4ulnlwH0QRKMQQdvwUymuTTlWDryeiZ
         oPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uf9ovgwZadCx9qH0j7ni/tLHBwLpSqqtIpLKHpJ2A5k=;
        b=I4rEj4nCss2uMgV9ihp9H7BTRVv5Ba4r1k0ISrLcRfGLysLlQN03Mig4guzBbhFRxQ
         jD4e8dmAYrbsBz827QZcxr0fscd1Lcy/aT9tPPozsFrzOUWQrKbugIqcK6RhZwkcpjBZ
         N+wrJwFsWYt8zpX7dYZ+ZnDiDGrMjsB1ABzU4qvl9kTShNl6kvDUmXedj/emBoRe5G4z
         N/yLsXse/GhoOVIffLuMYjQnOTwsgOBeGfFl1iW1HcieWhto4UcTHOcFPtt+v7s8cfIc
         xniFaEwBH3d4P80A61paCVcFmXUIiFlBJdjbYXGxFOa7rp0gegw/KTw8Eih8vBbr5zEc
         ch3Q==
X-Gm-Message-State: AOAM530qsbw0c0TtyjCaMUiE3FDJnl6msfD/9RjaXyE6WDS2H64PjW86
        alFwU8Yyx4E2vpQ/dXji5nBoylgatWqEYLXrnqw=
X-Google-Smtp-Source: ABdhPJwdhDJeG3UUdeAYHhaU+cyLC7AqaAQpYGsHZwnBCdZoSn/tUwKYj1BghaowLSKgddaJsiwEdUkYfnDBaoQm8q8=
X-Received: by 2002:aa7:c550:: with SMTP id s16mr23560320edr.130.1626551174723;
 Sat, 17 Jul 2021 12:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210716103651.1455-1-linux.amoon@gmail.com> <20210716103651.1455-2-linux.amoon@gmail.com>
In-Reply-To: <20210716103651.1455-2-linux.amoon@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 17 Jul 2021 21:46:04 +0200
Message-ID: <CAFBinCDeqauw_V-Vn9cat9HaCXj6HEMz6G+G+VbqCNtGEFGYzg@mail.gmail.com>
Subject: Re: [PATCHv2 1/4] ARM: dts: meson8b: odroidc1: Add usb phy power node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matt Corallo <oc2udbzfd@mattcorallo.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Brian Kim <brian.kim@hardkernel.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Fri, Jul 16, 2021 at 12:37 PM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add missing usb phy power node for phy mode fix below warning.
> P5V0 regulator suppy input voltage range to USB host controller.
low prio - typo: suppy -> supply

> As descriped in the C1+ schematics, GPIO GPIOAO_5 is used to
low prio - typo: descriped -> described

> enable input power to USB ports, set it to Active Low.
>
> [    1.253149] phy phy-c1108820.phy.0: Looking up phy-supply from device tree
> [    1.253166] phy phy-c1108820.phy.0: Looking up phy-supply property
>                 in node /soc/cbus@c1100000/phy@8820 failed
high prio:
Can you please describe how I can test this patch?
My concern is that previously I have tested your patch with ACTIVE_LOW
and ACTIVE_HIGH polarity.
In both cases USB is working and I cannot observe any change (apart
from this debug message being gone).

In the Odroid-C1 schematics (page 1) GPIOAO.BIT5 is connected to USB_OTG *only*.
I cannot give my Acked-/Reviewed-/Tested-by without a description of
how I can actually test the GPIO potion of this patch.

[...]
> +               /*
> +                * signal name from schematics: PWREN - GPIOAO.BIT5
> +                */
> +               gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
low prio:
Even though it's strictly not necessary I think this is confusing to read.
Since there's no "enable-active-high" property the GPIO will be
considered as "active low".
My suggestion is to change GPIO_ACTIVE_HIGH to GPIO_ACTIVE_LOW

Also if you have any extra information since you last pinged me on IRC
then it would be great if you could document it.
I am referring to these IRC message, where you are stating that the
correct polarity should be "active high":
<armoon> xdarklight I have a question on USB GPIO Polarity on Odroid C1+
<armoon> As per the
https://dn.odroid.com/S805/Schematics/odroid-c1+_rev0.4_20160226.pdf
<armoon> MP62551DGT-LF IC controls the power for the USB PORTS
<armoon> https://www.mouser.com/datasheet/2/277/MP62550-1384050.pdf is
MP62551DGT datasheet
<armoon> As per the data sheet in section ORDERING INFORMATION  Active
enable signal is set below MP62551DGT Active High

[...]
>  &usb1_phy {
>         status = "okay";
> +       phy-supply = <&usb_pwr_en>;
medium priority:
I have raised the following concern in one of my previous emails on this topic:
> The mistake I made before is considering USB VBUS as PHY power supply.
> I believe the USB PHY is actually powered by the AVDD18_USB_ADC and
> USB33_VDDIOH signals. See the S905 datasheet [0], page 25
> These are 1.8V and 3.3V signals while you are adding a 5V regulator.
you replied with:
> OK, thanks.
so I don't understand what "OK, thanks" means.
If it means "Martin, you are wrong" then please provide a description
so I can also learn something!


Best regards,
Martin
