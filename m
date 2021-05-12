Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3578A37BD81
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbhELM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:58:28 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:58869 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230334AbhELM6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:58:20 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FgFDj4JDkz9sf2;
        Wed, 12 May 2021 14:57:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CKX-q6AHXoOp; Wed, 12 May 2021 14:57:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FgFDj3J5cz9sf1;
        Wed, 12 May 2021 14:57:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4DE178B7F2;
        Wed, 12 May 2021 14:57:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id r9l0ajoEPVOw; Wed, 12 May 2021 14:57:09 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CFDFF8B7EF;
        Wed, 12 May 2021 14:57:08 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Force inlining of csum_add()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
 <20210511105154.GJ10366@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <e996ef13-c25c-5e9c-edd2-444eded88802@csgroup.eu>
Date:   Wed, 12 May 2021 14:56:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210511105154.GJ10366@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 11/05/2021 à 12:51, Segher Boessenkool a écrit :
> Hi!
> 
> On Tue, May 11, 2021 at 06:08:06AM +0000, Christophe Leroy wrote:
>> Commit 328e7e487a46 ("powerpc: force inlining of csum_partial() to
>> avoid multiple csum_partial() with GCC10") inlined csum_partial().
>>
>> Now that csum_partial() is inlined, GCC outlines csum_add() when
>> called by csum_partial().
> 
>> c064fb28 <csum_add>:
>> c064fb28:	7c 63 20 14 	addc    r3,r3,r4
>> c064fb2c:	7c 63 01 94 	addze   r3,r3
>> c064fb30:	4e 80 00 20 	blr
> 
> Could you build this with -fdump-tree-einline-all and send me the
> results?  Or open a GCC PR yourself :-)

Ok, I'll forward it to you in a minute.

> 
> Something seems to have decided this asm is more expensive than it is.
> That isn't always avoidable -- the compiler cannot look inside asms --
> but it seems it could be improved here.
> 
> Do you have (or can make) a self-contained testcase?

I have not tried, and I fear it might be difficult, because on a kernel build with dozens of calls 
to csum_add(), only ip6_tunnel.o exhibits such an issue.

> 
>> The sum with 0 is useless, should have been skipped.
> 
> That isn't something the compiler can do anything about (not sure if you
> were suggesting that); it has to be done in the user code (and it tries
> to already, see below).

I was not suggesting that, only that when properly inlined the sum with 0 is skipped (because we put 
the necessary stuff in csum_add() of course).

> 
>> And there is even one completely unused instance of csum_add().
> 
> That is strange, that should never happen.

It seems that several .o include unused versions of csum_add. After the final link, one remains (in 
addition to the used one) in vmlinux.

> 
>> ./arch/powerpc/include/asm/checksum.h: In function '__ip6_tnl_rcv':
>> ./arch/powerpc/include/asm/checksum.h:94:22: warning: inlining failed in call to 'csum_add': call is unlikely and code size would grow [-Winline]
>>     94 | static inline __wsum csum_add(__wsum csum, __wsum addend)
>>        |                      ^~~~~~~~
>> ./arch/powerpc/include/asm/checksum.h:172:31: note: called from here
>>    172 |                         sum = csum_add(sum, (__force __wsum)*(const u32 *)buff);
>>        |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> At least we say what happened.  Progress!  :-)

Lol. I've seen this warning for long, that's not something new I guess.

> 
>> In the non-inlined version, the first sum with 0 was performed.
>> Here it is skipped.
> 
> That is because of how __builtin_constant_p works, most likely.  As we
> discussed elsewhere it is evaluated before all forms of loop unrolling.

But we are not talking about loop unrolling here, are we ?

It seems that the reason here is that __builtin_constant_p() is evaluated long after GCC decided to 
not inline that call to csum_add().

Christophe
