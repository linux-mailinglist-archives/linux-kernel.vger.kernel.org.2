Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8336133455B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhCJRoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:44:54 -0500
Received: from gate.crashing.org ([63.228.1.57]:57622 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233252AbhCJRom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:44:42 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 12AHbCRi007688;
        Wed, 10 Mar 2021 11:37:12 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 12AHbAOa007687;
        Wed, 10 Mar 2021 11:37:10 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 10 Mar 2021 11:37:10 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, broonie@kernel.org,
        Paul Mackerras <paulus@samba.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in save_stack_trace() and friends
Message-ID: <20210310173710.GL29191@gate.crashing.org>
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu> <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com> <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu> <YD+o5QkCZN97mH8/@elver.google.com> <20210304145730.GC54534@C02TD0UTHF1T.local> <20210304215448.GU29191@gate.crashing.org> <20210309160505.GA4979@C02TD0UTHF1T.local> <20210309220532.GI29191@gate.crashing.org> <20210310112441.GA19619@C02TD0UTHF1T.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310112441.GA19619@C02TD0UTHF1T.local>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Mar 10, 2021 at 11:32:20AM +0000, Mark Rutland wrote:
> On Tue, Mar 09, 2021 at 04:05:32PM -0600, Segher Boessenkool wrote:
> > On Tue, Mar 09, 2021 at 04:05:23PM +0000, Mark Rutland wrote:
> > > On Thu, Mar 04, 2021 at 03:54:48PM -0600, Segher Boessenkool wrote:
> > > > On Thu, Mar 04, 2021 at 02:57:30PM +0000, Mark Rutland wrote:
> > > > > It looks like GCC is happy to give us the function-entry-time FP if we use
> > > > > __builtin_frame_address(1),
> > > > 
> > > > From the GCC manual:
> > > >      Calling this function with a nonzero argument can have
> > > >      unpredictable effects, including crashing the calling program.  As
> > > >      a result, calls that are considered unsafe are diagnosed when the
> > > >      '-Wframe-address' option is in effect.  Such calls should only be
> > > >      made in debugging situations.
> > > > 
> > > > It *does* warn (the warning is in -Wall btw), on both powerpc and
> > > > aarch64.  Furthermore, using this builtin causes lousy code (it forces
> > > > the use of a frame pointer, which we normally try very hard to optimise
> > > > away, for good reason).
> > > > 
> > > > And, that warning is not an idle warning.  Non-zero arguments to
> > > > __builtin_frame_address can crash the program.  It won't on simpler
> > > > functions, but there is no real definition of what a simpler function
> > > > *is*.  It is meant for debugging, not for production use (this is also
> > > > why no one has bothered to make it faster).
> > > >
> > > > On Power it should work, but on pretty much any other arch it won't.
> > > 
> > > I understand this is true generally, and cannot be relied upon in
> > > portable code. However as you hint here for Power, I believe that on
> > > arm64 __builtin_frame_address(1) shouldn't crash the program due to the
> > > way frame records work on arm64, but I'll go check with some local
> > > compiler folk. I agree that __builtin_frame_address(2) and beyond
> > > certainly can, e.g.  by NULL dereference and similar.
> > 
> > I still do not know the aarch64 ABI well enough.  If only I had time!
> > 
> > > For context, why do you think this would work on power specifically? I
> > > wonder if our rationale is similar.
> > 
> > On most 64-bit Power ABIs all stack frames are connected together as a
> > linked list (which is updated atomically, importantly).  This makes it
> > possible to always find all previous stack frames.
> 
> We have something similar on arm64, where the kernel depends on being
> built with a frame pointer following the AAPCS frame pointer rules.

The huge difference is on Power this is about the stack itself: you do
not need a frame pointer at all for it (there is no specific register
named as frame pointer, even).

> Every stack frame contains a "frame record" *somewhere* within that
> stack frame, and the frame records are chained together as a linked
> list. The frame pointer points at the most recent frame record (and this
> is what __builtin_frame_address(0) returns).

> > See gcc.gnu.org/PR60109 for example.
> 
> Sure; I see that being true generally (and Ramana noted that on 32-bit
> arm a frame pointer wasn't mandated), but I think in this case we have a
> stronger target (and configuration) specific guarantee.

It sounds like it, yes.  You need to have a frame pointer in the ABI,
with pretty strong rules, and have everything follow those rules.

> > Is the frame pointer required?!
> 
> The arm64 Linux port mandates frame pointers for kernel code. It is
> generally possible to build code without frame pointers (e.g. userspace),
> but doing that for kernel code would be a bug.

I see.  And it even is less expensive to do this than on most machines,
because of register pair load/store instructions :-)

> > > > The real way forward is to bite the bullet and to no longer pretend you
> > > > can do a full backtrace from just the stack contents.  You cannot.
> > > 
> > > I think what you mean here is that there's no reliable way to handle the
> > > current/leaf function, right? If so I do agree.
> > 
> > No, I meant what I said.
> > 
> > There is the separate issue that you do not know where the return
> > address (etc.) is stored in a function that has not yet done a call
> > itself, sure.  You cannot assume anything the ABI does not tell you you
> > can depend on.
> 
> This is in the frame record per the AAPCS.

But you do not know where in the function it will store that.  It often
can be optimised by the compiler to only store the LR and FP on paths
where a call will happen later, and there is no way (without DWARF info
or similar) to know whether that has happened yet or not.

This is a well-known problem of course.  For the current function you
cannot know in general if there is an activation frame yet or not.


Segher
