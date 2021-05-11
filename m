Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C581837A556
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhEKK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:58:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:55809 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231515AbhEKK6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:58:34 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 14BApu5c031983;
        Tue, 11 May 2021 05:51:56 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 14BAptH1031976;
        Tue, 11 May 2021 05:51:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 11 May 2021 05:51:54 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: Force inlining of csum_add()
Message-ID: <20210511105154.GJ10366@gate.crashing.org>
References: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, May 11, 2021 at 06:08:06AM +0000, Christophe Leroy wrote:
> Commit 328e7e487a46 ("powerpc: force inlining of csum_partial() to
> avoid multiple csum_partial() with GCC10") inlined csum_partial().
> 
> Now that csum_partial() is inlined, GCC outlines csum_add() when
> called by csum_partial().

> c064fb28 <csum_add>:
> c064fb28:	7c 63 20 14 	addc    r3,r3,r4
> c064fb2c:	7c 63 01 94 	addze   r3,r3
> c064fb30:	4e 80 00 20 	blr

Could you build this with -fdump-tree-einline-all and send me the
results?  Or open a GCC PR yourself :-)

Something seems to have decided this asm is more expensive than it is.
That isn't always avoidable -- the compiler cannot look inside asms --
but it seems it could be improved here.

Do you have (or can make) a self-contained testcase?

> The sum with 0 is useless, should have been skipped.

That isn't something the compiler can do anything about (not sure if you
were suggesting that); it has to be done in the user code (and it tries
to already, see below).

> And there is even one completely unused instance of csum_add().

That is strange, that should never happen.

> ./arch/powerpc/include/asm/checksum.h: In function '__ip6_tnl_rcv':
> ./arch/powerpc/include/asm/checksum.h:94:22: warning: inlining failed in call to 'csum_add': call is unlikely and code size would grow [-Winline]
>    94 | static inline __wsum csum_add(__wsum csum, __wsum addend)
>       |                      ^~~~~~~~
> ./arch/powerpc/include/asm/checksum.h:172:31: note: called from here
>   172 |                         sum = csum_add(sum, (__force __wsum)*(const u32 *)buff);
>       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At least we say what happened.  Progress!  :-)

> In the non-inlined version, the first sum with 0 was performed.
> Here it is skipped.

That is because of how __builtin_constant_p works, most likely.  As we
discussed elsewhere it is evaluated before all forms of loop unrolling.

The patch looks perfect of course :-)

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher


> --- a/arch/powerpc/include/asm/checksum.h
> +++ b/arch/powerpc/include/asm/checksum.h
> @@ -91,7 +91,7 @@ static inline __sum16 csum_tcpudp_magic(__be32 saddr, __be32 daddr, __u32 len,
>  }
>  
>  #define HAVE_ARCH_CSUM_ADD
> -static inline __wsum csum_add(__wsum csum, __wsum addend)
> +static __always_inline __wsum csum_add(__wsum csum, __wsum addend)
>  {
>  #ifdef __powerpc64__
>  	u64 res = (__force u64)csum;
