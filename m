Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3709941C0F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244896AbhI2Ire (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:47:34 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:39841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244764AbhI2Irc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:47:32 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1HmE-1mYG6m4BKc-002r16 for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021
 10:45:51 +0200
Received: by mail-wm1-f53.google.com with SMTP id g19-20020a1c9d13000000b003075062d4daso1162771wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:45:50 -0700 (PDT)
X-Gm-Message-State: AOAM530NsF/NbkTjcMEIxgqDA7oiIRgp66PuRDKl6NLIGcPMp1vmW1Hw
        IACKlyLcbHMpA9MKjsaSkyXLu8lEtkttlzX1Dbo=
X-Google-Smtp-Source: ABdhPJzqCwKl127cz2QAIug9k52aEJ4YFVJl10H5ExaqWrNYDMbabj08uEdj8WGiI+vahIxKZLPvws0pQjSbmc21pfc=
X-Received: by 2002:a05:600c:22d4:: with SMTP id 20mr9258111wmg.82.1632905150672;
 Wed, 29 Sep 2021 01:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-2-arnd@kernel.org>
 <CAK8P3a2mrVOXHzNKnLuHsdNCR3uVePE9W-Yn2CmW3nDpE8J7iA@mail.gmail.com>
In-Reply-To: <CAK8P3a2mrVOXHzNKnLuHsdNCR3uVePE9W-Yn2CmW3nDpE8J7iA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Sep 2021 10:45:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Mxmqj7t4TtYjzae-iCRPs2YtVMR=7v1vvUG-ixuKAtw@mail.gmail.com>
Message-ID: <CAK8P3a3Mxmqj7t4TtYjzae-iCRPs2YtVMR=7v1vvUG-ixuKAtw@mail.gmail.com>
Subject: Re: [PATCH 01/14] ARM: RiscPC needs older gcc version
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:QA/13Ne4Ax/rFXcU9a2RIi9+4sC4riwY35rwqim1buKJxZ3S/mP
 yyYGM17Izkxy+a/C1QTetCNj8BHY23+JXBQk2DPqDNX3Jlnp5Ao42o0+f768bn97rOWRH7J
 Z+llexkrDWNtp7ithch/6AHUPUfyTWmk+tMDheJ1pIXdx9rIyVy7cEBSG+wy3+XEfcGOXvr
 mGWSsd/cAIBZ2Cv5SHY3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dhM5ATZET0Q=:wh70nHNClgy3U33TIgVCNU
 132ChYRRPzzpErY6WOL4jMzYAxFNgCUWvsbrIoKwTfYGGF9ezBm0NvU2LSCoJtXpn5BifZ4nt
 jzFRYJe9aiKw4vkZkc8DL3438lhZ2GPQhIylxyvEVl967T3qSx/r4xACOhYY1XdEAxhneKBta
 IHW/zlvch6kYWHPh6VOTrpWjkKAckMAMrlJjk8tE9NqATFP789kgzC9xjKrQ+QwzpVS9qT40r
 iYtzU6iIbOXNgG6BxbJOzCQ1fNLISVtAtleA/u0MfT3C64EuaJXDbfGBTKaTWwMYQ83VMTCVG
 EKn+V130PU2J4nSMh2w84VoPkbAyVnfZ2oUHLalLooSWw8yGa37ZfM9aQt8onJCjR+w9rZoHe
 eKBtc2PAM1lR2X7J8e3ExGXSwuheciT5Z7fqgmqh4dMi4wf4WNB1YuMeqM1g8/LdAZ0wuQ56/
 kwjPeq3OYXLTd6af0BEngHpuzj4Zyw4+WEjjmignpTPPDEIY3g4hCRcdTtk4/vothH/+H+3H6
 NgQK1oGd0UO4IgqkYSRKi/U8eq2XF96TCze16C/7OX8aRDFdAgFC4HJy5c/LwYJQzaD7bs2gr
 ENJffDPw3oZaBdHQP+1ylNRhFxThy/0JaJUKKPqnkiE1Q5DmHRLKccvmNG6Dnim+g9kYmaslb
 y2vm3reGRDh/zxFg82VqQ41EnwOnityS5kATGP73C8CfhrIa8c2A05W87wUGhuRsx1MbmztZ1
 ku8l9Tz1errpwFz3Uv/4ikHI0Yx6R0AEq5yXQ+P7U98Ceplgd0O+UrCYhWe9TvFXmukg8S7So
 u8eU6R1qG05nCsQySm6gU42JbRbCGfHiqxqikEQh5EfrDQj0AeYZYAxc1fqsIYrt6mdZ2mEOL
 S2WpJq7omw0iPClWzsfA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 6:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Sep 28, 2021 at 5:42 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index fc196421b2ce..12a0bd4b315d 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -431,7 +431,7 @@ config ARCH_PXA
> >
> >  config ARCH_RPC
> >         bool "RiscPC"
> > -       depends on MMU
>
> This line was a botched rebase, it obviously has to stay here.
>
> > +       depends on !CC_IS_CLANG || GCC_VERSION < 90100

This line is also wrong, it needs to be '&&', not '||'.

        Arnd
