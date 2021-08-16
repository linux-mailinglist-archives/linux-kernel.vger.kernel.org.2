Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF253EDDCC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 21:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhHPTVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 15:21:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43469 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S229748AbhHPTVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 15:21:42 -0400
Received: (qmail 131180 invoked by uid 1000); 16 Aug 2021 15:21:09 -0400
Date:   Mon, 16 Aug 2021 15:21:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <20210816192109.GC121345@rowland.harvard.edu>
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRqfJz/lpUaZpxq7@elver.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 07:23:51PM +0200, Marco Elver wrote:
> On Mon, Aug 16, 2021 at 10:59AM -0400, Alan Stern wrote:
> [...]
> > > One caveat is the case I'm trying to understand doesn't involve just 2
> > > CPUs but also a device. And for now, I'm assuming that dma_wmb() is as
> > > strong as smp_wmb() also wrt other CPUs (but my guess is this
> > > assumption is already too strong).
> > 
> > I'm not sure that is right.  dma_wmb affects the visibility of writes to 
> > a DMA buffer from the point of view of the device, not necessarily from 
> > the point of view of other CPUs.  At least, there doesn't seem to be any 
> > claim in memory-barriers.txt that it does so.
> 
> Thanks, I thought so.
> 
> While I could just not instrument dma_*mb() at all, because KCSAN
> obviously can't instrument what devices do, I wonder if the resulting
> reports are at all interesting.
> 
> For example, if I do not make the assumption that dma_wmb==smp_smb, and
> don't instrument dma_*mb() at all, I also get racy UAF reordered writes:
> I could imagine some architecture where dma_wmb() propagates the write
> to devices from CPU 0; but CPU 1 then does the kfree(), reallocates,
> reuses the data, but then gets its data overwritten by CPU 0.

Access ordering of devices is difficult to describe.  How do you tell a 
memory model (either a theoretical one or one embedded in code like 
KCSAN) that a particular interrupt handler routine can't be called until 
after a particular write has enabled the device to generate an IRQ?

In the case you mention, how do you tell the memory model that the code 
on CPU 1 can't run until after CPU 0 has executed a particular write, one 
which is forced by some memory barrier to occur _after_ all the potential 
overwrites its worried about?

> What would be more useful?
> 
> 1. Let the architecture decide how they want KCSAN to instrument non-smp
>    barriers, given it's underspecified. This means KCSAN would report
>    different races on different architectures, but keep the noise down.
> 
> 2. Assume the weakest possible model, where non-smp barriers just do
>    nothing wrt other CPUs.

I don't think either of those would work out very well.  The problem 
isn't how you handle the non-smp barriers; the problem is how you 
describe to the memory model the way devices behave.

...

> > > In practice, my guess is no compiler and architecture combination would
> > > allow this today; or is there an arch where it could?
> > 
> > Probably not; reordering of reads tends to take place over time 
> > scales a lot shorter than lengthy I/O operations.
> 
> Which might be an argument to make KCSAN's non-smp barrier
> instrumentation arch-dependent, because some drivers might in fact be
> written with some target architectures and their properties in mind. At
> least it would help keep the noise down, and those architecture that
> want to see such races certainly still could.
> 
> Any preferences?

I'm not a good person to ask; I have never used KCSAN.  However...

While some drivers are indeed written for particular architectures or 
systems, I doubt that they rely very heavily on the special properties of 
their target architectures/systems to avoid races.  Rather, they rely on 
the hardware to behave correctly, just as non-arch-specific drivers do.

Furthermore, the kernel tries pretty hard to factor out arch-specific 
synchronization mechanisms and related concepts into general-purpose 
abstractions (in the way that smp_mb() is generally available but is 
defined differently for different architectures, for example).  Drivers 
tend to rely on these abstractions rather than on the arch-specific 
properties directly.

In short, trying to make KCSAN's handling of device I/O into something 
arch-specific doesn't seem (to me) like a particular advantageous 
approach.  Other people are likely to have different opinions.

Alan
