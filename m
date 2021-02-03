Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7B30E59D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 23:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbhBCWG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 17:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhBCWE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:04:59 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2C9C0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 14:04:19 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id m76so1165988ybf.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 14:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v7K3rW8zvq+XYmMSjDf3MSB+TOa5aFl39/Zfs0xNs5U=;
        b=Es7NUx4/adad+Te1etGM6bwLwJ+xNQFACicd47TDJTcUwCw0zDHsw6oP16iLf4nz+L
         N+wFktl7eNs+K6vmdsykdjHt8yoZvbxmBwggr9UzdN9c3gIufH8PRHP5Wv05cQO1Z94b
         HyLFKzyhmFf+L2qBsOqWGIPywS+sRgdJ/sNLy8AvmenYWwnQ3NWAidiIQ2la0tzOBvi9
         ie3kHKTLajBVzmdG8geg+EKsREOeeCydyP1b7Ro4OgWtnIxEy1i5FpGGc8onMeorgTB3
         sxtBJhh2dTbqeczjqzkOWomUGBXOYoIPLQ29kctTWYynhR9l0HJ6unt5UDKykjcysHoi
         6BuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v7K3rW8zvq+XYmMSjDf3MSB+TOa5aFl39/Zfs0xNs5U=;
        b=df13GrTtKwRox9vReIrJMEXAycZLnq7PkMQqzI4fgBJpro4M/ha1p+IlhbQZP5Ky0W
         uqJu/jw3ViboZcRd+k/cVSe27VTGHeViLJV2jhJDUTKbwE6uKQrNk/igKKWI33E62AEE
         LJ1woczQc4EjsYDbVhJrl02wKT5G91YDYByNrIahmE4wp+O3guYyeu1EMjcYaVp7HaIG
         qx8RJqyJSspUGPaMOLuHQGjVJw0TZ4IVzGMnXo4Q8ZKpQRzOM5pBL26fvZIqEax3QJ8h
         iFpi993Zc6zkAiWuI3QD/0tF/XIMjmhdfB5Vc4LXadYxuEbB5810NaSCKxzP4vbK9QT7
         jocw==
X-Gm-Message-State: AOAM532gkUPxlkTGabocEyMDNMtqHW9Y+qY8zdoL/i+BScFt/blNAaZb
        O4YSLE8gp1WwmsV88rxWLDT89C8R7TImf94uZ3nEDQ==
X-Google-Smtp-Source: ABdhPJyx22+rwKcjQf1sOF4vT0S+2zuBCVq2Amx9fXv363dMobm/ynDLr7OM46rqz11e1gNt/PhUW8JMNl8MCP4C42o=
X-Received: by 2002:a25:c683:: with SMTP id k125mr8298996ybf.32.1612389858339;
 Wed, 03 Feb 2021 14:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx> <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
 <20210203215757.pnfvfny2x67phyd7@viti.kaiser.cx>
In-Reply-To: <20210203215757.pnfvfny2x67phyd7@viti.kaiser.cx>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Feb 2021 14:03:42 -0800
Message-ID: <CAGETcx9YGkqOj7e5xeXdE-icog9-v+SsTpW35-n1KeCf6JvpbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 3, 2021 at 1:58 PM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Thus wrote Saravana Kannan (saravanak@google.com):
>
> > > With modules disabled, the kernel boots but probe fails for some
> > > (non-mainline) drivers in my tree.
>
> > Thanks Martin!
>
> > > All of those drivers have a gpio in
> > > their device-tree node, such as
>
> > > my_driver {
> > >    gpio_test1 = <&gpio1 0 0>;
> > >    ...
> > > };
>
> > > with gpio1 from arch/arm/boot/dts/imx25.dtsi.
>
> > > The probe function calls
>
> > > of_get_named_gpio(np, "gpio_test1", 0);
>
> > > to get the gpio. This fails with -EINVAL.
>
> > And you didn't see this issue with the fsl,avic patch?
>
> No. With the fsl,avic patch in place, all drivers are probed correctly.
>
> > The property you are using is not a standard GPIO binding (-gpios,
> > gpio, gpios) and I'm not surprised it's not working.
>
> I know that I should be using the gpiod API as suggested by Geert.
>
> BTW is this definition ok? Could its driver be converted to using the
> gpiod api?
>
> rtc: rtc {
>    compatible = "moxa,moxart-rtc";
>    gpio-rtc-sclk = <&gpio 5 0>;
> ...

The correct non-deprecated binding AFAIK is something-gpios. Not
gpio-something. And then you can use different APIs to get the GPIO (I
forget what it's called).

-Saravana

>
>
> > The gpio1 is probably getting probe deferred and ends up running after
> > "my_driver".
>
> I added a debug print in the probe function. It turned out that the
> driver for gpio1 is probed for the first time after my_driver.
>
> I removed the interrupt-controller property for gpio2 for testing. gpio2
> was then probed much earlier.
