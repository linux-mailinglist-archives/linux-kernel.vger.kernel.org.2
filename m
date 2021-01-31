Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639B0309ED5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 21:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbhAaUZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 15:25:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229596AbhAaTbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:31:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B1DB64E31;
        Sun, 31 Jan 2021 18:54:46 +0000 (UTC)
Date:   Sun, 31 Jan 2021 18:54:44 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc6
Message-ID: <20210131185443.GA29083@gaia>
References: <20210129190322.GA4590@gaia>
 <CAHk-=wh=1K+i6cd-Y_St3ktJAdrqriXf=ct-DcFUR2GkrraLaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=1K+i6cd-Y_St3ktJAdrqriXf=ct-DcFUR2GkrraLaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 02:09:05PM -0800, Linus Torvalds wrote:
> On Fri, Jan 29, 2021 at 11:03 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > arm64 fixes:
> >
> > - Fix the virt_addr_valid() returning true for < PAGE_OFFSET addresses.
> 
> That's a really odd fix.
> 
> It went from an incorrect bitwise operation (masking) to an _odd_
> bitwise operation (xor).
> 
> Yes, PAGE_OFFSET has the bit pattern of all upper bits set, so "(addr
> ^ PAGE_OFFSET)" by definition reverses the upper bits - and for a
> valid case turns them to zero.
> 
> But isn't the *logical* thing to do to use a subtract instead? For the
> valid cases, the two do the same thing (clear the upper bits), but
> just conceptually, isn't the operation that you actually want to do
> "(addr - PAGE_OFFSET)"?
> 
> IOW, why is it using that odd xor pattern that doesn't make much
> sense? I believe it _works_, but it looks very strange to me.

This macro used to test a single bit and it evolved into a bitmask. So,
yes, basically what we need is:

#define __is_lm_address(addr)	((u64)(addr) >= PAGE_OFFSET && \
				 (u64)(addr) < PAGE_END)

I wasn't sure whether the code generation with two comparisons is
similar to the xor variant but the compiler should probably be smart
enough to use CMP and CCMP. In the grand scheme, it probably doesn't
even matter.

Unless I miss something, I don't see any overflow issues even if we do
(((u64)addr - PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET)).

We can backport the fix already upstream and clean-up the code in
mainline going forward (after some sanity check on the code generation).
It would be easier to parse in the future.

> Also, shouldn't _lm_to_phys() do the same? It does that "mask upper
> bits" too that was problematic in __is_lm_address(). Again, shouldn't
> that logically be a subtract op?

Yes, that's similar and a subtract should do.

-- 
Catalin
