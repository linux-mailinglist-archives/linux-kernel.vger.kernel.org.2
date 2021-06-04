Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7F39B60C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFDJhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 05:37:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60677 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFDJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 05:37:07 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 811AF1BF215;
        Fri,  4 Jun 2021 09:35:19 +0000 (UTC)
Subject: Re: [PATCH] riscv: xip: support runtime trap patching
From:   Alex Ghiti <alex@ghiti.fr>
To:     Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Nicolas Pitre <nico@fluxnic.net>
References: <20210531085342.17494-1-vitaly.wool@konsulko.com>
 <62961217-1733-eaa3-b072-cbb252620c9a@ghiti.fr>
Message-ID: <2fb64dce-779a-c6f2-53b7-088cd38813a4@ghiti.fr>
Date:   Fri, 4 Jun 2021 11:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <62961217-1733-eaa3-b072-cbb252620c9a@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 31/05/2021 à 17:17, Alex Ghiti a écrit :
> Hi Vitaly,
> 
> Le 31/05/2021 à 10:53, Vitaly Wool a écrit :
>> RISCV_ERRATA_ALTERNATIVE patches text at runtime which is currently
>> not possible when the kernel is executed from the flash in XIP mode.
>> Since runtime patching concerns only traps at the moment, let's just
>> have all the traps reside in RAM anyway if RISCV_ERRATA_ALTERNATIVE
>> is set. Thus, these functions will be patch-able even when the .text
>> section is in flash.
>>
> 
> This sounds like a good fix for sifive platforms to work with XIP kernel 
> in 5.13: did you test that it actually works on HW?
> 
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
>> ---
>>   arch/riscv/kernel/traps.c           | 13 +++++++++----
>>   arch/riscv/kernel/vmlinux-xip.lds.S | 15 ++++++++++++++-
>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>> index 0721b9798595..7bc88d8aab97 100644
>> --- a/arch/riscv/kernel/traps.c
>> +++ b/arch/riscv/kernel/traps.c
>> @@ -86,8 +86,13 @@ static void do_trap_error(struct pt_regs *regs, int 
>> signo, int code,
>>       }
>>   }
>> +#if defined (CONFIG_XIP_KERNEL) && defined 
>> (CONFIG_RISCV_ERRATA_ALTERNATIVE)
>> +#define __trap_section        __section(".xip.traps")
>> +#else
>> +#define __trap_section
>> +#endif
> 
> Maybe we could do something more generic. At the moment, only traps are 
> subject to alternatives but that will likely expand: what about rather 
> defining a section called __alternative_section?

Any thoughts about that?

Thanks,

Alex

> 
>>   #define DO_ERROR_INFO(name, signo, code, str)                \
>> -asmlinkage __visible void name(struct pt_regs *regs)            \
>> +asmlinkage __visible __trap_section void name(struct pt_regs *regs)    \
>>   {                                    \
>>       do_trap_error(regs, signo, code, regs->epc, "Oops - " str);    \
>>   }
>> @@ -111,7 +116,7 @@ DO_ERROR_INFO(do_trap_store_misaligned,
>>   int handle_misaligned_load(struct pt_regs *regs);
>>   int handle_misaligned_store(struct pt_regs *regs);
>> -asmlinkage void do_trap_load_misaligned(struct pt_regs *regs)
>> +asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs 
>> *regs)
>>   {
>>       if (!handle_misaligned_load(regs))
>>           return;
>> @@ -119,7 +124,7 @@ asmlinkage void do_trap_load_misaligned(struct 
>> pt_regs *regs)
>>                 "Oops - load address misaligned");
>>   }
>> -asmlinkage void do_trap_store_misaligned(struct pt_regs *regs)
>> +asmlinkage void __trap_section do_trap_store_misaligned(struct 
>> pt_regs *regs)
>>   {
>>       if (!handle_misaligned_store(regs))
>>           return;
>> @@ -146,7 +151,7 @@ static inline unsigned long 
>> get_break_insn_length(unsigned long pc)
>>       return GET_INSN_LENGTH(insn);
>>   }
>> -asmlinkage __visible void do_trap_break(struct pt_regs *regs)
>> +asmlinkage __visible __trap_section void do_trap_break(struct pt_regs 
>> *regs)
>>   {
>>   #ifdef CONFIG_KPROBES
>>       if (kprobe_single_step_handler(regs))
>> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S 
>> b/arch/riscv/kernel/vmlinux-xip.lds.S
>> index 4b29b9917f99..a3ff09c4c3f9 100644
>> --- a/arch/riscv/kernel/vmlinux-xip.lds.S
>> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
>> @@ -99,9 +99,22 @@ SECTIONS
>>       }
>>       PERCPU_SECTION(L1_CACHE_BYTES)
>> -    . = ALIGN(PAGE_SIZE);
>> +    . = ALIGN(8);
>> +    .alternative : {
>> +        __alt_start = .;
>> +        *(.alternative)
>> +        __alt_end = .;
>> +    }
>>       __init_end = .;
>> +    . = ALIGN(16);
> 
> Why 16 here?
> 
>> +    .xip.traps : {
>> +        __xip_traps_start = .;
>> +        *(.xip.traps)
>> +        __xip_traps_end = .;
>> +    }
>> +
>> +    . = ALIGN(PAGE_SIZE);
>>       .sdata : {
>>           __global_pointer$ = . + 0x800;
>>           *(.sdata*)
>>
> 
> Thanks,
> 
> Alex
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
