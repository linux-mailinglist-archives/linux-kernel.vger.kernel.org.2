Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6C35D2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbhDLWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:14:22 -0400
Received: from gate.crashing.org ([63.228.1.57]:60708 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243890AbhDLWOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:14:06 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13CM8MKP012708;
        Mon, 12 Apr 2021 17:08:22 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13CM8MWJ012707;
        Mon, 12 Apr 2021 17:08:22 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Mon, 12 Apr 2021 17:08:22 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] powerpc/atomics: Use immediate operand when possible
Message-ID: <20210412220821.GN26583@gate.crashing.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu> <9f50b5fadeb090553e5c2fae025052d04d52f3c7.1617896018.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f50b5fadeb090553e5c2fae025052d04d52f3c7.1617896018.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Apr 08, 2021 at 03:33:45PM +0000, Christophe Leroy wrote:
> +#define ATOMIC_OP(op, asm_op, dot, sign)				\
>  static __inline__ void atomic_##op(int a, atomic_t *v)			\
>  {									\
>  	int t;								\
>  									\
>  	__asm__ __volatile__(						\
>  "1:	lwarx	%0,0,%3		# atomic_" #op "\n"			\
> -	#asm_op " %0,%2,%0\n"						\
> +	#asm_op "%I2" dot " %0,%0,%2\n"					\
>  "	stwcx.	%0,0,%3 \n"						\
>  "	bne-	1b\n"							\
> -	: "=&r" (t), "+m" (v->counter)					\
> -	: "r" (a), "r" (&v->counter)					\
> +	: "=&b" (t), "+m" (v->counter)					\
> +	: "r"#sign (a), "r" (&v->counter)				\
>  	: "cc");							\
>  }									\

You need "b" (instead of "r") only for "addi".  You can use "addic"
instead, which clobbers XER[CA], but *all* inline asm does, so that is
not a downside here (it is also not slower on any CPU that matters).

> @@ -238,14 +238,14 @@ static __inline__ int atomic_fetch_add_unless(atomic_t *v, int a, int u)
>  "1:	lwarx	%0,0,%1		# atomic_fetch_add_unless\n\
>  	cmpw	0,%0,%3 \n\
>  	beq	2f \n\
> -	add	%0,%2,%0 \n"
> +	add%I2	%0,%0,%2 \n"
>  "	stwcx.	%0,0,%1 \n\
>  	bne-	1b \n"
>  	PPC_ATOMIC_EXIT_BARRIER
> -"	subf	%0,%2,%0 \n\
> +"	sub%I2	%0,%0,%2 \n\
>  2:"
> -	: "=&r" (t)
> -	: "r" (&v->counter), "r" (a), "r" (u)
> +	: "=&b" (t)
> +	: "r" (&v->counter), "rI" (a), "r" (u)
>  	: "cc", "memory");

Same here.

Nice patches!

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
