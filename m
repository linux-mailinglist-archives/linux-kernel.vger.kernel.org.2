Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AC03893D9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347332AbhESQgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346964AbhESQgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:36:38 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60381C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
        Content-Transfer-Encoding; bh=I7EF5DgYXK5CNIBTo0gfJuvE3joYDduH2y
        ARUBRK5ps=; b=AUwfohXp0nzurU67e9OW4h+PY/fKPYE9lviT5s+v9ZRa0PFYxt
        uZFDr4079SUrpkhhjkpjXeAMVNGN/HFzI1mrkTQRTB8canXoeRfEdLbZaV4UL5fU
        IJCuUsG2q4I+kj6QA5CuX9k4SrsgUa8a3ppsfPdOboQq6gEcwwcqxziMs=
Received: from xhacker (unknown [101.86.20.15])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygBnbZkTPqVgof8DAQ--.63533S2;
        Thu, 20 May 2021 00:34:27 +0800 (CST)
Date:   Thu, 20 May 2021 00:29:09 +0800
From:   Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] riscv: Map the kernel with correct permissions the
 first time
Message-ID: <20210520002909.0b699b2b@xhacker>
In-Reply-To: <20210518152134.1772653-1-alex@ghiti.fr>
References: <20210518152134.1772653-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LkAmygBnbZkTPqVgof8DAQ--.63533S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1Duw4fJr17uFy8JFWUJwb_yoW3Kr4fpF
        W8Jrn8ZFWYqFykWrW7CryY9ryfJwn3Ja4aqF17CrykWFnrCF4Fvrn0ga9FqryDAayvqF4f
        Aay0kws3uwsrtFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUySb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC2
        0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
        0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
        14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20x
        vaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
        6r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07beAp5UUUUU=
X-CM-SenderInfo: xmv2xttqjtqzxdloh3xvwfhvlgxou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021 17:21:34 +0200
Alexandre Ghiti <alex@ghiti.fr> wrote:

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
> This patchset was tested on:
> 
> * kernel:
> - rv32 with CONFIG_STRICT_KERNEL_RWX: OK
> - rv32 without CONFIG_STRICT_KERNEL_RWX: OK
> - rv64 with CONFIG_STRICT_KERNEL_RWX: OK
> - rv64 without CONFIG_STRICT_KERNEL_RWX: OK
> 
> * xipkernel:
> - rv32: build only
> - rv64: OK
> 
>  arch/riscv/include/asm/set_memory.h |  2 -
>  arch/riscv/kernel/setup.c           |  1 -
>  arch/riscv/mm/init.c                | 80 ++++++++++++++---------------
>  3 files changed, 38 insertions(+), 45 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 086f757e8ba3..70154f012791 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -16,13 +16,11 @@ int set_memory_rw(unsigned long addr, int numpages);
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
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 03901d3a8b02..1eb50e512056 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -292,7 +292,6 @@ void __init setup_arch(char **cmdline_p)
>  	sbi_init();
>  
>  	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
> -		protect_kernel_text_data();
>  		protect_kernel_linear_mapping_text_rodata();

If we extend the idea a bit, I.E create the correct permission for alias line
mapping at the first time, we can remove protect_kernel_linear_mapping_text_rodata()

PS: No matter whether it's fine to extend, the set_memory_nx() calling in
protect_kernel_linear_mapping_text_rodata() is not necessary since the linear
mapping for 64bit is NX from the beginning.

>  	}
>  
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 4faf8bd157ea..92b3184420a2 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -436,6 +436,36 @@ asmlinkage void __init __copy_data(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +#define is_text_va(va)		({								\
> +		unsigned long _va = va;								\
> +		(_va < (unsigned long)__init_data_begin && _va >= (unsigned long)_start);	\
> +	})

It's better if is_text_va() is a inline function

> +
> +static inline __init pgprot_t pgprot_from_kernel_va(uintptr_t va)

I'm not sure whether it's necessary to put __init marker to inline functions
There are such issues in current riscv code, I planed to cook one patch
to remove __init from inline functions.


> +{
> +	return is_text_va(va) ? PAGE_KERNEL_READ_EXEC : PAGE_KERNEL;

if we extend the idea, then here we may return PAGE_KERNEL_READ, PAGE_KERNEL
and PAGE_KERNEL_READ_EXEC correspondingly.

Thanks

> +}
> +
> +void mark_rodata_ro(void)
> +{
> +	unsigned long rodata_start = (unsigned long)__start_rodata;
> +	unsigned long data_start = (unsigned long)_data;
> +
> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
> +
> +	debug_checkwx();
> +}
> +#else
> +static inline __init pgprot_t pgprot_from_kernel_va(uintptr_t va)
> +{
> +	if (IS_ENABLED(CONFIG_32BIT))
> +		return PAGE_KERNEL_EXEC;
> +
> +	return (va < kernel_virt_addr) ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
> +}
> +#endif
> +
>  /*
>   * setup_vm() is called from head.S with MMU-off.
>   *
> @@ -465,7 +495,8 @@ uintptr_t xiprom, xiprom_sz;
>  #define xiprom_sz      (*((uintptr_t *)XIP_FIXUP(&xiprom_sz)))
>  #define xiprom         (*((uintptr_t *)XIP_FIXUP(&xiprom)))
>  
> -static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size,
> +					    __always_unused bool early)
>  {
>  	uintptr_t va, end_va;
>  
> @@ -484,7 +515,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  				   map_size, PAGE_KERNEL);
>  }
>  #else
> -static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
> +static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size, bool early)
>  {
>  	uintptr_t va, end_va;
>  
> @@ -492,7 +523,7 @@ static void __init create_kernel_page_table(pgd_t *pgdir, uintptr_t map_size)
>  	for (va = kernel_virt_addr; va < end_va; va += map_size)
>  		create_pgd_mapping(pgdir, va,
>  				   load_pa + (va - kernel_virt_addr),
> -				   map_size, PAGE_KERNEL_EXEC);
> +				   map_size, early ? PAGE_KERNEL_EXEC : pgprot_from_kernel_va(va));
>  }
>  #endif
>  
> @@ -569,7 +600,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	 * us to reach paging_init(). We map all memory banks later
>  	 * in setup_vm_final() below.
>  	 */
> -	create_kernel_page_table(early_pg_dir, map_size);
> +	create_kernel_page_table(early_pg_dir, map_size, true);
>  
>  #ifndef __PAGETABLE_PMD_FOLDED
>  	/* Setup early PMD for DTB */
> @@ -693,21 +724,15 @@ static void __init setup_vm_final(void)
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
> +					   pgprot_from_kernel_va(va));
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
> @@ -738,35 +763,6 @@ static inline void setup_vm_final(void)
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


