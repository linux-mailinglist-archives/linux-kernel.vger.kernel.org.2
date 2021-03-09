Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0C2332B70
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 17:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhCIQGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 11:06:00 -0500
Received: from foss.arm.com ([217.140.110.172]:55774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhCIQFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:05:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DFF21042;
        Tue,  9 Mar 2021 08:05:35 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.49.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 032A13F71B;
        Tue,  9 Mar 2021 08:05:32 -0800 (PST)
Date:   Tue, 9 Mar 2021 16:05:23 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, broonie@kernel.org,
        Paul Mackerras <paulus@samba.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in
 save_stack_trace() and friends
Message-ID: <20210309160505.GA4979@C02TD0UTHF1T.local>
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu>
 <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com>
 <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu>
 <YD+o5QkCZN97mH8/@elver.google.com>
 <20210304145730.GC54534@C02TD0UTHF1T.local>
 <20210304215448.GU29191@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304215448.GU29191@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 03:54:48PM -0600, Segher Boessenkool wrote:
> Hi!

Hi Segher,

> On Thu, Mar 04, 2021 at 02:57:30PM +0000, Mark Rutland wrote:
> > It looks like GCC is happy to give us the function-entry-time FP if we use
> > __builtin_frame_address(1),
> 
> From the GCC manual:
>      Calling this function with a nonzero argument can have
>      unpredictable effects, including crashing the calling program.  As
>      a result, calls that are considered unsafe are diagnosed when the
>      '-Wframe-address' option is in effect.  Such calls should only be
>      made in debugging situations.
> 
> It *does* warn (the warning is in -Wall btw), on both powerpc and
> aarch64.  Furthermore, using this builtin causes lousy code (it forces
> the use of a frame pointer, which we normally try very hard to optimise
> away, for good reason).
> 
> And, that warning is not an idle warning.  Non-zero arguments to
> __builtin_frame_address can crash the program.  It won't on simpler
> functions, but there is no real definition of what a simpler function
> *is*.  It is meant for debugging, not for production use (this is also
> why no one has bothered to make it faster).
>
> On Power it should work, but on pretty much any other arch it won't.

I understand this is true generally, and cannot be relied upon in
portable code. However as you hint here for Power, I believe that on
arm64 __builtin_frame_address(1) shouldn't crash the program due to the
way frame records work on arm64, but I'll go check with some local
compiler folk. I agree that __builtin_frame_address(2) and beyond
certainly can, e.g.  by NULL dereference and similar.

For context, why do you think this would work on power specifically? I
wonder if our rationale is similar.

Are you aware of anything in particular that breaks using
__builtin_frame_address(1) in non-portable code, or is this just a
general sentiment of this not being a supported use-case?

> > Unless we can get some strong guarantees from compiler folk such that we
> > can guarantee a specific function acts boundary for unwinding (and
> > doesn't itself get split, etc), the only reliable way I can think to
> > solve this requires an assembly trampoline. Whatever we do is liable to
> > need some invasive rework.
> 
> You cannot get such a guarantee, other than not letting the compiler
> see into the routine at all, like with assembler code (not inline asm,
> real assembler code).

If we cannot reliably ensure this then I'm happy to go write an assembly
trampoline to snapshot the state at a function call boundary (where our
procedure call standard mandates the state of the LR, FP, and frame
records pointed to by the FP). This'll require reworking a reasonable
amount of code cross-architecture, so I'll need to get some more
concrete justification (e.g. examples of things that can go wrong in
practice).

> The real way forward is to bite the bullet and to no longer pretend you
> can do a full backtrace from just the stack contents.  You cannot.

I think what you mean here is that there's no reliable way to handle the
current/leaf function, right? If so I do agree.

Beyond that I believe that arm64's frame records should be sufficient.

Thanks,
Mark.
