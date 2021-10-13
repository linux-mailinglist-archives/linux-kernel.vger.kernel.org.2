Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440C842BA09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhJMITG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:19:06 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:57405 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhJMITD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:19:03 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HTlkM3zWfz9sSW;
        Wed, 13 Oct 2021 10:16:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pN2ZAo9E-Qm9; Wed, 13 Oct 2021 10:16:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HTlkM3CX9z9sRn;
        Wed, 13 Oct 2021 10:16:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 57AA48B780;
        Wed, 13 Oct 2021 10:16:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Lmb1gfGpz5Y9; Wed, 13 Oct 2021 10:16:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3061B8B763;
        Wed, 13 Oct 2021 10:16:59 +0200 (CEST)
Subject: Re: [PATCH] powerpc: don't select KFENCE on platform PPC_FSL_BOOK3E
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Liu Shixin <liushixin2@huawei.com>,
        Marco Elver <elver@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210924063927.1341241-1-liushixin2@huawei.com>
 <77ce95e4-1af1-6536-5f0c-a573c648801a@huawei.com>
 <87bl3u7oay.fsf@mpe.ellerman.id.au>
 <9c1ee778-b38b-3d41-37f3-5ea22dca063b@csgroup.eu>
 <8735p57nsb.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <09bd30b9-9a62-3c59-0ad3-62143a4c0343@csgroup.eu>
Date:   Wed, 13 Oct 2021 10:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <8735p57nsb.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/10/2021 à 02:48, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> Le 12/10/2021 à 08:24, Michael Ellerman a écrit :
>>> Liu Shixin <liushixin2@huawei.com> writes:
>>>> kindly ping.
>>>
>>> I was under the impression you were trying to debug why it wasn't
>>> working with Christophe.
>>
>> The investigation was a bit dormant to be honest since Liu confirmed
>> that neither KFENCE not DEBUG_PAGEALLOC works.
> 
> No worries. Sorry it fell to you to do the investigation.

No problem.


> 
>> I now looked at the effort to make it work, and it is not trivial.
>> At the time being, all linear space is mapped with pinned TLBs and
>> everything is setup for space 0, with space 1 being used temporarily
>> when doing heavy changes to space 0.
>>
>> We can't use standard pages for linear space on space 0 because we need
>> memory mapped at all time for exceptions (on booke exception run with
>> MMU on in space 0).
>>
>> In order to use standard pages, we'd need to reorganise the kernel to
>> have it run mostly in space 1 (for data at least) where we would map
>> almost everything with standard pages, and keep pinned TLB to map linear
>> space on space 0 for TLB miss exceptions. Then we'd do more or less like
>> book3s/32 and switch back into space 1 into other exceptions prolog.
>>
>> That could be good to do it as we could maybe have more code in common
>> with non booke 32 bits, but it is not a trivial job.
>>
>> So I suggest that for now, we just make KFENCE and DEBUG_PAGEALLOC
>> unselectable for booke/32 (e500 and 44x).
> 
> Yep seems reasonable.
> 


We also have a problem with STRICT_KERNEL_RWX as it is based on the same 
principles until someone implements it by blocks like book3s/32 and 8xx.

So it should also be unselectable on e500 and 44x for now.

Christophe
