Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B706A37D4B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 23:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355394AbhELS2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 14:28:15 -0400
Received: from foss.arm.com ([217.140.110.172]:44186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242516AbhELQe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:34:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A5891FB;
        Wed, 12 May 2021 09:33:51 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.72.67])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5D903F719;
        Wed, 12 May 2021 09:33:41 -0700 (PDT)
Date:   Wed, 12 May 2021 17:33:37 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Message-ID: <20210512163337.GB97719@C02TD0UTHF1T.local>
References: <20210510093753.40683-1-mark.rutland@arm.com>
 <20210510093753.40683-21-mark.rutland@arm.com>
 <CAMuHMdVFOvyQYBn45QSb-jHA3G5Guv0hRb-LO1n8L_gWzcZm8w@mail.gmail.com>
 <20210511100022.GD6152@C02TD0UTHF1T.local>
 <CAMuHMdV5LpRbDcbmQHP4gzXv6JiLzKNP8dAiMOa0GsfE5KgJzA@mail.gmail.com>
 <2501f556-1326-f09c-baa2-464057ea100c@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2501f556-1326-f09c-baa2-464057ea100c@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:15:58AM +1000, Greg Ungerer wrote:
> On 11/5/21 8:27 pm, Geert Uytterhoeven wrote:
> > On Tue, May 11, 2021 at 12:00 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Tue, May 11, 2021 at 11:27:45AM +0200, Geert Uytterhoeven wrote:
> > > > On Mon, May 10, 2021 at 11:42 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > > > We'd like all architectures to convert to ARCH_ATOMIC, as once all
> > > > > architectures are converted it will be possible to make significant
> > > > > cleanups to the atomics headers, and this will make it much easier to
> > > > > generically enable atomic functionality (e.g. debug logic in the
> > > > > instrumented wrappers).
> > > > > 
> > > > > As a step towards that, this patch migrates m68k to ARCH_ATOMIC. The
> > > > > arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> > > > > code wraps these with optional instrumentation to provide the regular
> > > > > functions.
> > > > > 
> > > > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > > 
> > > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > > 
> > > > I even gave this series a spin on ARAnyM and QEMU, and everything
> > > > seems to be fine.
> > > 
> > > Thanks! That's much appreciated; I was able to build-test, but didn't
> > > have a suitable setup for boot testing.
> > > 
> > > The Kbuild test robot noticed I broke one configuration by renaming
> > > atomic_dec_and_test_lt(), since it's not part of the common atomic API,
> > > and is used in get_mmu_context() in <asm/mmu_context.h>.
> > 
> > Ah, that's in the part for Coldfire, so I (and my builds) didn't notice.
> > 
> > > On the primciple of keeping the common atomic API separate from
> > > arch-specific bits, I've kept the `arch_` prefix and updated the caller.
> > > Does that sound good to you?
> > 
> > That's fine for me, but as this is Coldfire, I'd like to defer to Greg.
> 
> Looks fine to me too.
> 
> Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Thanks!

Mark.
