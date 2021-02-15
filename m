Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3399231BB05
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhBOOZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:25:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhBOOZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:25:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07D5664DDA;
        Mon, 15 Feb 2021 14:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613399058;
        bh=WzRlqDb+KM3KnQQxdMe8yShHTmNhXGHIiMbPcaisIkI=;
        h=Date:From:To:Cc:Subject:From;
        b=o6Bzm7kthOh9mtl5NgrmwUfR6+T0V4AiAiajgHdDcdec+Wpbm8LfZyXLx0vkVEliR
         Gb4Vy1VFQHGK9Ds1TfoSpWisNS2bNGNcr7HTdpHlfg5kKnevs7pJfcy0RxObraSrel
         ZEDbazby4CR9LOcjfWFupZzoXXwEpQ82b108l7Q9BZrhKiASdovBagatf8Am1vLmut
         53yRuZWrBCefVJKoZbFfohik+iD3qJ/bWQFoRUpr+z08MCiecFUydPIuuKRNCrOs3J
         KeZq+pUvX70fUt1vrCeEvLgP9KWMSNhMwrDF8m3gLrU8XjUNWF+CWBLCYvJxpUHyKm
         6525R7D7NwpZQ==
Date:   Mon, 15 Feb 2021 14:24:12 +0000
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, tytso@mit.edu, ardb@kernel.org
Subject: [GIT PULL] arm64 updates for 5.12
Message-ID: <20210215142412.GA1644@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 updates for 5.12. There's a summary in the tag
and we've only had a couple of trivial conflicts reported in -next, so
it should be plain sailing.

In terms of the diffstat, a couple of things stand out:

  - The faultaround patches to initialise prefaulted PTEs as 'old'
    bring in a bunch of changes to mm/, largely due to the rework from
    Kirill.

  - We have a change to drivers/char/random.c to avoid calling
    arch_get_random_seed_long() from add_interrupt_randomness(). We
    didn't have any luck getting a response from Ted on this [1], but
    since we need this change in order to enable the firmware-backed
    TRNG service, I've ended up including it here.

Cheers,

Will

[1] https://lore.kernel.org/linux-arm-kernel/CAMj1kXH2N_e722TiSU6_uUs_arjkBipwUnfD8=xj1etKE11DRQ@mail.gmail.com/

--->8

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 1ffa9763828cf73a4d4eaa04c29a4a89fb0708c7:

  Merge branch 'for-next/vdso' into for-next/core (2021-02-12 15:17:42 +0000)

----------------------------------------------------------------
arm64 updates for 5.12

 - vDSO build improvements including support for building with BSD.

 - Cleanup to the AMU support code and initialisation rework to support
   cpufreq drivers built as modules.

 - Removal of synthetic frame record from exception stack when entering
   the kernel from EL0.

 - Add support for the TRNG firmware call introduced by Arm spec
   DEN0098.

 - Cleanup and refactoring across the board.

 - Avoid calling arch_get_random_seed_long() from
   add_interrupt_randomness()

 - Perf and PMU updates including support for Cortex-A78 and the v8.3
   SPE extensions.

 - Significant steps along the road to leaving the MMU enabled during
   kexec relocation.

 - Faultaround changes to initialise prefaulted PTEs as 'old' when
   hardware access-flag updates are supported, which drastically
   improves vmscan performance.

 - CPU errata updates for Cortex-A76 (#1463225) and Cortex-A55
   (#1024718)

 - Preparatory work for yielding the vector unit at a finer granularity
   in the crypto code, which in turn will one day allow us to defer
   softirq processing when it is in use.

 - Support for overriding CPU ID register fields on the command-line.

----------------------------------------------------------------
Andre Przywara (2):
      firmware: smccc: Introduce SMCCC TRNG framework
      arm64: Add support for SMCCC TRNG entropy source

Anshuman Khandual (1):
      arm64/mm: Add warning for outside range requests in vmemmap_populate()

Ard Biesheuvel (3):
      firmware: smccc: Add SMCCC TRNG function call IDs
      random: avoid arch_get_random_seed_long() when collecting IRQ randomness
      arm64: assembler: add cond_yield macro

Geert Uytterhoeven (1):
      mm/nommu: Fix return type of filemap_map_pages()

Hailong Liu (1):
      arm64/ptdump:display the Linear Mapping start marker

James Morse (2):
      arm64: mm: Always update TCR_EL1 from __cpu_set_tcr_t0sz()
      arm64: trans_pgd: hibernate: idmap the single page that holds the copy page routines

Joey Gouly (2):
      arm64: vmlinux.ld.S: add assertion for reserved_pg_dir offset
      arm64: vmlinux.ld.S: add assertion for tramp_pg_dir offset

John Millikin (1):
      arm64: Support running gen_vdso_offsets.sh with BSD userland.

Keno Fischer (1):
      arm64: ptrace: Fix missing return in hw breakpoint code

Kirill A. Shutemov (1):
      mm: Cleanup faultaround and finish_fault() codepaths

Marc Zyngier (22):
      arm64: Drop workaround for broken 'S' constraint with GCC 4.9
      arm64: Fix labels in el2_setup macros
      arm64: Fix outdated TCR setup comment
      arm64: Turn the MMU-on sequence into a macro
      arm64: Provide an 'upgrade to VHE' stub hypercall
      arm64: Initialise as nVHE before switching to VHE
      arm64: Drop early setting of MDSCR_EL2.TPMS
      arm64: Move VHE-specific SPE setup to mutate_to_vhe()
      arm64: Simplify init_el2_state to be non-VHE only
      arm64: Move SCTLR_EL1 initialisation to EL-agnostic code
      arm64: cpufeature: Add global feature override facility
      arm64: cpufeature: Use IDreg override in __read_sysreg_by_encoding()
      arm64: Extract early FDT mapping from kaslr_early_init()
      arm64: cpufeature: Add an early command-line cpufeature override facility
      arm64: Allow ID_AA64MMFR1_EL1.VH to be overridden from the command line
      arm64: Honor VHE being disabled from the command-line
      arm64: Add an aliasing facility for the idreg override
      arm64: Make kvm-arm.mode={nvhe, protected} an alias of id_aa64mmfr1.vh=0
      KVM: arm64: Document HVC_VHE_RESTART stub hypercall
      arm64: Move "nokaslr" over to the early cpufeature infrastructure
      arm64: cpufeatures: Allow disabling of BTI from the command-line
      arm64: cpufeatures: Allow disabling of Pointer Auth from the command-line

Mark Rutland (2):
      arm64: remove EL0 exception frame record
      arm64: entry: consolidate Cortex-A76 erratum 1463225 workaround

Masahiro Yamada (1):
      arm64: do not descend to vdso directories twice

Miaohe Lin (1):
      mm/arm64: Correct obsolete comment in do_page_fault()

Nathan Chancellor (1):
      arm64: Make CPU_BIG_ENDIAN depend on ld.bfd or ld.lld 13.0.0+

Pavel Tatashin (11):
      arm64: kexec: make dtb_mem always enabled
      arm64: hibernate: variable pudp is used instead of pd4dp
      arm64: hibernate: move page handling function to new trans_pgd.c
      arm64: trans_pgd: make trans_pgd_map_page generic
      arm64: trans_pgd: pass allocator trans_pgd_create_copy
      arm64: trans_pgd: pass NULL instead of init_mm to *_populate functions
      arm64: kexec: move relocation function setup
      arm64: kexec: call kexec_image_info only once
      arm64: kexec: arm64_relocate_new_kernel clean-ups and optimizations
      arm64: kexec: arm64_relocate_new_kernel don't use x0 as temp
      arm64: hibernate: add __force attribute to gfp_t casting

Qi Liu (2):
      drivers/perf: Prevent forced unbinding of ARM_DMC620_PMU drivers
      drivers/perf: Replace spin_lock_irqsave to spin_lock

Quentin Perret (1):
      KVM: arm64: Move __hyp_set_vectors out of .hyp.text

Rikard Falkeborn (5):
      perf: qcom: Constify static struct attribute_group
      perf/imx_ddr: Constify static struct attribute_group
      perf: hisi: Constify static struct attribute_group
      perf: Constify static struct attribute_group
      arm64: perf: Constify static attribute_group structs

Robin Murphy (2):
      perf/arm-cmn: Fix PMU instance naming
      perf/arm-cmn: Move IRQs when migrating context

Seiya Wang (2):
      arm64: perf: add support for Cortex-A78
      dt-bindings: arm: add Cortex-A78 binding

Shaokun Zhang (2):
      arm64: mm: Remove unused header file
      arm64: cacheflush: Remove stale comment

Srinivas Ramana (1):
      arm64: Defer enabling pointer authentication on boot core

Sudarshan Rajagopalan (1):
      arm64/sparsemem: reduce SECTION_SIZE_BITS

Suzuki K Poulose (1):
      arm64: Extend workaround for erratum 1024718 to all versions of Cortex-A55

Viresh Kumar (3):
      arm64: topology: Avoid the have_policy check
      arm64: topology: Reorder init_amu_fie() a bit
      arm64: topology: Make AMUs work with modular cpufreq drivers

Wei Li (1):
      drivers/perf: Add support for ARMv8.3-SPE

Will Deacon (23):
      mm: Allow architectures to request 'old' entries when prefaulting
      arm64: mm: Implement arch_wants_old_prefaulted_pte()
      mm: Move immutable fields of 'struct vm_fault' into anonymous struct
      mm: Pass 'address' to map to do_set_pte() and drop FAULT_FLAG_PREFAULT
      mm: Avoid modifying vmf.address in __collapse_huge_page_swapin()
      mm: Use static initialisers for immutable fields of 'struct vm_fault'
      mm: Mark anonymous struct field of 'struct vm_fault' as 'const'
      arm64: Include linux/io.h in mm/mmap.c
      mm: filemap: Fix microblaze build failure with 'mmu_defconfig'
      Merge branch 'for-next/cosmetic' into for-next/core
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/crypto' into for-next/core
      Merge branch 'for-next/errata' into for-next/core
      Merge branch 'for-next/faultaround' into for-next/core
      Merge branch 'for-next/kexec' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/random' into for-next/core
      Merge branch 'for-next/rng' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core
      Merge branch 'for-next/stacktrace' into for-next/core
      Merge branch 'for-next/topology' into for-next/core
      Merge branch 'for-next/vdso' into for-next/core

YANG LI (1):
      arm64: mte: style: Simplify bool comparison

Zhiyuan Dai (1):
      arm64: improve whitespace

 Documentation/admin-guide/kernel-parameters.txt    |   9 +
 Documentation/admin-guide/perf/arm-cmn.rst         |   2 +-
 Documentation/devicetree/bindings/arm/pmu.yaml     |   1 +
 Documentation/virt/kvm/arm/hyp-abi.rst             |   9 +
 arch/arm/include/asm/archrandom.h                  |  10 +
 arch/arm64/Kconfig                                 |  11 +-
 arch/arm64/Makefile                                |  10 +-
 arch/arm64/include/asm/archrandom.h                |  82 +++++-
 arch/arm64/include/asm/asm-uaccess.h               |   4 +-
 arch/arm64/include/asm/assembler.h                 |  33 +++
 arch/arm64/include/asm/cacheflush.h                |   5 -
 arch/arm64/include/asm/cpufeature.h                |  11 +
 arch/arm64/include/asm/el2_setup.h                 |  60 ++--
 arch/arm64/include/asm/kexec.h                     |   5 +-
 arch/arm64/include/asm/kvm_asm.h                   |   8 +-
 arch/arm64/include/asm/memory.h                    |  12 +
 arch/arm64/include/asm/mmu_context.h               |   7 +-
 arch/arm64/include/asm/pgtable.h                   |  12 +-
 arch/arm64/include/asm/pointer_auth.h              |  10 +
 arch/arm64/include/asm/setup.h                     |  11 +
 arch/arm64/include/asm/sparsemem.h                 |  23 +-
 arch/arm64/include/asm/stackprotector.h            |   1 +
 arch/arm64/include/asm/sysreg.h                    |   9 +-
 arch/arm64/include/asm/trans_pgd.h                 |  39 +++
 arch/arm64/include/asm/uaccess.h                   |   2 +-
 arch/arm64/include/asm/virt.h                      |   7 +-
 arch/arm64/kernel/Makefile                         |   7 +-
 arch/arm64/kernel/alternative.c                    |   2 +-
 arch/arm64/kernel/asm-offsets.c                    |   3 +
 arch/arm64/kernel/cpu_errata.c                     |   2 -
 arch/arm64/kernel/cpufeature.c                     |  75 ++++-
 arch/arm64/kernel/entry-common.c                   |  54 +++-
 arch/arm64/kernel/entry.S                          |  14 +-
 arch/arm64/kernel/head.S                           |  75 +----
 arch/arm64/kernel/hibernate.c                      | 271 ++---------------
 arch/arm64/kernel/hyp-stub.S                       | 115 +++++++-
 arch/arm64/kernel/idreg-override.c                 | 216 ++++++++++++++
 arch/arm64/kernel/kaslr.c                          |  43 +--
 arch/arm64/kernel/machine_kexec.c                  |  57 ++--
 arch/arm64/kernel/module-plts.c                    |   2 +-
 arch/arm64/kernel/perf_event.c                     |  15 +-
 arch/arm64/kernel/process.c                        |   4 +-
 arch/arm64/kernel/ptrace.c                         |   1 +
 arch/arm64/kernel/relocate_kernel.S                |  48 +--
 arch/arm64/kernel/setup.c                          |  15 +
 arch/arm64/kernel/sleep.S                          |   1 +
 arch/arm64/kernel/stacktrace.c                     |  13 +-
 arch/arm64/kernel/syscall.c                        |  30 --
 arch/arm64/kernel/topology.c                       | 115 ++++----
 arch/arm64/kernel/traps.c                          |   2 +-
 arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S}     |   0
 arch/arm64/kernel/vdso/Makefile                    |   1 -
 arch/arm64/kernel/vdso/gen_vdso_offsets.sh         |   2 +-
 arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} |   0
 arch/arm64/kernel/vdso32/Makefile                  |   1 -
 arch/arm64/kernel/vmlinux.lds.S                    |   8 +
 arch/arm64/kvm/arm.c                               |   3 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S                 |   2 +-
 arch/arm64/mm/Makefile                             |   1 +
 arch/arm64/mm/fault.c                              |  34 +--
 arch/arm64/mm/mmap.c                               |  15 +-
 arch/arm64/mm/mmu.c                                |   4 +-
 arch/arm64/mm/proc.S                               |  16 +-
 arch/arm64/mm/ptdump.c                             |   1 +
 arch/arm64/mm/trans_pgd.c                          | 324 +++++++++++++++++++++
 drivers/char/random.c                              |  15 +-
 drivers/firmware/smccc/smccc.c                     |   6 +
 drivers/perf/arm-cci.c                             |   7 +-
 drivers/perf/arm-cmn.c                             |  19 +-
 drivers/perf/arm_dmc620_pmu.c                      |   5 +-
 drivers/perf/arm_pmu.c                             |   2 +-
 drivers/perf/arm_smmuv3_pmu.c                      |   8 +-
 drivers/perf/arm_spe_pmu.c                         |  23 +-
 drivers/perf/fsl_imx8_ddr_perf.c                   |  10 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |   2 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c       |   2 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c       |   2 +-
 drivers/perf/qcom_l2_pmu.c                         |   6 +-
 drivers/perf/qcom_l3_pmu.c                         |   6 +-
 drivers/perf/xgene_pmu.c                           |   5 +-
 fs/xfs/xfs_file.c                                  |   6 +-
 include/linux/arm-smccc.h                          |  31 ++
 include/linux/mm.h                                 |  25 +-
 include/linux/pgtable.h                            |  11 +
 mm/filemap.c                                       | 179 +++++++++---
 mm/khugepaged.c                                    |  37 ++-
 mm/memory.c                                        | 223 +++++---------
 mm/nommu.c                                         |   3 +-
 mm/shmem.c                                         |   6 +-
 mm/swapfile.c                                      |  11 +-
 .../selftests/arm64/mte/check_buffer_fill.c        |   2 +-
 91 files changed, 1652 insertions(+), 985 deletions(-)
 create mode 100644 arch/arm/include/asm/archrandom.h
 create mode 100644 arch/arm64/include/asm/setup.h
 create mode 100644 arch/arm64/include/asm/trans_pgd.h
 create mode 100644 arch/arm64/kernel/idreg-override.c
 rename arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S} (100%)
 rename arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} (100%)
 create mode 100644 arch/arm64/mm/trans_pgd.c
