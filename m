Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E37429FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbhJLIbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:31:41 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55201 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhJLIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:31:37 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MORN0-1mOc1w2bSI-00Py2I for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021
 10:29:34 +0200
Received: by mail-wr1-f48.google.com with SMTP id v17so64320162wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 01:29:34 -0700 (PDT)
X-Gm-Message-State: AOAM530Wmi5oO9KVWL3X7I2QE5qh0uaGd43T8kR4SeHl9a1BDNQ9R3XU
        tldxoqUbMTPbMCdYkPLKK1nyT3LKiLhklXs0iE8=
X-Google-Smtp-Source: ABdhPJwcy453LzA1tUavvEqP5ms9rW1r2DqfSTMfSCTi8S6jui2IgIf+ApKxmtJuO5nhKrgEieeU5ja5k85kajO4s7c=
X-Received: by 2002:a1c:2358:: with SMTP id j85mr3977852wmj.1.1634027374311;
 Tue, 12 Oct 2021 01:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me> <20210726140001.24820-9-nikita.shubin@maquefel.me>
 <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
In-Reply-To: <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Oct 2021 10:29:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
Message-ID: <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9RvfXZMBbsIM5/rpub5sqFB2nalWBwI+BO+3cZ9/HwHeGCM6aYd
 30eEA95drIDT6mkd6dxREd62cbq2vrCEFg+tgFKrjHhVNZd2vRYz3K3UX+4ou3zFiO2rZ9l
 G8Cx749n/lcLlH5CndwQ98mLImI1XDG3aermV8du3veJA3QwRGn2jc9fHOX50BjMk5smWUK
 30N/b6d6nUWaoMD6+B8Bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:h7Fo0geThcU=:IPQXolZ50dpHuib+n3Dg9w
 Z0qaE/HLqB8W67acVOjJrJ17uRZ5KlxNd/1qlOLwF9qGrTF7IKTVvfzgyz7BAg6DY9W9bb4oa
 rDiJ5VXkFRPA5n5KuZxQM7lYfl2pjFefuiZ+ZswdCn2VGYXA9boeI7JZ2vEEM5/HWTC01CpQR
 VW5v6Yf5bG1p1mFWEyLnYy1QtDiDoF6pfcXX6liXkiauLIHsOu4te7MACnm/f11INe8Vp1U/C
 pL10F7EQwwZ+Pocl+AHyQWdQP+MVxDqK8qm2krGBi5W22Hvi14TgJZbOvqD2jx398Omf20CFY
 +PXPTEi7Kkk1HkqwXqNFjepzcBcq80i2WkcMQHJBx4pxuFWGFZ6sr6nvJ5Q8HsgzBfLTyKEGO
 3J1cVQmZY9rBDXXUxA0dFr0MbQJ8ZEDiPhmsYdPr26oCO5CtYL15/FrstGiWrWfmlqpVMcEnc
 w17BPNocyIofR95JH2c39hofvXC8DvUd4ymW649nd++GYu3lHFH1VE44hKxCZ6C2jFgLLF8TV
 ZhPfXG0tgfeSt8Rdfl/csBlSClN9Upr0Fcnzy4x4+0Tu4SZkM4hou5kK2QW41DI1kXV996RqB
 mR/O8YQyReakmQgN4tpW3I9b4eON7teJhglk/6O3gJW2aAGGYa8aoM9UMssjz2p3wafkZ1KAJ
 RrBRMQ/+PzOQMG9c1XFrmsKAQesxsPS332vXbedqBqktpPjesuzkFNsxDdhdGbvRxli3jxFv6
 7XHreh1PGPzD9FEL3IZMOR5kM84rLApgD9oR28bRyW5tpMdNgw29xsFCFpPhTmj31/LNzCeZU
 J5O6BjVbjZHlmw5EHAfy0RZ/FmiQrgFpMg/FA3iYjobnABXUXAgcK7NnUW3AR1NvQ5/cqrh1g
 N7+Nf2mmTGTbZrsfvcFw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 10:03 AM Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
>
> Hello Russel, Arnd,
>
> On Mon, 2021-07-26 at 16:59 +0300, Nikita Shubin wrote:
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
> >
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
>
> with an
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> and
> Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
>
> shall I add this patch to the Russels patch system, or would
> Arnd take it to the SoC tree?

The SoC tree is the right place here.

Please resend the patches you want me to apply to soc@kernel.org
so they make it into patchwork and I can get them from there.

> There is already a merge commit 726e6f31b102 upstream which
> claims to merge it, but it's actually not in.

It looks like this is just the drivers/spi/ bit of the series. Are
there any other driver changes that are needed along with
the arch/arm/ patches, or is it just the actual clock support now?

       Arnd
