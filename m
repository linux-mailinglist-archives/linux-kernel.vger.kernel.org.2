Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C213EEDC3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 15:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbhHQNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 09:53:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231786AbhHQNxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 09:53:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5145660F58;
        Tue, 17 Aug 2021 13:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629208388;
        bh=HkQR3v2tgZqoqXvfcCaaGF1O5WkRs2MFBLBTe+MuExc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RgLq2wmV4YUESnEWz5lx7o1zsVDsCgDWWS4Lozq9znawa7mDcO3K1kVbFLVeKyUPE
         dgO4sVGWa8HXqZhTFglDyfcZ1wvQ7g88IUsEOmFf2VEp45BqkSJT8W7l3FEbnLeR8s
         7POrckDNE0brjbgiVd/xBz5iA1jec0ypCpR7NVf7vUtWEWLUyoGjFkyPm8IuWXkH/y
         yR4OjfgZ49xTZxuPaJVmJNrLvKzV7huFoCqFvK3OPry7CRyIzqKIxhPfh57x73+dVs
         9cS+v0hWNYTIrqY05aC4nJn0ZpjigRS3ZLhJB1D3qQ+p9HJxaTJqCh9HqYUrCPTomA
         1VvYdYRYuuACg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 20EF05C0F2E; Tue, 17 Aug 2021 06:53:08 -0700 (PDT)
Date:   Tue, 17 Aug 2021 06:53:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <20210817135308.GO4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com>
 <20210816192109.GC121345@rowland.harvard.edu>
 <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
 <20210817122816.GA12746@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817122816.GA12746@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 01:28:16PM +0100, Will Deacon wrote:
> Just on this bit...
> 
> On Mon, Aug 16, 2021 at 01:50:57PM -0700, Paul E. McKenney wrote:
> > 5.	The dma_mb(), dma_rmb(), and dma_wmb() appear to be specific
> > 	to ARMv8.
> 
> These are useful on other architectures too! IIRC, they were added by x86 in
> the first place. They're designed to be used with dma_alloc_coherent()
> allocations where you're sharing something like a ring buffer with a device
> and they guarantee accesses won't be reordered before they become visible
> to the device. They _also_ provide the same ordering to other CPUs.
> 
> I gave a talk at LPC about some of this, which might help (or might make
> things worse...):
> 
> https://www.youtube.com/watch?v=i6DayghhA8Q

The slides are here, correct?  Nice summary and examples!

https://elinux.org/images/a/a8/Uh-oh-Its-IO-Ordering-Will-Deacon-Arm.pdf

And this is all I see for dma_mb():

arch/arm64/include/asm/barrier.h:#define dma_mb()	dmb(osh)
arch/arm64/include/asm/io.h:#define __iomb()		dma_mb()

And then for __iomb():

arch/arm64/include/asm/io.h:#define __iomb()		dma_mb()
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:	__iomb();

But yes, dma_rmb() and dma_wmb() do look to have a few hundred uses
between them, and not just within ARMv8.  I gave up too soon, so
thank you!

> Ignore the bits about mmiowb() as we got rid of that.

Should the leftovers in current mainline be replaced by wmb()?  Or are
patches to that effect on their way in somewhere?

$ git grep 'mmiowb()'
arch/ia64/include/asm/mmiowb.h:#define mmiowb()	ia64_mfa()
arch/ia64/include/asm/spinlock.h:	mmiowb();
arch/mips/include/asm/mmiowb.h:#define mmiowb()	iobarrier_w()
arch/mips/include/asm/spinlock.h:	mmiowb();
arch/mips/kernel/gpio_txx9.c:	mmiowb();
arch/mips/kernel/gpio_txx9.c:	mmiowb();
arch/mips/kernel/gpio_txx9.c:	mmiowb();
arch/mips/kernel/irq_txx9.c:	mmiowb();
arch/mips/loongson2ef/common/bonito-irq.c:	mmiowb();
arch/mips/loongson2ef/common/bonito-irq.c:	mmiowb();
arch/mips/loongson2ef/common/mem.c:		mmiowb();
arch/mips/loongson2ef/common/pm.c:	mmiowb();
arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
arch/mips/loongson2ef/lemote-2f/reset.c:	mmiowb();
arch/mips/pci/ops-bonito64.c:	mmiowb();
arch/mips/pci/ops-loongson2.c:	mmiowb();
arch/mips/txx9/generic/irq_tx4939.c:	mmiowb();
arch/mips/txx9/generic/setup.c:	mmiowb();
arch/mips/txx9/rbtx4927/irq.c:	mmiowb();
arch/mips/txx9/rbtx4938/irq.c:	mmiowb();
arch/mips/txx9/rbtx4938/irq.c:	mmiowb();
arch/mips/txx9/rbtx4938/setup.c:	mmiowb();
arch/mips/txx9/rbtx4939/irq.c:	mmiowb();
arch/powerpc/include/asm/mmiowb.h:#define mmiowb()		mb()
arch/riscv/include/asm/mmiowb.h:#define mmiowb()	__asm__ __volatile__ ("fence o,w" : : : "memory");
arch/s390/include/asm/io.h:#define mmiowb()	zpci_barrier()
arch/sh/include/asm/mmiowb.h:#define mmiowb()			wmb()
arch/sh/include/asm/spinlock-llsc.h:	mmiowb();
include/asm-generic/mmiowb.h: * Generic implementation of mmiowb() tracking for spinlocks.
include/asm-generic/mmiowb.h: * 	1. Implement mmiowb() (and arch_mmiowb_state() if you're fancy)
include/asm-generic/mmiowb.h:		mmiowb();

							Thanx, Paul
