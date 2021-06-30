Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E9E3B821A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhF3M1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:27:30 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:48861 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbhF3M13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:27:29 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MwQGj-1l71Je22aL-00sJRe for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021
 14:24:59 +0200
Received: by mail-wr1-f43.google.com with SMTP id f14so3029817wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 05:24:59 -0700 (PDT)
X-Gm-Message-State: AOAM533Rq0bjHjqeIxQOo98KvfC95Qugr1nlXU3FeWFiCvr/DU0BBY+A
        oDOEbMz+J3tEc6LTJwDWeDt48OuAWEpRjQCUEvc=
X-Google-Smtp-Source: ABdhPJyvqh3j6mbSU1KmlUuXCp1yqw5wRXTQvgUnEwHAMGx9Ka3OvJMS9eU1Dt3llWzRAQtWzJWWQ6AaURHNtxTqlPY=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr1616263wrn.99.1625055899168;
 Wed, 30 Jun 2021 05:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210525140232.53872-1-mark.rutland@arm.com> <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
 <20210618084847.GA93984@C02TD0UTHF1T.local> <8a056e32-26bf-3038-984e-fcf8cac988d0@infradead.org>
 <4ec7308f-02c6-a357-eab8-63b6f2b7a5eb@infradead.org> <YNpJnzqg0yySeEE7@hirez.programming.kicks-ass.net>
 <a38e3284-62ee-4894-0475-2668733c5903@infradead.org> <CAK8P3a2yH+dSWrS=1E0UbwcRhYJEThgrk2i9=omCQvcMMQZcww@mail.gmail.com>
 <YNwji8yPUfQp/ErQ@hirez.programming.kicks-ass.net>
In-Reply-To: <YNwji8yPUfQp/ErQ@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 30 Jun 2021 14:24:43 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Yi7PDwBnPBRm4ZVX7FzyU_ogi+kN15zXsBg0AorFhHQ@mail.gmail.com>
Message-ID: <CAK8P3a0Yi7PDwBnPBRm4ZVX7FzyU_ogi+kN15zXsBg0AorFhHQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to ARCH_ATOMIC
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Brian Cain <bcain@codeaurora.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Zankel <chris@zankel.net>, Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>, Guo Ren <guoren@kernel.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Matt Turner <mattst88@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:x3f8ffoy30Ku6ZSIoJuL4Zhum2LeiEmWqG0ehIUcWZsM9eI3kME
 nCJsHtKREfDcaOFh46SMNvgi1SsF2iFSbk/lkJBeLem6OBX14Dm1H05kPWeg5IQiaXo5WdF
 Ux3rLsaw2hcenjqn9WQ5vxXPrm7O0cRaLtMCRABcr7G8w54z6FWl4uSkhPdDuMnh+2T5ubS
 5+SOnHG9gxO/WIVbmD+bw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZDiS7ZHrmys=:fdUjE6WUFnz5ta3aC6p3vg
 KSaAT0soQKQaMlo67hUbUfXmyZGghvVhvl5CHuxTAR+aaq+33a5Dn43bbZT3rDJLmOTuY4Qd+
 vTM1j1GLaY7d7Ngbt7eXfbuntkglIcgbojufSoTzW7kyjAgn7Q8vgQOdp6orGTfgNuAyoNxGQ
 420M0jMQkq8OgBoVebhMN0KkqXJeEnN7XTugya5SN16v7XQAnwwj14GdriHEfumNHvXjaM0WV
 KPGh5sOej0BDjhwjENK9lDRgYUnme8U1Y7/2eLcHVPSu11AobVkpdQV6AQavABB5bHQRC99fi
 de/3eUKxWGkL2JsrYKB0FHMm8QhULWtA3LJ79ztSrkjYSQ2grwDc3Jlc6ptlKHUi63bPgaKBw
 X3pWk7rX0tMS7LZBabO9eGx6ZOEHTdi7ouDh66Y8fzdiz1AvVi1qSbUT9shMoo69j8v6UlbRy
 QtQGVWF18SzvCxSWBeGi+RDtHsVRS5tEF4l2TXy3Mg9e7rz2VAlEWjw6+5XkvPYbcwMlFdhvF
 t876YDEdd06lERoKLcgV2RO/lO2QYEgoETlTY9+umFx5Q5gGDCUbTBtJjchxTaBjz2hA2S5I4
 +PvRWAWjC27c9FHwy7szux+FKYgSz1HvrNirphs9Upsvs3WqLrdMXYzOCt686+Sl5eAioy1ZF
 gjxqiknnAIXNZgJPj9HMQVQDdEAbrenFXitmnPC8EwJN12pUD4SHVPDwy/DWC1z7w4LUNvstP
 aqfi4tTjB13jm56fKB9aVjxP8WC7TEgdMPYCKtS5EMUb/M8b0Y34Jx0ITBh6LOovQIo6LDK6t
 iMyCxdbiYuyfTaE+aDfqIzcRirlh7yp12a6cTrWZ07F2kS6OGJpWXFUC3f2/jlcEV6l1NIu4F
 wpEX8oPw7JmiHL7hn29dusFkYdxv/cc6yx+J3HI/7PKkthoe+xU/vBWqg5IsXsTqx4qPDIlIC
 KbVpMcNgySas0edekFNkApahyk8aWXhZ/hUWsAfxJmlMtz3RCQpdU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 9:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 29, 2021 at 09:36:23AM +0200, Arnd Bergmann wrote:
> > For the specific case of cmpxchg64(), I do think it would make sense to either
> > have a Kconfig symbol that controls the few users, or to provide a spinlock
> > based fallback for those that don't have a native implementation.
>
> My preference goes to a Kconfig based solution; I so detest spinlock
> based atomics. I dream of the day we can kill the lot of 'em
> (sparc32-smp, parisc-smp are always the ones that come to mind).

Fair enough.

> This is doubly true for the xchg/cmpxchg/cmpxchg64 family of functions
> that are supposed to work together with READ_ONCE/WRITE_ONCE but don't
> (when 'emulated', we'd need WRITE_ONCE to also be spinlock based in
> that case).

Ah, I had not realized that this specifically was the problem, besides
the spinlock method also being awfully slow. That means the two are
already broken beyond repair, but presumably we no longer care because
there are approximately zero remaining users, right?

> That is, at least for atomic64_*() the whole API is self contained so we
> can (and do) frob atomic64_set() to behave sanely vs atomic64_cmpxchg().

I suppose it isn't possible to completely replace cmpxchg64() and xchg64()
with their atomic64() counterparts? I see there are only a handful of users,
but presumably those are the ones that are not easily changed to atomic64_t.

         Arnd
