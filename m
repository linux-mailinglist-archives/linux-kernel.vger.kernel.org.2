Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E3C34BCD7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhC1PWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 11:22:36 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27872 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhC1PWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:22:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F7fZl0xk1z9tyjq;
        Sun, 28 Mar 2021 17:22:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id qIqHHUlgVuux; Sun, 28 Mar 2021 17:22:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F7fZk73KDz9tyjp;
        Sun, 28 Mar 2021 17:22:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9618F8B782;
        Sun, 28 Mar 2021 17:22:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gWmuvRRHcR5U; Sun, 28 Mar 2021 17:22:07 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 30A088B75B;
        Sun, 28 Mar 2021 17:22:06 +0200 (CEST)
Subject: Re: [PATCH] powerpc/process: Enhance readability for trap types.
To:     Xiongwei Song <sxwjean@me.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        ravi.bangoria@linux.ibm.com, mikey@neuling.org,
        aneesh.kumar@linux.ibm.com, haren@linux.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <20210328143545.24324-1-sxwjean@me.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <8de71b45-efea-b493-ee90-b89062e8e30f@csgroup.eu>
Date:   Sun, 28 Mar 2021 17:21:58 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210328143545.24324-1-sxwjean@me.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 28/03/2021 à 16:35, Xiongwei Song a écrit :
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> Define macros to enhance the code readability on ppc trap types.

Good idea

> 
> Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> ---
>   arch/powerpc/kernel/process.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 3231c2df9e26..3bbd3cf353a7 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1451,6 +1451,10 @@ static void print_msr_bits(unsigned long val)
>   #define LAST_VOLATILE	12
>   #endif
>   
> +#define TRAP_MC  0x200 /* Machine Check */

I think usually we use MCE, so TRAP_MCE would be better

> +#define TRAP_DSI 0x300 /* DSI exception */
> +#define TRAP_AM  0x600 /* Alignment exception */

Don't know what AM means. TRAP_ALIGN would be more explicit.

> +

The defines should go in a header file, for instance asm/ptrace.h in order to be re-used in other files.

You should do more. You can find other places to improve with:

git grep "trap ==" arch/powerpc/
git grep "TRAP(regs) ==" arch/powerpc/

>   static void __show_regs(struct pt_regs *regs)
>   {
>   	int i, trap;
> @@ -1465,7 +1469,7 @@ static void __show_regs(struct pt_regs *regs)
>   	trap = TRAP(regs);
>   	if (!trap_is_syscall(regs) && cpu_has_feature(CPU_FTR_CFAR))
>   		pr_cont("CFAR: "REG" ", regs->orig_gpr3);
> -	if (trap == 0x200 || trap == 0x300 || trap == 0x600) {
> +	if (trap == TRAP_MC || trap == TRAP_DSI || trap == TRAP_AM) {
>   		if (IS_ENABLED(CONFIG_4xx) || IS_ENABLED(CONFIG_BOOKE))
>   			pr_cont("DEAR: "REG" ESR: "REG" ", regs->dar, regs->dsisr);
>   		else
> 
