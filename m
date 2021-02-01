Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E3930A5CC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhBAKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:50:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232392AbhBAKur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:50:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71A2C64DD8;
        Mon,  1 Feb 2021 10:50:05 +0000 (UTC)
Date:   Mon, 1 Feb 2021 10:50:02 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc6
Message-ID: <20210201105001.GA13756@gaia>
References: <20210129190322.GA4590@gaia>
 <CAHk-=wh=1K+i6cd-Y_St3ktJAdrqriXf=ct-DcFUR2GkrraLaA@mail.gmail.com>
 <20210131185443.GA29083@gaia>
 <CAMj1kXFCR=UnvKaX2oEF_M7dm3VXr4br6e6VZCee1QN2s_RjXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFCR=UnvKaX2oEF_M7dm3VXr4br6e6VZCee1QN2s_RjXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 12:07:52AM +0100, Ard Biesheuvel wrote:
> On Sun, 31 Jan 2021 at 19:55, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Fri, Jan 29, 2021 at 02:09:05PM -0800, Linus Torvalds wrote:
> > > On Fri, Jan 29, 2021 at 11:03 AM Catalin Marinas
> > > <catalin.marinas@arm.com> wrote:
> > > >
> > > > arm64 fixes:
> > > >
> > > > - Fix the virt_addr_valid() returning true for < PAGE_OFFSET addresses.
> > >
> > > That's a really odd fix.
> > >
> > > It went from an incorrect bitwise operation (masking) to an _odd_
> > > bitwise operation (xor).
> > >
> > > Yes, PAGE_OFFSET has the bit pattern of all upper bits set, so "(addr
> > > ^ PAGE_OFFSET)" by definition reverses the upper bits - and for a
> > > valid case turns them to zero.
> > >
> > > But isn't the *logical* thing to do to use a subtract instead? For the
> > > valid cases, the two do the same thing (clear the upper bits), but
> > > just conceptually, isn't the operation that you actually want to do
> > > "(addr - PAGE_OFFSET)"?
> > >
> > > IOW, why is it using that odd xor pattern that doesn't make much
> > > sense? I believe it _works_, but it looks very strange to me.
> >
> > This macro used to test a single bit and it evolved into a bitmask. So,
> > yes, basically what we need is:
> >
> > #define __is_lm_address(addr)   ((u64)(addr) >= PAGE_OFFSET && \
> >                                  (u64)(addr) < PAGE_END)
> >
> > I wasn't sure whether the code generation with two comparisons is
> > similar to the xor variant but the compiler should probably be smart
> > enough to use CMP and CCMP. In the grand scheme, it probably doesn't
> > even matter.
> >
> > Unless I miss something, I don't see any overflow issues even if we do
> > (((u64)addr - PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET)).
> >
> > We can backport the fix already upstream and clean-up the code in
> > mainline going forward (after some sanity check on the code generation).
> > It would be easier to parse in the future.
> >
> > > Also, shouldn't _lm_to_phys() do the same? It does that "mask upper
> > > bits" too that was problematic in __is_lm_address(). Again, shouldn't
> > > that logically be a subtract op?
> >
> > Yes, that's similar and a subtract should do.
> 
> The original bit test was written like that because it removes the
> need to reason about a potential tag in the upper bits. I tried to
> preserve that behavior when removing the guaranteed 1:1 split between
> the vmalloc and linear regions, by masking with PAGE_OFFSET and
> comparing with PAGE_END - PAGE_OFFSET, but unfortunately, both
> approaches suffer from the issue fixed by this patch, i.e., that
> virt_addr_valid(0x0) erroneously returns true.
> 
> I think both proposed fixes are appropriate, but they both reintroduce
> the need to consider the tag. I don't know whether or where this could
> pose a problem, but it needs to be taken into account.

I think we get away with this but should be fixed. For example,
virt_addr_valid() call in slab.c depends on DEBUG_SLAB but KASAN (which
generates kernel tagged addresses) depends on !DEBUG_SLAB. Some of the
uaccess hardening like check_object_size() -> check_heap_object() may
be skipped but no error.

Anyway, I'll write a patch to cover tagged kernel addresses as well.
When the linear map was at the top of the address range, we used to
have:

#define _virt_addr_is_linear(kaddr)	\
	(__tag_reset((u64)(kaddr)) >= PAGE_OFFSET)

Afterwards we kept the tagged addresses in mind (well, until the recent
"fix") but lost the check against user addresses with commit
68dd8ef32162 ("arm64: memory: Fix virt_addr_valid() using
__is_lm_address()").

-- 
Catalin
