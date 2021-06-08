Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8837039EDDD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 06:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhFHE5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 00:57:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59892 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhFHE5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 00:57:36 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FzdGk0tclzBDHZ;
        Tue,  8 Jun 2021 06:55:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OXJV5l2ukwIg; Tue,  8 Jun 2021 06:55:42 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FzdGj61yXzBDHG;
        Tue,  8 Jun 2021 06:55:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C59B88B7A8;
        Tue,  8 Jun 2021 06:55:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 46y0R86zWyBd; Tue,  8 Jun 2021 06:55:41 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4924B8B767;
        Tue,  8 Jun 2021 06:55:41 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Fix kernel-jump address for ppc64 wrapper boot
To:     He Ying <heying24@huawei.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, nathan@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210604092228.199588-1-heying24@huawei.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <c80f69d0-44b0-24a6-ce4f-ed5a40514597@csgroup.eu>
Date:   Tue, 8 Jun 2021 06:55:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210604092228.199588-1-heying24@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 04/06/2021 à 11:22, He Ying a écrit :
>  From "64-bit PowerPC ELF Application Binary Interface Supplement 1.9",
> we know that the value of a function pointer in a language like C is
> the address of the function descriptor and the first doubleword
> of the function descriptor contains the address of the entry point
> of the function.
> 
> So, when we want to jump to an address (e.g. addr) to execute for
> PPC-elf64abi, we should assign the address of addr *NOT* addr itself
> to the function pointer or system will jump to the wrong address.
> 
> Link: https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.html#FUNC-DES
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>   arch/powerpc/boot/main.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/arch/powerpc/boot/main.c b/arch/powerpc/boot/main.c
> index cae31a6e8f02..50fd7f11b642 100644
> --- a/arch/powerpc/boot/main.c
> +++ b/arch/powerpc/boot/main.c
> @@ -268,7 +268,16 @@ void start(void)
>   	if (console_ops.close)
>   		console_ops.close();
>   
> +#ifdef CONFIG_PPC64_BOOT_WRAPPER

This kind of need doesn't desserve a #ifdef, see 
https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

You can do:


	kentry = (kernel_entry_t)(IS_ENABLED(CONFIG_PPC64_BOOT_WRAPPER) ? &vmlinux.addr : vmlinux.addr);


Or, if you prefer something less compact:


	if (IS_ENABLED(CONFIG_PPC64_BOOT_WRAPPER))
		kentry = (kernel_entry_t) &vmlinux.addr;
	else
		kentry = (kernel_entry_t) vmlinux.addr;


> +	/*
> +	 * For PPC-elf64abi, the value of a function pointer is the address
> +	 * of the function descriptor. And the first doubleword of a function
> +	 * descriptor contains the address of the entry point of the function.
> +	 */
> +	kentry = (kernel_entry_t) &vmlinux.addr;
> +#else
>   	kentry = (kernel_entry_t) vmlinux.addr;
> +#endif
>   	if (ft_addr) {
>   		if(platform_ops.kentry)
>   			platform_ops.kentry(ft_addr, vmlinux.addr);
> 
