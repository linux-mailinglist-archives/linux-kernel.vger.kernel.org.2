Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F56236834B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 17:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237781AbhDVP2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 11:28:10 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10631 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233106AbhDVP2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 11:28:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FR1WR6Ykrz9v4h8;
        Thu, 22 Apr 2021 17:27:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5X18jCbvHMHQ; Thu, 22 Apr 2021 17:27:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FR1WR5bvkz9v4gH;
        Thu, 22 Apr 2021 17:27:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DCF898B846;
        Thu, 22 Apr 2021 17:27:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5QPcsvrhPnYt; Thu, 22 Apr 2021 17:27:32 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 34D3D8B845;
        Thu, 22 Apr 2021 17:27:32 +0200 (CEST)
Subject: Re: [PATCH 1/2] powerpc: Make the code in __show_regs nice-looking
To:     Xiongwei Song <sxwjean@me.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, 0x7f454c46@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <20210422151022.17868-1-sxwjean@me.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <15aac264-8626-ad15-7301-044c622d7f60@csgroup.eu>
Date:   Thu, 22 Apr 2021 17:27:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210422151022.17868-1-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/04/2021 à 17:10, Xiongwei Song a écrit :
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Create a new function named interrupt_detail_printable to judge which
> interrupts can print esr/dsisr register.

What is the benefit of that function ? It may be interesting if the test was done at several places, 
but as it is done at only one place, I don't thing it is an improvement.

Until know, you new immediately what was the traps that would print it. Now you have to go and look 
into a sub-function.

And the name is not nice either. All other functions testing anything on the trap type are called 
trap_is_something()

Here your function would be better called something like trap_sets_dsisr()

> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   arch/powerpc/kernel/process.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 89e34aa273e2..5c3830837f3a 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1453,9 +1453,23 @@ static void print_msr_bits(unsigned long val)
>   #define REGS_PER_LINE	8
>   #endif
>   
> +static bool interrupt_detail_printable(int trap)
> +{
> +	switch (trap) {
> +	case INTERRUPT_MACHINE_CHECK:
> +	case INTERRUPT_DATA_STORAGE:
> +	case INTERRUPT_ALIGNMENT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +
> +	return false;

That's redundant with the default case inside the switch.

> +}
> +
>   static void __show_regs(struct pt_regs *regs)
>   {
> -	int i, trap;
> +	int i;
>   
>   	printk("NIP:  "REG" LR: "REG" CTR: "REG"\n",
>   	       regs->nip, regs->link, regs->ctr);
> @@ -1464,12 +1478,9 @@ static void __show_regs(struct pt_regs *regs)
>   	printk("MSR:  "REG" ", regs->msr);
>   	print_msr_bits(regs->msr);
>   	pr_cont("  CR: %08lx  XER: %08lx\n", regs->ccr, regs->xer);
> -	trap = TRAP(regs);
>   	if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
>   		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
> -	if (trap == INTERRUPT_MACHINE_CHECK ||
> -	    trap == INTERRUPT_DATA_STORAGE ||
> -	    trap == INTERRUPT_ALIGNMENT) {
> +	if (interrupt_detail_printable(TRAP(regs))) {
>   		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
>   			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
>   		else
> 
