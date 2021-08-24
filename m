Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE43F6699
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbhHXRZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:25:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:51272 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240313AbhHXRWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:22:13 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17OHFvAg028670;
        Tue, 24 Aug 2021 12:15:57 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 17OHFuD6028666;
        Tue, 24 Aug 2021 12:15:56 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 24 Aug 2021 12:15:56 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/booke: Avoid link stack corruption in several places
Message-ID: <20210824171556.GJ1583@gate.crashing.org>
References: <e9fbc285eceb720e6c0e032ef47fe8b05f669b48.1629791751.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9fbc285eceb720e6c0e032ef47fe8b05f669b48.1629791751.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Aug 24, 2021 at 07:56:26AM +0000, Christophe Leroy wrote:
> Use bcl 20,31,+4 instead of bl in order to preserve link stack.

You use $+4 actually, which is clearer than .+4 or just +4 (and I am
surprised that the latter even works btw, I never knew :-) -- either
way it looks like a typo).

> -	bl	invstr				/* Find our address */
> +	bcl	20,31,$+4			/* Find our address */
>  invstr:	mflr	r6				/* Make it accessible */

You can remove the label now.  This isn't true in all cases, but here
you can (all times it is called "invstr").

> @@ -85,7 +85,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
>  	addi	r6,r6,10
>  	slw	r6,r8,r6	/* convert to mask */
>  
> -	bl	1f		/* Find our address */
> +	bcl	20,31,$+4	/* Find our address */
>  1:	mflr	r7

Here, too.

> @@ -1045,7 +1045,7 @@ head_start_47x:
>  	sync
>  
>  	/* Find the entry we are running from */
> -	bl	1f
> +	bcl	20,31,$+4
>  1:	mflr	r23
>  	tlbsx	r23,0,r23
>  	tlbre	r24,r23,0

And here.

> @@ -1132,7 +1132,7 @@ _GLOBAL(switch_to_as1)
>  	bne	1b
>  
>  	/* Get the tlb entry used by the current running code */
> -	bl	0f
> +	bcl	20,31,$+4
>  0:	mflr	r4
>  	tlbsx	0,r4

> @@ -1166,7 +1166,7 @@ _GLOBAL(switch_to_as1)
>  _GLOBAL(restore_to_as0)
>  	mflr	r0
>  
> -	bl	0f
> +	bcl	20,31,$+4
>  0:	mflr	r9
>  	addi	r9,r9,1f - 0b

And these.

> --- a/arch/powerpc/mm/nohash/tlb_low.S
> +++ b/arch/powerpc/mm/nohash/tlb_low.S
> @@ -199,7 +199,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_476_DD2)
>   * Touch enough instruction cache lines to ensure cache hits
>   */
>  1:	mflr	r9
> -	bl	2f
> +	bcl	20,31,$+4
>  2:	mflr	r6
>  	li	r7,32
>  	PPC_ICBT(0,R6,R7)		/* touch next cache line */
> @@ -414,7 +414,7 @@ _GLOBAL(loadcam_multi)
>  	 * Set up temporary TLB entry that is the same as what we're
>  	 * running from, but in AS=1.
>  	 */
> -	bl	1f
> +	bcl	20,31,$+4
>  1:	mflr	r6
>  	tlbsx	0,r8
>  	mfspr	r6,SPRN_MAS1

And these too.

There does not see to be a warning for usused local labels, it would be
useful in this case :-)


Segher
