Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B618C3534EE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 19:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbhDCRcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 13:32:16 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13271 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhDCRcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 13:32:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FCPB205JNz9v2DV;
        Sat,  3 Apr 2021 19:32:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OlKSWiwht6s7; Sat,  3 Apr 2021 19:32:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FCPB16NhVz9v2DT;
        Sat,  3 Apr 2021 19:32:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FB008B76D;
        Sat,  3 Apr 2021 19:32:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id exrl2fk04JRp; Sat,  3 Apr 2021 19:32:11 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A4BD8B76A;
        Sat,  3 Apr 2021 19:32:11 +0200 (CEST)
Subject: Re: [PATCH 08/10] powerpc/signal32: Convert restore_[tm]_user_regs()
 to user access block
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <cover.1616151715.git.christophe.leroy@csgroup.eu>
 <181adf15a6f644efcd1aeafb355f3578ff1b6bc5.1616151715.git.christophe.leroy@csgroup.eu>
Message-ID: <7460dcad-a1d1-375d-a9a5-ba5f1d7a41a7@csgroup.eu>
Date:   Sat, 3 Apr 2021 19:32:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <181adf15a6f644efcd1aeafb355f3578ff1b6bc5.1616151715.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/03/2021 à 12:06, Christophe Leroy a écrit :
> Convert restore_user_regs() and restore_tm_user_regs()
> to use user_access_read_begin/end blocks.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/include/asm/ptrace.h |   2 +-
>   arch/powerpc/kernel/signal_32.c   | 141 +++++++++++++++---------------
>   2 files changed, 72 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 088c83853026..0b1a6f53e553 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -567,19 +569,22 @@ static long restore_user_regs(struct pt_regs *regs,
>   	regs->msr &= ~MSR_SPE;
>   	if (msr & MSR_SPE) {
>   		/* restore spe registers from the stack */
> -		if (__copy_from_user(current->thread.evr, &sr->mc_vregs,
> -				     ELF_NEVRREG * sizeof(u32)))
> -			return 1;
> +		unsafe_copy_from_user(current->thread.evr, &sr->mc_vregs,
> +				      ELF_NEVRREG * sizeof(u32));

Missing the , failed); here at the end of the line.

Michael can you add it ?

Thanks
Christophe
