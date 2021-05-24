Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7689138E655
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhEXMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:12:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232110AbhEXMMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:12:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 493E931B;
        Mon, 24 May 2021 05:10:44 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.38.161])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1BBA53F719;
        Mon, 24 May 2021 05:10:36 -0700 (PDT)
Date:   Mon, 24 May 2021 13:10:34 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        boqun.feng@gmail.com, peterz@infradead.org, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, bcain@codeaurora.org,
        benh@kernel.crashing.org, chris@zankel.net, dalias@libc.org,
        davem@davemloft.net, deanbo422@gmail.com, deller@gmx.de,
        geert@linux-m68k.org, green.hu@gmail.com, guoren@kernel.org,
        ink@jurassic.park.msu.ru, James.Bottomley@HansenPartnership.com,
        jcmvbkbc@gmail.com, jonas@southpole.se, ley.foon.tan@intel.com,
        linux@armlinux.org.uk, mattst88@gmail.com, monstr@monstr.eu,
        mpe@ellerman.id.au, nickhu@andestech.com, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        tsbogend@alpha.franken.de, vgupta@synopsys.com,
        ysato@users.sourceforge.jp
Subject: Re: [PATCH 28/33] locking/atomic: riscv: move to ARCH_ATOMIC
Message-ID: <20210524121034.GG1040@C02TD0UTHF1T.local>
References: <20210510093753.40683-29-mark.rutland@arm.com>
 <mhng-4414d6c5-89dd-476a-b08c-ce34d0467781@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-4414d6c5-89dd-476a-b08c-ce34d0467781@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 12:02:45PM -0700, Palmer Dabbelt wrote:
> On Mon, 10 May 2021 02:37:48 PDT (-0700), mark.rutland@arm.com wrote:
> > We'd like all architectures to convert to ARCH_ATOMIC, as once all
> > architectures are converted it will be possible to make significant
> > cleanups to the atomics headers, and this will make it much easier to
> > generically enable atomic functionality (e.g. debug logic in the
> > instrumented wrappers).
> > 
> > As a step towards that, this patch migrates riscv to ARCH_ATOMIC. The
> > arch code provides arch_{atomic,atomic64,xchg,cmpxchg}*(), and common
> > code wraps these with optional instrumentation to provide the regular
> > functions.
> > 
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > Cc: Albert Ou <aou@eecs.berkeley.edu>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > Cc: Paul Walmsley <paul.walmsley@sifive.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/riscv/Kconfig               |   1 +
> >  arch/riscv/include/asm/atomic.h  | 128 +++++++++++++++++++--------------------
> >  arch/riscv/include/asm/cmpxchg.h |  34 +++++------
> >  3 files changed, 82 insertions(+), 81 deletions(-)

[...]

> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!

> Sorry this took a bit, I had this put on the slow queue because I thought it
> would conflict with Guo's patch set but from reading the rest of that thread
> it appears this is just supersedes which makes things much simpler.
> 
> I'm assuming this would be for 5.14, and you'd be merging it along with the
> prep work?

Yup; the plan is to take the whole series through the tip tree for
v5.14.

I'll post a v2 soon with some minor fixups.

> I don't think we have anything else in the works that would
> require atomic changes for 5.14 yet so that seems OK for now, but it'd be
> nice to have some shared tag I could pull in both so I can test this and in
> case we have more to put on top of it.  I'm fine waiting until something
> comes up if that's a headache on your end, though.

I think we can arrange a stable tag soon.

The Kbuild test robot is still finding a few edge cases with the
preprocessor glue on a few architectures, so my branch isn't stable yet,
but I think the core bit is solid, so if you wanted to test you should
be able to fetch my branch from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git atomics/arch-atomic

Thanks,
Mark.
