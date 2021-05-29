Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810C6394A33
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 06:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhE2EKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 00:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhE2EKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 00:10:24 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40340C061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 21:08:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x10so1632034plg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 21:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k9sddzV+vTevwO2p9KRYTHf/MN3ZRMxl5FQFp77LWGs=;
        b=TyHYKf4/mSF4qBZHD2GCtllhgahybLudD9DiMFrl7grLPeI820rtNHAF+byKNGR8WK
         Ytnz92mMVQZRG3Z83l3vwZ9uHQ0uA5rJ2oy4YR+NBE7uRblNqUh7nn4gFpLDouMlPnBG
         xvyheuszDkT1HxhZcX6FCWn7y/IK4Hc5cpZExXS7j+pgiq9b/tctdD/kpHdaXb4PHsJl
         yuaLCSKx9jraA5N74nUqaE2HWAmLruRKWUBQa0HENwgu28TABXt3CpONUyqXV1bi2/jr
         aoasz909VD1zhCtydCKmcbCk/OqiZb35j0CDFESGtATB3GXeFsJiHPB9FTRV5obxUeBp
         LY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k9sddzV+vTevwO2p9KRYTHf/MN3ZRMxl5FQFp77LWGs=;
        b=oeux3NzQU4pl+5F4ozl3Qp0y0/Ne2riOWj3VoaoBNyuDNXwDxgwcXMs203spqpOMEn
         BRguFgs6VYt/bGo5B+G08v9TpTnzoVreCZxWwUEseYyRk1PEwbI9ri6o7zh9MIoFOG8z
         GYf/C0tY7i4qJc/+WQCei3vV+ve2Z+H784qqN4Jv0Ch35v5jQqksUxIrBrvPPp/3VoGC
         esn3uHsTAKvts4jrkcQIA5lOkowHO2YKc+UhLzby3Flk4ual8madj4etBTdsweMUrb2O
         /TbYZOdUaiFZYIp5lgstPtoyVXVaeL9cGIq8ikJIf1J0kd8Z2QD+4KbqqsYq+DdVTter
         7emQ==
X-Gm-Message-State: AOAM531kPF3knfQr09i9vXtWxIHgc5jmUL6BGFY20mXGu86QVW1VRvfP
        2dwfcjGF8Bvqyf0H2b0/GgfpPyPWSa+J5Q==
X-Google-Smtp-Source: ABdhPJy7VvnF2QSKZGBO09nIkxaKBjTuBPuFkS8MggWA/nz6n3oOpQAlLwkQUrxIgvW6+VIS2Rk4nw==
X-Received: by 2002:a17:902:8d97:b029:ff:3d00:81ef with SMTP id v23-20020a1709028d97b02900ff3d0081efmr9069831plo.17.1622261327529;
        Fri, 28 May 2021 21:08:47 -0700 (PDT)
Received: from x1 ([2601:1c0:4701:ae70:973:a900:a1a6:cdbd])
        by smtp.gmail.com with ESMTPSA id m9sm5518495pfh.76.2021.05.28.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 21:08:46 -0700 (PDT)
Date:   Fri, 28 May 2021 21:08:43 -0700
From:   Drew Fustini <drew@beagleboard.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: Map the kernel with correct permissions the
 first time
Message-ID: <20210529040843.GA51164@x1>
References: <20210526134110.217073-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526134110.217073-1-alex@ghiti.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 03:41:10PM +0200, Alexandre Ghiti wrote:
> For 64b kernels, we map all the kernel with write and execute permissions
> and afterwards remove writability from text and executability from data.
> 
> For 32b kernels, the kernel mapping resides in the linear mapping, so we
> map all the linear mapping as writable and executable and afterwards we
> remove those properties for unused memory and kernel mapping as
> described above.
> 
> Change this behavior to directly map the kernel with correct permissions
> and avoid going through the whole mapping to fix the permissions.
> 
> At the same time, this fixes an issue introduced by commit 2bfc6cd81bd1
> ("riscv: Move kernel mapping outside of linear mapping") as reported
> here https://github.com/starfive-tech/linux/issues/17.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
> 
> Changes in v2:
> * Rebased on top of for-next (and "riscv: mm: fix build errors caused by
>   mk_pmd()")
> * Get rid of protect_kernel_linear_mapping_text_rodata as suggested by
>   Jisheng
> * Improve code in general compared to previous RFC
> 
> Tested on:
> 
> * kernel
> - rv32: OK
> - rv64: OK
> 
> * kernel w/o CONFIG_STRICT_KERNEL_RWX:
> - rv32: OK
> - rv64: OK
> 
> * xipkernel:
> - rv32: build only
> - rv64: OK
> 
> * nommukernel:
> - rv64: build only
> 
>  arch/riscv/include/asm/page.h       |   9 +-
>  arch/riscv/include/asm/sections.h   |  16 ++++
>  arch/riscv/include/asm/set_memory.h |   8 --
>  arch/riscv/kernel/setup.c           |   5 --
>  arch/riscv/mm/init.c                | 123 +++++++++++++++-------------
>  5 files changed, 89 insertions(+), 72 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 6e004d8fda4d..7ff5e0d81e41 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -95,6 +95,7 @@ extern unsigned long va_kernel_pa_offset;
>  #endif
>  extern unsigned long va_kernel_xip_pa_offset;
>  extern unsigned long pfn_base;
> +extern uintptr_t load_sz;
>  #define ARCH_PFN_OFFSET		(pfn_base)
>  #else
>  #define va_pa_offset		0
> @@ -108,6 +109,9 @@ extern unsigned long pfn_base;
>  extern unsigned long kernel_virt_addr;
>  
>  #ifdef CONFIG_64BIT
> +#define is_kernel_mapping(x)	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
> +#define is_linear_mapping(x)	((x) >= PAGE_OFFSET && (x) < kernel_virt_addr)
> +
>  #define linear_mapping_pa_to_va(x)	((void *)((unsigned long)(x) + va_pa_offset))
>  #define kernel_mapping_pa_to_va(y)	({						\
>  	unsigned long _y = y;								\
> @@ -127,10 +131,13 @@ extern unsigned long kernel_virt_addr;
>  
>  #define __va_to_pa_nodebug(x)	({						\
>  	unsigned long _x = x;							\
> -	(_x < kernel_virt_addr) ?						\
> +	is_linear_mapping(_x) ?							\
>  		linear_mapping_va_to_pa(_x) : kernel_mapping_va_to_pa(_x);	\
>  	})
>  #else
> +#define is_kernel_mapping(x)	((x) >= kernel_virt_addr && (x) < (kernel_virt_addr + load_sz))
> +#define is_linear_mapping(x)	((x) >= PAGE_OFFSET)
> +
>  #define __pa_to_va_nodebug(x)  ((void *)((unsigned long) (x) + va_pa_offset))
>  #define __va_to_pa_nodebug(x)  ((unsigned long)(x) - va_pa_offset)
>  #endif /* CONFIG_64BIT */
> diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
> index 8a303fb1ee3b..6b5affecca83 100644
> --- a/arch/riscv/include/asm/sections.h
> +++ b/arch/riscv/include/asm/sections.h
> @@ -6,6 +6,7 @@
>  #define __ASM_SECTIONS_H
>  
>  #include <asm-generic/sections.h>
> +#include <linux/mm.h>
>  
>  extern char _start[];
>  extern char _start_kernel[];
> @@ -13,4 +14,19 @@ extern char __init_data_begin[], __init_data_end[];
>  extern char __init_text_begin[], __init_text_end[];
>  extern char __alt_start[], __alt_end[];
>  
> +static inline bool is_va_kernel_text(uintptr_t va)
> +{
> +	return (va >= (uintptr_t)_start && va < (uintptr_t)__init_text_begin);
> +}
> +
> +static inline bool is_va_kernel_lm_alias_text(uintptr_t va)
> +{
> +	return (va >= (uintptr_t)lm_alias(_start) && va < (uintptr_t)lm_alias(__init_text_begin));
> +}
> +
> +static inline bool is_va_kernel_init_text(uintptr_t va)
> +{
> +	return (va >= (uintptr_t)__init_text_begin && va < (uintptr_t)__init_data_begin);
> +}
> +
>  #endif /* __ASM_SECTIONS_H */
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 086f757e8ba3..ebb8516ec5bc 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -16,22 +16,14 @@ int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>  int set_memory_rw_nx(unsigned long addr, int numpages);
> -void protect_kernel_text_data(void);
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> -static inline void protect_kernel_text_data(void) {}
>  static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
>  #endif
>  
> -#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> -void protect_kernel_linear_mapping_text_rodata(void);
> -#else
> -static inline void protect_kernel_linear_mapping_text_rodata(void) {}
> -#endif
> -
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  bool kernel_page_present(struct page *page);
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 4db4d0b5911f..96f483e7c279 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -290,11 +290,6 @@ void __init setup_arch(char **cmdline_p)
>  	init_resources();
>  	sbi_init();
>  
> -	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
> -		protect_kernel_text_data();
> -		protect_kernel_linear_mapping_text_rodata();
> -	}
> -
>  #ifdef CONFIG_SWIOTLB
>  	swiotlb_init(1);
>  #endif
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 2d80088f33d5..4b1bcbbd50aa 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -425,6 +425,63 @@ asmlinkage void __init __copy_data(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +static __init pgprot_t pgprot_from_va(uintptr_t va)
> +{
> +#ifdef CONFIG_64BIT
> +	if (is_va_kernel_text(va) || is_va_kernel_init_text(va))
> +		return PAGE_KERNEL_READ_EXEC;
> +
> +	/*
> +	 * We must mark only text as read-only as init text will get freed later
> +	 * and rodata section is marked readonly in mark_rodata_ro.
> +	 */
> +	if (is_va_kernel_lm_alias_text(va))
> +		return PAGE_KERNEL_READ;
> +
> +	return PAGE_KERNEL;
> +#else
> +	if (is_va_kernel_text(va))
> +		return PAGE_KERNEL_READ_EXEC;
> +
> +	if (is_va_kernel_init_text(va))
> +		return PAGE_KERNEL_EXEC;
> +
> +	return PAGE_KERNEL;
> +#endif /* CONFIG_64BIT */
> +}
> +
> +void mark_rodata_ro(void)
> +{
> +	unsigned long rodata_start = (unsigned long)__start_rodata;
> +	unsigned long data_start = (unsigned long)_data;
> +	unsigned long __maybe_unused lm_rodata_start = (unsigned long)lm_alias(__start_rodata);
> +	unsigned long __maybe_unused lm_data_start = (unsigned long)lm_alias(_data);
> +
> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> +#ifdef CONFIG_64BIT
> +	set_memory_ro(lm_rodata_start, (lm_data_start - lm_rodata_start) >> PAGE_SHIFT);
> +#endif
> +
> +	debug_checkwx();
> +}
> +#else /* CONFIG_STRICT_KERNEL_RWX */
> +static __init pgprot_t pgprot_from_va(uintptr_t va)
> +{
> +#ifdef CONFIG_64BIT
> +	if (is_kernel_mapping(va))
> +		return PAGE_KERNEL_EXEC;
> +
> +	if (is_linear_mapping(va))
> +		return PAGE_KERNEL;
> +
> +	return PAGE_KERNEL;
> +#else
> +	return PAGE_KERNEL_EXEC;
> +#endif /* CONFIG_64BIT */
> +}
> +#endif /* CONFIG_STRICT_KERNEL_RWX */
> +
>  /*
>   * setup_vm() is called from head.S with MMU-off.
>   *
> @@ -454,7 +511,8 @@ uintptr_t xiprom, xiprom_sz;
>  #define xiprom_sz      (*((uintptr_t *)XIP_FIXUP(&xiprom_sz)))
>  #define xiprom         (*((uintptr_t *)XIP_FIXUP(&xiprom)))
>  
> -static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
> +					    __always_unused bool early)
>  {
>  	uintptr_t va, end_va;
>  
> @@ -473,7 +531,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  				   map_size, PAGE_KERNEL);
>  }
>  #else
> -static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size, bool early)
>  {
>  	uintptr_t va, end_va;
>  
> @@ -481,7 +539,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  	for (va = kernel_virt_addr; va < end_va; va += map_size)
>  		create_pgd_mapping(pgdir, va,
>  				   load_pa + (va - kernel_virt_addr),
> -				   map_size, PAGE_KERNEL_EXEC);
> +				   map_size, early ? PAGE_KERNEL_EXEC : pgprot_from_va(va));
>  }
>  #endif
>  
> @@ -558,7 +616,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	 * us to reach paging_init(). We map all memory banks later
>  	 * in setup_vm_final() below.
>  	 */
> -	create_kernel_page_table(early_pg_dir, map_size);
> +	create_kernel_page_table(early_pg_dir, map_size, true);
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
>  	/* Setup early PMD for DTB */
> @@ -634,22 +692,6 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #endif
>  }
>  
> -#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> -void protect_kernel_linear_mapping_text_rodata(void)
> -{
> -	unsigned long text_start = (unsigned long)lm_alias(_start);
> -	unsigned long init_text_start = (unsigned long)lm_alias(__init_text_begin);
> -	unsigned long rodata_start = (unsigned long)lm_alias(__start_rodata);
> -	unsigned long data_start = (unsigned long)lm_alias(_data);
> -
> -	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
> -	set_memory_nx(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
> -
> -	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> -	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> -}
> -#endif
> -
>  static void __init setup_vm_final(void)
>  {
>  	uintptr_t va, map_size;
> @@ -682,21 +724,15 @@ static void __init setup_vm_final(void)
>  		map_size = best_map_size(start, end - start);
>  		for (pa = start; pa < end; pa += map_size) {
>  			va = (uintptr_t)__va(pa);
> -			create_pgd_mapping(swapper_pg_dir, va, pa,
> -					   map_size,
> -#ifdef CONFIG_64BIT
> -					   PAGE_KERNEL
> -#else
> -					   PAGE_KERNEL_EXEC
> -#endif
> -					);
>  
> +			create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
> +					   pgprot_from_va(va));
>  		}
>  	}
>  
>  #ifdef CONFIG_64BIT
>  	/* Map the kernel */
> -	create_kernel_page_table(swapper_pg_dir, PMD_SIZE);
> +	create_kernel_page_table(swapper_pg_dir, PMD_SIZE, false);
>  #endif
>  
>  	/* Clear fixmap PTE and PMD mappings */
> @@ -727,35 +763,6 @@ static inline void setup_vm_final(void)
>  }
>  #endif /* CONFIG_MMU */
>  
> -#ifdef CONFIG_STRICT_KERNEL_RWX
> -void __init protect_kernel_text_data(void)
> -{
> -	unsigned long text_start = (unsigned long)_start;
> -	unsigned long init_text_start = (unsigned long)__init_text_begin;
> -	unsigned long init_data_start = (unsigned long)__init_data_begin;
> -	unsigned long rodata_start = (unsigned long)__start_rodata;
> -	unsigned long data_start = (unsigned long)_data;
> -	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
> -
> -	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
> -	set_memory_ro(init_text_start, (init_data_start - init_text_start) >> PAGE_SHIFT);
> -	set_memory_nx(init_data_start, (rodata_start - init_data_start) >> PAGE_SHIFT);
> -	/* rodata section is marked readonly in mark_rodata_ro */
> -	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> -	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> -}
> -
> -void mark_rodata_ro(void)
> -{
> -	unsigned long rodata_start = (unsigned long)__start_rodata;
> -	unsigned long data_start = (unsigned long)_data;
> -
> -	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> -
> -	debug_checkwx();
> -}
> -#endif
> -
>  #ifdef CONFIG_KEXEC_CORE
>  /*
>   * reserve_crashkernel() - reserves memory for crash kernel
> -- 
> 2.30.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

I wanted to try testing this on the BeagleV Starlight but I could not
apply it cleanly against 5.13-rc3:

  $ git am /tmp/patch.am
  Applying: riscv: Map the kernel with correct permissions the first time
  error: patch failed: arch/riscv/include/asm/page.h:95
  error: arch/riscv/include/asm/page.h: patch does not apply
  Patch failed at 0001 riscv: Map the kernel with correct permissions the first time
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

Is there another branch I should be looking at?

thanks,
drew
