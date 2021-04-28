Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D7A36D3E4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhD1I0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:26:51 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:38707 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhD1I0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:26:49 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 519A91C000E;
        Wed, 28 Apr 2021 08:25:55 +0000 (UTC)
Subject: Re: [PATCH] RISC-V: Always define XIP_FIXUP
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, wangkefeng.wang@huawei.com,
        rppt@kernel.org, vitaly.wool@konsulko.com, greentime.hu@sifive.com,
        0x7f454c46@gmail.com, chenhuang5@huawei.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20210428033415.107756-1-palmer@dabbelt.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <b674bc91-8228-9236-f3ec-8f65bb5620c8@ghiti.fr>
Date:   Wed, 28 Apr 2021 04:25:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428033415.107756-1-palmer@dabbelt.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/27/21 à 11:34 PM, Palmer Dabbelt a écrit :
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> XIP depends on MMU, but XIP_FIXUP is defined throughout the kernel in
> order to avoid excessive ifdefs.  This just makes sure to always define
> XIP_FIXIP, which will fix MMU=n builds.

A small typo here.

> 
> Fixes: 44c922572952 ("RISC-V: enable XIP")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>   arch/riscv/include/asm/pgtable.h | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 2f1384e14e31..fd749351f432 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -73,18 +73,6 @@
>   #endif
>   #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>   
> -#ifdef CONFIG_XIP_KERNEL
> -#define XIP_OFFSET		SZ_8M
> -#define XIP_FIXUP(addr) ({							\
> -	uintptr_t __a = (uintptr_t)(addr);					\
> -	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
> -		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> -		__a;								\
> -	})
> -#else
> -#define XIP_FIXUP(addr)		(addr)
> -#endif /* CONFIG_XIP_KERNEL */
> -
>   #endif
>   
>   #ifndef __ASSEMBLY__
> @@ -101,6 +89,18 @@
>   #include <asm/pgtable-32.h>
>   #endif /* CONFIG_64BIT */
>   
> +#ifdef CONFIG_XIP_KERNEL
> +#define XIP_OFFSET		SZ_8M


XIP_OFFSET is used in head.S and then this breaks XIP_KERNEL. XIP_OFFSET 
must live outside the ifndef __ASSEMBLY__.


> +#define XIP_FIXUP(addr) ({							\
> +	uintptr_t __a = (uintptr_t)(addr);					\
> +	(__a >= CONFIG_XIP_PHYS_ADDR && __a < CONFIG_XIP_PHYS_ADDR + SZ_16M) ?	\
> +		__a - CONFIG_XIP_PHYS_ADDR + CONFIG_PHYS_RAM_BASE - XIP_OFFSET :\
> +		__a;								\
> +	})
> +#else
> +#define XIP_FIXUP(addr)		(addr)
> +#endif /* CONFIG_XIP_KERNEL */
> +
>   #ifdef CONFIG_MMU
>   /* Number of entries in the page global directory */
>   #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
> 

Thank you for doing that!

Alex
