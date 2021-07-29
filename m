Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0350C3DAA76
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhG2RnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhG2RnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:43:19 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74033C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:43:16 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id a201so11448319ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPcGrU8DIcjusEXWJE5PKUF8jV0LTNPBmsdBSpOQj18=;
        b=Yk9CeAU5IedoWiUzhQySeqEet+e5xX/gA9y8vrhh/DClehpr/WN7mwIw5pCA+Za4O/
         cb2mI+Ssym9T989Jnsh5CfWULN4uMQWWGi3dypTmeufxYxG+SEHh4G8hTheOow389Kdf
         ppXKncBtCbWkaWuJZ8UKWvpDWyFvxZsPFPjhlMoaDFCNsCl1ZuX3Jyx9SzvEOVMZb9eT
         XEAg+N5dC3jTdYXerXBfKHiaj2pFaY4ub9SJaU+ugXM8nzbwaYetvH4e8NNVn6LvkEuw
         ArRtYSJkUR3EkPtGvyw8Bn0quz00xb05xJSrHF73ldYyVjDiGOe+tl297wsLxVa+ok4a
         8xvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPcGrU8DIcjusEXWJE5PKUF8jV0LTNPBmsdBSpOQj18=;
        b=ELKe4X5B3TZV1iP008Pvmn86+bs5Lse/AlPY76VIk6zWSNHgFtXwmBXpLfVW2OhFGw
         A6RUXNUbLbt0e7LfgY92M7+rJgeb0hW5oBV6LJojgTtbAV5ANs6Ma114osMzARCM3zoT
         6cMcdgv/LTZi3tBAtWPtsvH8vPKruhR2PZ4CLPUKOo85LQqQbKlvPX11lJWrlQhPsBkd
         smjB8BTF5V/dPuh8tnu949E/FOQGe26C5rLvEI0dVWaIbuimV1jc9o+F3kizSOHTysHC
         vwZXL5796n/WkTuVYDZ8ExtL/pb6MQr+7PW/JQH3KMnL+AEJcKY4/yedXS1/OXCOtIFd
         QBOg==
X-Gm-Message-State: AOAM533UoHufXCtGQ0bRtz0i57C/965wZefpaXwMBsrHoeKv42FrtpT6
        eSKZ5VJxELKnF7YmBQOJoRpCb5SBuv2/U9bjKzauNg==
X-Google-Smtp-Source: ABdhPJxmCcZ+8GpEhlwZ1k/sN5SyGcoBQv30eRS5M90/ufyisL61kPpw6X/5cfK1kKasjeN0DnXgXyx4ml6AE/5Bw2E=
X-Received: by 2002:a25:3750:: with SMTP id e77mr8102733yba.469.1627580595689;
 Thu, 29 Jul 2021 10:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210728041253.15382-1-sergio.paracuellos@gmail.com>
In-Reply-To: <20210728041253.15382-1-sergio.paracuellos@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 29 Jul 2021 19:43:04 +0200
Message-ID: <CAMpxmJUnXpOhvaQuNPbFt3TY363vrsEWV1KXxhyBm7cJ-PWvwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] gpiolib: convert 'devprop_gpiochip_set_names' to
 support multiple gpiochip banks per device
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        John Thomson <git@johnthomson.fastmail.com.au>,
        NeilBrown <neil@brown.name>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 6:12 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
>
> There are some unfortunate cases where the DT representation
> of the device and the Linux internal representation differs.
> Such drivers for devices are forced to implement a custom function
> to avoid the core code 'devprop_gpiochip_set_names' to be executed
> since in any other case every gpiochip inside will got repeated
> names through its internal gpiochip banks. To avoid this antipattern
> this changes are introduced trying to adapt core 'devprop_gpiochip_set_names'
> to get a correct behaviour for every single situation.
>
> This series introduces a new 'offset' field in the gpiochip structure
> that can be used for those unfortunate drivers that must define multiple
> gpiochips per device.
>
> Drivers affected by this situation are also updated. These are
> 'gpio-mt7621' and 'gpio-brcmstb'.
>
> Motivation for this series available at [0].
>
> Thanks in advance for your feedback.
>
> Best regards,
>     Sergio Paracuellos
>
> Changes in v4:
>   - Add comma in warning message for clarity.
>   - Collect Gregory Fong Reviewed-by for PATCH 1/3.
>
> Changes in v3:
>   - Reflow a string literal to be on one line in PATCH 1/3.
>   - reflow commit messages PATCH 2/3 and PATCH 3/3 to occupy a little bit
>     more available space per line.
>
> Changes in v2:
>   - Address Gregory Fong comments in v1 of the series [1].
>   - Collect Andy Shevchenko Reviewed-by for the series.
>   - Collect Gregory Fong Acked-by for PATCH 3/3.
>
> [0]: https://lkml.org/lkml/2021/6/26/198
> [1]: https://lkml.org/lkml/2021/7/8/47
>
> Sergio Paracuellos (3):
>   gpiolib: convert 'devprop_gpiochip_set_names' to support multiple
>     gpiochip banks per device
>   gpio: mt7621: support gpio-line-names property
>   gpio: brcmstb: remove custom 'brcmstb_gpio_set_names'
>
>  drivers/gpio/gpio-brcmstb.c | 45 +------------------------------------
>  drivers/gpio/gpio-mt7621.c  |  1 +
>  drivers/gpio/gpiolib.c      | 32 +++++++++++++++++++++-----
>  include/linux/gpio/driver.h |  4 ++++
>  4 files changed, 33 insertions(+), 49 deletions(-)
>
> --
> 2.25.1
>

Patches queued for next. Thanks!

Bartosz
