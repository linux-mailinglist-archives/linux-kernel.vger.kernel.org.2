Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5309E3EDEC9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbhHPUvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:51:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231698AbhHPUv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:51:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D434E604D7;
        Mon, 16 Aug 2021 20:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629147057;
        bh=pyNKY2xB6czevxFIjcnp8bawyrjkXyL440TMckQLyDM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Vx17vyVNrCFihZUUAODRBAfDNkZDZ/PbUnJut28J+0Y/pOc9meElGyRfhvPB1DYV9
         Z6A5WdPk2YkbbOOVXPEhHBmKl3YmLeVbXO0+1uDva9Dzf5zVqnLdj63lskcoUPNwRx
         bkk4dUX8hqv93liR81H3oPBn8rlYuqzJdrY3o5afh6/KDaSl21ExYFySpmeO50s6wg
         n9Db1FtdLBYoviXzUoqEK0JR7lDnPDOjD3HqWtjPloVuaahpu/zg14cqhPEeXSBOzu
         /8oyv+ZLpkwCEZpZ+FlzcwWh1kvASWM66HrBBpCxL/mQ4/eQKFxBFWk5JvkvdicCcz
         iYxlnpOwsMnqA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A602F5C098A; Mon, 16 Aug 2021 13:50:57 -0700 (PDT)
Date:   Mon, 16 Aug 2021 13:50:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com>
 <20210816192109.GC121345@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816192109.GC121345@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 03:21:09PM -0400, Alan Stern wrote:
> On Mon, Aug 16, 2021 at 07:23:51PM +0200, Marco Elver wrote:
> > On Mon, Aug 16, 2021 at 10:59AM -0400, Alan Stern wrote:
> > [...]
> > > > One caveat is the case I'm trying to understand doesn't involve just 2
> > > > CPUs but also a device. And for now, I'm assuming that dma_wmb() is as
> > > > strong as smp_wmb() also wrt other CPUs (but my guess is this
> > > > assumption is already too strong).
> > > 
> > > I'm not sure that is right.  dma_wmb affects the visibility of writes to 
> > > a DMA buffer from the point of view of the device, not necessarily from 
> > > the point of view of other CPUs.  At least, there doesn't seem to be any 
> > > claim in memory-barriers.txt that it does so.
> > 
> > Thanks, I thought so.
> > 
> > While I could just not instrument dma_*mb() at all, because KCSAN
> > obviously can't instrument what devices do, I wonder if the resulting
> > reports are at all interesting.
> > 
> > For example, if I do not make the assumption that dma_wmb==smp_smb, and
> > don't instrument dma_*mb() at all, I also get racy UAF reordered writes:
> > I could imagine some architecture where dma_wmb() propagates the write
> > to devices from CPU 0; but CPU 1 then does the kfree(), reallocates,
> > reuses the data, but then gets its data overwritten by CPU 0.
> 
> Access ordering of devices is difficult to describe.  How do you tell a 
> memory model (either a theoretical one or one embedded in code like 
> KCSAN) that a particular interrupt handler routine can't be called until 
> after a particular write has enabled the device to generate an IRQ?
> 
> In the case you mention, how do you tell the memory model that the code 
> on CPU 1 can't run until after CPU 0 has executed a particular write, one 
> which is forced by some memory barrier to occur _after_ all the potential 
> overwrites its worried about?

What Alan said on the difficulty!

However, KCSAN has the advantage of not needing to specify the outcomes,
which is much of the complexity.  For LKMM to do a good job of handling
devices, we would need a model of each device(!).

> > What would be more useful?
> > 
> > 1. Let the architecture decide how they want KCSAN to instrument non-smp
> >    barriers, given it's underspecified. This means KCSAN would report
> >    different races on different architectures, but keep the noise down.
> > 
> > 2. Assume the weakest possible model, where non-smp barriers just do
> >    nothing wrt other CPUs.
> 
> I don't think either of those would work out very well.  The problem 
> isn't how you handle the non-smp barriers; the problem is how you 
> describe to the memory model the way devices behave.

There are some architecture-independent ordering guarantees for MMIO
which go something like this:

0.	MMIO readX() and writeX() accesses to the same device are
	implicitly ordered, whether relaxed or not.

1.	Locking partitions non-relaxed MMIO accesses in the manner that
	you would expect.  For example, if CPU 0 does an MMIO write,
	then releases a lock, and later CPU 1 acquires that same lock and
	does an MMIO read, CPU 0's MMIO write is guaranteed to happen
	before CPU 1's MMIO read.  PowerPC has to jump through a few
	hoops to make this happen.

	Relaxed MMIO accesses such as readb_relaxed() can be reordered
	with locking primitives on some architectures.

2.	smp_*() memory barriers are not guaranteed to affect MMIO
	accesses, especially not in kernels built with CONFIG_SMP=n.

3.	The mb() memory barrier is required to order prior MMIO
	accesses against subsequent MMIO accesses.  The wmb() and rmb()
	memory barriers are required to order prior order prior MMIO
	write/reads against later MMIO writes/reads, respectively.
	These memory barriers also order normal memory accesses in
	the same way as their smp_*() counterparts.

4.	The mmiowb() memory barrier can be slightly weaker than wmb(),
	as it is in ia64, but I have lost track of the details.

5.	The dma_mb(), dma_rmb(), and dma_wmb() appear to be specific
	to ARMv8.

6.	Non-relaxed MMIO writeX() accesses force ordering of prior
	normal memory writes before any DMA initiated by the writeX().

7.	Non-relaxed MMIO readX() accesses force ordering of later
	normal memory reads after any DMA whose completion is reported
	by the readX().  These readX() accesses are also ordered before
	any subsequent delay loops.

Some more detail is available in memory-barriers.txt and in this LWN
article:  https://lwn.net/Articles/698014/

I wish I could promise you that these are both fully up to date, but
it is almost certain that updates are needed.

> ...
> 
> > > > In practice, my guess is no compiler and architecture combination would
> > > > allow this today; or is there an arch where it could?
> > > 
> > > Probably not; reordering of reads tends to take place over time 
> > > scales a lot shorter than lengthy I/O operations.
> > 
> > Which might be an argument to make KCSAN's non-smp barrier
> > instrumentation arch-dependent, because some drivers might in fact be
> > written with some target architectures and their properties in mind. At
> > least it would help keep the noise down, and those architecture that
> > want to see such races certainly still could.
> > 
> > Any preferences?
> 
> I'm not a good person to ask; I have never used KCSAN.  However...
> 
> While some drivers are indeed written for particular architectures or 
> systems, I doubt that they rely very heavily on the special properties of 
> their target architectures/systems to avoid races.  Rather, they rely on 
> the hardware to behave correctly, just as non-arch-specific drivers do.
> 
> Furthermore, the kernel tries pretty hard to factor out arch-specific 
> synchronization mechanisms and related concepts into general-purpose 
> abstractions (in the way that smp_mb() is generally available but is 
> defined differently for different architectures, for example).  Drivers 
> tend to rely on these abstractions rather than on the arch-specific 
> properties directly.
> 
> In short, trying to make KCSAN's handling of device I/O into something 
> arch-specific doesn't seem (to me) like a particular advantageous 
> approach.  Other people are likely to have different opinions.

No preconceived notions here, at least not on this topic.  ;-)

							Thanx, Paul
