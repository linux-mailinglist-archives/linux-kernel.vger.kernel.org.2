Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990F1370D4E
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbhEBOKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 10:10:23 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37723 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbhEBOHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 10:07:25 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C457D20002;
        Sun,  2 May 2021 14:06:29 +0000 (UTC)
Subject: Re: [PATCH] riscv: Consistify
 protect_kernel_linear_mapping_text_rodata() use
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <b89a090317cf26bbe1caaa3cfa513a789ece1b19.1619708711.git.geert+renesas@glider.be>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <288c578a-d680-e2e8-33a1-004e11a4f6f0@ghiti.fr>
Date:   Sun, 2 May 2021 10:06:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <b89a090317cf26bbe1caaa3cfa513a789ece1b19.1619708711.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 4/29/21 à 11:10 AM, Geert Uytterhoeven a écrit :
> The various uses of protect_kernel_linear_mapping_text_rodata() are
> not consistent:
>    - Its definition depends on "64BIT && !XIP_KERNEL",
>    - Its forward declaration depends on MMU,
>    - Its single caller depends on "STRICT_KERNEL_RWX && 64BIT && MMU &&
>      !XIP_KERNEL".
> 
> Fix this by settling on the dependencies of the caller, which can be
> simplified as STRICT_KERNEL_RWX depends on "MMU && !XIP_KERNEL".
> Provide a dummy definition, as the caller is protected by
> "IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)" instead of "#ifdef
> CONFIG_STRICT_KERNEL_RWX".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Only tested on K210 (SiPeed MAIX BiT).
> ---
>   arch/riscv/include/asm/set_memory.h | 7 ++++++-
>   arch/riscv/kernel/setup.c           | 2 --
>   arch/riscv/mm/init.c                | 2 +-
>   3 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index a9c56776fa0e74d6..086f757e8ba3cc69 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -17,7 +17,6 @@ int set_memory_x(unsigned long addr, int numpages);
>   int set_memory_nx(unsigned long addr, int numpages);
>   int set_memory_rw_nx(unsigned long addr, int numpages);
>   void protect_kernel_text_data(void);
> -void protect_kernel_linear_mapping_text_rodata(void);
>   #else
>   static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
>   static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> @@ -27,6 +26,12 @@ static inline void protect_kernel_text_data(void) {}
>   static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
>   #endif
>   
> +#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> +void protect_kernel_linear_mapping_text_rodata(void);
> +#else
> +static inline void protect_kernel_linear_mapping_text_rodata(void) {}
> +#endif
> +
>   int set_direct_map_invalid_noflush(struct page *page);
>   int set_direct_map_default_noflush(struct page *page);
>   bool kernel_page_present(struct page *page);
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 7b31779101f662e4..03901d3a8b027343 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -293,9 +293,7 @@ void __init setup_arch(char **cmdline_p)
>   
>   	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
>   		protect_kernel_text_data();
> -#if defined(CONFIG_64BIT) && defined(CONFIG_MMU) && !defined(CONFIG_XIP_KERNEL)
>   		protect_kernel_linear_mapping_text_rodata();
> -#endif
>   	}
>   
>   #ifdef CONFIG_SWIOTLB
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 3ebc0f5d2b73b42b..6cc0421a5d0ef4a3 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -646,7 +646,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>   #endif
>   }
>   
> -#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
> +#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
>   void protect_kernel_linear_mapping_text_rodata(void)
>   {
>   	unsigned long text_start = (unsigned long)lm_alias(_start);
> 

I tested this on the following configs:

- rv32_defconfig (build and valid on qemu)
- defconfig (with and without CONFIG_STRICT_KERNEL_RWX) (build and valid 
on qemu)
- xip kernel (build and valid on qemu)
- nommu_k210_defconfig (build only)

so you can add:

Tested-by: Alexandre Ghiti <alex@ghiti.fr>

Thank you for the cleanup!

Alex
