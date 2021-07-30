Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EEF3DBD64
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 18:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhG3Qz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 12:55:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:56521 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhG3QzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 12:55:24 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxHLs-1n77cc1pTE-00xbBO; Fri, 30 Jul 2021 18:55:18 +0200
Received: by mail-wr1-f45.google.com with SMTP id h14so12087408wrx.10;
        Fri, 30 Jul 2021 09:55:18 -0700 (PDT)
X-Gm-Message-State: AOAM531x36drL025206zfhSfsIdVNUVYtXIIdwh7tJXRkoxahAE6fFFe
        5pch65HRs5BPODEUF4YRSt9avNT68PPACJ16s+4=
X-Google-Smtp-Source: ABdhPJx8pRQBP+fRbShwuYvNiG34iB85ht3PkP357n80b2tOp0dc7/DUvny3sNOHPUMU7TLnQH+oHIK/GgO7nACZa6s=
X-Received: by 2002:adf:f446:: with SMTP id f6mr4206493wrp.361.1627664118110;
 Fri, 30 Jul 2021 09:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210730134552.853350-1-bert@biot.com> <20210730134552.853350-5-bert@biot.com>
 <CAK8P3a3OuJ3pMSdEA4Rt3aWvvuX2+_Bg5x7-kZ1++fvvJvgGxA@mail.gmail.com> <d5498cc1-f700-998f-4e98-918081f2ac66@phrozen.org>
In-Reply-To: <d5498cc1-f700-998f-4e98-918081f2ac66@phrozen.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Jul 2021 18:55:02 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1c9bVjACjAN=2d+XiBn+yWgHHs9CEUmik7U61+3MzFhw@mail.gmail.com>
Message-ID: <CAK8P3a1c9bVjACjAN=2d+XiBn+yWgHHs9CEUmik7U61+3MzFhw@mail.gmail.com>
Subject: Re: [PATCH 4/5] ARM: Add basic support for EcoNet EN7523 SoC
To:     John Crispin <john@phrozen.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Bert Vermeulen <bert@biot.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Felix Fietkau <nbd@nbd.name>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Djm3HiGtPborGwABFKLa69C29V921SpSOe07xLTEUvN1ltcib6i
 oU/7+2bli17JFsiITTU2UsrQHCJmRtJnoY+9zlZktzDif2QGD2dXiaFyoWQmdkMc4Yn9dvz
 qq63H6S93Jzyzu4jS+tuYMPvIOpvPsrkTlP1ul+Z4mbsqZFt0YYJs53i4gPmF95zUdLdOsO
 Oz61d1ljFEleqlOSPbCNg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gKgZSZRph+M=:9190HjctsZ8ZsfU/3fz5Zy
 XcLcDmqmyjFh8xMVT/kyrd4nwiYHOx8vPve6q0MleNDzdMM3zW8jH6qQDS/Zhvk5/P90B717m
 8kFR9YakEvKAdj3dgaYyC9mdwjVNYlfPa4fshumIOzV9Ng5huI/M+TEs7HOq5slDWgVfxdwK8
 vXpsWTkOke/BxCuYubNJlk06DKhovUgZ0Oa27GP2Z8cbPTUd44le8YRnh8UiHJwKINUZYS/Dy
 3qNeLeELScI8Mgxao9CWL3sQTTzwDxHrwcqvy/zWCCHEtu/GmzxGEZj2FLE17uD0s2TuPVkM/
 M0Ammy4P3/4+zavBbnlh2+pJ6p+TUCWLq+AWUH7djVJJPFGzQVgnV3aumJB8M2vzmaSUgl3nQ
 WZAz9N6OEvs7Mx9rZ9M7awuPRSsyvLf4PzKKjalNIqjEV1OlsRFWRCLZSwgaH37uQnExogVfI
 +awAMCrZWXtldPs1yvMOXj5Vf+W+K42oLvAUibLTTxBqP5CDrau96Z/r0N2tDld244CP1NAq1
 4Qnksqd3n9GwzDid+vUU1OhjFnyN4SG88yZ1kz4Q5dvC/hWbrmGKBJbm3j7EJ2Mdm89HUcGdP
 7Y4X+TUEstGvKNz/xu1Qx16PS+72YrqzoWedbSEAAhL1hOB15Iy5tQxLCAqqSdU4CnldljMT1
 Z8ezGMN7kEcA7PWFA1Z9Vha9m0KP2AF8t0Jlgy7pb55J7DoLVbHNuZA2CnaS1fyOBeGsdNH0A
 i5/ZyrWprd6QxAxQpvAGf6GKoySxNQiKN5VrJQ7VqCFvW9yA5w2pbmCGu00eBzPDxh4eaRSNR
 NVd9PswvNDIe8FKva1HPGIoociPuFQmH3wN47wvm6WSAT18B7Gl5bEahKAoRSIXceWA1Yb80k
 Ex++Yo6sRmjecHpjyFpxpBXefdBwXsVemgc7LICKM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 5:16 PM John Crispin <john@phrozen.org> wrote:
> On 30.07.21 16:48, Arnd Bergmann wrote:
> > Given how closely related this probably is to MT7623/MT7622, should this
> > perhaps just be part of arch/arm/mach-mediatek? According to
> > https://wikidevi.wi-cat.ru/MediaTek#xPON, the older (mips based) MT752x
> > chips are apparently just rebranded to EN752x after the business unit
> > was spun off, but I guess they are still in the same family.
>
> Hi,
>
> ECNT (what was once known as trendchip) is now a subsidary of MTK (and
> not a BU if I am understanding it correctly).
>
> the EN7523 is rather similar to the MT7622 for some parts, other parts
> (spi, flash, wdt, gpio, .. drivers all needed to be rewritten and will
> be part of the next series).
>
> the older MIPS silicon shares almost no IP with the current ARM silicon.

Ah, so I guess the old Trendchip parts were separately developed separately
from the Ralink parts before the original acquisition, and then Ralink/Mediatek
combined the two product lines before spinning off the dsl products into
a new subsidiary.

> not really my call to decide which folder this should live in. it seemed
> natural to just give it its own folder, as ECNT is not a BU of MTK.
>
> we can change that however if required.

My preference would be to have a common directory for both,
but I'm not going to require that. From the kernel perspective the
main question is actually not who makes the parts but who is going
to maintain the code.

Matthias is doing a good job taking care of the Mediatek parts,
and he's familiar with the arm-soc process. If there is enough overlap
between the Mediatek and EcoNet devices that we would expect
either conflicts between binding/driver patches, or that you would want
each other to review the patches for related parts, then it would
make most sense to have a common directory and maintainer
entry for both, with all patches going through the same git tree.

It would also be nice to have someone listed as second maintainer
for mediatek, since Matthias is currently the only one listed there.
(Doesn't have to be you, I don't mean to drag you into taking up
more work if you don't want to).

Please discuss this between the three of you (Bert, John and
Matthias), and let me know what you think works best for all of
you.

       Arnd
