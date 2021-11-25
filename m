Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D59445D865
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354743AbhKYKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:47:50 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:54981 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236759AbhKYKpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:45:49 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J0DwY21xqz9sSF;
        Thu, 25 Nov 2021 11:42:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nw29zLpg9ntr; Thu, 25 Nov 2021 11:42:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J0DwY0pwpz9sRt;
        Thu, 25 Nov 2021 11:42:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F23758B77A;
        Thu, 25 Nov 2021 11:42:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id glwMjUd7MNY6; Thu, 25 Nov 2021 11:42:36 +0100 (CET)
Received: from [192.168.203.227] (unknown [192.168.203.227])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 485A28B763;
        Thu, 25 Nov 2021 11:42:36 +0100 (CET)
Message-ID: <3f3578d4-168e-54ef-a3a7-cb7ec2aed43c@csgroup.eu>
Date:   Thu, 25 Nov 2021 11:42:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 9/9] powerpc: Simplify and move arch_randomize_brk()
Content-Language: fr-FR
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, alex@ghiti.fr
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
References: <cover.1637828367.git.christophe.leroy@csgroup.eu>
 <4c5a2b18774552c2226573f7069ffeee71ad77cb.1637828367.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <4c5a2b18774552c2226573f7069ffeee71ad77cb.1637828367.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 25/11/2021 à 09:23, Christophe Leroy a écrit :
> arch_randomize_brk() is only needed for hash on book3s/64, for other
> platforms the one provided by the default mmap layout is good enough.
> 
> Move it to hash_utils.c and use randomize_page() like the generic one.
> 
> And properly opt out the radix case instead of making an assumption
> on mmu_highuser_ssize.
> 
> Also change to a 32M range like most other architectures instead of 8M.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: New
> ---
>   arch/powerpc/kernel/process.c         | 40 ---------------------------
>   arch/powerpc/mm/book3s64/hash_utils.c | 18 ++++++++++++
>   include/linux/sizes.h                 |  2 ++
>   3 files changed, 20 insertions(+), 40 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 406d7ee9e322..f1f2f17543d6 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -2274,43 +2274,3 @@ unsigned long arch_align_stack(unsigned long sp)
>   		sp -= get_random_int() & ~PAGE_MASK;
>   	return sp & ~0xf;
>   }
> -
> -static inline unsigned long brk_rnd(void)
> -{
> -        unsigned long rnd = 0;
> -
> -	/* 8MB for 32bit, 1GB for 64bit */
> -	if (is_32bit_task())
> -		rnd = (get_random_long() % (1UL<<(23-PAGE_SHIFT)));
> -	else
> -		rnd = (get_random_long() % (1UL<<(30-PAGE_SHIFT)));
> -
> -	return rnd << PAGE_SHIFT;
> -}
> -
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -	unsigned long base = mm->brk;
> -	unsigned long ret;
> -
> -#ifdef CONFIG_PPC_BOOK3S_64
> -	/*
> -	 * If we are using 1TB segments and we are allowed to randomise
> -	 * the heap, we can put it above 1TB so it is backed by a 1TB
> -	 * segment. Otherwise the heap will be in the bottom 1TB
> -	 * which always uses 256MB segments and this may result in a
> -	 * performance penalty. We don't need to worry about radix. For
> -	 * radix, mmu_highuser_ssize remains unchanged from 256MB.
> -	 */
> -	if (!is_32bit_task() && (mmu_highuser_ssize == MMU_SEGSIZE_1T))
> -		base = max_t(unsigned long, mm->brk, 1UL << SID_SHIFT_1T);
> -#endif
> -
> -	ret = PAGE_ALIGN(base + brk_rnd());
> -
> -	if (ret < mm->brk)
> -		return mm->brk;
> -
> -	return ret;
> -}
> -
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 1d09d4aeddbf..3521fad6a479 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -37,6 +37,7 @@
>   #include <linux/cpu.h>
>   #include <linux/pgtable.h>
>   #include <linux/debugfs.h>
> +#include <linux/random.h>

Also need <linux/elf-randomize.h> to get the declaration of 
arch_randomize_brk() and make sparse happy :)

Michael can you add it if you apply this version ?

Thanks

>   
>   #include <asm/interrupt.h>
>   #include <asm/processor.h>
> @@ -2072,3 +2073,20 @@ void __init print_system_hash_info(void)
>   	if (htab_hash_mask)
>   		pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
>   }
> +
> +unsigned long arch_randomize_brk(struct mm_struct *mm)
> +{
> +	/*
> +	 * If we are using 1TB segments and we are allowed to randomise
> +	 * the heap, we can put it above 1TB so it is backed by a 1TB
> +	 * segment. Otherwise the heap will be in the bottom 1TB
> +	 * which always uses 256MB segments and this may result in a
> +	 * performance penalty.
> +	 */
> +	if (is_32bit_task())
> +		return randomize_page(mm->brk, SZ_32M);
> +	else if (!radix_enabled() && mmu_highuser_ssize == MMU_SEGSIZE_1T)
> +		return randomize_page(max_t(unsigned long, mm->brk, SZ_1T), SZ_1G);
> +	else
> +		return randomize_page(mm->brk, SZ_1G);
> +}
> diff --git a/include/linux/sizes.h b/include/linux/sizes.h
> index 1ac79bcee2bb..84aa448d8bb3 100644
> --- a/include/linux/sizes.h
> +++ b/include/linux/sizes.h
> @@ -47,6 +47,8 @@
>   #define SZ_8G				_AC(0x200000000, ULL)
>   #define SZ_16G				_AC(0x400000000, ULL)
>   #define SZ_32G				_AC(0x800000000, ULL)
> +
> +#define SZ_1T				_AC(0x10000000000, ULL)
>   #define SZ_64T				_AC(0x400000000000, ULL)
>   
>   #endif /* __LINUX_SIZES_H__ */
> 
