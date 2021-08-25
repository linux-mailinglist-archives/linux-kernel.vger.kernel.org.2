Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186733F6EB3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbhHYFK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbhHYFK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:10:27 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D70C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:09:42 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id x16so20260544pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DWHk8mstYyPO+AAHZ16yuY+dqKsWCC5nLDU6ME20Sk4=;
        b=QNdrGkouNupReWxodNHkGyJ6QmdWaDNvsXKWuFBckhcXcWjy7VFLMsWpgV/+/jTZZJ
         adfQjq/yqK6H7OXsgRLUf9gGuDfdulZOtr4n2SplbByZLdyydZKPGg4aBK31oEAJeOoi
         y9CJbZfCRQH4Th56Sco4n21GigSV0Hp/keYUAMNVJgdHDmHSs6pKkhekcboXyomeXfnp
         a0EgBDPQ5d/uSg6KPH6Q0DUBqyasjasw+YzjYJZgJfLdqy6kbyLxHw8s6C0KKPoTFGuT
         0p+G1F6bfJNIiuLIrKTk7aMjmxHHFzbgFh3nk5HS1LUWUEH3NL7LHhHRL0DhRf8MBPaz
         LdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DWHk8mstYyPO+AAHZ16yuY+dqKsWCC5nLDU6ME20Sk4=;
        b=gbm0WOh1FJ9IMeMPoJESVTkmI1M8VtHA1/+yDoDoRI5THcF7UqYUnAhq1onuLyo0Ih
         4o9RMtqPtyQZuKgjtx+AWm1OuGaM9rMz0yeWv9cFi+IsQHGGRlnkWX/RoLJAcRHzP76R
         3TDPWg388ON3oUX6YpyALnnAXSsrJtnGK39IzGNrrmYzyB7NveQLYsiY+CyJxCjNl6wy
         59Ki1xd8liaGmLcfRrsIyOFV1piXUOKZMEbZ3xzqY2nRdwLadKvEV85Y1913/v4dHvgm
         TEqHsTWZjhW90hX3IL1o1ZfOxbSd5AQJgK5voF+msLWPtlB+/p/rD96XZz97j0Q5sGr8
         0lOQ==
X-Gm-Message-State: AOAM531t+axuqvVuOquyyBMDOZYkS7C1H7qJriY+6Elx2oSoimYf7JB+
        PJIyUIXe21fscnK5VPYJ2wuZDA==
X-Google-Smtp-Source: ABdhPJw/w5StR+RaozK6DFqilyJPQJeYjeA4P2QB/JmgD2UG+GmMA6zlchtm2Mhuxh/yFSDM/sb29w==
X-Received: by 2002:a65:6288:: with SMTP id f8mr40207829pgv.81.1629868181717;
        Tue, 24 Aug 2021 22:09:41 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s1sm17645684pfd.13.2021.08.24.22.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 22:09:41 -0700 (PDT)
Date:   Tue, 24 Aug 2021 22:09:41 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 22:09:37 PDT (-0700)
Subject:     Re: [PATCH RFC] riscv: Introduce compile-time early page table for XIP kernel
In-Reply-To: <20210805095538.641737-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        vitaly.wool@konsulko.com, jszhang3@mail.ustc.edu.cn,
        Atish Patra <Atish.Patra@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-214a8229-1b01-4449-8f76-16729594bb2a@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Aug 2021 02:55:38 PDT (-0700), alex@ghiti.fr wrote:
> As described in [1], XIP kernel current implementation introduces a few
> drawbacks caused by the 'fixups'.
>
> All those fixups are necessary because the MMU is not enabled soon enough:
> this patch introduces a way to compute the early page table at
> 'compile-time' by generating, from the XIP config, a linker script that
> contains the early page table definition.
>
> A python script is used to generate the early page table: for now, it
> redefines quite a few macros from the C code, but I have at least one
> way to retrieve those values to avoid duplicating their definitions.
>
> XIP kernel then loads the static early page table before accessing any
> global variable in C and then avoids all the fixups.
>
> This is an RFC as there are quite a few things to clean and improve.
>
> [1] https://patchwork.kernel.org/project/linux-riscv/patch/20210618142353.2114854-1-alex@ghiti.fr/

The idea generally looks good, but since XIP systems are likely size 
constraied I'd like to see some rough numbers.  Specifically my worry 
would be that the page table is too large when resident in flash, but 
that might be canceled out by all the fixups.  I haven't actually looked 
at the code, but it might be possible to alleviate this by filling out 
the memory portion of the page tables super early in boot.

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/Makefile                           |  11 ++
>  arch/riscv/include/asm/pgtable.h              |  22 +--
>  .../riscv/kernel/generate-early-page-table.py | 154 ++++++++++++++++++
>  arch/riscv/kernel/head.S                      |  62 +++++--
>  arch/riscv/kernel/setup.c                     |   2 +-
>  arch/riscv/kernel/vmlinux-xip.lds.S           |   3 +
>  arch/riscv/mm/init.c                          | 140 ++++++++--------
>  7 files changed, 286 insertions(+), 108 deletions(-)
>  create mode 100755 arch/riscv/kernel/generate-early-page-table.py
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index bc74afdbf31e..6adb28bacc1a 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -123,6 +123,17 @@ $(BOOT_TARGETS): vmlinux
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>  	@$(kecho) '  Kernel: $(boot)/$@ is ready'
>
> +ifeq ($(CONFIG_XIP_KERNEL),y)
> +vmlinux: early-page-table.lds.S
> +
> +quiet_cmd_generate_early_page_table = GENPGT  $@
> +cmd_generate_early_page_table =	$(srctree)/arch/riscv/kernel/generate-early-page-table.py .config
> +
> +# TODO this is always called even without modifications!
> +early-page-table.lds.S: $(srctree)/arch/riscv/kernel/generate-early-page-table.py
> +	$(call if_changed,generate_early_page_table)
> +endif
> +
>  Image.%: Image
>  	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 39b550310ec6..8fef6f7bc22d 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -94,17 +94,6 @@
>  #include <asm/pgtable-32.h>
>  #endif /* CONFIG_64BIT */
>
> -#ifdef CONFIG_XIP_KERNEL
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
>  #ifdef CONFIG_MMU
>  /* Number of entries in the page global directory */
>  #define PTRS_PER_PGD    (PAGE_SIZE / sizeof(pgd_t))
> @@ -680,15 +669,8 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  #define kern_addr_valid(addr)   (1) /* FIXME */
>
>  extern char _start[];
> -extern void *_dtb_early_va;
> -extern uintptr_t _dtb_early_pa;
> -#if defined(CONFIG_XIP_KERNEL) && defined(CONFIG_MMU)
> -#define dtb_early_va	(*(void **)XIP_FIXUP(&_dtb_early_va))
> -#define dtb_early_pa	(*(uintptr_t *)XIP_FIXUP(&_dtb_early_pa))
> -#else
> -#define dtb_early_va	_dtb_early_va
> -#define dtb_early_pa	_dtb_early_pa
> -#endif /* CONFIG_XIP_KERNEL */
> +extern void *dtb_early_va;
> +extern uintptr_t dtb_early_pa;
>
>  void paging_init(void);
>  void misc_mem_init(void);
> diff --git a/arch/riscv/kernel/generate-early-page-table.py b/arch/riscv/kernel/generate-early-page-table.py
> new file mode 100755
> index 000000000000..98a401355932
> --- /dev/null
> +++ b/arch/riscv/kernel/generate-early-page-table.py
> @@ -0,0 +1,154 @@
> +#!/usr/bin/env python
> +
> +from os import path
> +import sys
> +import re
> +
> +if len(sys.argv) != 2:
> +	print("Usage: %s PATH_TO_CONFIG" % sys.argv[0])
> +	sys.exit(1)
> +
> +EARLY_PAGE_TABLE_LDS_PATH = path.join(path.dirname(path.abspath(__file__)), "early-page-table.lds.S")
> +
> +# PAGE_SIZE / sizeof(uint64_t)
> +PTRS_PER_PGD = 512
> +PTRS_PER_PMD = 512
> +PTRS_PER_PTE = 512
> +
> +KERNEL_PGDS_NR = int(PTRS_PER_PGD / 2)
> +
> +PAGE_PFN_SHIFT = 10
> +PAGE_SHIFT = 12
> +PAGE_SIZE = 1 << PAGE_SHIFT
> +PMD_SIZE = 1 << 21
> +PGDIR_SIZE = 1 << 30
> +
> +TASK_SIZE = int(PGDIR_SIZE * PTRS_PER_PGD / 2)
> +KERNEL_MAPPING_BASE_ADDR = 0xFFFFFFFFFFFFFFFF - TASK_SIZE + 1
> +KERNEL_LINK_ADDR = 0xFFFFFFFF80000000
> +FIXADDR_START = 0xFFFFFFCEFEE00000
> +DTB_EARLY_BASE_VA = PGDIR_SIZE
> +
> +PAGE_KERNEL_EXEC = (1 << 1) | (1 << 2) | (1 << 0) | (1 << 6) | (1 << 7) | (1 << 5) | (1 << 3)
> +PAGE_TABLE = (1 << 0)
> +
> +XIP_OFFSET = 8 * 1024 * 1024
> +
> +def extract_addr_from_config(config_path):
> +	with open(config_path, "r") as fconfig:
> +		content = fconfig.read()
> +		p = re.compile('CONFIG_PHYS_RAM_BASE=.*').search(content)
> +		if p:
> +			phys_ram_base = p.group().split('=')[1]
> +		else:
> +			print("Can't find CONFIG_PHYS_RAM_BASE in .config!")
> +			sys.exit(1)
> +
> +		p = re.compile("CONFIG_XIP_PHYS_ADDR=.*").search(content)
> +		if p:
> +			xip_phys_addr = p.group().split('=')[1]
> +		else:
> +			print("Can't find CONFIG_XIP_PHYS_ADDR in .config!")
> +			sys.exit(1)
> +
> +		p = re.compile("CONFIG_BUILTIN_DTB.*").search(content)
> +		if p:
> +			builtin_dtb = True if p.group() == "CONFIG_BUILTIN_DTB=y" else False
> +		else:
> +			builtin_dtb = False
> +
> +	return (phys_ram_base, xip_phys_addr, builtin_dtb)
> +
> +def pte_page_table(phys_addr):
> +	return "((({}) >> {}) << {}) | 0x{:x}".format(phys_addr, PAGE_SHIFT, PAGE_PFN_SHIFT, PAGE_TABLE)
> +
> +def pte_page_kernel_exec(phys_addr):
> +	return "((({}) >> {}) << {}) | 0x{:x}".format(phys_addr, PAGE_SHIFT, PAGE_PFN_SHIFT, PAGE_KERNEL_EXEC)
> +
> +def pgd_entry_index(addr):
> +	if addr >= KERNEL_MAPPING_BASE_ADDR:
> +		return int((addr  - KERNEL_MAPPING_BASE_ADDR) / PGDIR_SIZE) + KERNEL_PGDS_NR
> +	else:
> +		return int(addr / PGDIR_SIZE)
> +
> +def pmd_entry_index(addr):
> +	offset_in_pgdir = addr & (PGDIR_SIZE - 1)
> +	return int(offset_in_pgdir / PMD_SIZE)
> +
> +def pte_entry_index(addr):
> +	offset_in_pgdir = addr & (PMD_SIZE - 1)
> +	return int(offset_in_pgdir / PAGE_SIZE)
> +
> +def create_kernel_page_table():
> +	pgdir_kernel_mapping_entry = pgd_entry_index(KERNEL_LINK_ADDR)
> +	early_pg_dir[pgdir_kernel_mapping_entry] = pte_page_table("XIP_PHYS_ADDR(early_pmd)")
> +
> +	# First half resides in flash
> +	for i in range(0, int(XIP_OFFSET / PMD_SIZE)):
> +		early_pmd[i] = pte_page_kernel_exec(str(hex(int(xip_phys_addr, 0) + i * PMD_SIZE)))
> +
> +	# Second half is in RAM
> +	for i in range(int(XIP_OFFSET / PMD_SIZE), int(2 * XIP_OFFSET / PMD_SIZE)):
> +		early_pmd[i] = pte_page_kernel_exec(str(hex(int(phys_ram_base, 0) + i * PMD_SIZE - XIP_OFFSET)))
> +
> +def create_fixaddr_page_table():
> +	pgdir_fixaddr_entry = pgd_entry_index(FIXADDR_START)
> +	early_pg_dir[pgdir_fixaddr_entry] = pte_page_table("RAM_PHYS_ADDR(fixmap_pmd)")
> +
> +	pmd_fixaddr_entry = pmd_entry_index(FIXADDR_START)
> +	fixmap_pmd[pmd_fixaddr_entry] = pte_page_table("RAM_PHYS_ADDR(fixmap_pte)")
> +
> +def create_fdt_early_page_table():
> +	pgdir_fdt_entry = pgd_entry_index(DTB_EARLY_BASE_VA)
> +	early_pg_dir[pgdir_fdt_entry] = pte_page_table("RAM_PHYS_ADDR(early_dtb_pmd)")
> +
> +	pmd_fdt_entry = pmd_entry_index(DTB_EARLY_BASE_VA)
> +	early_dtb_pmd[pmd_fdt_entry] = pte_page_kernel_exec("XIP_PHYS_ADDR(__dtb_start)")
> +	early_dtb_pmd[pmd_fdt_entry + 1] = pte_page_kernel_exec("XIP_PHYS_ADDR(__dtb_start) + {}".format(PMD_SIZE))
> +
> +def setup_vm():
> +	create_kernel_page_table()
> +	create_fixaddr_page_table()
> +	if not builtin_dtb:
> +		create_fdt_early_page_table()
> +
> +def dump_macros(f):
> +	f.write("#define XIP_PHYS_ADDR(x) ((x) - KERNEL_LINK_ADDR + {})\n".format(xip_phys_addr))
> +	f.write("#define RAM_PHYS_ADDR(x) ((x) - KERNEL_LINK_ADDR + {} - 0x{:x})\n".format(phys_ram_base, XIP_OFFSET))
> +	f.write("\n")
> +
> +def dump_section_header(f):
> +	f.write(".init.early_page_table :\n")
> +	f.write("{\n")
> +
> +def dump_section_footer(f):
> +	f.write("}\n")
> +
> +def dump_page_table_level(f, ptl, nr_entries, ptl_name):
> +	f.write("\t{} = .;\n".format(ptl_name))
> +	for i in range(0, nr_entries):
> +		f.write("\tQUAD({})\n".format(ptl[i]))
> +
> +def dump_page_table(f):
> +	dump_page_table_level(f, early_pg_dir, PTRS_PER_PGD, "early_pg_dir")
> +	dump_page_table_level(f, early_pmd, PTRS_PER_PMD, "early_pmd")
> +	dump_page_table_level(f, fixmap_pmd, PTRS_PER_PMD, "fixmap_pmd")
> +	dump_page_table_level(f, fixmap_pte, PTRS_PER_PTE, "fixmap_pte")
> +	if not builtin_dtb:
> +		dump_page_table_level(f, early_dtb_pmd, PTRS_PER_PMD, "early_dtb_pmd")
> +
> +early_pg_dir = [ "0" ] * PTRS_PER_PGD
> +early_pmd = [ "0" ] * PTRS_PER_PMD
> +fixmap_pmd = [ "0" ] * PTRS_PER_PMD
> +fixmap_pte = [ "0" ] * PTRS_PER_PTE
> +early_dtb_pmd = [ "0" ] * PTRS_PER_PMD
> +
> +(phys_ram_base, xip_phys_addr, builtin_dtb) = extract_addr_from_config(sys.argv[1])
> +
> +setup_vm()
> +
> +with open(EARLY_PAGE_TABLE_LDS_PATH, "w") as flds:
> +	dump_macros(flds)
> +	dump_section_header(flds)
> +	dump_page_table(flds)
> +	dump_section_footer(flds)
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index fce5184b22c3..bbc42c335cdb 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -79,11 +79,12 @@ pe_head_start:
>
>  .align 2
>  #ifdef CONFIG_MMU
> +
> +# a0: page directory address
> +# a1: kernel virtual address
> +# returns: relocated return address
>  relocate:
>  	/* Relocate return address */
> -	la a1, kernel_map
> -	XIP_FIXUP_OFFSET a1
> -	REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
>  	la a2, _start
>  	sub a1, a1, a2
>  	add ra, ra, a1
> @@ -98,6 +99,7 @@ relocate:
>  	li a1, SATP_MODE
>  	or a2, a2, a1
>
> +#ifndef CONFIG_XIP_KERNEL
>  	/*
>  	 * Load trampoline page directory, which will cause us to trap to
>  	 * stvec if VA != PA, or simply fall through if VA == PA.  We need a
> @@ -105,11 +107,21 @@ relocate:
>  	 * to ensure the new translations are in use.
>  	 */
>  	la a0, trampoline_pg_dir
> -	XIP_FIXUP_OFFSET a0
>  	srl a0, a0, PAGE_SHIFT
>  	or a0, a0, a1
>  	sfence.vma
>  	csrw CSR_SATP, a0
> +#else
> +	/*
> +	 * Switch to kernel page tables.  A full fence is necessary in order to
> +	 * avoid using the trampoline translations, which are only correct for
> +	 * the first superpage.  Fetching the fence is guarnteed to work
> +	 * because that first superpage is translated the same way.
> +	 */
> +	csrw CSR_SATP, a2
> +	sfence.vma
> +#endif
> +
>  .align 2
>  1:
>  	/* Set trap vector to spin forever to help debug */
> @@ -121,7 +133,7 @@ relocate:
>  .option norelax
>  	la gp, __global_pointer$
>  .option pop
> -
> +#ifndef CONFIG_XIP_KERNEL
>  	/*
>  	 * Switch to kernel page tables.  A full fence is necessary in order to
>  	 * avoid using the trampoline translations, which are only correct for
> @@ -130,6 +142,7 @@ relocate:
>  	 */
>  	csrw CSR_SATP, a2
>  	sfence.vma
> +#endif
>
>  	ret
>  #endif /* CONFIG_MMU */
> @@ -174,6 +187,8 @@ secondary_start_common:
>  	/* Enable virtual memory and relocate to virtual address */
>  	la a0, swapper_pg_dir
>  	XIP_FIXUP_OFFSET a0
> +	la a1, kernel_map
> +	REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
>  	call relocate
>  #endif
>  	call setup_trap_vector
> @@ -280,7 +295,25 @@ pmp_done:
>  	mv a0, s0
>  #endif
>
> -#ifndef CONFIG_XIP_KERNEL
> +	/* Save hart ID and DTB physical address */
> +	mv s0, a0
> +	mv s1, a1
> +
> +#ifdef CONFIG_XIP_KERNEL
> +	/* Keep DTB physical address before switching to virtual addressing */
> +	la s2, __dtb_start
> +	/* No need to fixup early_pg_dir as it is read-only */
> +	la a0, early_pg_dir
> +	li a1, KERNEL_LINK_ADDR
> +	call relocate
> +#ifdef CONFIG_BUILTIN_DTB
> +	mv a0, s2
> +#else
> +	mv a0, s1
> +#endif /* CONFIG_BUILTIN_DTB */
> +	la sp, init_thread_union + THREAD_SIZE
> +	call setup_vm
> +#else /* CONFIG_XIP_KERNEL */
>  	/* Clear BSS for flat non-ELF images */
>  	la a3, __bss_start
>  	la a4, __bss_stop
> @@ -290,18 +323,8 @@ clear_bss:
>  	add a3, a3, RISCV_SZPTR
>  	blt a3, a4, clear_bss
>  clear_bss_done:
> -#endif
> -	/* Save hart ID and DTB physical address */
> -	mv s0, a0
> -	mv s1, a1
> -
> -	la a2, boot_cpu_hartid
> -	XIP_FIXUP_OFFSET a2
> -	REG_S a0, (a2)
> -
>  	/* Initialize page tables and relocate to virtual addresses */
>  	la sp, init_thread_union + THREAD_SIZE
> -	XIP_FIXUP_OFFSET sp
>  #ifdef CONFIG_BUILTIN_DTB
>  	la a0, __dtb_start
>  #else
> @@ -310,9 +333,14 @@ clear_bss_done:
>  	call setup_vm
>  #ifdef CONFIG_MMU
>  	la a0, early_pg_dir
> -	XIP_FIXUP_OFFSET a0
> +	la a1, kernel_map
> +	REG_L a1, KERNEL_MAP_VIRT_ADDR(a1)
>  	call relocate
>  #endif /* CONFIG_MMU */
> +#endif /* CONFIG_XIP_KERNEL */
> +
> +	la a2, boot_cpu_hartid
> +	REG_S s0, (a2)
>
>  	call setup_trap_vector
>  	/* Restore C environment */
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 18bd0e4bc36c..19b416900f68 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -276,7 +276,7 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>  	unflatten_and_copy_device_tree();
>  #else
> -	if (early_init_dt_verify(__va(XIP_FIXUP(dtb_early_pa))))
> +	if (early_init_dt_verify(__va(dtb_early_pa)))
>  		unflatten_device_tree();
>  	else
>  		pr_err("No DTB found in kernel mappings\n");
> diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
> index af776555ded9..6aba03f3eadf 100644
> --- a/arch/riscv/kernel/vmlinux-xip.lds.S
> +++ b/arch/riscv/kernel/vmlinux-xip.lds.S
> @@ -77,6 +77,9 @@ SECTIONS
>  	}
>  	__end_ro_after_init = .;
>
> +	. = ALIGN(PAGE_SIZE);
> +#include "early-page-table.lds.S"
> +
>  	. = ALIGN(PAGE_SIZE);
>  	__init_begin = .;
>  	.init.data : {
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index e2c8f188ad95..d5098b366274 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -32,9 +32,6 @@
>
>  struct kernel_mapping kernel_map __ro_after_init;
>  EXPORT_SYMBOL(kernel_map);
> -#ifdef CONFIG_XIP_KERNEL
> -#define kernel_map	(*(struct kernel_mapping *)XIP_FIXUP(&kernel_map))
> -#endif
>
>  phys_addr_t phys_ram_base __ro_after_init;
>  EXPORT_SYMBOL(phys_ram_base);
> @@ -49,8 +46,8 @@ EXPORT_SYMBOL(empty_zero_page);
>
>  extern char _start[];
>  #define DTB_EARLY_BASE_VA      PGDIR_SIZE
> -void *_dtb_early_va __initdata;
> -uintptr_t _dtb_early_pa __initdata;
> +void *dtb_early_va __initdata;
> +uintptr_t dtb_early_pa __initdata;
>
>  struct pt_alloc_ops {
>  	pte_t *(*get_pte_virt)(phys_addr_t pa);
> @@ -212,29 +209,22 @@ static void __init setup_bootmem(void)
>  }
>
>  #ifdef CONFIG_MMU
> -static struct pt_alloc_ops _pt_ops __initdata;
> -
> -#ifdef CONFIG_XIP_KERNEL
> -#define pt_ops (*(struct pt_alloc_ops *)XIP_FIXUP(&_pt_ops))
> -#else
> -#define pt_ops _pt_ops
> -#endif
> +static struct pt_alloc_ops pt_ops __initdata;
>
>  unsigned long pfn_base __ro_after_init;
>  EXPORT_SYMBOL(pfn_base);
>
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> +#ifdef CONFIG_XIP_KERNEL
> +extern pte_t fixmap_pte[PTRS_PER_PTE];
> +extern pgd_t early_pg_dir[PTRS_PER_PGD];
> +#else
>  static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> -
>  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
> -static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> +#endif
>
> -#ifdef CONFIG_XIP_KERNEL
> -#define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
> -#define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
> -#define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
> -#endif /* CONFIG_XIP_KERNEL */
> +static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
>  void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>  {
> @@ -306,17 +296,16 @@ static void __init create_pte_mapping(pte_t *ptep,
>
>  #ifndef __PAGETABLE_PMD_FOLDED
>
> +#ifdef CONFIG_XIP_KERNEL
> +extern pmd_t fixmap_pmd[PTRS_PER_PMD];
> +extern pmd_t early_pmd[PTRS_PER_PMD];
> +#else
>  static pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  static pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
>  static pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
> +#endif
>
> -#ifdef CONFIG_XIP_KERNEL
> -#define trampoline_pmd ((pmd_t *)XIP_FIXUP(trampoline_pmd))
> -#define fixmap_pmd     ((pmd_t *)XIP_FIXUP(fixmap_pmd))
> -#define early_pmd      ((pmd_t *)XIP_FIXUP(early_pmd))
> -#endif /* CONFIG_XIP_KERNEL */
> -
> -static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
> +static __maybe_unused pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
>  {
>  	/* Before MMU is enabled */
>  	return (pmd_t *)((uintptr_t)pa);
> @@ -333,7 +322,7 @@ static pmd_t *__init get_pmd_virt_late(phys_addr_t pa)
>  	return (pmd_t *) __va(pa);
>  }
>
> -static phys_addr_t __init alloc_pmd_early(uintptr_t va)
> +static __maybe_unused phys_addr_t __init alloc_pmd_early(uintptr_t va)
>  {
>  	BUG_ON((va - kernel_map.virt_addr) >> PGDIR_SHIFT);
>
> @@ -521,6 +510,14 @@ static void __init create_kernel_page_table(pgd_t *pgdir,
>  				   kernel_map.phys_addr + (va - (kernel_map.virt_addr + XIP_OFFSET)),
>  				   PMD_SIZE, PAGE_KERNEL);
>  }
> +
> +static void __init setup_early_page_table(uintptr_t dtb_pa)
> +{
> +	/*
> +	 * Nothing must be done here since the early page table is generated at
> +	 * compile-time.
> +	*/
> +}
>  #else
>  static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
>  {
> @@ -534,7 +531,6 @@ static void __init create_kernel_page_table(pgd_t *pgdir, bool early)
>  				   early ?
>  					PAGE_KERNEL_EXEC : pgprot_from_va(va));
>  }
> -#endif
>
>  /*
>   * Setup a 4MB mapping that encompasses the device tree: for 64-bit kernel,
> @@ -557,20 +553,48 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
>  		create_pmd_mapping(early_dtb_pmd, DTB_EARLY_BASE_VA + PMD_SIZE,
>  				   pa + PMD_SIZE, PMD_SIZE, PAGE_KERNEL);
>  	}
> +#endif
> +}
>
> -	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
> +static void __init setup_early_page_table(uintptr_t dtb_pa)
> +{
> +	pt_ops.alloc_pte = alloc_pte_early;
> +	pt_ops.get_pte_virt = get_pte_virt_early;
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	pt_ops.alloc_pmd = alloc_pmd_early;
> +	pt_ops.get_pmd_virt = get_pmd_virt_early;
> +#endif
> +	/* Setup early PGD for fixmap */
> +	create_pgd_mapping(early_pg_dir, FIXADDR_START,
> +			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
> +
> +#ifndef __PAGETABLE_PMD_FOLDED
> +	/* Setup fixmap PMD */
> +	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
> +			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
> +	/* Setup trampoline PGD and PMD */
> +	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
> +			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
> +
> +	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> +			   kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
>  #else
> +	/* Setup trampoline PGD */
> +	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
> +			   kernel_map.phys_addr, PGDIR_SIZE, PAGE_KERNEL_EXEC);
> +#endif
> +
>  	/*
> -	 * For 64-bit kernel, __va can't be used since it would return a linear
> -	 * mapping address whereas dtb_early_va will be used before
> -	 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
> -	 * kernel is mapped in the linear mapping, that makes no difference.
> +	 * Setup early PGD covering entire kernel which will allow
> +	 * us to reach paging_init(). We map all memory banks later
> +	 * in setup_vm_final() below.
>  	 */
> -	dtb_early_va = kernel_mapping_pa_to_va(XIP_FIXUP(dtb_pa));
> -#endif
> +	create_kernel_page_table(early_pg_dir, true);
>
> -	dtb_early_pa = dtb_pa;
> +	/* Setup early mapping for FDT early scan */
> +	create_fdt_early_page_table(early_pg_dir, dtb_pa);
>  }
> +#endif
>
>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  {
> @@ -600,45 +624,21 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  	BUG_ON((PAGE_OFFSET % PGDIR_SIZE) != 0);
>  	BUG_ON((kernel_map.phys_addr % PMD_SIZE) != 0);
>
> -	pt_ops.alloc_pte = alloc_pte_early;
> -	pt_ops.get_pte_virt = get_pte_virt_early;
> -#ifndef __PAGETABLE_PMD_FOLDED
> -	pt_ops.alloc_pmd = alloc_pmd_early;
> -	pt_ops.get_pmd_virt = get_pmd_virt_early;
> -#endif
> -	/* Setup early PGD for fixmap */
> -	create_pgd_mapping(early_pg_dir, FIXADDR_START,
> -			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
> +	setup_early_page_table(dtb_pa);
>
> -#ifndef __PAGETABLE_PMD_FOLDED
> -	/* Setup fixmap PMD */
> -	create_pmd_mapping(fixmap_pmd, FIXADDR_START,
> -			   (uintptr_t)fixmap_pte, PMD_SIZE, PAGE_TABLE);
> -	/* Setup trampoline PGD and PMD */
> -	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
> -			   (uintptr_t)trampoline_pmd, PGDIR_SIZE, PAGE_TABLE);
> -#ifdef CONFIG_XIP_KERNEL
> -	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> -			   kernel_map.xiprom, PMD_SIZE, PAGE_KERNEL_EXEC);
> -#else
> -	create_pmd_mapping(trampoline_pmd, kernel_map.virt_addr,
> -			   kernel_map.phys_addr, PMD_SIZE, PAGE_KERNEL_EXEC);
> -#endif
> +#ifndef CONFIG_BUILTIN_DTB
> +	dtb_early_va = (void *)DTB_EARLY_BASE_VA + (dtb_pa & (PMD_SIZE - 1));
>  #else
> -	/* Setup trampoline PGD */
> -	create_pgd_mapping(trampoline_pg_dir, kernel_map.virt_addr,
> -			   kernel_map.phys_addr, PGDIR_SIZE, PAGE_KERNEL_EXEC);
> -#endif
> -
>  	/*
> -	 * Setup early PGD covering entire kernel which will allow
> -	 * us to reach paging_init(). We map all memory banks later
> -	 * in setup_vm_final() below.
> +	 * For 64-bit kernel, __va can't be used since it would return a linear
> +	 * mapping address whereas dtb_early_va will be used before
> +	 * setup_vm_final installs the linear mapping. For 32-bit kernel, as the
> +	 * kernel is mapped in the linear mapping, that makes no difference.
>  	 */
> -	create_kernel_page_table(early_pg_dir, true);
> +	dtb_early_va = kernel_mapping_pa_to_va(dtb_pa);
> +#endif
>
> -	/* Setup early mapping for FDT early scan */
> -	create_fdt_early_page_table(early_pg_dir, dtb_pa);
> +	dtb_early_pa = dtb_pa;
>
>  	/*
>  	 * Bootime fixmap only can handle PMD_SIZE mapping. Thus, boot-ioremap
