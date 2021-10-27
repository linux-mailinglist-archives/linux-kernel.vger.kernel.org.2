Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A641043C1E6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 06:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbhJ0E6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 00:58:00 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:45125 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235671AbhJ0E57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 00:57:59 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HfGbT2SPfz9sSp;
        Wed, 27 Oct 2021 06:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jmrJJAbWIoSS; Wed, 27 Oct 2021 06:55:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HfGbT1Kr0z9sSX;
        Wed, 27 Oct 2021 06:55:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A3928B76D;
        Wed, 27 Oct 2021 06:55:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id N2jP4ihRTbJH; Wed, 27 Oct 2021 06:55:33 +0200 (CEST)
Received: from [192.168.203.162] (unknown [192.168.203.162])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 74EB08B763;
        Wed, 27 Oct 2021 06:55:32 +0200 (CEST)
Message-ID: <063e72e1-fc05-7783-9f42-f681dd08a4b2@csgroup.eu>
Date:   Wed, 27 Oct 2021 06:55:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] powerpc/book3e: Fix set_memory_x() and
 set_memory_nx()
Content-Language: fr-FR
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
 <c41100f9c144dc5b62e5a751b810190c6b5d42fd.1635226743.git.christophe.leroy@csgroup.eu>
 <1635309296.3vv9pb80wz.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <1635309296.3vv9pb80wz.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/10/2021 à 06:44, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of October 26, 2021 3:39 pm:
>> set_memory_x() calls pte_mkexec() which sets _PAGE_EXEC.
>> set_memory_nx() calls pte_exprotec() which clears _PAGE_EXEC.
>>
>> Book3e has 2 bits, UX and SX, which defines the exec rights
>> resp. for user (PR=1) and for kernel (PR=0).
>>
>> _PAGE_EXEC is defined as UX only.
>>
>> An executable kernel page is set with either _PAGE_KERNEL_RWX
>> or _PAGE_KERNEL_ROX, which both have SX set and UX cleared.
>>
>> So set_memory_nx() call for an executable kernel page does
>> nothing because UX is already cleared.
>>
>> And set_memory_x() on a non-executable kernel page makes it
>> executable for the user and keeps it non-executable for kernel.
>>
>> Also, pte_exec() always returns 'false' on kernel pages, because
>> it checks _PAGE_EXEC which doesn't include SX, so for instance
>> the W+X check doesn't work.
>>
>> To fix this:
>> - change tlb_low_64e.S to use _PAGE_BAP_UX instead of _PAGE_USER
>> - sets both UX and SX in _PAGE_EXEC so that pte_user() returns
>> true whenever one of the two bits is set
> 
> I don't understand this change. Which pte_user() returns true after
> this change? Or do you mean pte_exec()?

Oops, yes, I mean pte_exec()

Unless I have to re-spin, can Michael eventually fix that typo while 
applying ?

> 
> Does this filter through in some cases at least for kernel executable
> PTEs will get both bits set? Seems cleaner to distinguish user and
> kernel exec for that but maybe it's a lot of churn?

Didn't understand what you mean.

I did it like that to be able to continue using _PAGE_EXEC for checking 
executability regardless of whether this is user or kernel, and then 
continue using the generic nohash pte_exec() helper.

Other solution would be to get rid of _PAGE_EXEC completely for book3e 
and implement both pte_exec() and pte_mkexec() with _PAGE_BAP_UX and 
_PAGE_BAP_SX, but I'm not sure it is worth the churn as you say. It 
would also mean different helpers for book3s/32 when it is using 32 bits 
PTE (CONFIG_PTE_64BIT=n)

Christophe

> 
> Thanks,
> Nick
> 
>> and pte_exprotect()
>> clears both bits.
>> - Define a book3e specific version of pte_mkexec() which sets
>> either SX or UX based on UR.
>>
>> Fixes: 1f9ad21c3b38 ("powerpc/mm: Implement set_memory() routines")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> v3: Removed pte_mkexec() from nohash/64/pgtable.h
>> v2: New
>> ---
