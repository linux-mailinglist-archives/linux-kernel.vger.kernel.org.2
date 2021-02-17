Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5BA31DC91
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbhBQPlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:41:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:60957 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233787AbhBQPlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:41:08 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 11HFb5XE011443;
        Wed, 17 Feb 2021 09:37:05 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 11HFb4fK011440;
        Wed, 17 Feb 2021 09:37:04 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 17 Feb 2021 09:37:04 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Feng Tang <feng.tang@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: {standard input}:577: Error: unsupported relocation against base
Message-ID: <20210217153704.GM28121@gate.crashing.org>
References: <202101051834.FGH835Vs-lkp@intel.com> <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu> <20210205100821.GA71063@shbuild999.sh.intel.com> <87lfbouzgd.fsf@mpe.ellerman.id.au> <20210216220619.GL28121@gate.crashing.org> <87a6s3uu3y.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6s3uu3y.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Feb 17, 2021 at 04:43:45PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Tue, Feb 16, 2021 at 08:36:02PM +1100, Michael Ellerman wrote:
> >> Feng Tang <feng.tang@intel.com> writes:
> >> >   {standard input}:577: Error: unsupported relocation against base
> >> >   {standard input}:580: Error: unsupported relocation against base
> >> >   {standard input}:583: Error: unsupported relocation against base
> >
> >> > The reason is macro 'mfdcr' requirs an instant number as parameter,
> >> > which is not met by show_plbopb_regs().
> >> 
> >> It doesn't require a constant, it checks if the argument is constant:
> >> 
> >> #define mfdcr(rn)						\
> >> 	({unsigned int rval;					\
> >> 	if (__builtin_constant_p(rn) && rn < 1024)		\
> >> 		asm volatile("mfdcr %0," __stringify(rn)	\
> >> 		              : "=r" (rval));			\
> >> 	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
> >> 		rval = mfdcrx(rn);				\
> >> 	else							\
> >> 		rval = __mfdcr(rn);				\
> >> 	rval;})
> >
> > It requires a constant number with known (at compile time) value, while
> > __builtin_constant_p checks for any constant.  The address of some
> > defined symbol is a constant as well normally, for example.
> >
> > It's better to write that asm as
> > 	asm volatile("mfdcr %0,%1" : "=r" (rval) : "n"(rn));
> > btw (the "n" constraint means "constant integer with known value" (it
> > stands for "numeric"), while the "i" constraint means just "constant
> > integer").
> 
> Actually that fixes it.

Huh interesting.  I was going to suggest to use __is_constexpr instead,
but that should return true for slightly fewer expressions (but probably
still okay in this case).

> diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
> index 7141ccea8c94..d143308b0f95 100644
> --- a/arch/powerpc/include/asm/dcr-native.h
> +++ b/arch/powerpc/include/asm/dcr-native.h
> @@ -53,8 +53,8 @@ static inline void mtdcrx(unsigned int reg, unsigned int val)
>  #define mfdcr(rn)                                              \
>         ({unsigned int rval;                                    \
>         if (__builtin_constant_p(rn) && rn < 1024)              \
> -               asm volatile("mfdcr %0," __stringify(rn)        \
> -                             : "=r" (rval));                   \
> +               asm volatile("mfdcr %0, %1" : "=r" (rval)       \
> +                            : "n" (rn));                       \
>         else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))  \
>                 rval = mfdcrx(rn);                              \
>         else                                                    \
> 
> 
> I guess because we give the compiler time to work out the constant,
> rather than stringifying it immediately.

Yeah, this is not preprocessor magic, the compiler actually does its
thing here.  It still won't work if the compiler cannot reduce the
expression to a number (but it does see it is constant), but that is the
best you can do here probably.


Segher
