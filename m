Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A970E3387CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhCLIkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:40:24 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:48978 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232237AbhCLIkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:40:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DxfQ81Fkcz9v0tv;
        Fri, 12 Mar 2021 09:40:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Rn4VRcLedMso; Fri, 12 Mar 2021 09:40:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DxfQ76Wftz9v0ts;
        Fri, 12 Mar 2021 09:39:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6EA878B764;
        Fri, 12 Mar 2021 09:40:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1daKeA9LbCwM; Fri, 12 Mar 2021 09:40:00 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D60748B810;
        Fri, 12 Mar 2021 09:39:59 +0100 (CET)
Subject: Re: [PATCH v2 28/43] powerpc/64e: Call bad_page_fault() from
 do_page_fault()
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
 <b2878184d4c21faa8af55b60e52c83f391272112.1615291473.git.christophe.leroy@csgroup.eu>
 <1615339667.i88ve15v8a.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <6e5e8283-8aad-cf61-565b-03903e5d20b5@csgroup.eu>
Date:   Fri, 12 Mar 2021 09:39:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615339667.i88ve15v8a.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 10/03/2021 à 02:29, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of March 9, 2021 10:09 pm:
>> book3e/64 is the last one calling __bad_page_fault()
>> from assembly.
>>
>> Save non volatile registers before calling do_page_fault()
>> and modify do_page_fault() to call __bad_page_fault()
>> for all platforms.
>>
>> Then it can be refactored by the call of bad_page_fault()
>> which avoids the duplication of the exception table search.
> 
> This can go in with the 64e change after your series. I think it should
> be ready for the next merge window as well.

Yes, I thought it would pull more optimisation, but at the end it doesn't bring anythink, so I'll 
drop it for now and leave it to you for your series.

> 
> Thanks,
> Nick
> 
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/kernel/exceptions-64e.S |  8 +-------
>>   arch/powerpc/mm/fault.c              | 17 ++++-------------
>>   2 files changed, 5 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
>> index e8eb9992a270..b60f89078a3f 100644
>> --- a/arch/powerpc/kernel/exceptions-64e.S
>> +++ b/arch/powerpc/kernel/exceptions-64e.S
>> @@ -1010,15 +1010,9 @@ storage_fault_common:
>>   	addi	r3,r1,STACK_FRAME_OVERHEAD
>>   	ld	r14,PACA_EXGEN+EX_R14(r13)
>>   	ld	r15,PACA_EXGEN+EX_R15(r13)
>> +	bl	save_nvgprs
>>   	bl	do_page_fault
>> -	cmpdi	r3,0
>> -	bne-	1f
>>   	b	ret_from_except_lite
>> -1:	bl	save_nvgprs
>> -	mr	r4,r3
>> -	addi	r3,r1,STACK_FRAME_OVERHEAD
>> -	bl	__bad_page_fault
>> -	b	ret_from_except
>>   
>>   /*
>>    * Alignment exception doesn't fit entirely in the 0x100 bytes so it
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 2e54bac99a22..7bcff3fca110 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -541,24 +541,15 @@ NOKPROBE_SYMBOL(___do_page_fault);
>>   
>>   static long __do_page_fault(struct pt_regs *regs)
>>   {
>> -	const struct exception_table_entry *entry;
>>   	long err;
>>   
>>   	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
>>   	if (likely(!err))
>> -		return err;
>> -
>> -	entry = search_exception_tables(regs->nip);
>> -	if (likely(entry)) {
>> -		instruction_pointer_set(regs, extable_fixup(entry));
>>   		return 0;
>> -	} else if (!IS_ENABLED(CONFIG_PPC_BOOK3E_64)) {
>> -		__bad_page_fault(regs, err);
>> -		return 0;
>> -	} else {
>> -		/* 32 and 64e handle the bad page fault in asm */
>> -		return err;
>> -	}
>> +
>> +	bad_page_fault(regs, err);
>> +
>> +	return 0;
>>   }
>>   NOKPROBE_SYMBOL(__do_page_fault);
>>   
>> -- 
>> 2.25.0
>>
>>
