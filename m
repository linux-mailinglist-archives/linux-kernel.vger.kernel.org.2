Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786DC41DAC6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350508AbhI3NRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:17:34 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:50313 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350073AbhI3NRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:17:32 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HKtz92ckbz9sTd;
        Thu, 30 Sep 2021 15:15:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r-nx1qNhbRJp; Thu, 30 Sep 2021 15:15:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HKtz83yGVz9sTF;
        Thu, 30 Sep 2021 15:15:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 701A98B773;
        Thu, 30 Sep 2021 15:15:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id n4fciGlgmtXr; Thu, 30 Sep 2021 15:15:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.149])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 65DED8B763;
        Thu, 30 Sep 2021 15:15:47 +0200 (CEST)
Subject: Re: [PATCH v2 1/7] arm64: add CPU field to struct thread_info
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20210930125813.197418-1-ardb@kernel.org>
 <20210930125813.197418-2-ardb@kernel.org>
 <6b003f58-48df-7ac4-4dbf-81b2c5bca5d9@csgroup.eu>
 <CAMj1kXECGp=5QRQS8HQNfE6RyA=eQfRiciDdjXp_ucpk8OxkDQ@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f634b2fe-3d89-709b-a56e-7da08af3988e@csgroup.eu>
Date:   Thu, 30 Sep 2021 15:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXECGp=5QRQS8HQNfE6RyA=eQfRiciDdjXp_ucpk8OxkDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/09/2021 à 15:07, Ard Biesheuvel a écrit :
> On Thu, 30 Sept 2021 at 15:06, Christophe Leroy
> <christophe.leroy@csgroup.eu> wrote:
>>
>>
>>
>> Le 30/09/2021 à 14:58, Ard Biesheuvel a écrit :
>>> The CPU field will be moved back into thread_info even when
>>> THREAD_INFO_IN_TASK is enabled, so add it back to arm64's definition of
>>> struct thread_info.
>>>
>>> Note that arm64 always has CONFIG_SMP=y so there is no point in guarding
>>> the CPU field with an #ifdef.
>>>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>> ---
>>>    arch/arm64/include/asm/thread_info.h | 1 +
>>>    arch/arm64/kernel/asm-offsets.c      | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>>> index 6623c99f0984..c02bc8c183c3 100644
>>> --- a/arch/arm64/include/asm/thread_info.h
>>> +++ b/arch/arm64/include/asm/thread_info.h
>>> @@ -42,6 +42,7 @@ struct thread_info {
>>>        void                    *scs_base;
>>>        void                    *scs_sp;
>>>    #endif
>>> +     u32                     cpu;
>>>    };
>>>
>>>    #define thread_saved_pc(tsk)        \
>>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>>> index 551427ae8cc5..cee9f3e9f906 100644
>>> --- a/arch/arm64/kernel/asm-offsets.c
>>> +++ b/arch/arm64/kernel/asm-offsets.c
>>> @@ -29,6 +29,7 @@ int main(void)
>>>      DEFINE(TSK_ACTIVE_MM,             offsetof(struct task_struct, active_mm));
>>>      DEFINE(TSK_CPU,           offsetof(struct task_struct, cpu));
>>>      BLANK();
>>> +  DEFINE(TSK_TI_CPU,         offsetof(struct task_struct, thread_info.cpu));
>>
>> Why adding that now ? For powerpc you do the switch in 5.
>>
> 
> 
> Why not?

Maybe to remain consistent between archs ?

> 
> 
>>>      DEFINE(TSK_TI_FLAGS,              offsetof(struct task_struct, thread_info.flags));
>>>      DEFINE(TSK_TI_PREEMPT,    offsetof(struct task_struct, thread_info.preempt_count));
>>>    #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>>>
