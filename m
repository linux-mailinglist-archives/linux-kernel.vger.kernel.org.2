Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9493D93EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhG1RGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 13:06:07 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:34389 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhG1RGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 13:06:00 -0400
Received: by mail-yb1-f175.google.com with SMTP id a93so5154311ybi.1;
        Wed, 28 Jul 2021 10:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qa1TBZYoLh+YW4PL+E3qWZTqGnp9tadNlp+6JNZ01k8=;
        b=Jy4xHBJ9PFo19VYDdXr9BvTMVMM6CFfvG1/Y3JYGZKK8/4J2eCkAPXh0VqskJEmAn9
         A2QFGvRXHLa3BPXPN0OHTkCbTFE/XGnv+f44Sm+J1Jawz8rYdjNKhQK+43if5QOwjKlp
         UMxEbV+lfMR7CXIT5O7awZOIT0bo2Dcfu4YboHSoHgEOHlbshyl2m3Jonh8chaoY8Ozc
         ZJWS7kI3qyWSV93tfb7jFgBMK9RpkRpaBeMt1mM30YvXJOhrZrXDAMjJM7BBSb3awSKS
         EuW2blx5cYEwn0KJuTZ+0fqlu+FDufQM6qLAhEjYe3NIQlhCXFQ+yd72eWWSb30absz1
         Gtag==
X-Gm-Message-State: AOAM531niC+Dmygu1T9/bKf7My4p2Fp9gCTuBFVKH3K3q1Ocr1WnPAmN
        8g/dkOH56yJYNc0S0pdIaEoHvu2zlbQMVmxwzy8=
X-Google-Smtp-Source: ABdhPJxAcps2oVxkB58J6mo4MBlUBaaOa0QLieInecYjzoFhd3BRYME5jWkJspYp6fLqXsEuVOFrUpsE+D1Sw7atR20=
X-Received: by 2002:a25:8093:: with SMTP id n19mr945626ybk.414.1627491958119;
 Wed, 28 Jul 2021 10:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210726171802.1052716-1-kernel@esmil.dk> <bcc9de67-f006-0a81-8c3f-2ae5188dca48@roeck-us.net>
In-Reply-To: <bcc9de67-f006-0a81-8c3f-2ae5188dca48@roeck-us.net>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 28 Jul 2021 19:05:47 +0200
Message-ID: <CANBLGcxpaFt-bokq8=Tie-bJnWk5AqLyr-1Ns-+Xtobxs5bYQQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hwmon: Add StarFive JH7100 temperature sensor
To:     Guenter Roeck <linux@roeck-us.net>,
        Drew Fustini <drew@beagleboard.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-hwmon@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2021 at 18:54, Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/26/21 10:18 AM, Emil Renner Berthing wrote:
> > This adds a driver for the temperature sensor on the JH7100, a RISC-V
> > SoC by StarFive Technology Co. Ltd., and most likely also the upcoming
> > JH7110 version.
> >
> > The SoC is used on the BeagleV Starlight board:
> > https://github.com/beagleboard/beaglev-starlight
> >
> > Support for this SoC is not yet upstreamed, but is actively worked on,
> > so it should only be a matter of time before that happens.
> >
>
> Hmm, makes me wonder if I should apply the series now or later,
> when the chip is actually supported by the kernel. Comments/thoughts ?
>
> Guenter

I'd of course love if it was applied now. That would at least mean
fewer patches to rebase when keeping the beaglev patches [1] up to
date, and I'd be very surprised if SoC support doesn't make it
upstream eventually. But I'd also fully understand the position that
this only makes sense to add when support for the SoC is upstream too.
I'm adding Drew, as he might have something to say about this.

[1]: https://github.com/starfive-tech/linux/tree/beaglev

/Emil

> > v3:
> > * Handle timeouts from wait_for_completion_interruptible_timeout
> >    properly.
> >
> > v2:
> > * Fix checkpatch.pl --strict warnings
> >    - Add myself to MAINTAINERS
> >    - Fix multiline comments
> >    - Use proper case and whitespace for #defines
> >    - Add comment to sfctemp::lock mutex.
> > * Remaining comments by Guenter Roeck
> >    - Add Documentation/hwmon/sfctemp.rst
> >    - Use devm_add_action() and devm_hwmon_device_register_with_info()
> >      instead of a driver .remove function.
> >    - Don't do test conversion at probe time.
> >    - #include <linux/io.h>
> >    - Remove unused #defines
> >    - Use int return variable in sfctemp_convert().
> > * Add Samin's Signed-off-by to patch 2/2
> >
> > Emil Renner Berthing (2):
> >    dt-bindings: hwmon: add starfive,jh7100-temp bindings
> >    hwmon: (sfctemp) Add StarFive JH7100 temperature sensor
> >
> >   .../bindings/hwmon/starfive,jh7100-temp.yaml  |  43 +++
> >   Documentation/hwmon/index.rst                 |   1 +
> >   Documentation/hwmon/sfctemp.rst               |  32 ++
> >   MAINTAINERS                                   |   8 +
> >   drivers/hwmon/Kconfig                         |  10 +
> >   drivers/hwmon/Makefile                        |   1 +
> >   drivers/hwmon/sfctemp.c                       | 291 ++++++++++++++++++
> >   7 files changed, 386 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/hwmon/starfive,jh7100-temp.yaml
> >   create mode 100644 Documentation/hwmon/sfctemp.rst
> >   create mode 100644 drivers/hwmon/sfctemp.c
> >
>
