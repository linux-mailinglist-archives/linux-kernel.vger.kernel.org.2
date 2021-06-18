Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86733ACC6F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbhFRNlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:41:12 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:46709 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhFRNlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:41:11 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrhDg-1lWzEO3j4W-00nlOQ for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021
 15:39:00 +0200
Received: by mail-wr1-f42.google.com with SMTP id i94so10818619wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 06:39:00 -0700 (PDT)
X-Gm-Message-State: AOAM531rd9QqSX9y0fEkRg7Oe6SRUeTWnPrxbKAYZ3Qmhi1UVTl8MVqj
        IjX52Py+TBuNNN8xpjK03ANOhydIuoOR3FUIqwM=
X-Google-Smtp-Source: ABdhPJxVD5+tW/Jgy58X+CwgUp4mUTAmg464TUvUB8YCvLiMqzZHmfKDoNJ2ZUN/OE5n7UNa4bVSUdvXG8KC+jFlc64=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr12561494wrz.165.1624023540546;
 Fri, 18 Jun 2021 06:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <2142129092ff9aa00e600c42a26c4015b7f5ceec.1623813516.git.luto@kernel.org>
 <YMnPezLs6vb418Wz@hirez.programming.kicks-ass.net> <YMnQVoKvM5G34Yan@hirez.programming.kicks-ass.net>
 <20210616103446.GC22278@shell.armlinux.org.uk> <YMncQv1uT5QyQ84w@hirez.programming.kicks-ass.net>
 <20210616132226.GD22278@shell.armlinux.org.uk> <20210616150456.GC22433@arm.com>
 <20210616152326.GG22278@shell.armlinux.org.uk> <20210616154529.GD22433@arm.com>
 <20210616160050.GE22433@arm.com> <20210616162716.GH22278@shell.armlinux.org.uk>
 <CACRpkdYHoC66K7W6mUMqKfAJkcKeopBnAq8Rq+tLSdLo61jtAQ@mail.gmail.com>
In-Reply-To: <CACRpkdYHoC66K7W6mUMqKfAJkcKeopBnAq8Rq+tLSdLo61jtAQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Jun 2021 15:36:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2P=AzY09OVvHQreLGKjQkN9Z=GM4OrO77zWhh7dF1bMw@mail.gmail.com>
Message-ID: <CAK8P3a2P=AzY09OVvHQreLGKjQkN9Z=GM4OrO77zWhh7dF1bMw@mail.gmail.com>
Subject: Re: [PATCH 7/8] membarrier: Remove arm (32) support for SYNC_CORE
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Russell King (Oracle)" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Daniel Golle <daniel@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:IRqfIhNTch6ZRjsAdF7kJImwIx+3BApZ8XNCItn3xu+auGYPC6w
 xKlysM/Lvr05Hd2yC+oDTYBQYnlYjcErEAuZd8BqqUy1FHBUCFXDMqCqVjBP5o4iVcER+t4
 3EFDNitI5vA2XjcksXbq5wtK8B+RCvYE7GkfieNPawOUBoFdAzOwgd0iPwl8QrFeRzHt6AE
 x9fAyPJ8NVqojUVihV1uA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EPAqwZ4LlE8=:L3zQEKuKQArW2JtYO/wxa3
 wbC4qrpxkEyJ6D0dFjHFCNaD809EhO+MXCzzOQfb5n6vgClnq99tLwxFQqcX7Fg/9znVoQyyQ
 Z948Rg+xirm3635UblXKgS4faulN+rhksdJ6gG5+z8SbxLSvjlSC6vXIM5tx4XgIA7JcTAlPt
 pRpJUVTchiLQejatexREDfIvWBUWoHc3WheEPFigS4zEZFg7BflBda8UQ7L7SoSft+4ijqEz6
 +2bejJOSsvQaaLCV7xgNu/w1gjIfqvC6en8ZgCtnRbhx+XrghotvrcYlxNsUGMdHq2YQu/ICX
 hucPagYgyd5pyZC+WpW9d73XJFlVxZyK/h+Xrsxa+Z4TnBUbcNpj6W1wWXArlxBB55SzszcCP
 eVHxiC8P+z9TTpKHlz9LUHL0hX8VTsg23pqkgQyeu5xufQNTf7XcLCwm6WQeD+IMa6fGn79Ii
 Yuh3OGHs3fEopdeqUbOAMo6BFvXwwok+WpFljzepsVY7Vve6U4R0llvDCYuG8FoGgTrn7MnSV
 x1FmrRjwsrYdR377XXF3yhddbT4MvqwhsOawaep3yzp6zY2s4CZptYmdqn6gNTECEENEVx07a
 lI8E+MkT1IkMVnKc5aeLa4YJBzx1tkLGOppWH+yMQ0OI6vYCmVCTlYfD3c3ZNTIYjdhFkDpGm
 TuD8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 2:54 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Jun 16, 2021 at 6:27 PM Russell King (Oracle) <linux@armlinux.org.uk> wrote:

> > So it seems to come down to a question about CNS3xxx and OXNAS. If
> > these aren't being used, maybe we can drop ARM11MPCore support and
> > the associated platforms?
> >
> > Linus, Krzysztof, Neil, any input?
>
> I don't especially need to keep the ARM11MPCore machine alive,
> it is just a testchip after all. The Oxnas is another story, that has wide
> deployment and was contributed recently (2016) and has excellent
> support in OpenWrt so I wouldn't really want to axe that.

Agreed, as long as oxnas and/or cns3xxx are around, we should just keep
the realview 11mpcore support, but if both of the commercial platforms
are gone, then the realview can be retired as far as I'm concerned.

Regarding oxnas, I see that OpenWRT has a number of essential
device drivers (sata, pcie, usb and reset) that look like they could just
be merged upstream, but that effort appears to have stalled: no
device support was added to the dts files since the original 2016
merge. While the support in OpenWRT may be excellent, the platform
support in the mainline kernel is limited to ethernet, nand, uart
and gpio.

       Arnd
