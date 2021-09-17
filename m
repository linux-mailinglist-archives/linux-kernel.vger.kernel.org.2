Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB12410052
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 22:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhIQUff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 16:35:35 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56791 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhIQUfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 16:35:32 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MTw02-1mIyZZ1nhy-00R0nV for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021
 22:34:07 +0200
Received: by mail-wm1-f44.google.com with SMTP id j134-20020a1c238c000000b0030b32367649so4508877wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 13:34:07 -0700 (PDT)
X-Gm-Message-State: AOAM531lcAQokS874COQ4116LRKxUWBYqqM2L/grfmtUBGbTXbfEJELX
        lm/4/WAwwkTOtFR5zsihva7yXxhCuAsmqCDUYUU=
X-Google-Smtp-Source: ABdhPJzAbeTYpS2KwNzXeQccqROQ/2kwCIIHTD2x3Zr6TyjGe+VoZM1x0dwFcygbCopM8pJgYBHGbYVc6dFIkJDVR3I=
X-Received: by 2002:a05:600c:190e:: with SMTP id j14mr9029138wmq.35.1631910847126;
 Fri, 17 Sep 2021 13:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210830213846.2609349-1-ndesaulniers@google.com> <CAK8P3a2JJ=5t16enn2LaZE_zT1ZqNVyi9FQpTUrgVsQWiMtDkw@mail.gmail.com>
In-Reply-To: <CAK8P3a2JJ=5t16enn2LaZE_zT1ZqNVyi9FQpTUrgVsQWiMtDkw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Sep 2021 22:33:51 +0200
X-Gmail-Original-Message-ID: <CAK8P3a04ZGgxNf6mmufwOmCY37JJkN9CHDJGQe2wY4CabwafuQ@mail.gmail.com>
Message-ID: <CAK8P3a04ZGgxNf6mmufwOmCY37JJkN9CHDJGQe2wY4CabwafuQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: select HAVE_FUTEX_CMPXCHG
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:p1XEjFy2mplEQvjvoaAaFErbq9T+uN3kV2LrbHiTbIIio+NYTjt
 LeWt5uUH7+76j/Xge9HJ/nxUQ40HtBzB1qR2cPshj7JniNF2y17uxFexv0dL6WlezLfkRiy
 FguTBAhU7dx2VY2awXjybNk1QoETDZZHXbZvi29dpOhAkTFXHx+T0qJYO6/b7N3C/o2aAUR
 AufE5boMrw4FoDL5yYkyg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:885faAdw30Y=:kUXn+2t+5zXO6wshoJbwAC
 q/IXKTG6vm42JjFheEehSJRa0bn3r1M50+wNCFkPa5BvBVPDKbc76hOvX5hsrTHQZhFb+iucg
 enjbkKPQN+ODPVo9/zS3WAuT92t2+MDGrPGx9jXYL48Tzj7s6r/alNb+P7wRAAbEehXEdVEsl
 VpgZ9G/PiU/SofxtY5I2/EMLM4q+z9XvqGd7jbhq3NzEjyizhjiI+GFhqNH7vAJg478wqOSbI
 Nl9G2NCrVqdCexr58BlTgHD91zUztNzW46z6ynMPgdpC5flBBcZAh0uX+m6D7CyqpoT9+srwn
 7gqbq8GgeXcQfGjJKnO36Ma8di4bylZBe0Cx2B5ST6GOLSdfdOqQtpKko1DfFI9A1kBBl3OCT
 W9m0VrkvDOHX5gkSWNsqM5WAcu5GFpiMQ4OwkVfB88JFE9vVBVJVauCYKLoo+dwpACahPEm/S
 ojCDe1bxRZqyXyLL14skAyt4oO8EQ5BlfstcdMMbNqZneDy/dval+VHt6IRXTOg6UGbeO8OY7
 lUxHjfNKj75ivyeBu+00ctLHV6DcpxstBvZppXicMq1UdlhwaB1D6Vhs5QyCliKYzf4C7Bl28
 Lvgmdqc/ZQSMkQKQx8cAMjs0N0vaSTSoMDTuhDy9n52SjpFgq998yBlj22CPA07l4BEtsBlCN
 R9EsCUYbyCppMPVuV3cwKWO14XJ/hEc3wrS/j5U3Mm4W6YyNVb0cZZ03WEpaArksjiRDqlmr+
 0uvg4YovuyWKeQO19ElEp1Jy2H+IY/vveQ63Og==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 9:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Nice! I did remember that we had come up with a number of solutions
> for the build error and that at least one of them was an obvious and
> nice fix, but I could never figure out what it was. This is clearly better
> than any of the other ones I had found when I last looked.

Actually it turns out that I had come up with another approach, removing
the need for HAVE_FUTEX_CMPXCHG and the boot time check altogether:

https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?h=randconfig-5.13&id=7bbd7403526a2a9f398f360fcb97f256052ca6bf

Guo Ren fixed the missing csky bit in there, but since the sparc32 support
is still missing, I never sent this before forgetting about it.
I think the only users of sparc32 these days are LEON CPUs, which have
usable atomics and could implement this properly but support for that was
not upstreamed.

        Arnd
