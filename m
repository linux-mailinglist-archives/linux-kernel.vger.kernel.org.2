Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F20F45EF5E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377640AbhKZNsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:48:39 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:59985 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353614AbhKZNqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:46:38 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J0wth2H7kz9sSM;
        Fri, 26 Nov 2021 14:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vK7OUS3ldOV2; Fri, 26 Nov 2021 14:43:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J0wth1NLYz9sQv;
        Fri, 26 Nov 2021 14:43:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1EE3A8B77D;
        Fri, 26 Nov 2021 14:43:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GsDpKo4Y4dVs; Fri, 26 Nov 2021 14:43:24 +0100 (CET)
Received: from [192.168.204.6] (unknown [192.168.204.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 216EE8B763;
        Fri, 26 Nov 2021 14:43:23 +0100 (CET)
Message-ID: <6b1e51a8-2f4d-2024-df90-a35c926d7a30@csgroup.eu>
Date:   Fri, 26 Nov 2021 14:43:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] powerpc: mm: radix_tlb: rearrange the if-else block
Content-Language: fr-FR
To:     Anders Roxell <anders.roxell@linaro.org>, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     Arnd Bergmann <arnd@arndb.de>, llvm@lists.linux.dev,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        nathan@kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20211125154406.470082-1-anders.roxell@linaro.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20211125154406.470082-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/11/2021 à 16:44, Anders Roxell a écrit :
> Clang warns:
> 
> arch/powerpc/mm/book3s64/radix_tlb.c:1191:23: error: variable 'hstart' is uninitialized when used here [-Werror,-Wuninitialized]
>                                  __tlbiel_va_range(hstart, hend, pid,
>                                                    ^~~~~~
> arch/powerpc/mm/book3s64/radix_tlb.c:1175:23: note: initialize the variable 'hstart' to silence this warning
>                  unsigned long hstart, hend;
>                                      ^
>                                       = 0
> arch/powerpc/mm/book3s64/radix_tlb.c:1191:31: error: variable 'hend' is uninitialized when used here [-Werror,-Wuninitialized]
>                                  __tlbiel_va_range(hstart, hend, pid,
>                                                            ^~~~
> arch/powerpc/mm/book3s64/radix_tlb.c:1175:29: note: initialize the variable 'hend' to silence this warning
>                  unsigned long hstart, hend;
>                                            ^
>                                             = 0
> 2 errors generated.
> 
> Rework the if-else to pull the 'IS_ENABLE(CONFIG_TRANSPARENT_HUGEPAGE)'
> check one level up, this will silent the warnings. That will also
> simplify the 'else' path. Clang is getting confused with these warnings,
> but the warnings is a false-positive.

But you are duplicating a significant part of the code by doing that, 
and duplicated code generaly leads to bugs.

And we already have redundant stuff between FLUSH_TYPE_LOCAL leg and 
cputlb_use_tlbie() leg.

Can't you fix CLANG instead :) ?

Or just add an else to the IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) that 
sets hstart and hend to 0 ?

Or just put hstart and hend calculation outside the IS_ENABLED() ? After 
all GCC should drop the calculation when not used.


> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   arch/powerpc/mm/book3s64/radix_tlb.c | 31 +++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
> index 7724af19ed7e..e494a45ce1b4 100644
> --- a/arch/powerpc/mm/book3s64/radix_tlb.c
> +++ b/arch/powerpc/mm/book3s64/radix_tlb.c
> @@ -1170,16 +1170,14 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
>   				_tlbiel_pid_multicast(mm, pid, RIC_FLUSH_ALL);
>   			}
>   		}
> -	} else {
> +	} else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
>   		bool hflush = false;
>   		unsigned long hstart, hend;
>   
> -		if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> -			hstart = (start + PMD_SIZE - 1) & PMD_MASK;
> -			hend = end & PMD_MASK;
> -			if (hstart < hend)
> -				hflush = true;
> -		}
> +		hstart = (start + PMD_SIZE - 1) & PMD_MASK;
> +		hend = end & PMD_MASK;
> +		if (hstart < hend)
> +			hflush = true;
>   
>   		if (type == FLUSH_TYPE_LOCAL) {
>   			asm volatile("ptesync": : :"memory");
> @@ -1207,6 +1205,25 @@ static inline void __radix__flush_tlb_range(struct mm_struct *mm,
>   				_tlbiel_va_range_multicast(mm,
>   					hstart, hend, pid, PMD_SIZE, MMU_PAGE_2M, flush_pwc);
>   		}
> +	} else {
> +
> +		if (type == FLUSH_TYPE_LOCAL) {
> +			asm volatile("ptesync" : : : "memory");
> +			if (flush_pwc)
> +				/* For PWC, only one flush is needed */
> +				__tlbiel_pid(pid, 0, RIC_FLUSH_PWC);
> +			__tlbiel_va_range(start, end, pid, page_size, mmu_virtual_psize);
> +			ppc_after_tlbiel_barrier();
> +		} else if (cputlb_use_tlbie()) {
> +			asm volatile("ptesync" : : : "memory");
> +			if (flush_pwc)
> +				__tlbie_pid(pid, RIC_FLUSH_PWC);
> +			__tlbie_va_range(start, end, pid, page_size, mmu_virtual_psize);
> +			asm volatile("eieio; tlbsync; ptesync" : : : "memory");
> +		} else {
> +			_tlbiel_va_range_multicast(mm,
> +					start, end, pid, page_size, mmu_virtual_psize, flush_pwc);
> +		}
>   	}
>   out:
>   	preempt_enable();
> 
