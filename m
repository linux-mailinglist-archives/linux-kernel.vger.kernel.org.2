Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156AE37A429
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhEKKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:01:41 -0400
Received: from foss.arm.com ([217.140.110.172]:44294 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231392AbhEKKBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:01:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B7BE169C;
        Tue, 11 May 2021 03:00:32 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.91])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 271233F719;
        Tue, 11 May 2021 03:00:25 -0700 (PDT)
Date:   Tue, 11 May 2021 11:00:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH 20/33] locking/atomic: m68k: move to ARCH_ATOMIC
Message-ID: <20210511100022.GD6152@C02TD0UTHF1T.local>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-21-mark.rutland@arm.com>
 <CAMuHMdVFOvyQYBn45QSb-jHA3G5Guv0hRb-LO1n8L_gWzcZm8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVFOvyQYBn45QSb-jHA3G5Guv0hRb-LO1n8L_gWzcZm8w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 11:27:45AM +0200, Geert Uytterhoeven wrote:
> Hi Mark,

Hi Geert,

> On Mon, May 10, 2021 at 11:42 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > We'd like all architectures to convert to ARCH_ATOMIC, as once all
> > architectures are converted it will be possible to make significant
> > cleanups to the atomics headers, and this will make it much easier to
> > generically enable atomic functionality (e.g. debug logic in the
> > instrumented wrappers).
> >
> > As a step towards that, this patch migrates m68k to ARCH_ATOMIC. The
> > arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> > code wraps these with optional instrumentation to provide the regular
> > functions.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> I even gave this series a spin on ARAnyM and QEMU, and everything
> seems to be fine.

Thanks! That's much appreciated; I was able to build-test, but didn't
have a suitable setup for boot testing.

The Kbuild test robot noticed I broke one configuration by renaming 
atomic_dec_and_test_lt(), since it's not part of the common atomic API,
and is used in get_mmu_context() in <asm/mmu_context.h>.

On the primciple of keeping the common atomic API separate from
arch-specific bits, I've kept the `arch_` prefix and updated the caller.
Does that sound good to you?

Thanks,
Mark.
