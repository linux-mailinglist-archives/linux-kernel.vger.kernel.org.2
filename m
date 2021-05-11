Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9581E37A495
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbhEKK2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:28:38 -0400
Received: from mail-vs1-f50.google.com ([209.85.217.50]:45995 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhEKK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:28:36 -0400
Received: by mail-vs1-f50.google.com with SMTP id x188so4343011vsx.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIkrxbqENVoInkWJDP+jiJxx4wRojWyFG0U09oYNhN8=;
        b=NuVxPPXLHfPFb1M2wmgoaAJ7cAXVbUwmJe9LAS200wtwbhHYE+trTCzO9rQbT3xFUP
         jIftc/Nxm3q1zjxtzaqtuY4mt/Geg7DxXe4VpKqgjyMSP6zIzHT+BN5mvHaxcKmJxZf6
         MfvMndjbtC116PZUAomYGx1l+FyEVmquTl0ax+JR/30pbSgiQnQxLzkoDTX2ZbfdE3xI
         FlLpZpfpjtYlV6tCh1I6yIuAjxJbUmv7aMrW7Njx1L2OJ9X1qPSkJAK1fardr++fEI9E
         JD3pu3WB18P4mGZbOnYEZP9WWHL/rYS9KD5zhkC+cqeUZ4L4MsUdj+1RG3PcjLO0IU6R
         84/g==
X-Gm-Message-State: AOAM531R0a55Xknzzbpgyi4LWCMqQZLSFtP57N/A4DwHhBuChJeZ4S/z
        946hjjd7N5yEVMpqz4k5cRo2Yvw+LUvq0V5bHXg=
X-Google-Smtp-Source: ABdhPJwc+AOEQ8HwzUtQMWq36N66YaELie0ykqVUELPA2a1eR9TyG5GqCTuhkycnNJ5UGTc7OTKiBKcNbOcUrsZoaNw=
X-Received: by 2002:a67:8745:: with SMTP id j66mr25322124vsd.18.1620728849817;
 Tue, 11 May 2021 03:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210510093753.40683-1-mark.rutland@arm.com> <20210510093753.40683-21-mark.rutland@arm.com>
 <CAMuHMdVFOvyQYBn45QSb-jHA3G5Guv0hRb-LO1n8L_gWzcZm8w@mail.gmail.com> <20210511100022.GD6152@C02TD0UTHF1T.local>
In-Reply-To: <20210511100022.GD6152@C02TD0UTHF1T.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 11 May 2021 12:27:18 +0200
Message-ID: <CAMuHMdV5LpRbDcbmQHP4gzXv6JiLzKNP8dAiMOa0GsfE5KgJzA@mail.gmail.com>
Subject: Re: [PATCH 20/33] locking/atomic: m68k: move to ARCH_ATOMIC
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

CC Greg

On Tue, May 11, 2021 at 12:00 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Tue, May 11, 2021 at 11:27:45AM +0200, Geert Uytterhoeven wrote:
> > On Mon, May 10, 2021 at 11:42 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > We'd like all architectures to convert to ARCH_ATOMIC, as once all
> > > architectures are converted it will be possible to make significant
> > > cleanups to the atomics headers, and this will make it much easier to
> > > generically enable atomic functionality (e.g. debug logic in the
> > > instrumented wrappers).
> > >
> > > As a step towards that, this patch migrates m68k to ARCH_ATOMIC. The
> > > arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> > > code wraps these with optional instrumentation to provide the regular
> > > functions.
> > >
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >
> > I even gave this series a spin on ARAnyM and QEMU, and everything
> > seems to be fine.
>
> Thanks! That's much appreciated; I was able to build-test, but didn't
> have a suitable setup for boot testing.
>
> The Kbuild test robot noticed I broke one configuration by renaming
> atomic_dec_and_test_lt(), since it's not part of the common atomic API,
> and is used in get_mmu_context() in <asm/mmu_context.h>.

Ah, that's in the part for Coldfire, so I (and my builds) didn't notice.

> On the primciple of keeping the common atomic API separate from
> arch-specific bits, I've kept the `arch_` prefix and updated the caller.
> Does that sound good to you?

That's fine for me, but as this is Coldfire, I'd like to defer to Greg.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
