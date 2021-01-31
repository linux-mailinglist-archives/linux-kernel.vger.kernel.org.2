Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34100309F63
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 00:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhAaXKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 18:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhAaXIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 18:08:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27CF964E3D
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 23:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612134484;
        bh=ML3pWEeMMJmeb16X1p/+6mBPgkFQK4NaFqC/8riKPtw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WdOG68mXaJDIsqRTLcV74BNTBwJoJ9ZOKw1ukhHgB3LFm9C+UrxrpaZwUE7GpMG9n
         3JMJKvqU5mMCrAQOQTXTyeZz5ILv0/U6y3mboocgvofPc3+n5WXMwRTGFdoNeSjwOp
         H6yt9Q6CrNVRkqq/PJUrlQxv/V+s7KyZy86soiZFsoghVtt8Yas/DV7AHZI2OVCJ2g
         KsclbcLDLcCSrUO0LSde+dUJ+yaT008fjdAeUin5kN+K/iJlgMqAcCsnMlQmSfVU8N
         edWP9ZzNy7Z5IcuLM3TUivxoxcvkEDIHbkWEfvcql+iFZDjU/5NGpfrLCNB0wN6tmM
         DsenuwSY8j1Og==
Received: by mail-oo1-f52.google.com with SMTP id z36so3807398ooi.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 15:08:04 -0800 (PST)
X-Gm-Message-State: AOAM532GFuZI5kUo+7nXeiOBXqdwu+A4PtUvj7tBRuAeZxRvY+ZnqWLK
        +PylsOrdMzTkupP0+kqXMOrpvvtsPnhaOHxTrg0=
X-Google-Smtp-Source: ABdhPJzKIo+RoOFz1jt6KOjS5O4uIwOWM2x1Px4KxJpMLZ7ekDuu6z/sw9emrjv1JYnEjSV3peFpJYk0hXlMfKwIPls=
X-Received: by 2002:a05:6820:283:: with SMTP id q3mr10094973ood.13.1612134483478;
 Sun, 31 Jan 2021 15:08:03 -0800 (PST)
MIME-Version: 1.0
References: <20210129190322.GA4590@gaia> <CAHk-=wh=1K+i6cd-Y_St3ktJAdrqriXf=ct-DcFUR2GkrraLaA@mail.gmail.com>
 <20210131185443.GA29083@gaia>
In-Reply-To: <20210131185443.GA29083@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 1 Feb 2021 00:07:52 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFCR=UnvKaX2oEF_M7dm3VXr4br6e6VZCee1QN2s_RjXQ@mail.gmail.com>
Message-ID: <CAMj1kXFCR=UnvKaX2oEF_M7dm3VXr4br6e6VZCee1QN2s_RjXQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for 5.11-rc6
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jan 2021 at 19:55, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Fri, Jan 29, 2021 at 02:09:05PM -0800, Linus Torvalds wrote:
> > On Fri, Jan 29, 2021 at 11:03 AM Catalin Marinas
> > <catalin.marinas@arm.com> wrote:
> > >
> > > arm64 fixes:
> > >
> > > - Fix the virt_addr_valid() returning true for < PAGE_OFFSET addresses.
> >
> > That's a really odd fix.
> >
> > It went from an incorrect bitwise operation (masking) to an _odd_
> > bitwise operation (xor).
> >
> > Yes, PAGE_OFFSET has the bit pattern of all upper bits set, so "(addr
> > ^ PAGE_OFFSET)" by definition reverses the upper bits - and for a
> > valid case turns them to zero.
> >
> > But isn't the *logical* thing to do to use a subtract instead? For the
> > valid cases, the two do the same thing (clear the upper bits), but
> > just conceptually, isn't the operation that you actually want to do
> > "(addr - PAGE_OFFSET)"?
> >
> > IOW, why is it using that odd xor pattern that doesn't make much
> > sense? I believe it _works_, but it looks very strange to me.
>
> This macro used to test a single bit and it evolved into a bitmask. So,
> yes, basically what we need is:
>
> #define __is_lm_address(addr)   ((u64)(addr) >= PAGE_OFFSET && \
>                                  (u64)(addr) < PAGE_END)
>
> I wasn't sure whether the code generation with two comparisons is
> similar to the xor variant but the compiler should probably be smart
> enough to use CMP and CCMP. In the grand scheme, it probably doesn't
> even matter.
>
> Unless I miss something, I don't see any overflow issues even if we do
> (((u64)addr - PAGE_OFFSET) < (PAGE_END - PAGE_OFFSET)).
>
> We can backport the fix already upstream and clean-up the code in
> mainline going forward (after some sanity check on the code generation).
> It would be easier to parse in the future.
>
> > Also, shouldn't _lm_to_phys() do the same? It does that "mask upper
> > bits" too that was problematic in __is_lm_address(). Again, shouldn't
> > that logically be a subtract op?
>
> Yes, that's similar and a subtract should do.
>

The original bit test was written like that because it removes the
need to reason about a potential tag in the upper bits. I tried to
preserve that behavior when removing the guaranteed 1:1 split between
the vmalloc and linear regions, by masking with PAGE_OFFSET and
comparing with PAGE_END - PAGE_OFFSET, but unfortunately, both
approaches suffer from the issue fixed by this patch, i.e., that
virt_addr_valid(0x0) erroneously returns true.

I think both proposed fixes are appropriate, but they both reintroduce
the need to consider the tag. I don't know whether or where this could
pose a problem, but it needs to be taken into account.
