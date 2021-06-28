Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030243B65B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbhF1PeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236874AbhF1PMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:12:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4711F60C3E;
        Mon, 28 Jun 2021 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624892988;
        bh=Umwo5rw5YNIp5jhzg+DTCU9WwNl+RQErseQjpH98jOY=;
        h=Date:From:To:Cc:Subject:From;
        b=jqR/gqQsjrolNPkY/orQ43kMGxddJYhKunuaug4sf9SaU5MOmLIjUw5ITbPVxNOmg
         mrQaTFUsE8NplTtboZv7CwwzqWHGgPTp/AXUVTw0ef/VKcGJMzf0Ncd66o/tk2TrKr
         HPG/F1/UWlhhtz6n58Wkpbfev+60MZs42M1yQBxrSiMqM6gQ8yWq4lTCOuVe754tbj
         c9yE+w6ZN7L17l+wxx8Hdyb3bfQUdTO5eNclOQMDfFIkBBQoGQRCSNSe6lcE0geQJD
         vGhaMYXAjykdXP6vCXN+kDiNS5ERZj1FIuqVC4nserRvLpR9OuK9dXHXjCZR2DNdA9
         KzmA5XLyKnGlw==
Date:   Mon, 28 Jun 2021 16:09:43 +0100
From:   Will Deacon <will@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     catalin.marinas@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: [GIT PULL] arm64 updates for 5.14
Message-ID: <20210628150943.GA6205@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pile of arm64 updates for 5.14. There's a reasonable
amount here and the juicy details are all in the tag. We've run into a
handful of trivial conflicts in -next, but please shout if any of the
resolutions are unclear.

It's worth noting that the MTE/KASAN changes strayed outside of our
usual directories due to core mm changes and some associated changes to
some other architectures; Andrew asked for us to carry these [1] rather
that take them via the -mm tree.

We've also pulled in a branch from -tip which allows our perf drivers to
handle IRQ affinity setting properly.

Cheers,

Will

[1] https://lore.kernel.org/linux-arm-kernel/20210603200308.2a08d25db0dc92430a545b4c@linux-foundation.org/

--->8

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

for you to fetch changes up to 3d1bf78c7b13a0ad88e77dce94df88400f47e0dd:

  Merge branch 'for-next/sve' into for-next/core (2021-06-24 14:07:04 +0100)

----------------------------------------------------------------
arm64 updates for 5.14

 - Optimise SVE switching for CPUs with 128-bit implementations.

 - Fix output format from SVE selftest.

 - Add support for versions v1.2 and 1.3 of the SMC calling convention.

 - Allow Pointer Authentication to be configured independently for
   kernel and userspace.

 - PMU driver cleanups for managing IRQ affinity and exposing event
   attributes via sysfs.

 - KASAN optimisations for both hardware tagging (MTE) and out-of-line
   software tagging implementations.

 - Relax frame record alignment requirements to facilitate 8-byte
   alignment with KASAN and Clang.

 - Cleanup of page-table definitions and removal of unused memory types.

 - Reduction of ARCH_DMA_MINALIGN back to 64 bytes.

 - Refactoring of our instruction decoding routines and addition of some
   missing encodings.

 - Move entry code moved into C and hardened against harmful compiler
   instrumentation.

 - Update booting requirements for the FEAT_HCX feature, added to v8.7
   of the architecture.

 - Fix resume from idle when pNMI is being used.

 - Additional CPU sanity checks for MTE and preparatory changes for
   systems where not all of the CPUs support 32-bit EL0.

 - Update our kernel string routines to the latest Cortex Strings
   implementation.

 - Big cleanup of our cache maintenance routines, which were confusingly
   named and inconsistent in their implementations.

 - Tweak linker flags so that GDB can understand vmlinux when using RELR
   relocations.

 - Boot path cleanups to enable early initialisation of per-cpu
   operations needed by KCSAN.

 - Non-critical fixes and miscellaneous cleanup.

----------------------------------------------------------------
Anshuman Khandual (8):
      arm64/mm: Validate CONFIG_PGTABLE_LEVELS
      arm64/mm: Remove [PUD|PMD]_TABLE_BIT from [pud|pmd]_bad()
      arm64/mm: Make vmemmap_free() available only with CONFIG_MEMORY_HOTPLUG
      arm64/mm: Drop SWAPPER_INIT_MAP_SIZE
      arm64/mm: Use CONT_PMD_SHIFT for ARM64_MEMSTART_SHIFT
      arm64/mm: Drop SECTION_[SHIFT|SIZE|MASK]
      arm64/mm: Fix ttbr0 values stored in struct thread_info for software-pan
      arm64/mm: Rename ARM64_SWAPPER_USES_SECTION_MAPS

Catalin Marinas (2):
      arm64: Change the cpuinfo_arm64 member type for some sysregs to u64
      arm64: Check if GMID_EL1.BS is the same on all CPUs

ChenXiaoSong (1):
      perf: qcom: Remove redundant dev_err call in qcom_l3_cache_pmu_probe()

Daniel Kiss (2):
      arm64: Add ARM64_PTR_AUTH_KERNEL config option
      arm64: Conditionally configure PTR_AUTH key of the kernel.

Dong Aisheng (3):
      arm64: mm: fix the count comments in compute_indices
      arm64: mm: drop unused __pa(__idmap_text_start)
      arm64: head: fix code comments in set_cpu_boot_mode_flag

Evgenii Stepanov (1):
      kasan: speed up mte_set_mem_tag_range

Fuad Tabba (16):
      arm64: Apply errata to swsusp_arch_suspend_exit
      arm64: Do not enable uaccess for flush_icache_range
      arm64: Do not enable uaccess for invalidate_icache_range
      arm64: Downgrade flush_icache_range to invalidate
      arm64: assembler: remove user_alt
      arm64: Move documentation of dcache_by_line_op
      arm64: Fix comments to refer to correct function __flush_icache_range
      arm64: __inval_dcache_area to take end parameter instead of size
      arm64: dcache_by_line_op to take end parameter instead of size
      arm64: __flush_dcache_area to take end parameter instead of size
      arm64: __clean_dcache_area_poc to take end parameter instead of size
      arm64: __clean_dcache_area_pop to take end parameter instead of size
      arm64: __clean_dcache_area_pou to take end parameter instead of size
      arm64: sync_icache_aliases to take end parameter instead of size
      arm64: Fix cache maintenance function comments
      arm64: Rename arm64-internal cache maintenance functions

Gavin Shan (1):
      arm64: mm: Pass original fault address to handle_mm_fault()

Hao Fang (1):
      drivers/perf: hisi: use the correct HiSilicon copyright

Jing Xiangfeng (1):
      drivers/perf: fix the missed ida_simple_remove() in ddr_perf_probe()

Julien Thierry (7):
      arm64: Move patching utilities out of instruction encoding/decoding
      arm64: Move aarch32 condition check functions
      arm64: Move instruction encoder/decoder under lib/
      arm64: insn: Add SVE instruction class
      arm64: insn: Add barrier encodings
      arm64: insn: Add some opcodes to instruction decoder
      arm64: insn: Add load/store decoding helpers

Junhao He (4):
      drivers/perf: arm_spe_pmu: Fix some coding style issues
      drivers/perf: arm_pmu: Fix some coding style issues
      drivers/perf: arm-cmn: Add space after ','
      drivers/perf: arm-cci: Fix checkpatch spacing error

Kefeng Wang (2):
      arm64: mm: Use better bitmap_zalloc()
      arm64: mm: Add is_el1_data_abort() helper

Lee Jones (1):
      arm64: smp: Bump debugging information print down to KERN_DEBUG

Madhavan T. Venkataraman (1):
      arm64: Implement stack trace termination record

Marc Zyngier (4):
      arm64: Add cpuidle context save/restore helpers
      arm64: Convert cpu_do_idle() to using cpuidle context helpers
      PSCI: Use cpuidle context helpers in psci_cpu_suspend_enter()
      arm64: suspend: Use cpuidle context helpers in cpu_suspend()

Mark Brown (6):
      arm64: Document requirement for access to FEAT_HCX
      kselftest/arm64: Add missing newline to SVE test skipping output
      arm64/sve: Split _sve_flush macro into separate Z and predicate flushes
      arm64/sve: Use the sve_flush macros in sve_load_from_fpsimd_state()
      arm64/sve: Skip flushing Z registers with 128 bit vectors
      arm64: smccc: Support SMCCC v1.3 SVE register saving hint

Mark Rutland (32):
      arm64: assembler: replace `kaddr` with `addr`
      arm64: assembler: add conditional cache fixups
      arm64: assembler: add set_this_cpu_offset
      arm64: smp: remove pointless secondary_data maintenance
      arm64: smp: remove stack from secondary_data
      arm64: smp: unify task and sp setup
      arm64: smp: initialize cpu offset earlier
      arm64: update string routine copyrights and URLs
      arm64: remove redundant local_daif_mask() in bad_mode()
      arm64: entry: unmask IRQ+FIQ after EL0 handling
      arm64: entry: convert SError handlers to C
      arm64: entry: move arm64_preempt_schedule_irq to entry-common.c
      arm64: entry: move NMI preempt logic to C
      arm64: entry: add a call_on_irq_stack helper
      arm64: entry: convert IRQ+FIQ handlers to C
      arm64: entry: organise entry handlers consistently
      arm64: entry: organise entry vectors consistently
      arm64: entry: consolidate EL1 exception returns
      arm64: entry: move bad_mode() to entry-common.c
      arm64: entry: improve bad_mode()
      arm64: entry: template the entry asm functions
      arm64: entry: handle all vectors with C
      arm64: entry: fold el1_inv() into el1h_64_sync_handler()
      arm64: entry: split bad stack entry
      arm64: entry: split SDEI entry
      arm64: entry: make NMI entry/exit functions static
      arm64: entry: don't instrument entry code with KCOV
      arm64: idle: don't instrument idle code with KCOV
      arm64: mm: decode xFSC in mem_abort_decode()
      arm64: insn: decouple patching from insn code
      arm64: insn: move AARCH64_INSN_SIZE into <asm/insn.h>
      arm64: insn: avoid circular include dependency

Nick Desaulniers (1):
      Makefile: fix GDB warning with CONFIG_RELR

Peter Collingbourne (7):
      arm64: Change the on_*stack functions to take a size argument
      arm64: stacktrace: Relax frame record alignment requirement to 8 bytes
      kasan: arm64: support specialized outlined tag mismatch checks
      mm: arch: remove indirection level in alloc_zeroed_user_highpage_movable()
      kasan: use separate (un)poison implementation for integrated init
      arm64: mte: handle tags zeroing at page allocation time
      kasan: disable freed user page poisoning with HW tags

Qi Liu (7):
      perf: Add EVENT_ATTR_ID to simplify event attributes
      drivers/perf: Simplify EVENT ATTR macro in SMMU PMU driver
      drivers/perf: Simplify EVENT ATTR macro in qcom_l2_pmu.c
      drivers/perf: Simplify EVENT ATTR macro in qcom_l3_pmu.c
      drivers/perf: Simplify EVENT ATTR macro in xgene_pmu.c
      drivers/perf: Simplify EVENT ATTR macro in fsl_imx8_ddr_perf.c
      arm64: perf: Simplify EVENT ATTR macro in perf_event.c

Raphael Gault (1):
      arm64: Restrict undef hook for cpufeature registers

Rikard Falkeborn (1):
      perf/hisi: Constify static attribute_group structs

Robin Murphy (5):
      arm64: Add assembly annotations for weak-PI-alias madness
      arm64: Import latest memcpy()/memmove() implementation
      arm64: Better optimised memchr()
      arm64: Rewrite __arch_clear_user()
      perf/smmuv3: Don't trample existing events with global filter

Sam Tebbs (4):
      arm64: Import latest version of Cortex Strings' memcmp
      arm64: Import latest version of Cortex Strings' strcmp
      arm64: Import updated version of Cortex Strings' strlen
      arm64: Import latest version of Cortex Strings' strncmp

Shaokun Zhang (2):
      arm64: perf: Add more support on caps under sysfs
      drivers/perf: hisi: Fix data source control

Sudeep Holla (1):
      arm64: smccc: Add support for SMCCCv1.2 extended input/output registers

Thomas Gleixner (8):
      genirq: Export affinity setter for modules
      perf/arm-ccn: Use irq_set_affinity()
      perf/arm-cmn: Use irq_set_affinity()
      perf/arm-dmc620: Use irq_set_affinity()
      perf/arm-dsu: Use irq_set_affinity()
      perf/arm-smmuv3: Use irq_set_affinity()
      perf/imx_ddr: Use irq_set_affinity()
      perf/hisi: Use irq_set_affinity()

Tian Tao (3):
      arm64: perf: Convert snprintf to sysfs_emit
      arm_pmu: move to use request_irq by IRQF_NO_AUTOEN flag
      perf: qcom_l2_pmu: move to use request_irq by IRQF_NO_AUTOEN flag

Tuan Phan (1):
      perf/arm-cmn: Fix invalid pointer when access dtc object sharing the same IRQ number

Will Deacon (32):
      Merge tag 'irq-export-set-affinity' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into for-next/perf
      Merge branch 'for-next/ffa' into for-next/smccc
      Merge branch 'for-next/stacktrace' into for-next/boot
      Merge branch 'for-next/stacktrace' into for-next/kasan
      arm64: scs: Drop unused 'tmp' argument to scs_{load, save} asm macros
      arm64: mm: Remove unused support for Device-GRE memory type
      arm64: acpi: Map EFI_MEMORY_WT memory as Normal-NC
      arm64: mm: Remove unused support for Normal-WT memory type
      arm64: cache: Lower ARCH_DMA_MINALIGN to 64 (L1_CACHE_BYTES)
      arm64: cpuinfo: Split AArch32 registers out into a separate struct
      arm64: Allow mismatched 32-bit EL0 support
      KVM: arm64: Kill 32-bit vCPUs on systems with mismatched EL0 support
      arm64: Kill 32-bit applications scheduled on 64-bit-only CPUs
      Merge branch 'for-next/stacktrace' into for-next/core
      Merge branch 'for-next/boot' into for-next/core
      Merge branch 'for-next/build' into for-next/core
      Merge branch 'for-next/caches' into for-next/core
      Merge branch 'for-next/cortex-strings' into for-next/core
      Merge branch 'for-next/cpufeature' into for-next/core
      Merge branch 'for-next/cpuidle' into for-next/core
      Merge branch 'for-next/docs' into for-next/core
      Merge branch 'for-next/entry' into for-next/core
      Merge branch 'for-next/insn' into for-next/core
      Merge branch 'for-next/kasan' into for-next/core
      Merge branch 'for-next/misc' into for-next/core
      Merge branch 'for-next/mm' into for-next/core
      Merge branch 'for-next/mte' into for-next/core
      Merge branch 'for-next/perf' into for-next/core
      Merge branch 'for-next/ptrauth' into for-next/core
      Merge branch 'for-next/selftests' into for-next/core
      Merge branch 'for-next/smccc' into for-next/core
      Merge branch 'for-next/sve' into for-next/core

Yang Jihong (1):
      arm_pmu: Fix write counter incorrect in ARMv7 big-endian mode

YueHaibing (4):
      perf: arm_pmu: use DEVICE_ATTR_RO macro
      perf: qcom: use DEVICE_ATTR_RO macro
      perf: xgene_pmu: use DEVICE_ATTR_RO macro
      perf: arm_spe: use DEVICE_ATTR_RO macro

Zhenyu Ye (1):
      arm64: tlb: fix the TTL value of tlb_get_level

Zou Wei (1):
      drivers/perf: Remove redundant dev_err call in tx2_uncore_pmu_init_dev()

 Documentation/arm64/booting.rst                  |   6 +
 Makefile                                         |   2 +-
 arch/alpha/include/asm/page.h                    |   6 +-
 arch/arm/include/asm/cpuidle.h                   |   5 +
 arch/arm/kernel/perf_event_v7.c                  |   4 +-
 arch/arm64/Kconfig                               |  33 +-
 arch/arm64/Makefile                              |   2 +-
 arch/arm64/include/asm/alternative-macros.h      |   9 +-
 arch/arm64/include/asm/arch_gicv3.h              |   3 +-
 arch/arm64/include/asm/asm-prototypes.h          |   6 +
 arch/arm64/include/asm/asm_pointer_auth.h        |  49 +--
 arch/arm64/include/asm/assembler.h               |  98 +++---
 arch/arm64/include/asm/cache.h                   |   2 +-
 arch/arm64/include/asm/cacheflush.h              |  71 ++--
 arch/arm64/include/asm/cpu.h                     |  45 +--
 arch/arm64/include/asm/cpufeature.h              |  15 +-
 arch/arm64/include/asm/cpuidle.h                 |  35 ++
 arch/arm64/include/asm/efi.h                     |   2 +-
 arch/arm64/include/asm/exception.h               |  34 +-
 arch/arm64/include/asm/fpsimd.h                  |   2 +-
 arch/arm64/include/asm/fpsimdmacros.h            |   4 +-
 arch/arm64/include/asm/insn-def.h                |   9 +
 arch/arm64/include/asm/insn.h                    |  67 +++-
 arch/arm64/include/asm/kernel-pgtable.h          |  19 +-
 arch/arm64/include/asm/kvm_asm.h                 |   1 +
 arch/arm64/include/asm/kvm_mmu.h                 |   7 +-
 arch/arm64/include/asm/linkage.h                 |   8 +
 arch/arm64/include/asm/memory.h                  |   6 +-
 arch/arm64/include/asm/mmu_context.h             |   4 +-
 arch/arm64/include/asm/module.lds.h              |  17 +-
 arch/arm64/include/asm/mte-kasan.h               |  93 ++++--
 arch/arm64/include/asm/mte.h                     |   4 +
 arch/arm64/include/asm/page.h                    |  10 +-
 arch/arm64/include/asm/patching.h                |  13 +
 arch/arm64/include/asm/perf_event.h              |   5 +
 arch/arm64/include/asm/pgtable-hwdef.h           |   7 -
 arch/arm64/include/asm/pgtable-prot.h            |   1 -
 arch/arm64/include/asm/pgtable.h                 |   5 +-
 arch/arm64/include/asm/pointer_auth.h            |  59 ++--
 arch/arm64/include/asm/processor.h               |  16 +-
 arch/arm64/include/asm/scs.h                     |   8 +-
 arch/arm64/include/asm/sdei.h                    |  10 +-
 arch/arm64/include/asm/smp.h                     |   2 -
 arch/arm64/include/asm/stacktrace.h              |  32 +-
 arch/arm64/include/asm/sysreg.h                  |   2 -
 arch/arm64/include/asm/tlb.h                     |   4 +
 arch/arm64/kernel/Makefile                       |  11 +-
 arch/arm64/kernel/acpi.c                         |  22 +-
 arch/arm64/kernel/alternative.c                  |   2 +-
 arch/arm64/kernel/asm-offsets.c                  |  15 +-
 arch/arm64/kernel/cpufeature.c                   | 210 +++++++++---
 arch/arm64/kernel/cpuinfo.c                      |  58 ++--
 arch/arm64/kernel/efi-entry.S                    |   9 +-
 arch/arm64/kernel/entry-common.c                 | 256 +++++++++++++-
 arch/arm64/kernel/entry-fpsimd.S                 |  22 +-
 arch/arm64/kernel/entry.S                        | 369 ++++++--------------
 arch/arm64/kernel/fpsimd.c                       |   6 +-
 arch/arm64/kernel/ftrace.c                       |   1 +
 arch/arm64/kernel/head.S                         |  76 +++--
 arch/arm64/kernel/hibernate-asm.S                |   7 +-
 arch/arm64/kernel/hibernate.c                    |  20 +-
 arch/arm64/kernel/idle.c                         |  46 +++
 arch/arm64/kernel/idreg-override.c               |   3 +-
 arch/arm64/kernel/image-vars.h                   |   2 +-
 arch/arm64/kernel/jump_label.c                   |   1 +
 arch/arm64/kernel/kaslr.c                        |  12 +-
 arch/arm64/kernel/kgdb.c                         |   1 +
 arch/arm64/kernel/machine_kexec.c                |  30 +-
 arch/arm64/kernel/patching.c                     | 150 +++++++++
 arch/arm64/kernel/perf_callchain.c               |   2 +-
 arch/arm64/kernel/perf_event.c                   |  40 ++-
 arch/arm64/kernel/probes/kprobes.c               |  18 +-
 arch/arm64/kernel/probes/simulate-insn.c         |   1 +
 arch/arm64/kernel/probes/uprobes.c               |   2 +-
 arch/arm64/kernel/process.c                      |  99 ++----
 arch/arm64/kernel/ptrace.c                       |   2 +-
 arch/arm64/kernel/sdei.c                         |  64 +---
 arch/arm64/kernel/setup.c                        |   8 +-
 arch/arm64/kernel/signal.c                       |  26 ++
 arch/arm64/kernel/smccc-call.S                   |  83 +++++
 arch/arm64/kernel/smp.c                          |  16 +-
 arch/arm64/kernel/smp_spin_table.c               |   7 +-
 arch/arm64/kernel/stacktrace.c                   |  18 +-
 arch/arm64/kernel/suspend.c                      |  12 +-
 arch/arm64/kernel/sys_compat.c                   |   2 +-
 arch/arm64/kernel/traps.c                        | 135 ++++++--
 arch/arm64/kvm/arm.c                             |  13 +-
 arch/arm64/kvm/hyp/nvhe/cache.S                  |   4 +-
 arch/arm64/kvm/hyp/nvhe/setup.c                  |   3 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                    |   2 +-
 arch/arm64/kvm/hyp/pgtable.c                     |  13 +-
 arch/arm64/lib/Makefile                          |   4 +-
 arch/arm64/lib/clear_user.S                      |  47 +--
 arch/arm64/{kernel => lib}/insn.c                | 249 +-------------
 arch/arm64/lib/kasan_sw_tags.S                   |  76 +++++
 arch/arm64/lib/memchr.S                          |  65 +++-
 arch/arm64/lib/memcmp.S                          | 346 +++++++------------
 arch/arm64/lib/memcpy.S                          | 272 ++++++++++++---
 arch/arm64/lib/memmove.S                         | 189 -----------
 arch/arm64/lib/mte.S                             |  20 ++
 arch/arm64/lib/strcmp.S                          | 289 +++++++---------
 arch/arm64/lib/strlen.S                          | 258 +++++++++-----
 arch/arm64/lib/strncmp.S                         | 406 ++++++++++-------------
 arch/arm64/lib/uaccess_flushcache.c              |   4 +-
 arch/arm64/mm/cache.S                            | 158 ++++-----
 arch/arm64/mm/context.c                          |   6 +-
 arch/arm64/mm/fault.c                            |  50 ++-
 arch/arm64/mm/flush.c                            |  29 +-
 arch/arm64/mm/init.c                             |   7 +
 arch/arm64/mm/mmu.c                              |  13 +-
 arch/arm64/mm/proc.S                             |  24 +-
 arch/arm64/mm/ptdump.c                           |   4 -
 arch/arm64/net/bpf_jit_comp.c                    |   1 +
 arch/arm64/tools/cpucaps                         |   3 +-
 arch/ia64/include/asm/page.h                     |   6 +-
 arch/m68k/include/asm/page_no.h                  |   6 +-
 arch/s390/include/asm/page.h                     |   6 +-
 arch/x86/include/asm/page.h                      |   6 +-
 drivers/firmware/psci/psci.c                     |   9 +-
 drivers/firmware/smccc/smccc.c                   |   4 +
 drivers/misc/lkdtm/bugs.c                        |   6 +-
 drivers/perf/arm-cci.c                           |   4 +-
 drivers/perf/arm-ccn.c                           |   6 +-
 drivers/perf/arm-cmn.c                           |  13 +-
 drivers/perf/arm_dmc620_pmu.c                    |   5 +-
 drivers/perf/arm_dsu_pmu.c                       |   8 +-
 drivers/perf/arm_pmu.c                           |  16 +-
 drivers/perf/arm_smmuv3_pmu.c                    |  35 +-
 drivers/perf/arm_spe_pmu.c                       |  12 +-
 drivers/perf/fsl_imx8_ddr_perf.c                 |  18 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c    |   5 +-
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c     |   9 +-
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c     |   5 +-
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c      |   5 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c         |   6 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.h         |   2 +-
 drivers/perf/hisilicon/hisi_uncore_sllc_pmu.c    |   7 +-
 drivers/perf/qcom_l2_pmu.c                       |  11 +-
 drivers/perf/qcom_l3_pmu.c                       |  15 +-
 drivers/perf/thunderx2_pmu.c                     |   4 +-
 drivers/perf/xgene_pmu.c                         |  17 +-
 include/linux/arm-smccc.h                        |  88 ++++-
 include/linux/gfp.h                              |  18 +-
 include/linux/highmem.h                          |  43 +--
 include/linux/interrupt.h                        |  35 +-
 include/linux/kasan.h                            |  64 ++--
 include/linux/page-flags.h                       |   9 +
 include/linux/perf_event.h                       |   6 +
 include/trace/events/mmflags.h                   |   9 +-
 kernel/irq/manage.c                              |  33 +-
 mm/kasan/common.c                                |   4 +-
 mm/kasan/hw_tags.c                               |  32 ++
 mm/kasan/sw_tags.c                               |   7 +
 mm/mempool.c                                     |   6 +-
 mm/page_alloc.c                                  |  66 ++--
 scripts/Makefile.kasan                           |   1 +
 scripts/tools-support-relr.sh                    |   3 +-
 tools/testing/selftests/arm64/fp/sve-probe-vls.c |   2 +-
 158 files changed, 3370 insertions(+), 2563 deletions(-)
 create mode 100644 arch/arm64/include/asm/insn-def.h
 create mode 100644 arch/arm64/include/asm/patching.h
 create mode 100644 arch/arm64/kernel/idle.c
 create mode 100644 arch/arm64/kernel/patching.c
 rename arch/arm64/{kernel => lib}/insn.c (86%)
 create mode 100644 arch/arm64/lib/kasan_sw_tags.S
 delete mode 100644 arch/arm64/lib/memmove.S
