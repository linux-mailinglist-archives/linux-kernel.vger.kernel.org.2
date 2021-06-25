Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEE3B41D6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhFYKlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:41:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhFYKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:41:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C745E61443;
        Fri, 25 Jun 2021 10:39:08 +0000 (UTC)
Date:   Fri, 25 Jun 2021 11:39:06 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] arm64: an infinite loop in generic_perform_write()
Message-ID: <20210625103905.GA20835@arm.com>
References: <da9c2fa9-a545-0c48-4490-d6134cc31425@huawei.com>
 <20210623132223.GA96264@C02TD0UTHF1T.local>
 <1c635945-fb25-8871-7b34-f475f75b2caf@huawei.com>
 <YNP6/p/yJzLLr8M8@casper.infradead.org>
 <YNQuZ8ykN7aR+1MP@infradead.org>
 <YNRpYli/5/GWvaTT@casper.infradead.org>
 <27fbb8c1-2a65-738f-6bec-13f450395ab7@arm.com>
 <YNSyZaZtPTmTa5P8@zeniv-ca.linux.org.uk>
 <20210624185554.GC25097@arm.com>
 <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8e87aba-22f7-d039-ceaa-a93591b04b1e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 09:36:54PM +0100, Robin Murphy wrote:
> On 2021-06-24 19:55, Catalin Marinas wrote:
> > On Thu, Jun 24, 2021 at 04:27:17PM +0000, Al Viro wrote:
> > > On Thu, Jun 24, 2021 at 02:22:27PM +0100, Robin Murphy wrote:
> > > > FWIW I think the only way to make the kernel behaviour any more robust here
> > > > would be to make the whole uaccess API more expressive, such that rather
> > > > than simply saying "I only got this far" it could actually differentiate
> > > > between stopping due to a fault which may be recoverable and worth retrying,
> > > > and one which definitely isn't.
> > > 
> > > ... and propagate that "more expressive" information through what, 3 or 4
> > > levels in the call chain?
> > > 
> > >  From include/linux/uaccess.h:
> > > 
> > >   * If raw_copy_{to,from}_user(to, from, size) returns N, size - N bytes starting
> > >   * at to must become equal to the bytes fetched from the corresponding area
> > >   * starting at from.  All data past to + size - N must be left unmodified.
> > >   *
> > >   * If copying succeeds, the return value must be 0.  If some data cannot be
> > >   * fetched, it is permitted to copy less than had been fetched; the only
> > >   * hard requirement is that not storing anything at all (i.e. returning size)
> > >   * should happen only when nothing could be copied.  In other words, you don't
> > >   * have to squeeze as much as possible - it is allowed, but not necessary.
> > > 
> > > arm64 instances violate the aforementioned hard requirement.
> > 
> > After reading the above a few more times, I think I get it. The key
> > sentence is: not storing anything at all should happen only when nothing
> > could be copied. In the MTE case, something can still be copied.
> > 
> > > Please, fix
> > > it there; it's not hard.  All you need is an exception handler in .Ltiny15
> > > that would fall back to (short) byte-by-byte copy if the faulting address
> > > happened to be unaligned.  Or just do one-byte copy, not that it had been
> > > considerably cheaper than a loop.  Will be cheaper than propagating that extra
> > > information up the call chain, let alone paying for extra ->write_begin()
> > > and ->write_end() for single byte in generic_perform_write().
> > 
> > Yeah, it's definitely fixable in the arch code. I misread the above
> > requirements and thought it could be fixed in the core code.
> > 
> > Quick hack, though I think in the actual exception handling path in .S
> > more sense (and it needs the copy_to_user for symmetry):
> 
> Hmm, if anything the asm version might be even more straightforward; I think
> it's pretty much just this (untested):

That's what I thought but it was too late in the day to think in asm.

> diff --git a/arch/arm64/lib/copy_to_user.S b/arch/arm64/lib/copy_to_user.S
> index 043da90f5dd7..632bf1f9540d 100644
> --- a/arch/arm64/lib/copy_to_user.S
> +++ b/arch/arm64/lib/copy_to_user.S
> @@ -62,6 +62,9 @@ EXPORT_SYMBOL(__arch_copy_to_user)
> 
>         .section .fixup,"ax"
>         .align  2
> -9998:  sub     x0, end, dst                    // bytes not copied
> +9998:  ldrb    w7, [x1]
> +USER(9997f,    sttrb   w7, [x0])
> +       add     x0, x0, #1
> +9997:  sub     x0, end, dst                    // bytes not copied
>         ret
>         .previous
> 
> If we can get away without trying to finish the whole copy bytewise, (i.e.
> we don't cause any faults of our own by knowingly over-reading in the
> routine itself), I'm more than happy with that.

I don't think we over-read/write in the routine itself as this is based
on the user memcpy() which can't handle faults. And since we got a fault
before the end of the copy, we have at least one byte left in the
buffer (which may or may not trigger a fault).

I wonder whether we should skip the extra byte copy if something was
copied, i.e. start the exception handler with:

	cmp	dstin, dst
	b.ne	9997f

That said, the fall-back to bytewise copying may have some advantage. I
think we still have the issue where we copy some data to user but report
less (STP failing on the second 8-byte when the first had been already
written first 8). A byte copy loop would solve this, unless we pass the
fault address to the exception handler (I thought you had some patch for
this at some point).

-- 
Catalin
