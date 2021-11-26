Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E34A45E9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346224AbhKZIyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:54:20 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:41447 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359747AbhKZIwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:52:18 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J0pM146QPz9sSM;
        Fri, 26 Nov 2021 09:49:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c2ITOMNwlhy3; Fri, 26 Nov 2021 09:49:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J0pM13DYBz9sSH;
        Fri, 26 Nov 2021 09:49:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F77F8B77D;
        Fri, 26 Nov 2021 09:49:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LxK8mRy4-wOq; Fri, 26 Nov 2021 09:49:01 +0100 (CET)
Received: from [192.168.204.6] (unknown [192.168.204.6])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AB2D38B763;
        Fri, 26 Nov 2021 09:49:00 +0100 (CET)
Message-ID: <5a995d46-5292-b6e1-f88e-81d8cbc40b83@csgroup.eu>
Date:   Fri, 26 Nov 2021 09:49:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] powerpc/code-patching: Relax verification of patchability
Content-Language: fr-FR
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nicholas Piggin <npiggin@gmail.com>
References: <68d7d57675e0963fe5e2c4b84b0cb2390c78638c.1637912333.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <68d7d57675e0963fe5e2c4b84b0cb2390c78638c.1637912333.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/11/2021 à 08:39, Christophe Leroy a écrit :
> Commit 8b8a8f0ab3f5 ("powerpc/code-patching: Improve verification of
> patchability") introduced a stricter verification of the patched
> area by checking it is proper kernel text.
> 
> But as least two usages of patch_instruction() fall outside:
> - Code patching selftests, which use stack and vmalloc space.
> - Ftrace
> 
> So for the time being, partially revert commit 8b8a8f0ab3f5 and add
> a onetime warning:
> 
>    Running code patching self-tests ...
>    patch_instruction() called on invalid text address 0xe1011e58 from test_code_patching+0x34/0xd6c
> 
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Fixes: 8b8a8f0ab3f5 ("powerpc/code-patching: Improve verification of patchability")
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/lib/code-patching.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 1dd636a85cc1..c87eea773930 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -190,9 +190,13 @@ static int do_patch_instruction(u32 *addr, struct ppc_inst instr)
>   int patch_instruction(u32 *addr, struct ppc_inst instr)
>   {
>   	/* Make sure we aren't patching a freed init section */
> -	if (!kernel_text_address((unsigned long)addr))
> +	if (system_state >= SYSTEM_FREEING_INITMEM && init_section_contains(addr, 4))
>   		return 0;
>   
> +	if (!kernel_text_address((unsigned long)addr))
> +		pr_warn_once("%s() called on invalid text address 0x%p from %pS\n",
> +			     __func__, addr, __builtin_return_address(0));
> +

May it be better to use pr_warn_ratelimited() instead in order to catch 
more than the first occurence ?

>   	return do_patch_instruction(addr, instr);
>   }
>   NOKPROBE_SYMBOL(patch_instruction);
> 
