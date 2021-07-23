Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487903D41EC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhGWUYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGWUYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:24:21 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB818C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:04:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id x7so3212282ljn.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+du+0LHLfACLmN4y/oi02W5K+tfyhYdkNu9bdamCZoA=;
        b=PU8ExjLpqbQ7v0/Tet2GfCUlvlxrEFfeIpx99CC6Xk5+aELtn+8O2bULpwHlEZGAvn
         NnHZbXmI78vEHdBxHtZdyoo4dhMLlT2nPyNgRDVcWyxKJotHDsvBsAI/8Q/F8l4YOnBQ
         AyrT7aqeEglidsG7hJLMiRgyvgQ3JRMk5SYfTEVV7ThBCZJm5KFsOk5f+lvBLw0btP4d
         42l2xOo19oJRKfeJBplz2KKkTKwgw9DGVyLxFvfQXjpTCqIQwObnvEaazH8ZHwd4Oykv
         zukRN0buICPccVlmtRqHaOmhc4TWJsks2Iy/oXmqVOytYVEv4MmzD+t8N/9ISPqhEy9e
         2cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+du+0LHLfACLmN4y/oi02W5K+tfyhYdkNu9bdamCZoA=;
        b=L/5sQ/HPGGI2fL7EdoJPMaWR9CdCPf1TQdohuUDopAuuEdPg+bizrnNGjIMlgUZPYn
         dgc/CKe6vyHrFOWwGIB3VE3iRo6FoMQFRQtCJJmv1VP7YTxieh9r9oBQol6DcAVLht/T
         3AD4X7oNv4Fiv1FsuEYzJksxaSFIk9QLih3RQnkWMnhqscwQc2gsepcoEDw4XtH2kK9U
         oOe5vPah7NkqEYtvuRGRL1fZqkPG6F0WC6dPtizp0aOkC4TiaVHYCqmwSdNT7khu1Ook
         b+2kRXM7wpUN/hE0yVJEKrQLSXEQL0PoFYqfxI+N2KRibgMJXNiT9GpP37BLRYt6q+uV
         +7GA==
X-Gm-Message-State: AOAM532erNlaeF70jW/7ZQGW+1BwsIkD0M3ACVkA/QxABoEpX7x4gpM+
        Adh3rPKgmqeeBCiOKBSJ9q1zvpC1DrSFT8poOhyy0KSv+jE=
X-Google-Smtp-Source: ABdhPJxQWYsOWFLVby006xkxrHiuFL3EnCGftMH8g5GForQjSavZnil4OEtYwmjZFYh8qrp4mdkJspxPgo3NmEIWfGc=
X-Received: by 2002:a2e:9d15:: with SMTP id t21mr4501765lji.200.1627074292231;
 Fri, 23 Jul 2021 14:04:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210701002037.912625-1-drew@beagleboard.org> <20210701002037.912625-3-drew@beagleboard.org>
 <8c59105d32a9936f8806501ecd20e044@walle.cc>
In-Reply-To: <8c59105d32a9936f8806501ecd20e044@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 23:04:41 +0200
Message-ID: <CACRpkdbhKsuXZiLCh_iajJQWDdQQOZ87QF3xDr5Vc66SoVCnxQ@mail.gmail.com>
Subject: Re: [RFC PATH 2/2] gpio: starfive-jh7100: Add StarFive JH7100 GPIO driver
To:     Michael Walle <michael@walle.cc>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Huan Feng <huan.feng@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 1, 2021 at 8:39 AM Michael Walle <michael@walle.cc> wrote:
> Am 2021-07-01 02:20, schrieb Drew Fustini:
> > Add GPIO driver for the StarFive JH7100 SoC [1] used on the
> > BeagleV Starlight JH7100 board [2].
> >
> > [1] https://github.com/starfive-tech/beaglev_doc/
> > [2] https://github.com/beagleboard/beaglev-starlight
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > Signed-off-by: Huan Feng <huan.feng@starfivetech.com>
> > Signed-off-by: Drew Fustini <drew@beagleboard.org>
>
> Could this driver use GPIO_REGMAP and REGMAP_IRQ? See
> drivers/gpio/gpio-sl28cpld.c for an example.

To me it looks just memory-mapped?

Good old gpio-mmio.c (select GPIO_GENERIC) should
suffice I think.

Drew please look at drivers/gpio/gpio-ftgpio010.c for an example
of GPIO_GENERIC calling bgpio_init() in probe().

Yours,
Linus Walleij
