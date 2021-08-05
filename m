Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6D03E11F8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbhHEKGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:06:53 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:39505 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240012AbhHEKGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:06:33 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GgPQJ2Dj8z9sWd;
        Thu,  5 Aug 2021 12:06:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8oyvXudL7BcU; Thu,  5 Aug 2021 12:06:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GgPQJ0jp3z9sWW;
        Thu,  5 Aug 2021 12:06:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E80428B7BF;
        Thu,  5 Aug 2021 12:06:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3NbVlcRkN_qF; Thu,  5 Aug 2021 12:06:15 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 01A878B7BD;
        Thu,  5 Aug 2021 12:06:14 +0200 (CEST)
Subject: Re: [RFC PATCH 1/4] powerpc: Optimize register usage for esr register
To:     sxwjean@me.com, linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, ravi.bangoria@linux.ibm.com, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, sandipan@linux.ibm.com,
        efremov@linux.com, peterx@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20210726143053.532839-1-sxwjean@me.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5e2336aa-90bf-b820-b5e4-e9a63088930f@csgroup.eu>
Date:   Thu, 5 Aug 2021 12:06:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726143053.532839-1-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/07/2021 à 16:30, sxwjean@me.com a écrit :
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Create an anonymous union for dsisr and esr regsiters, we can reference
> esr to get the exception detail when CONFIG_4xx=y or CONFIG_BOOKE=y.
> Otherwise, reference dsisr. This makes code more clear.

I'm not sure it is worth doing that.

What is the point in doing the following when you know that regs->esr and regs->dsisr are exactly 
the same:

 > -	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
 > +	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
 > +		err = ___do_page_fault(regs, regs->dar, regs->esr);
 > +	else
 > +		err = ___do_page_fault(regs, regs->dar, regs->dsisr);
 > +

Or even

 > -	int is_write = page_fault_is_write(regs->dsisr);
 > +	unsigned long err_reg;
 > +	int is_write;
 > +
 > +	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
 > +		err_reg = regs->esr;
 > +	else
 > +		err_reg = regs->dsisr;
 > +
 > +	is_write = page_fault_is_write(err_reg);


Artificially growing the code for that makes no sense to me.


To avoid anbiguity, maybe the best would be to rename regs->dsisr to something like regs->sr , so 
that we know it represents the status register, which is DSISR or ESR depending on the platform.


> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   arch/powerpc/include/asm/ptrace.h          |  5 ++++-
>   arch/powerpc/include/uapi/asm/ptrace.h     |  5 ++++-
>   arch/powerpc/kernel/process.c              |  2 +-
>   arch/powerpc/kernel/ptrace/ptrace.c        |  2 ++
>   arch/powerpc/kernel/traps.c                |  2 +-
>   arch/powerpc/mm/fault.c                    | 16 ++++++++++++++--
>   arch/powerpc/platforms/44x/machine_check.c |  4 ++--
>   arch/powerpc/platforms/4xx/machine_check.c |  2 +-
>   8 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 3e5d470a6155..c252d04b1206 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -44,7 +44,10 @@ struct pt_regs
>   #endif
>   			unsigned long trap;
>   			unsigned long dar;
> -			unsigned long dsisr;
> +			union {
> +				unsigned long dsisr;
> +				unsigned long esr;
> +			};
>   			unsigned long result;
>   		};
>   	};
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 7004cfea3f5f..e357288b5f34 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -53,7 +53,10 @@ struct pt_regs
>   	/* N.B. for critical exceptions on 4xx, the dar and dsisr
>   	   fields are overloaded to hold srr0 and srr1. */
>   	unsigned long dar;		/* Fault registers */
> -	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
> +	union {
> +		unsigned long dsisr;		/* on Book-S used for DSISR */
> +		unsigned long esr;		/* on 4xx/Book-E used for ESR */
> +	};
>   	unsigned long result;		/* Result of a system call */
>   };
>   
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 185beb290580..f74af8f9133c 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
>   	    trap == INTERRUPT_DATA_STORAGE ||
>   	    trap == INTERRUPT_ALIGNMENT) {
>   		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> -			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
> +			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->esr);
>   		else
>   			pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
>   	}
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index 0a0a33eb0d28..00789ad2c4a3 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -375,6 +375,8 @@ void __init pt_regs_check(void)
>   		     offsetof(struct user_pt_regs, dar));
>   	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
>   		     offsetof(struct user_pt_regs, dsisr));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=
> +		     offsetof(struct user_pt_regs, esr));
>   	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
>   		     offsetof(struct user_pt_regs, result));
>   
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index dfbce527c98e..2164f5705a0b 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -562,7 +562,7 @@ static inline int check_io_access(struct pt_regs *regs)
>   #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>   /* On 4xx, the reason for the machine check or program exception
>      is in the ESR. */
> -#define get_reason(regs)	((regs)->dsisr)
> +#define get_reason(regs)	((regs)->esr)
>   #define REASON_FP		ESR_FP
>   #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
>   #define REASON_PRIVILEGED	ESR_PPR
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a8d0ce85d39a..62953d4e7c93 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -541,7 +541,11 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
>   {
>   	long err;
>   
> -	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
> +	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> +		err = ___do_page_fault(regs, regs->dar, regs->esr);
> +	else
> +		err = ___do_page_fault(regs, regs->dar, regs->dsisr);
> +
>   	if (unlikely(err))
>   		bad_page_fault(regs, err);
>   }
> @@ -567,7 +571,15 @@ NOKPROBE_SYMBOL(hash__do_page_fault);
>    */
>   static void __bad_page_fault(struct pt_regs *regs, int sig)
>   {
> -	int is_write = page_fault_is_write(regs->dsisr);
> +	unsigned long err_reg;
> +	int is_write;
> +
> +	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> +		err_reg = regs->esr;
> +	else
> +		err_reg = regs->dsisr;
> +
> +	is_write = page_fault_is_write(err_reg);
>   
>   	/* kernel has accessed a bad area */
>   
> diff --git a/arch/powerpc/platforms/44x/machine_check.c b/arch/powerpc/platforms/44x/machine_check.c
> index a5c898bb9bab..5d19daacd78a 100644
> --- a/arch/powerpc/platforms/44x/machine_check.c
> +++ b/arch/powerpc/platforms/44x/machine_check.c
> @@ -11,7 +11,7 @@
>   
>   int machine_check_440A(struct pt_regs *regs)
>   {
> -	unsigned long reason = regs->dsisr;
> +	unsigned long reason = regs->esr;
>   
>   	printk("Machine check in kernel mode.\n");
>   	if (reason & ESR_IMCP){
> @@ -48,7 +48,7 @@ int machine_check_440A(struct pt_regs *regs)
>   #ifdef CONFIG_PPC_47x
>   int machine_check_47x(struct pt_regs *regs)
>   {
> -	unsigned long reason = regs->dsisr;
> +	unsigned long reason = regs->esr;
>   	u32 mcsr;
>   
>   	printk(KERN_ERR "Machine check in kernel mode.\n");
> diff --git a/arch/powerpc/platforms/4xx/machine_check.c b/arch/powerpc/platforms/4xx/machine_check.c
> index a71c29892a91..a905da1d6f41 100644
> --- a/arch/powerpc/platforms/4xx/machine_check.c
> +++ b/arch/powerpc/platforms/4xx/machine_check.c
> @@ -10,7 +10,7 @@
>   
>   int machine_check_4xx(struct pt_regs *regs)
>   {
> -	unsigned long reason = regs->dsisr;
> +	unsigned long reason = regs->esr;
>   
>   	if (reason & ESR_IMCP) {
>   		printk("Instruction");
> 
