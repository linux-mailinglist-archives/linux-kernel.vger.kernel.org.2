Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82375313E88
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236137AbhBHTIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 14:08:18 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:8163 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235046AbhBHRrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 12:47:45 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DZD420fkxzB09Zf;
        Mon,  8 Feb 2021 18:46:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id bYGNs9EgU_2X; Mon,  8 Feb 2021 18:46:58 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DZD416pSZzB09Zc;
        Mon,  8 Feb 2021 18:46:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 99D6D8B7B3;
        Mon,  8 Feb 2021 18:47:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id tjn8MpdDVxWz; Mon,  8 Feb 2021 18:47:03 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32AA48B7B2;
        Mon,  8 Feb 2021 18:47:03 +0100 (CET)
Subject: Re: [PATCH v4 14/23] powerpc/syscall: Save r3 in regs->orig_r3
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
 <5d375bea8f519924e110842f6b0d05e83cd04470.1611585031.git.christophe.leroy@csgroup.eu>
 <1611656262.d3l09kg9o2.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <792bd9e7-64c3-a783-7a42-d306d46e4aca@csgroup.eu>
Date:   Mon, 8 Feb 2021 18:47:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <1611656262.d3l09kg9o2.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/01/2021 à 11:18, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of January 26, 2021 12:48 am:
>> Save r3 in regs->orig_r3 in system_call_exception()
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/kernel/entry_64.S | 1 -
>>   arch/powerpc/kernel/syscall.c  | 2 ++
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
>> index aa1af139d947..a562a4240aa6 100644
>> --- a/arch/powerpc/kernel/entry_64.S
>> +++ b/arch/powerpc/kernel/entry_64.S
>> @@ -278,7 +278,6 @@ END_BTB_FLUSH_SECTION
>>   	std	r10,_LINK(r1)
>>   	std	r11,_TRAP(r1)
>>   	std	r12,_CCR(r1)
>> -	std	r3,ORIG_GPR3(r1)
>>   	addi	r10,r1,STACK_FRAME_OVERHEAD
>>   	ld	r11,exception_marker@toc(r2)
>>   	std	r11,-16(r10)		/* "regshere" marker */
> 
> This misses system_call_vectored.

Oops yes, this patch was cooked before SCV where introduced. Fixes in v5.

Thanks
Christophe
