Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA9A41DB2A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350893AbhI3Ng7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:36:59 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36309 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349563AbhI3Ng6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:36:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4HKvPZ3WwBz9sVL;
        Thu, 30 Sep 2021 15:35:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id LWfDC8gYcJM3; Thu, 30 Sep 2021 15:35:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4HKvPZ2RX8z9sVK;
        Thu, 30 Sep 2021 15:35:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B8DC8B773;
        Thu, 30 Sep 2021 15:35:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ODWiSNY5bC5p; Thu, 30 Sep 2021 15:35:14 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.149])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 158B98B763;
        Thu, 30 Sep 2021 15:35:13 +0200 (CEST)
Subject: Re: [PATCH v2 5/7] sched: move CPU field back into thread_info if
 THREAD_INFO_IN_TASK=y
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
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
 <20210930125813.197418-6-ardb@kernel.org>
 <427566ca-80c0-56eb-880b-908bd4a71e9a@csgroup.eu>
 <CAMj1kXF6NSy1WRrmHkg15ZD_myCa1gj7dN-CqPyz=bmRmoOdMQ@mail.gmail.com>
 <ff33f8b0-dadd-ce94-8e34-d78822119fa6@csgroup.eu>
Message-ID: <2e1f58c0-8b2a-3d72-2261-a43f810e7070@csgroup.eu>
Date:   Thu, 30 Sep 2021 15:35:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <ff33f8b0-dadd-ce94-8e34-d78822119fa6@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 30/09/2021 à 15:22, Christophe Leroy a écrit :
> 
> 
> Le 30/09/2021 à 15:12, Ard Biesheuvel a écrit :
>> On Thu, 30 Sept 2021 at 15:09, Christophe Leroy
>> <christophe.leroy@csgroup.eu> wrote:
>>>
>>>
>>>
>>> Le 30/09/2021 à 14:58, Ard Biesheuvel a écrit :
>>>> THREAD_INFO_IN_TASK moved the CPU field out of thread_info, but this
>>>> causes some issues on architectures that define raw_smp_processor_id()
>>>> in terms of this field, due to the fact that #include'ing linux/sched.h
>>>> to get at struct task_struct is problematic in terms of circular
>>>> dependencies.
>>>>
>>>> Given that thread_info and task_struct are the same data structure
>>>> anyway when THREAD_INFO_IN_TASK=y, let's move it back so that having
>>>> access to the type definition of struct thread_info is sufficient to
>>>> reference the CPU number of the current task.
>>>>
>>>> Note that this requires THREAD_INFO_IN_TASK's definition of the
>>>> task_thread_info() helper to be updated, as task_cpu() takes a
>>>> pointer-to-const, whereas task_thread_info() (which is used to generate
>>>> lvalues as well), needs a non-const pointer. So make it a macro 
>>>> instead.
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>>>> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>>    arch/arm64/kernel/asm-offsets.c   |  1 -
>>>>    arch/arm64/kernel/head.S          |  2 +-
>>>>    arch/powerpc/kernel/asm-offsets.c |  2 +-
>>>>    arch/powerpc/kernel/smp.c         |  2 +-
>>>>    include/linux/sched.h             | 13 +------------
>>>>    kernel/sched/sched.h              |  4 ----
>>>>    6 files changed, 4 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/kernel/asm-offsets.c 
>>>> b/arch/arm64/kernel/asm-offsets.c
>>>> index cee9f3e9f906..0bfc048221af 100644
>>>> --- a/arch/arm64/kernel/asm-offsets.c
>>>> +++ b/arch/arm64/kernel/asm-offsets.c
>>>> @@ -27,7 +27,6 @@
>>>>    int main(void)
>>>>    {
>>>>      DEFINE(TSK_ACTIVE_MM,             offsetof(struct task_struct, 
>>>> active_mm));
>>>> -  DEFINE(TSK_CPU,            offsetof(struct task_struct, cpu));
>>>>      BLANK();
>>>>      DEFINE(TSK_TI_CPU,                offsetof(struct task_struct, 
>>>> thread_info.cpu));
>>>>      DEFINE(TSK_TI_FLAGS,              offsetof(struct task_struct, 
>>>> thread_info.flags));
>>>> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
>>>> index 17962452e31d..6a98f1a38c29 100644
>>>> --- a/arch/arm64/kernel/head.S
>>>> +++ b/arch/arm64/kernel/head.S
>>>> @@ -412,7 +412,7 @@ SYM_FUNC_END(__create_page_tables)
>>>>        scs_load \tsk
>>>>
>>>>        adr_l   \tmp1, __per_cpu_offset
>>>> -     ldr     w\tmp2, [\tsk, #TSK_CPU]
>>>> +     ldr     w\tmp2, [\tsk, #TSK_TI_CPU]
>>>
>>> Why do you need to change the name ?
>>>
>>> For powerpc64, you leave TASK_CPU.
>>>
>>
>> Because arm64 has a clear idiom here, where TSK_TI_ is used for
>> thread_info fields accessed via a task_struct pointer. Also, it only
>> occurs once in the code.
>>
>> Power does not seem to have this idiom, and TASK_CPU is used in many
>> more places, so I don't think it makes sense to change its name.
> 
> In the old days it was called TI_CPU, was changed by commit f7354ccac844 
> ("powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU") after 
> commit ed1cd6deb013 ("powerpc: Activate CONFIG_THREAD_INFO_IN_TASK")
> 
> I don't have a strong opinion about it but we have:
> 
> $ git grep thread_info arch/powerpc/kernel/asm-offsets.c
> arch/powerpc/kernel/asm-offsets.c:#include <asm/thread_info.h>
> arch/powerpc/kernel/asm-offsets.c:      OFFSET(TI_livepatch_sp, 
> thread_info, livepatch_sp);
> arch/powerpc/kernel/asm-offsets.c:      OFFSET(TI_LOCAL_FLAGS, 
> thread_info, local_flags);
> arch/powerpc/kernel/asm-offsets.c: offsetof(struct task_struct, 
> thread_info));

Forget that. I didn't realise that your change keeps it based on 
'task_struct' so it makes sense to keep it named TASK_CPU.

> 
> 
>>
>>
>>>>        ldr     \tmp1, [\tmp1, \tmp2, lsl #3]
>>>>        set_this_cpu_offset \tmp1
>>>>        .endm
>>>> diff --git a/arch/powerpc/kernel/asm-offsets.c 
>>>> b/arch/powerpc/kernel/asm-offsets.c
>>>> index e563d3222d69..e37e4546034e 100644
>>>> --- a/arch/powerpc/kernel/asm-offsets.c
>>>> +++ b/arch/powerpc/kernel/asm-offsets.c
>>>> @@ -93,7 +93,7 @@ int main(void)
>>>>    #endif /* CONFIG_PPC64 */
>>>>        OFFSET(TASK_STACK, task_struct, stack);
>>>>    #ifdef CONFIG_SMP
>>>> -     OFFSET(TASK_CPU, task_struct, cpu);
>>>> +     OFFSET(TASK_CPU, task_struct, thread_info.cpu);
>>>>    #endif
>>>>
>>>>    #ifdef CONFIG_LIVEPATCH
>>>
>>> ...
