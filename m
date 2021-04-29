Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D570736EB77
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237292AbhD2Nn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:43:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54285 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhD2Nn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:43:57 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 934956000F;
        Thu, 29 Apr 2021 13:43:06 +0000 (UTC)
Subject: Re: [PATCH v2] RISC-V: Always define XIP_FIXUP
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>, akpm@linux-foundation.org,
        rppt@kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        wangkefeng.wang@huawei.com, vitaly.wool@konsulko.com,
        greentime.hu@sifive.com, 0x7f454c46@gmail.com,
        chenhuang5@huawei.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>,
        Guenter Roeck <linux@roeck-us.net>
References: <20210428214512.551153-1-palmer@dabbelt.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <fd30ede9-b105-e9e2-c9e8-f2d88dc2a653@ghiti.fr>
Date:   Thu, 29 Apr 2021 09:43:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428214512.551153-1-palmer@dabbelt.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/28/21 à 5:45 PM, Palmer Dabbelt a écrit :
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> XIP depends on MMU, but XIP_FIXUP is used throughout the kernel in
> order to avoid excessive ifdefs.  This just makes sure to always define
> XIP_FIXUP, which will fix MMU=n builds.  XIP_OFFSET is used by assembly
> but XIP_FIXUP is C-only, so they're split.
> 
> Fixes: 44c922572952 ("RISC-V: enable XIP")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
> Changes since v1:
> 
> * Clean up the commit text.
> * Define XIP_OFFSET for assembly.
> ---
>   arch/riscv/include/asm/pgtable.h | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 2f1384e14e31..9469f464e71a 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -73,18 +73,10 @@
>   #endif
>   #define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
>   
> +#endif
> +
>   #ifdef CONFIG_XIP_KERNEL
>   #define XIP_OFFSET		SZ_8M
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
> @@ -101,6 +93,17 @@
>   #include <asm/pgtable-32.h>
>   #endif /* CONFIG_64BIT */
>   
> +#ifdef CONFIG_XIP_KERNEL
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

XIP_KERNEL works now and !MMU compiles so you can add:

Tested-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks!
