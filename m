Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30EC532DCAA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 23:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbhCDWDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 17:03:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:36144 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241291AbhCDWC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 17:02:58 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 124Lsnob015064;
        Thu, 4 Mar 2021 15:54:49 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 124Lsm4r015063;
        Thu, 4 Mar 2021 15:54:48 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 4 Mar 2021 15:54:48 -0600
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
Message-ID: <20210304215448.GU29191@gate.crashing.org>
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu> <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com> <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu> <YD+o5QkCZN97mH8/@elver.google.com> <20210304145730.GC54534@C02TD0UTHF1T.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304145730.GC54534@C02TD0UTHF1T.local>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Mar 04, 2021 at 02:57:30PM +0000, Mark Rutland wrote:
> It looks like GCC is happy to give us the function-entry-time FP if we use
> __builtin_frame_address(1),

From the GCC manual:
     Calling this function with a nonzero argument can have
     unpredictable effects, including crashing the calling program.  As
     a result, calls that are considered unsafe are diagnosed when the
     '-Wframe-address' option is in effect.  Such calls should only be
     made in debugging situations.

It *does* warn (the warning is in -Wall btw), on both powerpc and
aarch64.  Furthermore, using this builtin causes lousy code (it forces
the use of a frame pointer, which we normally try very hard to optimise
away, for good reason).

And, that warning is not an idle warning.  Non-zero arguments to
__builtin_frame_address can crash the program.  It won't on simpler
functions, but there is no real definition of what a simpler function
*is*.  It is meant for debugging, not for production use (this is also
why no one has bothered to make it faster).

On Power it should work, but on pretty much any other arch it won't.

> Unless we can get some strong guarantees from compiler folk such that we
> can guarantee a specific function acts boundary for unwinding (and
> doesn't itself get split, etc), the only reliable way I can think to
> solve this requires an assembly trampoline. Whatever we do is liable to
> need some invasive rework.

You cannot get such a guarantee, other than not letting the compiler
see into the routine at all, like with assembler code (not inline asm,
real assembler code).

The real way forward is to bite the bullet and to no longer pretend you
can do a full backtrace from just the stack contents.  You cannot.


Segher
