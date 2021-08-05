Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86BF3E1228
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhHEKJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:09:38 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:53337 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240055AbhHEKJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:09:36 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4GgPTs0GH3z9sWL;
        Thu,  5 Aug 2021 12:09:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hrCC9IOrwgJL; Thu,  5 Aug 2021 12:09:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4GgPTq5Q1rz9sWH;
        Thu,  5 Aug 2021 12:09:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 94D538B7BF;
        Thu,  5 Aug 2021 12:09:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1RA1AC0yMRHI; Thu,  5 Aug 2021 12:09:19 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B02EA8B7BD;
        Thu,  5 Aug 2021 12:09:18 +0200 (CEST)
Subject: Re: [RFC PATCH 3/4] powerpc: Optimize register usage for dear
 register
To:     sxwjean@me.com, linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, ravi.bangoria@linux.ibm.com, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, sandipan@linux.ibm.com,
        efremov@linux.com, peterx@redhat.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
References: <20210726143053.532839-1-sxwjean@me.com>
 <20210726143053.532839-3-sxwjean@me.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <56d9e3ce-f303-fd41-bd16-5655d9dc5e52@csgroup.eu>
Date:   Thu, 5 Aug 2021 12:09:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726143053.532839-3-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/07/2021 à 16:30, sxwjean@me.com a écrit :
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Create an anonymous union for dar and dear regsiters, we can reference
> dear to get the effective address when CONFIG_4xx=y or CONFIG_BOOKE=y.
> Otherwise, reference dar. This makes code more clear.

Same comment here as for patch 1.


> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   arch/powerpc/include/asm/ptrace.h      | 5 ++++-
>   arch/powerpc/include/uapi/asm/ptrace.h | 5 ++++-
>   arch/powerpc/kernel/process.c          | 2 +-
>   arch/powerpc/kernel/ptrace/ptrace.c    | 2 ++
>   arch/powerpc/kernel/traps.c            | 5 ++++-
>   arch/powerpc/mm/fault.c                | 2 +-
>   6 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index c252d04b1206..fa725e3238c2 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -43,7 +43,10 @@ struct pt_regs
>   			unsigned long mq;
>   #endif
>   			unsigned long trap;
> -			unsigned long dar;
> +			union {
> +				unsigned long dar;
> +				unsigned long dear;
> +			};
>   			union {
>   				unsigned long dsisr;
>   				unsigned long esr;
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index e357288b5f34..9ae150fb4c4b 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -52,7 +52,10 @@ struct pt_regs
>   	unsigned long trap;		/* Reason for being here */
>   	/* N.B. for critical exceptions on 4xx, the dar and dsisr
>   	   fields are overloaded to hold srr0 and srr1. */
> -	unsigned long dar;		/* Fault registers */
> +	union {
> +		unsigned long dar;		/* Fault registers */
> +		unsigned long dear;
> +	};
>   	union {
>   		unsigned long dsisr;		/* on Book-S used for DSISR */
>   		unsigned long esr;		/* on 4xx/Book-E used for ESR */
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index f74af8f9133c..50436b52c213 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
>   	    trap == INTERRUPT_DATA_STORAGE ||
>   	    trap == INTERRUPT_ALIGNMENT) {
>   		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> -			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->esr);
> +			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dear, regs->esr);
>   		else
>   			pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
>   	}
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index 00789ad2c4a3..969dca8b0718 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -373,6 +373,8 @@ void __init pt_regs_check(void)
>   		     offsetof(struct user_pt_regs, trap));
>   	BUILD_BUG_ON(offsetof(struct pt_regs, dar) !=
>   		     offsetof(struct user_pt_regs, dar));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, dear) !=
> +		     offsetof(struct user_pt_regs, dear));
>   	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
>   		     offsetof(struct user_pt_regs, dsisr));
>   	BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 2164f5705a0b..0796630d3d23 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1609,7 +1609,10 @@ DEFINE_INTERRUPT_HANDLER(alignment_exception)
>   	}
>   bad:
>   	if (user_mode(regs))
> -		_exception(sig, regs, code, regs->dar);
> +		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> +			_exception(sig, regs, code, regs->dear);
> +		else
> +			_exception(sig, regs, code, regs->dar);
>   	else
>   		bad_page_fault(regs, sig);
>   }
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 62953d4e7c93..3db6b39a1178 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -542,7 +542,7 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
>   	long err;
>   
>   	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> -		err = ___do_page_fault(regs, regs->dar, regs->esr);
> +		err = ___do_page_fault(regs, regs->dear, regs->esr);
>   	else
>   		err = ___do_page_fault(regs, regs->dar, regs->dsisr);
>   
> 
