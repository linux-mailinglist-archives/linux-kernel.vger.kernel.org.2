Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA03F02E5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbhHRLkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235504AbhHRLkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:40:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EAF36102A;
        Wed, 18 Aug 2021 11:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629286780;
        bh=64lfdI1AoHvUNIyK9a7f1o6chZWmrkYoJ8rCOK0A0VM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzYhHK2Wd5VhXYsUanQRHSD60fNwEBkDn/AFgKkX8tSV6UY76pVtAef3dLBsi7z1j
         /+duUYXirW/8LiDtzL7tqjgVfaemExTFTLJEkscA7C+UMjA3tojuu9p7/UzQxFrQJb
         5jPKhd8LRzL6sflbFcIUUM4xFI8NMEKB0wWcLMVmRjP44E0bmcTkwuZ2DX558la7NS
         tR2DPIX1HYf5DbWmaTFOPHV3B0M9+oMab+QbIfemCLzTqSFeWa9VHOwUScYtI6KQ4Q
         yqIAku4SYkq1897bvaxdhyGwJtLeO7ie24ORZZilnGIlwz+mLukPmQEfy6bn3Xyzx7
         dTYOz2PHA1i4g==
Date:   Wed, 18 Aug 2021 12:39:36 +0100
From:   Will Deacon <will@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <20210818113935.GA14107@willie-the-truck>
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com>
 <20210816192109.GC121345@rowland.harvard.edu>
 <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210817122816.GA12746@willie-the-truck>
 <20210817135308.GO4126399@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817135308.GO4126399@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Tue, Aug 17, 2021 at 06:53:08AM -0700, Paul E. McKenney wrote:
> On Tue, Aug 17, 2021 at 01:28:16PM +0100, Will Deacon wrote:
> > Just on this bit...
> > 
> > On Mon, Aug 16, 2021 at 01:50:57PM -0700, Paul E. McKenney wrote:
> > > 5.	The dma_mb(), dma_rmb(), and dma_wmb() appear to be specific
> > > 	to ARMv8.
> > 
> > These are useful on other architectures too! IIRC, they were added by x86 in
> > the first place. They're designed to be used with dma_alloc_coherent()
> > allocations where you're sharing something like a ring buffer with a device
> > and they guarantee accesses won't be reordered before they become visible
> > to the device. They _also_ provide the same ordering to other CPUs.
> > 
> > I gave a talk at LPC about some of this, which might help (or might make
> > things worse...):
> > 
> > https://www.youtube.com/watch?v=i6DayghhA8Q
> 
> The slides are here, correct?  Nice summary and examples!
> 
> https://elinux.org/images/a/a8/Uh-oh-Its-IO-Ordering-Will-Deacon-Arm.pdf

Yes, that looks like them. I've also put them up here:

https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/slides/elce-2018.pdf

(turns out it was ELCE not LPC!)

> And this is all I see for dma_mb():
> 
> arch/arm64/include/asm/barrier.h:#define dma_mb()	dmb(osh)
> arch/arm64/include/asm/io.h:#define __iomb()		dma_mb()
> 
> And then for __iomb():
> 
> arch/arm64/include/asm/io.h:#define __iomb()		dma_mb()
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:	__iomb();
> 
> But yes, dma_rmb() and dma_wmb() do look to have a few hundred uses
> between them, and not just within ARMv8.  I gave up too soon, so
> thank you!

No problem, and yes, dma_mb() is an arm64-internal thing which we should
probably rename.

> > Ignore the bits about mmiowb() as we got rid of that.
> 
> Should the leftovers in current mainline be replaced by wmb()?  Or are
> patches to that effect on their way in somewhere?

I already got rid of the non-arch usage of mmiowb(), but I wasn't bravei
enough to change the arch code as it may well be that they're relying on
some specific instruction semantics.

Despite my earlier comment, mmiowb() still exists, but only as a part of
ARCH_HAS_MMIOWB where it is used to add additional spinlock ordering so
that the rest of the kernel doesn't need to use mmiowb() at all.

So I suppose for these:

> arch/mips/kernel/gpio_txx9.c:	mmiowb();
> arch/mips/kernel/gpio_txx9.c:	mmiowb();
> arch/mips/kernel/gpio_txx9.c:	mmiowb();
> arch/mips/kernel/irq_txx9.c:	mmiowb();
> arch/mips/loongson2ef/common/bonito-irq.c:	mmiowb();
> arch/mips/loongson2ef/common/bonito-irq.c:	mmiowb();
> arch/mips/loongson2ef/common/mem.c:		mmiowb();
> arch/mips/loongson2ef/common/pm.c:	mmiowb();
> arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
> arch/mips/pci/ops-bonito64.c:	mmiowb();
> arch/mips/pci/ops-loongson2.c:	mmiowb();
> arch/mips/txx9/generic/irq_tx4939.c:	mmiowb();
> arch/mips/txx9/generic/setup.c:	mmiowb();
> arch/mips/txx9/rbtx4927/irq.c:	mmiowb();
> arch/mips/txx9/rbtx4938/irq.c:	mmiowb();
> arch/mips/txx9/rbtx4938/irq.c:	mmiowb();
> arch/mips/txx9/rbtx4938/setup.c:	mmiowb();
> arch/mips/txx9/rbtx4939/irq.c:	mmiowb();

we could replace mmiowb() with iobarrier_w().

Will
