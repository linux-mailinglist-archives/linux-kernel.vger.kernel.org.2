Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755693E238D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 08:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbhHFGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 02:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhHFGxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 02:53:37 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAF2C061798
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 23:53:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ggx5B1S6Wz9sCD;
        Fri,  6 Aug 2021 16:53:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1628232798;
        bh=vD1LTdPK6JfRXO2TE9cg4Rh9PKZx4+TBHw0WLGKC9bU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GVGwvFBGLVzVFjPmETJqgZJ/hNeJU5weXVURVKih5fKtMwzCjHMLjXuPm45N12vOp
         Vt6XopcGqXqlT3nEItSo7f5Y3vV5WTJz0POh+T0BOXc7y4DHJwUOBBuhwE+6UAaJWS
         MD/zjJc6lde91EIXiCeaIstPtyrr7kupmStC2oEzbiawq7S6UHRtOX/hbcphSmqTU3
         hSAfl5ju8dTzc/ZoSiAR6ohFFZx+2CDnYOlhavYAwnY3R3A/oIYj5dAsPNpIIT4zgd
         ZYmfx++fkitquwKoVs1KVZYeQXU6OyMWznfHqJN4Ll2SkUbnPBygxyAtgwMom/v0pe
         Mz+ZGp9D9InZg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     sxwjean@me.com, linuxppc-dev@lists.ozlabs.org
Cc:     oleg@redhat.com, benh@kernel.crashing.org, paulus@samba.org,
        ravi.bangoria@linux.ibm.com, christophe.leroy@csgroup.eu,
        npiggin@gmail.com, aneesh.kumar@linux.ibm.com,
        sandipan@linux.ibm.com, efremov@linux.com, peterx@redhat.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: Re: [RFC PATCH 1/4] powerpc: Optimize register usage for esr register
In-Reply-To: <20210726143053.532839-1-sxwjean@me.com>
References: <20210726143053.532839-1-sxwjean@me.com>
Date:   Fri, 06 Aug 2021 16:53:14 +1000
Message-ID: <874kc3njxh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sxwjean@me.com writes:
> From: Xiongwei Song <sxwjean@gmail.com>
>
> Create an anonymous union for dsisr and esr regsiters, we can reference
> esr to get the exception detail when CONFIG_4xx=y or CONFIG_BOOKE=y.
> Otherwise, reference dsisr. This makes code more clear.
>
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>  arch/powerpc/include/asm/ptrace.h          |  5 ++++-
>  arch/powerpc/include/uapi/asm/ptrace.h     |  5 ++++-
>  arch/powerpc/kernel/process.c              |  2 +-
>  arch/powerpc/kernel/ptrace/ptrace.c        |  2 ++
>  arch/powerpc/kernel/traps.c                |  2 +-
>  arch/powerpc/mm/fault.c                    | 16 ++++++++++++++--
>  arch/powerpc/platforms/44x/machine_check.c |  4 ++--
>  arch/powerpc/platforms/4xx/machine_check.c |  2 +-
>  8 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 3e5d470a6155..c252d04b1206 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -44,7 +44,10 @@ struct pt_regs
>  #endif
>  			unsigned long trap;
>  			unsigned long dar;
> -			unsigned long dsisr;
> +			union {
> +				unsigned long dsisr;
> +				unsigned long esr;
> +			};

I don't mind doing that.

>  			unsigned long result;
>  		};
>  	};
> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
> index 7004cfea3f5f..e357288b5f34 100644
> --- a/arch/powerpc/include/uapi/asm/ptrace.h
> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
> @@ -53,7 +53,10 @@ struct pt_regs
>  	/* N.B. for critical exceptions on 4xx, the dar and dsisr
>  	   fields are overloaded to hold srr0 and srr1. */
>  	unsigned long dar;		/* Fault registers */
> -	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
> +	union {
> +		unsigned long dsisr;		/* on Book-S used for DSISR */
> +		unsigned long esr;		/* on 4xx/Book-E used for ESR */
> +	};
>  	unsigned long result;		/* Result of a system call */
>  };

But I'm not sure about the use of anonymous unions in UAPI headers. Old
compilers don't support them, so there's a risk of breakage.

I'd rather we didn't touch the uapi version.


> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 185beb290580..f74af8f9133c 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1499,7 +1499,7 @@ static void __show_regs(struct pt_regs *regs)
>  	    trap == INTERRUPT_DATA_STORAGE ||
>  	    trap == INTERRUPT_ALIGNMENT) {
>  		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> -			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
> +			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->esr);
>  		else
>  			pr_cont("DAR: "REG" DSISR: %08lx ", regs->dar, regs->dsisr);
>  	}
> diff --git a/arch/powerpc/kernel/ptrace/ptrace.c b/arch/powerpc/kernel/ptrace/ptrace.c
> index 0a0a33eb0d28..00789ad2c4a3 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace.c
> @@ -375,6 +375,8 @@ void __init pt_regs_check(void)
>  		     offsetof(struct user_pt_regs, dar));
>  	BUILD_BUG_ON(offsetof(struct pt_regs, dsisr) !=
>  		     offsetof(struct user_pt_regs, dsisr));
> +	BUILD_BUG_ON(offsetof(struct pt_regs, esr) !=
> +		     offsetof(struct user_pt_regs, esr));
>  	BUILD_BUG_ON(offsetof(struct pt_regs, result) !=
>  		     offsetof(struct user_pt_regs, result));
>  
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index dfbce527c98e..2164f5705a0b 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -562,7 +562,7 @@ static inline int check_io_access(struct pt_regs *regs)
>  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>  /* On 4xx, the reason for the machine check or program exception
>     is in the ESR. */
> -#define get_reason(regs)	((regs)->dsisr)
> +#define get_reason(regs)	((regs)->esr)
>  #define REASON_FP		ESR_FP
>  #define REASON_ILLEGAL		(ESR_PIL | ESR_PUO)
>  #define REASON_PRIVILEGED	ESR_PPR
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index a8d0ce85d39a..62953d4e7c93 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -541,7 +541,11 @@ static __always_inline void __do_page_fault(struct pt_regs *regs)
>  {
>  	long err;
>  
> -	err = ___do_page_fault(regs, regs->dar, regs->dsisr);
> +	if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
> +		err = ___do_page_fault(regs, regs->dar, regs->esr);
> +	else
> +		err = ___do_page_fault(regs, regs->dar, regs->dsisr);

As Christophe said, I don't thinks this is an improvement.

It makes the code less readable. If anyone is confused about what is
passed to ___do_page_fault() they can either read the comment above it,
or look at the definition of pt_regs to see that esr and dsisr share
storage.

cheers
