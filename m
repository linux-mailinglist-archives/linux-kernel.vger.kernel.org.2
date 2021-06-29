Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA273B6EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 09:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhF2Hl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 03:41:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:37749 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhF2HlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 03:41:24 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mspy4-1l4vHc0dbs-00tDGL for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021
 09:38:56 +0200
Received: by mail-wr1-f50.google.com with SMTP id u11so24516354wrw.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 00:38:56 -0700 (PDT)
X-Gm-Message-State: AOAM530B/grLXBSYlhua255jwRZ1d5pdUFDDelnjgHcsAEOD+JR09SrM
        2+PDd97QYxHda88V3cHK1GR3l2BpJ83kTfxYAFU=
X-Google-Smtp-Source: ABdhPJw9pHs7dYczJPgU//N0dx30V5NbNID6LbBuUsUHg4SH8Wz7NtH60Q2sc97coNjPhMc1cJSCiOqqUlBykw4nQDg=
X-Received: by 2002:a5d:5012:: with SMTP id e18mr32760783wrt.286.1624952335774;
 Tue, 29 Jun 2021 00:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210525140232.53872-1-mark.rutland@arm.com> <a15122e9-700d-c909-4794-d569ed1f6c61@infradead.org>
 <20210618084847.GA93984@C02TD0UTHF1T.local> <8a056e32-26bf-3038-984e-fcf8cac988d0@infradead.org>
 <4ec7308f-02c6-a357-eab8-63b6f2b7a5eb@infradead.org> <YNpJnzqg0yySeEE7@hirez.programming.kicks-ass.net>
 <a38e3284-62ee-4894-0475-2668733c5903@infradead.org>
In-Reply-To: <a38e3284-62ee-4894-0475-2668733c5903@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 29 Jun 2021 09:36:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2yH+dSWrS=1E0UbwcRhYJEThgrk2i9=omCQvcMMQZcww@mail.gmail.com>
Message-ID: <CAK8P3a2yH+dSWrS=1E0UbwcRhYJEThgrk2i9=omCQvcMMQZcww@mail.gmail.com>
Subject: Re: [PATCH v2 00/33] locking/atomic: convert all architectures to ARCH_ATOMIC
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
X-Provags-ID: V03:K1:OusdAOhpIuCSTgWlDfBxnWE30OE+d7OHCuiGMbxIUXyAx+OhO+X
 QURiDjQdF8jIGtmIgzMWiwrvCnNLHMVpwCqMTs/pyxoNChnYt/nzfZbGQalz4dWU1rWezWT
 CP1k6jCGF5K6554KCOCT432MkRh+t91lYw/kgFDOVQkxgtfAea/3ZI5n9y7ktQeMZULrQ8X
 GM7/pvGCdNB4PwYE7gSXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iwAbF8R4eNA=:0nWU0f6Nu/er2SUG9PLkr6
 rZ08t/Oy7cWy6o1FQy7G/h6TAH+V3pIzVaTe7s64qU0ePiD/MI3DmCd9mZn2TTiV0wYSem7WV
 lM26yviPQ5xDzd1vKjMkfjuuehnRSjNEOdQpfSeahk7Ay7phUUm8ve2OfMUofE6mnlL8eMosS
 qdhgBtdO2ox/LtQAnvRA/0M2x6M1UwkUlaCziZgwA6d/n/6SwuIfbUCY4Vqv6ndSmU5wULt2p
 pIc8TJX3raD8PBeF50y3tQP97oe6y8AA3O8xcrVTUs7a9sCidUrsi+zwXC5Eh4jPN9FIwiEEL
 OvAKKRMycw8o/B85OldmmFM3SULYWgBywwOM23qfWfbv9yx4OryXZFJMp+/CFy4kUT7oE2b7Z
 J+X8e44Pubv6t6zsaCFx3VsCiNWKmRCxg9/pB+AZgaz3pHiBT8lxsnghs/IHUg2K4+r2xSJWN
 DE4+XhNlq7gWftAJooEkLvxWxi/vr+JNE/fzpBTt2GxyObRXFKkhKnGMFGNrM0AWS0IWeVcxd
 ll0lWb27xS52lZmR0GJ+RufWV2kJ4YgBHPEAPgtW6H0OH8Cjc9Nj2IHeL48VqzJD81RT+nNZg
 f5X3/lajwNxoInlgp3jqZB7TCKzn3e/2x/QXTS6ZaKXChy3XP6zwgyAO47LSMMdrGPsldZfmp
 dCgA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 12:21 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 6/28/21 3:13 PM, Peter Zijlstra wrote:
> > On Mon, Jun 28, 2021 at 02:22:15PM -0700, Randy Dunlap wrote:
> >
> > 0day also reported something like that. We found that this was a
> > pre-existing error, and Mark's patches only changed the error, it never
> > successfully build.
> >
> > cmpxchg64 is an optional feature for 32bit architectures, one that ARMv7
> > does provide, and uses, for it's iommu bits. Building the ARM iommu
> > drivers on ARC seem somewhat daft but is a result of that COMPILE_TEST
> > config.
> >
>
> Yes, I realize it's just a COMPILE_TEST config. Not very interesting IMHO.

Agreed as well. However, there is an interesting question in who gets to decide
which compile-test configurations are relevant and which ones are not.

I'm definitely interested in seeing any compile-time regression on the
architectures
I most care about (arm, arm64, x86) and I can see the same thing making
sense for other architectures that have someone chasing randconfig regressions,
but less so on architectures that fail general randconfig builds already.

For the specific case of cmpxchg64(), I do think it would make sense to either
have a Kconfig symbol that controls the few users, or to provide a spinlock
based fallback for those that don't have a native implementation.

        Arnd
