Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562A0374F09
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhEFFwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 01:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbhEFFwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 01:52:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B10C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 22:51:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cl24-20020a17090af698b0290157efd14899so2859678pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 22:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=204InDvewW0NeAJe9RK09seUjAHujsEPcmvcETgwrDQ=;
        b=SLYXAzavXatL/HITRf6jPa6vQx2t1toKfYB74ZiRwxSKGfkVdkkPJ6Fym06SaqucKo
         EszZqhHA++wPWIcS7N+Sq9Fmp7vje0gKRfnQFvopgb5XfXRsXqwy2iDHfiDJo9ENWC2+
         VJb7tL056p7ar1wPNbl8Qk9DbyxSH80CJfpKf+ObJVt7LlXJQ5exB/AvgQaBhmqDIQUW
         dPWiejN+zoep7CDi6Oaa63FbtW2p2k3hzogzbGdoR6BX0bgHXJQXYFa0XWN7IBq2Z8Nw
         x9gCIvk+wcCEnFJ+G4mfELjI/kYBX4l3jfPeVe1dtrosnYO7FB+1+BmQL0YroFZt5Spp
         6l4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=204InDvewW0NeAJe9RK09seUjAHujsEPcmvcETgwrDQ=;
        b=GWh2YZ2pW7NCsbpJdhTC5ecijYufjdVD3NczyNKRlnThEPWHLMTPcQEbwFASFdvgWZ
         WO+x0W25pSpDrkponvAY6ZoCKPkZDebPdrBDWfHQuSl/g+nFBjNQaK96P/9y0CysmUyy
         mV8+5Cti0mN29Xyy89fCeRm4xai38459l5nYSKV2AlsCqkH5eisZOGgRuhVSsQ7Hmgul
         F5lwgOFXF/F/z/WCclr3aEyalij2HR7J85yHA+G8Ge1MEQfsD4Ja4nwBlK0lI0rtnsk4
         mp53XYDO6+UVWPxDwsGI+YPH7nK4ocjXPX2kI7zjG3X77PT/5QQWpLkmW1+6Y79RM6M8
         3U3A==
X-Gm-Message-State: AOAM531CbCRr4A9julAofFTq4DxLDMv3l7/Ady4BA+4vEEupY7ftIXoP
        jFNn4l1j3GXPzSnJl5+QCgswjZgoZHvE4g==
X-Google-Smtp-Source: ABdhPJyewRx2byCP1QEiftZm9jKj07xJ0E1APwRjLhPf910LwDygUtaq7pAQDbTWXtqYd4NpNLsywA==
X-Received: by 2002:a17:902:bcc3:b029:ed:4637:fb2f with SMTP id o3-20020a170902bcc3b02900ed4637fb2fmr2978586pls.72.1620280296555;
        Wed, 05 May 2021 22:51:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g21sm953420pjl.28.2021.05.05.22.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 22:51:36 -0700 (PDT)
Date:   Wed, 05 May 2021 22:51:36 -0700 (PDT)
X-Google-Original-Date: Wed, 05 May 2021 22:51:31 PDT (-0700)
Subject: [GIT PULL] RISC-V Patches for the 5.13 Merge Window, Part 1
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-723be372-8df5-44b9-9e4f-def2eb929f8e@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.13-mw0

for you to fetch changes up to f54c7b5898d31eda3d6608da13b55c0466ba49fe:

  RISC-V: Always define XIP_FIXUP (2021-05-01 08:53:41 -0700)

----------------------------------------------------------------
RISC-V Patches for the 5.13 Merge Window, Part 1

* Support for the memtest= kernel command-line argument.
* Support for building the kernel with FORTIFY_SOURCE.
* Support for generic clockevent broadcasts.
* Support for the buildtar build target.
* Some build system cleanups to pass more LLVM-friendly arguments.
* Support for kprobes.
* A rearranged kernel memory map, the first part of supporting sv48
  systems.
* Improvements to kexec, along with support for kdump and crash kernels.
* An alternatives-based errata framework, along with support for
  handling a pair of errata that manifest on some SiFive designs
  (including the HiFive Unmatched).
* Support for XIP.
* A device tree for the Microchip PolarFire ICICLE SoC and associated
  dev board.

Along with a bunch of cleanups.  There are already a handful of fixes
on the list so there will likely be a part 2.

----------------------------------------------------------------
I had a handful of merge conflicts.  One was in the documentation and I don't
think there's anything we can do about that, but two were between my trees and
those aren't really necessary.  We've bumped up against this for a few cycles
now and I'm going to change up my workflow to avoid this sort of thing
happening again.

Here are my conflict resolutions, if that helps:

diff --cc Documentation/admin-guide/kernel-parameters.txt
index 20447b531630,a1266f33d6e6..5bcc229d31e2
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@@ -2794,7 -2804,24 +2804,24 @@@
  			seconds.  Use this parameter to check at some
  			other rate.  0 disables periodic checking.
  
+ 	memory_hotplug.memmap_on_memory
+ 			[KNL,X86,ARM] Boolean flag to enable this feature.
+ 			Format: {on | off (default)}
+ 			When enabled, runtime hotplugged memory will
+ 			allocate its internal metadata (struct pages)
+ 			from the hotadded memory which will allow to
+ 			hotadd a lot of memory without requiring
+ 			additional memory to do so.
+ 			This feature is disabled by default because it
+ 			has some implication on large (e.g. GB)
+ 			allocations in some configurations (e.g. small
+ 			memory blocks).
+ 			The state of the flag can be read in
+ 			/sys/module/memory_hotplug/parameters/memmap_on_memory.
+ 			Note that even when enabled, there are a few cases where
+ 			the feature is not effective.
+ 
 -	memtest=	[KNL,X86,ARM,PPC] Enable memtest
 +	memtest=	[KNL,X86,ARM,PPC,RISCV] Enable memtest
  			Format: <integer>
  			default : 0 <disable>
  			Specifies the number of memtest passes to be
diff --cc arch/riscv/Kconfig
index 6ddf5a2eb84d,6860c0c21190..a8ad8eb76120
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@@ -28,11 -27,10 +28,12 @@@ config RISC
  	select ARCH_HAS_PTE_SPECIAL
  	select ARCH_HAS_SET_DIRECT_MAP
  	select ARCH_HAS_SET_MEMORY
 -	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
 +	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
 +	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
 +	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
+ 	select ARCH_SUPPORTS_HUGETLBFS if MMU
  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
  	select ARCH_WANT_FRAME_POINTERS
  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
diff --cc arch/riscv/kernel/Makefile
index 56d5cd2a5982,647a47f5484a..d3081e4d9600
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@@ -8,11 -8,8 +8,12 @@@ CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTR
  CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
  CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
  endif
+ CFLAGS_syscall_table.o	+= $(call cc-option,-Wno-override-init,)
  
 +ifdef CONFIG_KEXEC
 +AFLAGS_kexec_relocate.o := -mcmodel=medany -mno-relax
 +endif
 +
  extra-y += head.o
  extra-y += vmlinux.lds
  
diff --cc arch/riscv/kernel/setup.c
index 7b31779101f6,f8f15332caa2..5638f85e82f6
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@@ -148,14 -129,26 +148,15 @@@ static void __init init_resources(void
  	struct resource *res = NULL;
  	struct resource *mem_res = NULL;
  	size_t mem_res_sz = 0;
 -	int ret = 0, i = 0;
 -
 -	code_res.start = __pa_symbol(_text);
 -	code_res.end = __pa_symbol(_etext) - 1;
 -	code_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 -
 -	rodata_res.start = __pa_symbol(__start_rodata);
 -	rodata_res.end = __pa_symbol(__end_rodata) - 1;
 -	rodata_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 -
 -	data_res.start = __pa_symbol(_data);
 -	data_res.end = __pa_symbol(_edata) - 1;
 -	data_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 +	int num_resources = 0, res_idx = 0;
 +	int ret = 0;
  
 -	bss_res.start = __pa_symbol(__bss_start);
 -	bss_res.end = __pa_symbol(__bss_stop) - 1;
 -	bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
 +	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
 +	num_resources = memblock.memory.cnt + memblock.reserved.cnt + 1;
 +	res_idx = num_resources - 1;
  
- 	mem_res_sz = num_resources * sizeof(*mem_res);
+ 	/* + 1 as memblock_alloc() might increase memblock.reserved.cnt */
+ 	mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt + 1) * sizeof(*mem_res);
  	mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
  	if (!mem_res)
  		panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);
diff --cc arch/riscv/kernel/time.c
index 302ceafe0f81,1b432264f7ef..8217b0f67c6c
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@@ -9,8 -9,9 +9,9 @@@
  #include <linux/delay.h>
  #include <asm/sbi.h>
  #include <asm/processor.h>
+ #include <asm/timex.h>
  
 -unsigned long riscv_timebase;
 +unsigned long riscv_timebase __ro_after_init;
  EXPORT_SYMBOL_GPL(riscv_timebase);
  
  void __init time_init(void)
diff --cc arch/riscv/mm/kasan_init.c
index 4fa412a314f9,937d13ce9ab8..c3e3db5177aa
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@@ -162,8 -159,36 +162,10 @@@ static void __init kasan_shallow_popula
  {
  	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
  	unsigned long vend = PAGE_ALIGN((unsigned long)end);
 -	unsigned long pfn;
 -	int index;
 -	void *p;
 -	pud_t *pud_dir, *pud_k;
 -	pgd_t *pgd_dir, *pgd_k;
 -	p4d_t *p4d_dir, *p4d_k;
 -
 -	while (vaddr < vend) {
 -		index = pgd_index(vaddr);
 -		pfn = csr_read(CSR_SATP) & SATP_PPN;
 -		pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
 -		pgd_k = init_mm.pgd + index;
 -		pgd_dir = pgd_offset_k(vaddr);
 -		set_pgd(pgd_dir, *pgd_k);
 -
 -		p4d_dir = p4d_offset(pgd_dir, vaddr);
 -		p4d_k  = p4d_offset(pgd_k, vaddr);
 -
 -		vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
 -		pud_dir = pud_offset(p4d_dir, vaddr);
 -		pud_k = pud_offset(p4d_k, vaddr);
 -
 -		if (pud_present(*pud_dir)) {
 -			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 -			pud_populate(&init_mm, pud_dir, p);
 -		}
 -		vaddr += PAGE_SIZE;
 -	}
 +
 +	kasan_shallow_populate_pgd(vaddr, vend);
+ 
+ 	local_flush_tlb_all();
  }
  
  void __init kasan_init(void)
@@@ -196,12 -216,8 +198,12 @@@
  			break;
  
  		kasan_populate(kasan_mem_to_shadow(start), kasan_mem_to_shadow(end));
- 	};
+ 	}
  
 +	/* Populate kernel, BPF, modules mapping */
 +	kasan_populate(kasan_mem_to_shadow((const void *)MODULES_VADDR),
 +		       kasan_mem_to_shadow((const void *)BPF_JIT_REGION_END));
 +
  	for (i = 0; i < PTRS_PER_PTE; i++)
  		set_pte(&kasan_early_shadow_pte[i],
  			mk_pte(virt_to_page(kasan_early_shadow_page),


----------------------------------------------------------------
Alexandre Ghiti (6):
      riscv: Cleanup KASAN_VMALLOC support
      riscv: Move kernel mapping outside of linear mapping
      Documentation: riscv: Add documentation that describes the VM layout
      riscv: Prepare ptdump for vm layout dynamic addresses
      riscv: Fix 32b kernel build with CONFIG_DEBUG_VIRTUAL=y
      riscv: Remove 32b kernel mapping from page table dump

Anup Patel (2):
      RISC-V: Don't print SBI version for all detected extensions
      RISC-V: Fix error code returned by riscv_hartid_to_cpuid()

Atish Patra (4):
      RISC-V: Add Microchip PolarFire SoC kconfig option
      dt-bindings: riscv: microchip: Add YAML documentation for the PolarFire SoC
      RISC-V: Initial DTS for Microchip ICICLE board
      RISC-V: Enable Microchip PolarFire ICICLE SoC

Carlos de Paula (1):
      kbuild: buildtar: add riscv support

Guo Ren (1):
      riscv: Enable generic clockevent broadcast

Jisheng Zhang (11):
      samples/kprobes: Add riscv support
      riscv: add __init section marker to some functions
      riscv: Mark some global variables __ro_after_init
      riscv: Constify sys_call_table
      riscv: Constify sbi_ipi_ops
      riscv: kprobes: Implement alloc_insn_page()
      riscv: bpf: Move bpf_jit_alloc_exec() and bpf_jit_free_exec() to core
      riscv: bpf: Avoid breaking W^X
      riscv: module: Create module allocations without exec permissions
      riscv: Set ARCH_HAS_STRICT_MODULE_RWX if MMU
      riscv: vdso: fix and clean-up Makefile

Kefeng Wang (2):
      riscv: Add support for memtest
      riscv: Add ARCH_HAS_FORTIFY_SOURCE

Liao Chang (1):
      riscv/kprobe: fix kernel panic when invoking sys_read traced by kprobe

Nathan Chancellor (4):
      riscv: Use $(LD) instead of $(CC) to link vDSO
      scripts/recordmcount.pl: Fix RISC-V regex for clang
      riscv: Workaround mcount name prior to clang-13
      riscv: Select HAVE_DYNAMIC_FTRACE when -fpatchable-function-entry is available

Nick Kossifidis (5):
      RISC-V: Add EM_RISCV to kexec UAPI header
      RISC-V: Add kexec support
      RISC-V: Improve init_resources()
      RISC-V: Add kdump support
      RISC-V: Add crash kernel support

Palmer Dabbelt (1):
      RISC-V: Always define XIP_FIXUP

Vincent Chen (5):
      riscv: Add 3 SBI wrapper functions to get cpu manufacturer information
      riscv: Introduce alternative mechanism to apply errata solution
      riscv: sifive: Add SiFive alternative ports
      riscv: sifive: Apply errata "cip-453" patch
      riscv: sifive: Apply errata "cip-1200" patch

Vitaly Wool (1):
      RISC-V: enable XIP

zhouchuangao (1):
      riscv/mm: Use BUG_ON instead of if condition followed by BUG.

 Documentation/admin-guide/kernel-parameters.txt    |   2 +-
 .../devicetree/bindings/riscv/microchip.yaml       |  27 ++
 Documentation/riscv/index.rst                      |   1 +
 Documentation/riscv/vm-layout.rst                  |  63 ++++
 arch/riscv/Kconfig                                 |  90 +++++-
 arch/riscv/Kconfig.erratas                         |  44 +++
 arch/riscv/Kconfig.socs                            |   8 +
 arch/riscv/Makefile                                |   9 +-
 arch/riscv/boot/Makefile                           |  13 +
 arch/riscv/boot/dts/Makefile                       |   1 +
 arch/riscv/boot/dts/microchip/Makefile             |   2 +
 .../dts/microchip/microchip-mpfs-icicle-kit.dts    |  72 +++++
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi  | 329 ++++++++++++++++++++
 arch/riscv/boot/loader.lds.S                       |   3 +-
 arch/riscv/configs/defconfig                       |   4 +
 arch/riscv/errata/Makefile                         |   2 +
 arch/riscv/errata/alternative.c                    |  74 +++++
 arch/riscv/errata/sifive/Makefile                  |   2 +
 arch/riscv/errata/sifive/errata.c                  | 106 +++++++
 arch/riscv/errata/sifive/errata_cip_453.S          |  38 +++
 arch/riscv/include/asm/alternative-macros.h        | 142 +++++++++
 arch/riscv/include/asm/alternative.h               |  39 +++
 arch/riscv/include/asm/asm.h                       |   1 +
 arch/riscv/include/asm/csr.h                       |   3 +
 arch/riscv/include/asm/elf.h                       |   6 +
 arch/riscv/include/asm/errata_list.h               |  39 +++
 arch/riscv/include/asm/ftrace.h                    |  14 +-
 arch/riscv/include/asm/kexec.h                     |  56 ++++
 arch/riscv/include/asm/page.h                      |  47 ++-
 arch/riscv/include/asm/pgtable.h                   |  65 +++-
 arch/riscv/include/asm/sbi.h                       |   3 +
 arch/riscv/include/asm/sections.h                  |   1 +
 arch/riscv/include/asm/set_memory.h                |   1 +
 arch/riscv/include/asm/smp.h                       |   4 +-
 arch/riscv/include/asm/string.h                    |   5 +
 arch/riscv/include/asm/syscall.h                   |   2 +-
 arch/riscv/include/asm/tlbflush.h                  |   3 +-
 arch/riscv/include/asm/vendorid_list.h             |  10 +
 arch/riscv/kernel/Makefile                         |   6 +
 arch/riscv/kernel/crash_dump.c                     |  46 +++
 arch/riscv/kernel/crash_save_regs.S                |  56 ++++
 arch/riscv/kernel/entry.S                          |   6 +-
 arch/riscv/kernel/head.S                           |  49 ++-
 arch/riscv/kernel/head.h                           |   3 +
 arch/riscv/kernel/kexec_relocate.S                 | 223 ++++++++++++++
 arch/riscv/kernel/machine_kexec.c                  | 193 ++++++++++++
 arch/riscv/kernel/mcount.S                         |  10 +-
 arch/riscv/kernel/module.c                         |   8 +-
 arch/riscv/kernel/probes/kprobes.c                 |  12 +-
 arch/riscv/kernel/sbi.c                            |  31 +-
 arch/riscv/kernel/setup.c                          | 129 +++++---
 arch/riscv/kernel/smp.c                            |  24 +-
 arch/riscv/kernel/smpboot.c                        |   4 +
 arch/riscv/kernel/syscall_table.c                  |   2 +-
 arch/riscv/kernel/time.c                           |   2 +-
 arch/riscv/kernel/traps.c                          |   2 +-
 arch/riscv/kernel/vdso.c                           |   4 +-
 arch/riscv/kernel/vdso/Makefile                    |  16 +-
 arch/riscv/kernel/vmlinux-xip.lds.S                | 133 ++++++++
 arch/riscv/kernel/vmlinux.lds.S                    |  16 +-
 arch/riscv/mm/fault.c                              |  13 +
 arch/riscv/mm/init.c                               | 337 +++++++++++++++++++--
 arch/riscv/mm/kasan_init.c                         |  74 ++---
 arch/riscv/mm/physaddr.c                           |   2 +-
 arch/riscv/mm/ptdump.c                             |  75 ++++-
 arch/riscv/net/bpf_jit_comp64.c                    |  13 -
 arch/riscv/net/bpf_jit_core.c                      |  14 +
 include/uapi/linux/kexec.h                         |   1 +
 samples/kprobes/kprobe_example.c                   |   8 +
 scripts/package/buildtar                           |   8 +
 scripts/recordmcount.pl                            |   2 +-
 71 files changed, 2637 insertions(+), 216 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/riscv/microchip.yaml
 create mode 100644 Documentation/riscv/vm-layout.rst
 create mode 100644 arch/riscv/Kconfig.erratas
 create mode 100644 arch/riscv/boot/dts/microchip/Makefile
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
 create mode 100644 arch/riscv/errata/Makefile
 create mode 100644 arch/riscv/errata/alternative.c
 create mode 100644 arch/riscv/errata/sifive/Makefile
 create mode 100644 arch/riscv/errata/sifive/errata.c
 create mode 100644 arch/riscv/errata/sifive/errata_cip_453.S
 create mode 100644 arch/riscv/include/asm/alternative-macros.h
 create mode 100644 arch/riscv/include/asm/alternative.h
 create mode 100644 arch/riscv/include/asm/errata_list.h
 create mode 100644 arch/riscv/include/asm/kexec.h
 create mode 100644 arch/riscv/include/asm/vendorid_list.h
 create mode 100644 arch/riscv/kernel/crash_dump.c
 create mode 100644 arch/riscv/kernel/crash_save_regs.S
 create mode 100644 arch/riscv/kernel/kexec_relocate.S
 create mode 100644 arch/riscv/kernel/machine_kexec.c
 create mode 100644 arch/riscv/kernel/vmlinux-xip.lds.S
