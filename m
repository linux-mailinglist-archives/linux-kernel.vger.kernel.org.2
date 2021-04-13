Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F6A35E8BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348597AbhDMWE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:04:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:36694 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231815AbhDMWEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:04:24 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 13DLw5dB022427;
        Tue, 13 Apr 2021 16:58:05 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 13DLw41j022426;
        Tue, 13 Apr 2021 16:58:04 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 13 Apr 2021 16:58:03 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] powerpc/bitops: Use immediate operand when possible
Message-ID: <20210413215803.GT26583@gate.crashing.org>
References: <09da6fec57792d6559d1ea64e00be9870b02dab4.1617896018.git.christophe.leroy@csgroup.eu> <20210412215428.GM26583@gate.crashing.org> <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecb1b1a5-ae92-e8a3-6490-26341edfbccb@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 06:33:19PM +0200, Christophe Leroy wrote:
> Le 12/04/2021 à 23:54, Segher Boessenkool a écrit :
> >On Thu, Apr 08, 2021 at 03:33:44PM +0000, Christophe Leroy wrote:
> >>For clear bits, on 32 bits 'rlwinm' can be used instead or 'andc' for
> >>when all bits to be cleared are consecutive.
> >
> >Also on 64-bits, as long as both the top and bottom bits are in the low
> >32-bit half (for 32 bit mode, it can wrap as well).
> 
> Yes. But here we are talking about clearing a few bits, all other ones must 
> remain unchanged. An rlwinm on PPC64 will always clear the upper part, 
> which is unlikely what we want.

No, it does not.  It takes the low 32 bits of the source reg, duplicated
to the top half as well, then rotated, then ANDed with the mask (which
can wrap around).  This isn't very often very useful, but :-)

(One useful operation is splatting 32 bits to both halves of a 64-bit
register, which is just rlwinm d,s,0,1,0).

If you only look at the low 32 bits, it does exactly the same as on
32-bit implementations.

> >>For the time being only
> >>handle the single bit case, which we detect by checking whether the
> >>mask is a power of two.
> >
> >You could look at rs6000_is_valid_mask in GCC:
> >   <https://gcc.gnu.org/git/?p=gcc.git;a=blob;f=gcc/config/rs6000/rs6000.c;h=48b8efd732b251c059628096314848305deb0c0b;hb=HEAD#l11148>
> >used by rs6000_is_valid_and_mask immediately after it.  You probably
> >want to allow only rlwinm in your case, and please note this checks if
> >something is a valid mask, not the inverse of a valid mask (as you
> >want here).
> 
> This check looks more complex than what I need. It is used for both rlw... 
> and rld..., and it calculates the operants.  The only thing I need is to 
> validate the mask.

It has to do exactly the same thing for rlwinm as for all 64-bit
variants (rldicl, rldicr, rldic).

One side effect of calculation the bit positions with exact_log2 is that
that returns negative if the argument is not a power of two.

Here is a simpler way, that handles all cases:  input in "u32 val":

	if (!val)
		return nonono;
	if (val & 1)
		val = ~val;	// make the mask non-wrapping
	val += val & -val;	// adding the low set bit should result in
				// at most one bit set
	if (!(val & (val - 1)))
		return okidoki_all_good;

> I found a way: By anding the mask with the complement of itself rotated by 
> left bits to 1, we identify the transitions from 0 to 1. If the result is a 
> power of 2, it means there's only one transition so the mask is as expected.

That does not handle all cases (it misses all bits set at least).  Which
isn't all that interesting of course, but is a valid mask (but won't
clear any bits, so not too interesting for your specific case :-) )


Segher
