Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF883EEC40
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 14:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbhHQMOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 08:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbhHQMOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 08:14:48 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6B1C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:14:15 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k8so9310887wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 05:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ix6jNCDi/nRG6HwuIPNkhPwWUXVhcH/J6lfAEhtZJ30=;
        b=k7jDQ3lYwh5gRgesXbULLe2Lee+ryIsRGqtui+o172BzP0k0ajqgLPIogS7Se1iYEk
         3NqZzYMOfkcJK/YNWqzKQXQir7ff7DkUFYQkPdn1WIrS0v+Ix0dWJtE8YKGLqiiAr5CG
         XQsfpsN/boyQQlemHGRisR6jaaG9xYkdTlL+BpAz+6C66fqRg+hr5uxk3BTl7vtJI64O
         ySinXJkOPwyrCu3xnoonQ/KbTnO7NttEibR4W3ptYysPgwpOugRx6c7bJ5xWNljYFYR8
         j/lvNadDlMtVDrMgXAiFD1k/x2uXea9oxKDCesvbTtA0dipj9dyQnAmGETKKFO6aGndN
         oQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ix6jNCDi/nRG6HwuIPNkhPwWUXVhcH/J6lfAEhtZJ30=;
        b=KHWJRwUM71JaRwKqDZ+BRZNFr5bhUg24WwJPyljXl+cLFhFEjQz40GuG0JZ3IM3Uo1
         TtdaBfl72xjfhYeeijh0fhnoSs6N3aQB0lrsKxa/AujdupbCLxJwzjg+QaORJffS63Kj
         uMp09eT+nYeH4Bd4zgceaz6OKvsUtVJiUNUzZqMdOac5mOQMsVQMoXVrzi8jkYyfp4hm
         x5HU5VEWZP7CL2t8YkfbHFaxkMzSn/804AkxTUXvIv6eIeMu8wALZtQXkOTalMtarUr6
         NgRX/V2lsNhM+3DtkBHDE4bdVRiF9hLKo4g5aWvkH3DH23k1k/FOrH6P0T4MPJ9O9yIS
         23Lw==
X-Gm-Message-State: AOAM531PdpFjPqezIE54HE+GAXLcMkOJt+ECcTxEK8WcoCabmC4YDlC9
        tF5aKnKr8JPC9a2mofQOQVOlww==
X-Google-Smtp-Source: ABdhPJyPhYtxa6i2ZoiZ2i3Jle7sNsGS/ALFbF6EXN4Ntl5ChGDzionaQZMSOKNOEm4TqVjVgjAQMg==
X-Received: by 2002:adf:e94c:: with SMTP id m12mr3744998wrn.235.1629202453271;
        Tue, 17 Aug 2021 05:14:13 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:b13d:94d3:30db:869e])
        by smtp.gmail.com with ESMTPSA id p8sm1868998wme.22.2021.08.17.05.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 05:14:12 -0700 (PDT)
Date:   Tue, 17 Aug 2021 14:14:06 +0200
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: LKMM: Read dependencies of writes ordered by dma_wmb()?
Message-ID: <YRuoDhY6gXnx/XEW@elver.google.com>
References: <YRo58c+JGOvec7tc@elver.google.com>
 <20210816145945.GB121345@rowland.harvard.edu>
 <YRqfJz/lpUaZpxq7@elver.google.com>
 <20210816192109.GC121345@rowland.harvard.edu>
 <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816205057.GN4126399@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 01:50PM -0700, Paul E. McKenney wrote:
> On Mon, Aug 16, 2021 at 03:21:09PM -0400, Alan Stern wrote:
[...]
> > Access ordering of devices is difficult to describe.  How do you tell a 
> > memory model (either a theoretical one or one embedded in code like 
> > KCSAN) that a particular interrupt handler routine can't be called until 
> > after a particular write has enabled the device to generate an IRQ?
> > 
> > In the case you mention, how do you tell the memory model that the code 
> > on CPU 1 can't run until after CPU 0 has executed a particular write, one 
> > which is forced by some memory barrier to occur _after_ all the potential 
> > overwrites its worried about?
> 
> What Alan said on the difficulty!
> 
> However, KCSAN has the advantage of not needing to specify the outcomes,
> which is much of the complexity.  For LKMM to do a good job of handling
> devices, we would need a model of each device(!).

For full models, like the formal LKMM, I agree it's extremely difficult!

KCSAN has the advantage that it's a "dynamic analysis" tool, relying on
merely instrumenting real code and running on the real HW. The real HW
is still in charge of generating interrupts, and real devices (like that
E1000 device, though in this case virtualized by QEMU) aren't in any way
abstracted or modeled.

KCSAN's (and any other sanitizer's) primary goals is to just _detect_
certain classes of bugs by making these detectable via instrumentation
but otherwise run real code and HW.

Thus far, for KCSAN this has been trivial because all it does is keep an
eye on reads and writes, and observes if accesses race; and then, per
rules for data races (it needs to know about plain and marked accesses),
it decides if something is a reportable data race.

The real HW is entirely in charge of when and if something executes
concurrently.

One problem with instrumentation, however, is that it adds certain
overheads which make some effects of the hardware very unlikely to
observe. For example, the effects of weak memory. Therefore, I'm
teaching KCSAN a limited set of weak memory effects allowed by the LKMM
by pretending the current CPU reordered an access (currently just
"load/store buffering").

To avoid false positives, however, the tool now has to know about memory
barriers, otherwise it might simulate reordering too aggressively.

Because KCSAN relies on compiler instrumentation, we are simply limited
to analyzing what is happening on CPUs, but devices are invisible, and
just observe what happens as a result on other CPUs if a device is
involved.

The case with E1000 and dma_wmb() came about because KCSAN is now able
to detect races between 2 CPUs because dma_wmb() doesn't seem to say
anything about ordering among CPUs.

The main points are:

1. KCSAN doesn't need a model for devices because it's still running on
   real HW with real devices that are in charge of generating interrupts.

2. In the case with the E1000 driver, a real device causes CPU 1 to run
   the interrupt, which does a free to memory that might still be read/written
   to if CPU 0 reordered its accesses (simulated by KCSAN). That reordering
   can be inhibited by the right barrier, but we haven't found it in the
   code yet. At least the dma_wmb() isn't required to order the writes
   between the 2 CPUs (AFAIK).

> > > What would be more useful?
> > > 
> > > 1. Let the architecture decide how they want KCSAN to instrument non-smp
> > >    barriers, given it's underspecified. This means KCSAN would report
> > >    different races on different architectures, but keep the noise down.
> > > 
> > > 2. Assume the weakest possible model, where non-smp barriers just do
> > >    nothing wrt other CPUs.
> > 
> > I don't think either of those would work out very well.  The problem 
> > isn't how you handle the non-smp barriers; the problem is how you 
> > describe to the memory model the way devices behave.
> 
> There are some architecture-independent ordering guarantees for MMIO
> which go something like this:
> 
> 0.	MMIO readX() and writeX() accesses to the same device are
> 	implicitly ordered, whether relaxed or not.
> 
> 1.	Locking partitions non-relaxed MMIO accesses in the manner that
> 	you would expect.  For example, if CPU 0 does an MMIO write,
> 	then releases a lock, and later CPU 1 acquires that same lock and
> 	does an MMIO read, CPU 0's MMIO write is guaranteed to happen
> 	before CPU 1's MMIO read.  PowerPC has to jump through a few
> 	hoops to make this happen.
> 
> 	Relaxed MMIO accesses such as readb_relaxed() can be reordered
> 	with locking primitives on some architectures.
> 
> 2.	smp_*() memory barriers are not guaranteed to affect MMIO
> 	accesses, especially not in kernels built with CONFIG_SMP=n.
> 
> 3.	The mb() memory barrier is required to order prior MMIO
> 	accesses against subsequent MMIO accesses.  The wmb() and rmb()
> 	memory barriers are required to order prior order prior MMIO
> 	write/reads against later MMIO writes/reads, respectively.
> 	These memory barriers also order normal memory accesses in
> 	the same way as their smp_*() counterparts.
> 
> 4.	The mmiowb() memory barrier can be slightly weaker than wmb(),
> 	as it is in ia64, but I have lost track of the details.
> 
> 5.	The dma_mb(), dma_rmb(), and dma_wmb() appear to be specific
> 	to ARMv8.
> 
> 6.	Non-relaxed MMIO writeX() accesses force ordering of prior
> 	normal memory writes before any DMA initiated by the writeX().
> 
> 7.	Non-relaxed MMIO readX() accesses force ordering of later
> 	normal memory reads after any DMA whose completion is reported
> 	by the readX().  These readX() accesses are also ordered before
> 	any subsequent delay loops.
> 
> Some more detail is available in memory-barriers.txt and in this LWN
> article:  https://lwn.net/Articles/698014/
> 
> I wish I could promise you that these are both fully up to date, but
> it is almost certain that updates are needed.

Thanks, that's useful. What I can tell is that most I/O ops and barriers
have no effect on other CPUs (except for mb() etc.). For KCSAN that's
all that matters.

[...]
> > > Which might be an argument to make KCSAN's non-smp barrier
> > > instrumentation arch-dependent, because some drivers might in fact be
> > > written with some target architectures and their properties in mind. At
> > > least it would help keep the noise down, and those architecture that
> > > want to see such races certainly still could.
> > > 
> > > Any preferences?
> > 
> > I'm not a good person to ask; I have never used KCSAN.  However...
> > 
> > While some drivers are indeed written for particular architectures or 
> > systems, I doubt that they rely very heavily on the special properties of 
> > their target architectures/systems to avoid races.  Rather, they rely on 
> > the hardware to behave correctly, just as non-arch-specific drivers do.
> > 
> > Furthermore, the kernel tries pretty hard to factor out arch-specific 
> > synchronization mechanisms and related concepts into general-purpose 
> > abstractions (in the way that smp_mb() is generally available but is 
> > defined differently for different architectures, for example).  Drivers 
> > tend to rely on these abstractions rather than on the arch-specific 
> > properties directly.
> > 
> > In short, trying to make KCSAN's handling of device I/O into something 
> > arch-specific doesn't seem (to me) like a particular advantageous 
> > approach.  Other people are likely to have different opinions.

As explained above, KCSAN just instruments C code but still runs on real
HW with real devices. All I'm trying to figure out is what I/O ops and
barriers say about making accesses visible to other CPUs to avoid false
positives.

However, it seems by this discussing I'm starting to conclude that the
E1000 race might in fact be something allowed, although very unlikely.

The main question I was trying to answer is "should such cases be
reported or not?", since KCSAN's goal is not to model the system
faithfully, but to detect bugs. Either way is possible, and I don't have
a preference. I'm leaning towards "no assumptions, report everything"
now, because the "access reordering" mode won't be enabled by default.

Thanks,
-- Marco
