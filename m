Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9757537A397
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 11:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhEKJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 05:28:21 -0400
Received: from foss.arm.com ([217.140.110.172]:43660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231302AbhEKJ2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 05:28:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E321F1691;
        Tue, 11 May 2021 02:27:12 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF9563F719;
        Tue, 11 May 2021 02:27:05 -0700 (PDT)
Date:   Tue, 11 May 2021 10:27:01 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <rth@twiddle.net>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 00/33] locking/atomic: convert all architectures to
 ARCH_ATOMIC
Message-ID: <20210511092701.GB6152@C02TD0UTHF1T.local>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <CAK8P3a0pO=Jqbd503Kx-H_S1AzikcPjHT5=40ACZuxSF3dUFNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0pO=Jqbd503Kx-H_S1AzikcPjHT5=40ACZuxSF3dUFNQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 04:56:03PM +0200, Arnd Bergmann wrote:
> On Mon, May 10, 2021 at 11:39 AM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > This series (based on v5.13-rc1) converts all architectures to
> > ARCH_ATOMIC. This will allow the use of instrumented atomics on all
> > architectures (e.g. for KASAN and similar), and simplifies the core
> > atomic code (which should allow for easier rework of the fallbacks and
> > other bits in future).
> >
> > The series is split into three parts:
> >
> > 1) Some preparatory work is done to prepare architectures and common
> >    code for the conversion. In this phase h8300 and microblaze are
> >    converted to use the asm-generic atomics exclusively, and the
> >    asm-generic implementations are made to function with or without
> >    ARCH_ATOMIC.
> >
> > 2) Architectures are converted one-by-one to use the ARCH_ATOMIC
> >    interface. I've converted each architecture with its own patch (even
> >    where the conversion is trivial) to make review and bisection easier.
> >
> > 3) The code handling !ARCH_ATOMIC is removed.
> >
> > Note: I've generated the patches with:
> >
> >   git format-patch -C -M -D
> >
> > ... so the preimage of include/linux/atomic-fallback.h is not included
> > in the diff when it is deleted.
> >
> > The series can also be found in my atomics/arch-atomic branch on
> > kernel.org:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=atomics/arch-atomic
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/arch-atomic
> 
> Nice work!
> 
> I had recently tried experimented with cleanups around cmpxchg(),
> adding fixed-length
> versions of that which can be used to implement the atomics with less bloated
> preprocessor output. My patches will clearly conflict with your
> series, but it seems
> that we should do yours first in any case.

Ah; sorry for stepping on your toes with this. Simplifying the
xchg/cmpxchg glue sounds like a nice cleanup too!

> I'm happy to put this into the asm-generic tree once you have
> collected enough Acks.

Great! Going via asm-generic sounds good to me. The kbuild test robot
has found a few issues, so I'll probably have a v2 with those fixed and
some acks accumulated.

Peter, does that make sense to you, or did you have reasons to want this
to go via tip?

Thanks,
Mark.
