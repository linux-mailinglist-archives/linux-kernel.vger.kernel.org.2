Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8514135FA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 17:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhIUPRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 11:17:03 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:35267 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233905AbhIUPRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 11:17:02 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HDQ3T2Bvzz9sTJ;
        Tue, 21 Sep 2021 17:15:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SGxHaHHzvTVd; Tue, 21 Sep 2021 17:15:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HDQ3Q5y23z9sSt;
        Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8DD48B765;
        Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GLz8YS2uY4_Y; Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.127])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29C6D8B763;
        Tue, 21 Sep 2021 17:15:30 +0200 (CEST)
Subject: Re: [PATCH v4 1/3] powerpc/bitops: Use immediate operand when
 possible
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <db9d01d5c543c5add4b2beadb03d39e99c7ada2c.1632126669.git.christophe.leroy@csgroup.eu>
 <20210920212303.GZ1583@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <917987b7-48fd-d2f6-cbe4-7f7442cf86de@csgroup.eu>
Date:   Tue, 21 Sep 2021 17:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210920212303.GZ1583@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/09/2021 à 23:23, Segher Boessenkool a écrit :
> Hi!
> 
> On Mon, Sep 20, 2021 at 10:31:17AM +0200, Christophe Leroy wrote:
>> Today we get the following code generation for bitops like
>> set or clear bit:
>>
>> 	c0009fe0:	39 40 08 00 	li      r10,2048
>> 	c0009fe4:	7c e0 40 28 	lwarx   r7,0,r8
>> 	c0009fe8:	7c e7 53 78 	or      r7,r7,r10
>> 	c0009fec:	7c e0 41 2d 	stwcx.  r7,0,r8
>>
>> 	c000d568:	39 00 18 00 	li      r8,6144
>> 	c000d56c:	7c c0 38 28 	lwarx   r6,0,r7
>> 	c000d570:	7c c6 40 78 	andc    r6,r6,r8
>> 	c000d574:	7c c0 39 2d 	stwcx.  r6,0,r7
>>
>> Most set bits are constant on lower 16 bits, so it can easily
>> be replaced by the "immediate" version of the operation. Allow
>> GCC to choose between the normal or immediate form.
> 
> You can also handle the second sixteen bits (the "shifted" half), by
> using oris etc.  The "%eN" output modifier prints an "s" for this:
>    /* If the low 16 bits are 0, but some other bit is set, write 's'.  */
> But this doesn't handle non-constant arguments, so you're likely better
> off using what you have noe.
> 
>> For clear bits, on 32 bits 'rlwinm' can be used instead of 'andc' for
>> when all bits to be cleared are consecutive.
> 
> Or when all you want to keep are consecutive (you do handle that now :-) )
> 
>> On 64 bits we don't have any equivalent single operation for clearing,
>> single bits or a few bits, we'd need two 'rldicl' so it is not
>> worth it, the li/andc sequence is doing the same.
> 
> You can use rlwinm whenever you want to clear all top 32 bits.
> 
> A sometimes nice idiom is  ori x,x,N ; xori x,x,N  to clear the bits N
> (or oris/xoris).  But it's two insns no matter what (but no spare
> register is needed).

Could be a candidate for a follow-up change if someone want to focus on 
PPC64.

> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
>> +static inline unsigned long test_and_clear_bits(unsigned long mask, volatile unsigned long *_p)
>> +{
>> +	unsigned long old, t;
>> +	unsigned long *p = (unsigned long *)_p;
>> +
>> +	if (IS_ENABLED(CONFIG_PPC32) &&
>> +	    __builtin_constant_p(mask) && is_rlwinm_mask_valid(mask)) {
> 
> is_rlwinm_mask_valid(~mask)?  So that test_and_clear_bits(0, ...) will
> work with rlwinm, and test_and_clear_bits(0xffffffff, ...) will not make
> gas scream bloody murder ("illegal bitmask").  Tha mask you pass to the
> instruction is ~mask after all.

Ok, fixed in v5.

> 
> Looks great except that one nit.  Thanks :-)
> 
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks

Christophe
