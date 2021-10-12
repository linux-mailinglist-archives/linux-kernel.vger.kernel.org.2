Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8942342A4B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhJLMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:41:36 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45101 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhJLMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:41:34 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MTikV-1mAonu1vu1-00U6II for <linux-kernel@vger.kernel.org>; Tue, 12 Oct
 2021 14:39:31 +0200
Received: by mail-wr1-f46.google.com with SMTP id u18so66732874wrg.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:39:31 -0700 (PDT)
X-Gm-Message-State: AOAM533HVANlpAHPe4vgmKgZTj1HMMGvTTZVRlU0aDNdx4b1KziGDRsh
        zqw5smkRPwZQZLOX/idTmE/0sN+HneqfUzciQtk=
X-Google-Smtp-Source: ABdhPJycDrwq9fjLRevQV4F9PRVUimkG5w4H6XTXXjDWasGIzvcz5dzzU9Lb1ifEFm7lEgIcQzkIsOoTK7wd5WS9ZDc=
X-Received: by 2002:adf:a3da:: with SMTP id m26mr30755774wrb.336.1634042371064;
 Tue, 12 Oct 2021 05:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-9-nikita.shubin@maquefel.me> <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
 <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
 <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
 <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
 <YWVixgDQtJ8EGbwo@sirena.org.uk> <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
 <YWVmvHsEkPFkrD/R@sirena.org.uk> <7ec1690ea0ca9f6538b8228f78e62b2f38405fd4.camel@gmail.com>
 <YWVvyKq4W4VShiRU@sirena.org.uk> <00781d5212bb4015064d07e762ae0695d16e834e.camel@gmail.com>
 <CAMuHMdUCpfpORD9r28r1hdtdKMPyvXtkYZQsiBCfM8WDcLYKFw@mail.gmail.com>
In-Reply-To: <CAMuHMdUCpfpORD9r28r1hdtdKMPyvXtkYZQsiBCfM8WDcLYKFw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 12 Oct 2021 14:39:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2cvd+od4+UwwrBQ=7F3+cpEAMFz9tBfsZ=nR1Ak1ppwQ@mail.gmail.com>
Message-ID: <CAK8P3a2cvd+od4+UwwrBQ=7F3+cpEAMFz9tBfsZ=nR1Ak1ppwQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
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
        Nikita Shubin <nikita.shubin@maquefel.me>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oYkoYGSrU5UsWg9p053GUIhLF5WJN613Ak1mJiMtpSg1WHcXIw3
 J6yVJ4PTPBIa9iSlWICYdFT0dAxl+fflfc+ZhZdIy1yTbjLaj61R+KKd39ECjio2qJawriv
 cluJelB3vtqbrunq+MDyR43lRYn97fsGt7VrsBMMufGTuAX8RPKvXbE381ODWcUYinphlxh
 oMZuHF0sCgZRCWKLoJLrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:N8hvaeEeIjE=:QkbNzGOWTNlFlmbcw5hiM8
 10wZimC88zSWV+xs+ZEArj9VseOUXJR/hz3Gc9gDq814VzidWsQKqb3rBtkrRtq2UAOjAy/4n
 tc0JTav40YtHO491ZIAHJs24mE6RTmTXQsfWWdnq4XJKpORbpoe6DnbwayttHHUZ6Sol6zZVo
 yAhJ7lau4lZ+CNGRlWcCo7bz9HPCbXJvzZ97OKNx1rC9FN2A9lAqAl2ri6hk97cYMjjoyCObn
 DLrhddqYg2aWttwmiNmxpPpKxfSCqcFrglyb/Pk+AY/HlIrbeJMGtXob0TkrSSnKn0ownzfjZ
 1r6gC6RVDv1WgTxMCQIfheYa8k76coz82o5rZ4Jztqgo+jgu/0IpFyqS8/X1YAU64A5Y0MXpZ
 +1Ze0pg40Vugsi/3mpUilcI5c8l6ejQQePizg/J15lq7ExQTA40SHS7JIuLgsbkEzkdmKDUb+
 07mqEevSKW6rzeZI2Vl90Luqd8iMIQ9aG01pQQOoG+zZJq0kE3H9QUG0miC7FYuWQ9OrLm6UK
 uCzi8y94Es1fPz1rex73/ujPjNXtpc99WLpAFOYvmRlt4CxdSdk9sonOGcXb1NVVMCDnAnOTY
 Q8w9KbEoRdh6RsGADz0u3oK4bvqudNUKrfNjmWIDtEDVx7yomzj9jWuRz/zR1iWaNgDdGP9k/
 sQ/uuL+1ywTeRCMo5uGZQ+UmBu74GnD+6G9HuJtdn0EBl0/hzFjjyy5b2rIt0YGuThM3TOu4n
 LXQB8jcG/nEJnnivIH7lCymjR51F9ymWajuTSA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 1:30 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Oct 12, 2021 at 1:26 PM Alexander Sverdlin <alexander.sverdlin@gmail.com> wrote:
> > On Tue, 2021-10-12 at 12:21 +0100, Mark Brown wrote:
> > >  Looks like Arnd is ready to pick it, and the only dependency which is
> > > > not yet merged into Linus's tree is "ASoC: cirrus: i2s: Prepare clock before using it".
> > >
> > > OK, so I'm still unclear as to what's going on here.  Arnd's mail where
> > > I got copied into this subthread suggested that things were getting
> > > merged by individual trees which is generally easiest?
> >
> > I only wanted to ask you to pick ASoC patch, I can resend it if you'd like.
> > It has no dependencies and all the previous patches were already picked
> > and are visible in the Linus's master.
>
> So it might be better for Arnd to pick up the ASoC patch, too.
> Else he has to postpone the final CCF conversion patch one more cycle,
> to avoid regressions.

Right, if everything else is in mainline, then having the last two patches
in the soc tree gets the job done the quickest.

If any of the other patches are only in linux-next but not in mainline yet,
then it seems best for Mark to take the ASoC/i2s patch for v5.16, and I'll
take the last one for v5.17, or maybe queue it separately from the rest
and send that in the second half of the 5.16 merge window after everything
else has landed.

       Arnd
