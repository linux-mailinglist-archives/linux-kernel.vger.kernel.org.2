Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B670C3A4DDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFLJUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:20:34 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:40919 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFLJUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:20:33 -0400
Received: by mail-ua1-f51.google.com with SMTP id d18so3505488ual.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNVmqtlfIFUqowfDuqxU7WaEgRPHbdl7aBs/A7dTrEM=;
        b=JM8HB6tsXv8gIn8uL8kNe2JZ5cu7d89BvTG6qAWpxLWFZTqiYlz7NSE3myd0cSHHN/
         p4q65B8+oAsfpqL6etQOGSmDKAcRdy2H7u6LN+uYjn7tSk151xrJ7CNmGpug/F1JfGNe
         nTDUwnBQP1/fujV/SW02OQTIOesqnWauoBVNb98I8GwU2PXmS9V/kLNytkpmk2MZP8GE
         5ajxnxnNGfro82knlAncphlQGutIYh8udJIo6VC6jMTWlfRlNNqKjUQMyWYIAXpP/R8D
         J8SyNwx/WKd7iGrRjCpGnPwycPuVblpv2YED3xneiY1NjbhKg9PZ3rCAqSX82HQGpGT0
         aCfA==
X-Gm-Message-State: AOAM532EBGNw4e79EgAm82YnUpIpWWeWZxF/iDdgaHcmFosK9VgXF0L4
        Vykc08ZORoXZw8b6GTPob8cV6INMByeOr6HQl/8=
X-Google-Smtp-Source: ABdhPJwAI+RI3SrTRAwJf2AZP+U4pTFRMUo0MFueLRV4ahK9wQLru2LdW5DTHGGxkQKU4qbDdnY+9mRef6FwEAFwJ3E=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr6821642uad.100.1623489500812;
 Sat, 12 Jun 2021 02:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
 <20210525083340.27722-2-nikita.shubin@maquefel.me> <8cdf2b130ae02ba00324d0a70cbbcd3ba53e1d09.camel@gmail.com>
In-Reply-To: <8cdf2b130ae02ba00324d0a70cbbcd3ba53e1d09.camel@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 12 Jun 2021 11:18:09 +0200
Message-ID: <CAMuHMdVMbik3Zti3eKm1T9tAgY-iinD=om6qBA3DK5JwmqrMtA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ep93xx: clock: convert in-place to COMMON_CLK
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Sat, Jun 12, 2021 at 12:42 AM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On Tue, 2021-05-25 at 11:33 +0300, Nikita Shubin wrote:
> > Converted in-place without moving file to drivers/clk.
> >
> > tested on ts7250 (EP9302).
> >
> > Only setting rate and change parent tested for, as they
> > are missing on ts7250:
> > - video
> > - I2S
> > - ADC/KEYPAD
> > - PWM
> >
> > Only video and I2S clock are interesting, as they are
> > GATE + double DIV + MUX, all other are pretty much
> > common but require ep93xx_syscon_swlocked_write to set
> > registers.
>
> This doesnt look good in my test:
>
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
> Enabling unprepared ep93xx-adc

> [<c0266560>] (ep93xx_adc_probe) from [<c02126e0>] (platform_probe+0x34/0x80)

> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
> Enabling unprepared ep93xx-spi.0

> [<c023eeb4>] (ep93xx_spi_prepare_hardware) from [<c023c0f8>] (__spi_pump_messages+0x124/0x620)

> WARNING: CPU: 0 PID: 36 at drivers/clk/clk.c:952 clk_core_disable+0xbc/0xd8
> ep93xx-spi.0 already disabled
> [<c023ee98>] (ep93xx_spi_unprepare_hardware) from [<c023c35c>] (__spi_pump_messages+0x388/0x620)

These are issues in individual drivers, not in the CCF implementation.
All drivers using the clock API should be converted from
clk_{en,dis}able() to clk_{prepare_enable,disable_unprepare}() first.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
