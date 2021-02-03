Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2F30DA2B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbhBCMuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:50:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:3947 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhBCMpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:45:54 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DW1bx1lvkz9txxD;
        Wed,  3 Feb 2021 13:45:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HjMAXj_hX0ua; Wed,  3 Feb 2021 13:45:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DW1bx0MsNz9txxB;
        Wed,  3 Feb 2021 13:45:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C76B8B7E6;
        Wed,  3 Feb 2021 13:45:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NgsdGv0kVo9P; Wed,  3 Feb 2021 13:45:02 +0100 (CET)
Received: from [172.25.230.103] (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E2FC8B7E5;
        Wed,  3 Feb 2021 13:45:02 +0100 (CET)
Subject: Re: [PATCH v10 6/6] powerpc: Book3S 64-bit outline-only KASAN support
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        kasan-dev@googlegroups.com, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
References: <20210203115946.663273-1-dja@axtens.net>
 <20210203115946.663273-7-dja@axtens.net>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4b790789-052f-76de-a289-726517026efd@csgroup.eu>
Date:   Wed, 3 Feb 2021 13:45:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203115946.663273-7-dja@axtens.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 03/02/2021 à 12:59, Daniel Axtens a écrit :
> Implement a limited form of KASAN for Book3S 64-bit machines running under
> the Radix MMU, supporting only outline mode.
> 

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index a66f435dabbf..9a6fd603f0e7 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -2157,8 +2157,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack,
>   			break;
>   
>   		stack = (unsigned long *) sp;
> -		newsp = stack[0];
> -		ip = stack[STACK_FRAME_LR_SAVE];
> +		newsp = READ_ONCE_NOCHECK(stack[0]);
> +		ip = READ_ONCE_NOCHECK(stack[STACK_FRAME_LR_SAVE]);
>   		if (!firstframe || ip != lr) {
>   			printk("%s["REG"] ["REG"] %pS",
>   				loglvl, sp, ip, (void *)ip);
> @@ -2176,17 +2176,19 @@ void show_stack(struct task_struct *tsk, unsigned long *stack,
>   		 * See if this is an exception frame.
>   		 * We look for the "regshere" marker in the current frame.
>   		 */
> -		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE)
> -		    && stack[STACK_FRAME_MARKER] == STACK_FRAME_REGS_MARKER) {
> +		if (validate_sp(sp, tsk, STACK_INT_FRAME_SIZE) &&
> +		    (READ_ONCE_NOCHECK(stack[STACK_FRAME_MARKER]) ==
> +		     STACK_FRAME_REGS_MARKER)) {
>   			struct pt_regs *regs = (struct pt_regs *)
>   				(sp + STACK_FRAME_OVERHEAD);
>   
> -			lr = regs->link;
> +			lr = READ_ONCE_NOCHECK(regs->link);
>   			printk("%s--- interrupt: %lx at %pS\n",
> -			       loglvl, regs->trap, (void *)regs->nip);
> +			       loglvl, READ_ONCE_NOCHECK(regs->trap),
> +			       (void *)READ_ONCE_NOCHECK(regs->nip));
>   			__show_regs(regs);
>   			printk("%s--- interrupt: %lx\n",
> -			       loglvl, regs->trap);
> +			       loglvl, READ_ONCE_NOCHECK(regs->trap));
>   
>   			firstframe = 1;
>   		}


The above changes look like a bug fix not directly related to KASAN. Should be split out in another 
patch I think.

Christophe
