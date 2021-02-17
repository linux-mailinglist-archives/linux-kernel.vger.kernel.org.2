Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5209831D523
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 06:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBQFoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 00:44:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhBQFoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 00:44:34 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1678C061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 21:43:53 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DgRbQ3QKZz9sSC;
        Wed, 17 Feb 2021 16:43:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1613540629;
        bh=cuTueLS+LkhijlxNPLuAoL98d7mLmmeibblhAo85X+k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aA8wYWmXhfqeStgk5RZlDxrEjZGKD8i3sFU+IxNy0VtdcG9kOqdt2d19IlZSvopC3
         Jv+sGAftN3y6qLMSqOGutGtngFRy2Vn3++pRhQUxzoE8M1PxySd5IoP/iwV6RyNF18
         OeVtWY7CV5cOI8z0umK0i/F9/JZAnZdJPeosklWjcpOArJf2iUIOLhzE2SSsUSYkg2
         4FsLYvned2JdoUzcmVt2LrvPrEUkqFLQloKZZHcUPosv7hvUDHTgayHuG3hCh5R47U
         8tgDPeYGvxC8LDszbhWx9u/qXoVT5wyJTAt60mFiJmKLqrI964TsOmG1IS5QwYi6tT
         YOg2jys92DyxQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        lkp <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: {standard input}:577: Error: unsupported relocation against base
In-Reply-To: <20210216220619.GL28121@gate.crashing.org>
References: <202101051834.FGH835Vs-lkp@intel.com>
 <98587e13-d22f-973f-1e16-f7a811f71016@csgroup.eu>
 <20210205100821.GA71063@shbuild999.sh.intel.com>
 <87lfbouzgd.fsf@mpe.ellerman.id.au>
 <20210216220619.GL28121@gate.crashing.org>
Date:   Wed, 17 Feb 2021 16:43:45 +1100
Message-ID: <87a6s3uu3y.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Tue, Feb 16, 2021 at 08:36:02PM +1100, Michael Ellerman wrote:
>> Feng Tang <feng.tang@intel.com> writes:
>> >   {standard input}:577: Error: unsupported relocation against base
>> >   {standard input}:580: Error: unsupported relocation against base
>> >   {standard input}:583: Error: unsupported relocation against base
>
>> > The reason is macro 'mfdcr' requirs an instant number as parameter,
>> > which is not met by show_plbopb_regs().
>> 
>> It doesn't require a constant, it checks if the argument is constant:
>> 
>> #define mfdcr(rn)						\
>> 	({unsigned int rval;					\
>> 	if (__builtin_constant_p(rn) && rn < 1024)		\
>> 		asm volatile("mfdcr %0," __stringify(rn)	\
>> 		              : "=r" (rval));			\
>> 	else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))	\
>> 		rval = mfdcrx(rn);				\
>> 	else							\
>> 		rval = __mfdcr(rn);				\
>> 	rval;})
>
> It requires a constant number with known (at compile time) value, while
> __builtin_constant_p checks for any constant.  The address of some
> defined symbol is a constant as well normally, for example.
>
> It's better to write that asm as
> 	asm volatile("mfdcr %0,%1" : "=r" (rval) : "n"(rn));
> btw (the "n" constraint means "constant integer with known value" (it
> stands for "numeric"), while the "i" constraint means just "constant
> integer").

Actually that fixes it.

diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index 7141ccea8c94..d143308b0f95 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -53,8 +53,8 @@ static inline void mtdcrx(unsigned int reg, unsigned int val)
 #define mfdcr(rn)                                              \
        ({unsigned int rval;                                    \
        if (__builtin_constant_p(rn) && rn < 1024)              \
-               asm volatile("mfdcr %0," __stringify(rn)        \
-                             : "=r" (rval));                   \
+               asm volatile("mfdcr %0, %1" : "=r" (rval)       \
+                            : "n" (rn));                       \
        else if (likely(cpu_has_feature(CPU_FTR_INDEXED_DCR)))  \
                rval = mfdcrx(rn);                              \
        else                                                    \


I guess because we give the compiler time to work out the constant,
rather than stringifying it immediately.

cheers
