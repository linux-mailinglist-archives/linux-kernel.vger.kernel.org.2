Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5131D27F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 23:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhBPWLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 17:11:32 -0500
Received: from gate.crashing.org ([63.228.1.57]:41763 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230501AbhBPWLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 17:11:20 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 11GM6LUA023081;
        Tue, 16 Feb 2021 16:06:21 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 11GM6Jik023080;
        Tue, 16 Feb 2021 16:06:19 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 16 Feb 2021 16:06:19 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Feng Tang <feng.tang@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: {standard input}:577: Error: unsupported relocation against base
Message-ID: <20210216220619.GL28121@gate.crashing.org>
References: <202101051834.FGH835Vs-lkp@intel.com> <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu> <20210205100821.GA71063@shbuild999.sh.intel.com> <87lfbouzgd.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lfbouzgd.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Feb 16, 2021 at 08:36:02PM +1100, Michael Ellerman wrote:
> Feng Tang <feng.tang@intel.com> writes:
> >   {standard input}:577: Error: unsupported relocation against base
> >   {standard input}:580: Error: unsupported relocation against base
> >   {standard input}:583: Error: unsupported relocation against base

> > The reason is macro 'mfdcr' requirs an instant number as parameter,
> > which is not met by show_plbopb_regs().
> 
> It doesn't require a constant, it checks if the argument is constant:
> 
> #define mfdcr(rn)						\
> 	({unsigned int rval;					\
> 	if (__builtin_constant_p(rn) && rn < 1024)		\
> 		asm volatile("mfdcr %0," __stringify(rn)	\
> 		              : "=r" (rval));			\
> 	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
> 		rval = mfdcrx(rn);				\
> 	else							\
> 		rval = __mfdcr(rn);				\
> 	rval;})

It requires a constant number with known (at compile time) value, while
__builtin_constant_p checks for any constant.  The address of some
defined symbol is a constant as well normally, for example.

It's better to write that asm as
	asm volatile("mfdcr %0,%1" : "=r" (rval) : "n"(rn));
btw (the "n" constraint means "constant integer with known value" (it
stands for "numeric"), while the "i" constraint means just "constant
integer").

> But the error you're seeing implies the compiler is choosing the first
> leg of the if, even when rn == "base + x", which is surprising.
> 
> We've had cases in the past of __builtin_constant_p() returning false
> for things that a human can see are constant at build time, but I've
> never seen the reverse.

And it doesn't here :-)

But, you need some way to figure out an arg is a constant known number
here.  We don't have a builtin for that I think.  Maybe some trick can
be done?  Maybe simply test "rn >= 0" as well, does that work?


Segher
